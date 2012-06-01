From: nguyenhu@minatec.inpg.fr
Subject: Re: [PATCHv2] Possibility to read both from ~/.gitconfig and from
 $XDG_CONFIG_HOME/git/config
Date: Fri, 01 Jun 2012 21:49:07 +0200
Message-ID: <20120601214907.Horde.e8FjWXwdC4BPyRyzuIrz5oA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; DelSp=Yes
Cc: git@vger.kernel.org
To: ramsay@ramsay1.demon.co.uk
X-From: git-owner@vger.kernel.org Fri Jun 01 21:49:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaXr1-0002OZ-1H
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 21:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758825Ab2FATtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 15:49:12 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:38728 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758665Ab2FATtL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 15:49:11 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 475C81A02ED;
	Fri,  1 Jun 2012 21:49:08 +0200 (CEST)
Received: from etu-189-20.vpn-inp.grenoble-inp.fr
 (etu-189-20.vpn-inp.grenoble-inp.fr [147.171.189.20]) by
 webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Fri, 01 Jun
 2012 21:49:07 +0200
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199017>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> I have not tried this patch (or the v3 version, which I haven't read  
> yet), but
> is it likely that this has re-introduced the bug addressed by commit 05bab3ea
> ("config.c: Fix a static buffer overwrite bug by avoiding mkpath()",  
> >19-11-2011)?.
>
> I don't know the answer, but I suspect that it may have done just  
> that. >(indeed, it
> may well have made the bug more likely to appear).
>
>
>> The original that read from $HOME/.gitconfig was simple enough so
>> having three copies of getenv("HOME") was perfectly fine, but as you
>> are introduce this much complexity to to decide which two files to
>> read from, the code added this patch needs to be refactored and
>> three copies of the same logic need to be consolidated, I would have
>> to say.
>
> I agree. Also, using mksnpath() in the refactored code (rather than
> mkpath()) would be a good idea. :-P
>
> ATB,
> Ramsay Jones

Is not mkpath() the same function as mksnpath with char *buff =  
buf[PATH_MAX] and size_t n = sizeof(buf) ?
