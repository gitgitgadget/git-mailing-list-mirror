From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-init: don't base core.filemode on the ability to
 chmod.
Date: Wed, 03 Oct 2007 14:19:40 +0200
Message-ID: <470388DC.4040504@viscovery.net>
References: <20071003105501.GD7085@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 14:20:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id3DA-0005er-0G
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 14:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758539AbXJCMTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 08:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758540AbXJCMTn
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 08:19:43 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:55595 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499AbXJCMTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 08:19:42 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Id3CU-0001B5-KP; Wed, 03 Oct 2007 14:19:38 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6257F69F; Wed,  3 Oct 2007 14:19:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071003105501.GD7085@admingilde.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59832>

Martin Waitz schrieb:
> At least on Linux the vfat file system honors chmod calls but does not
> store them permanently (as there is no on-disk format for it).
> So the filemode test which tries to chmod a file thinks that the file
> system does support file modes.  This will result in problems when the
> file system gets mounted for the next time and all the executable bits
> are back.
> 
> A more reliable test for file systems without filemode support is to
> simply check if new files are created with the executable bit set.

On Windows, we don't get an executable bit at all. Better use both 
heuristics, i.e. set core.filemode false if either one diagnoses an 
unreliable x-bit.

-- Hannes
