From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] diff: generate prettier filenames when using	GIT_EXTERNAL_DIFF
Date: Wed, 27 May 2009 09:14:27 +0200
Message-ID: <4A1CE853.9080305@viscovery.net>
References: <1243394364-13772-1-git-send-email-davvid@gmail.com> <1243394364-13772-2-git-send-email-davvid@gmail.com> <4A1CDF11.4080507@viscovery.net> <20090527070221.GC2986@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	markus.heidelberg@web.de, nick@incise.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 27 09:14:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9DLS-0003A8-3K
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 09:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbZE0HOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 03:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbZE0HO3
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 03:14:29 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:61870 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbZE0HO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 03:14:28 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M9DLH-0007Tx-E9; Wed, 27 May 2009 09:14:27 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2FC85795; Wed, 27 May 2009 09:14:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090527070221.GC2986@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120039>

David Aguilar schrieb:
> On Wed, May 27, 2009 at 08:34:57AM +0200, Johannes Sixt wrote:
>> David Aguilar schrieb:
>>> +#include <libgen.h>
>> We don't have libgen.h on Windows :-( (at least not with my aging gcc
>> 3.something). Would you please open-code the call to basename()?
> 
> I don't know much about Windows.
> Do we need to check for \ in addition to /?

If the paths have been taken from the index or have passed through
get_pathspec or prefix_filename, then it is sufficient to check for '/'.
Otherwise, use is_dir_sep() (note it is a macro: don't call it like
is_dir_sep(*c++)).

-- Hannes
