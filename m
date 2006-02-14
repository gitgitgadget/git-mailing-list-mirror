From: Sam Vilain <sam@vilain.net>
Subject: Re: Handling large files with GIT
Date: Wed, 15 Feb 2006 10:21:59 +1300
Message-ID: <43F249F7.5060008@vilain.net>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>  <87slqty2c8.fsf@mid.deneb.enyo.de> <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com> <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk> <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org> <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org> <Pine.LNX.4.64.0602122058260.3691@g5.osdl.org> <43F113A5.2080506@f2s.com> <Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0602141108050.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ian Molton <spyro@f2s.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 22:22:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F97cn-0002ca-CH
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 22:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422781AbWBNVWP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 16:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422789AbWBNVWO
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 16:22:14 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:13984 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1422781AbWBNVWO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 16:22:14 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 16A344BE4; Wed, 15 Feb 2006 10:22:10 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 0B5232ECB;
	Wed, 15 Feb 2006 10:22:03 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602141108050.3691@g5.osdl.org>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16176>

Linus Torvalds wrote:
> That said, I think git could do much better if the layout was optimized 
> for git. For example, in the maildir thing, there's two issues: the flat 
> directory structure is sub-optimal, but the other thing seems to be that 
> maildir apparently saves metadata in the filename.
> 
> Saving meta-data in the filename should actually work wonderfully well 
> with git, but both merging and git-diff-tree consider the filename to be 
> the "index", so they optimize for that. You could do indexing the other 
> way around, and consider the contents to be the index (and the filename is 
> the "status"), but that's obviously not sane for a sw project, even if it 
> might be exactly what you want to do for mail handling.

This seems to me to be another use case where git could gain orders of
magnitude speed improvement by either explicit ("forensic") history
objects, or a history analysis cache.

Sam.
