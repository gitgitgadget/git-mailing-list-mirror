From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How to check repository/working tree status from a script
Date: Wed, 20 May 2009 13:32:30 +0200
Message-ID: <4A13EA4E.9050805@viscovery.net>
References: <20090519143537.GA23505@torres.zugschlus.de> <alpine.LSU.2.00.0905191630120.23478@hermes-2.csi.cam.ac.uk> <20090519160031.GB23505@torres.zugschlus.de> <alpine.LFD.2.01.0905190915050.3301@localhost.localdomain> <20090520111028.GA15453@torres.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Haber <mh+git@zugschlus.de>
X-From: git-owner@vger.kernel.org Wed May 20 13:38:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6k7b-000172-0E
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 13:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756992AbZETLcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 07:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759527AbZETLcU
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 07:32:20 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:46584 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759546AbZETLcT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 07:32:19 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M6k1x-00011W-C6; Wed, 20 May 2009 13:32:17 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1648E6D9; Wed, 20 May 2009 13:32:17 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090520111028.GA15453@torres.zugschlus.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119603>

Marc Haber schrieb:
> On Tue, May 19, 2009 at 09:18:12AM -0700, Linus Torvalds wrote:
>> And if what you want to know about is whether there are _new_ files you 
>> might want to check, then you need a third check: 'git ls-files'. You 
>> won't see it in the error code, but you can do
>>
>> 	others=$(git ls-files -o --exclude-standard)
>>
>> and then check it 'others' is empty or not.
> 
> So parsing the output is both the canonical and only way to do so
> since there is no meaningful exit code? Can I assume that the
> formatting of git output is not subject to change?

See 'man git':

"Porcelain" commands are *not* for use in scripts; their output may
change. git diff, git status, git commit, git checkout are in this category.

"Plumbing" commands are for use in scripts and their output will not
change. git ls-files, git diff-tree, git diff-files are in this category.

-- Hannes
