From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: git rebase -f --autosquash
Date: Sat, 12 May 2012 13:05:55 +0200
Message-ID: <1336820755.3002.11.camel@centaur.lab.cmartin.tk>
References: <D7BE2BACB49749DB9FC37D4ACCCD008B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Kitchen <kitchen.andy@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 12 13:06:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STA98-0006Dq-Qb
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 13:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661Ab2ELLFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 May 2012 07:05:53 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:51056 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248Ab2ELLFw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 07:05:52 -0400
Received: from [192.168.1.3] (brln-4d0c2fce.pool.mediaWays.net [77.12.47.206])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 018F346051;
	Sat, 12 May 2012 13:05:42 +0200 (CEST)
In-Reply-To: <D7BE2BACB49749DB9FC37D4ACCCD008B@gmail.com>
X-Mailer: Evolution 3.2.2-1+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197723>

On Sat, 2012-05-12 at 20:38 +1000, Andy Kitchen wrote:
> Hi All, 
> 
> I commonly use:
> 
> git commit --fixup <commit>
> 
> to preen commits before pushing them. I can run
> 
> git rebase -i --autosquash HEAD@{upstream}
> 
> to apply these fixes, however, autosquash only
> applies to interactive rebases.
> 
> Because I am sure that my fixes are applicable,
> I would like to be able to non-interactively autosquash, possibly
> like so:
> 
> git rebase -f --autosquash HEAD@{upstream}
> 
> 
> Would anyone else find this feature useful?

If you're confident that an autosquash would produce the right
instructions, you can skip the editor phase by setting the EDITOR
environment variable to something that won't spawn an editor. Popular
variants are 'cat' and ':'. I prefer 'cat' because then I can see the
instruction set in the terminal and verify it's the correct one. You can
also set the rebase.autosquash config variable and then you just have to
type

    EDITOR=cat git rebase -i @{u}

or

    EDITOR=: git rebase -i @{u}

and maybe set an alias (I have a 'riu' alias for 'rebase -i @{u}').

I'm not saying an extra option wouldn't be useful, but there's already
ways of making git not spawn a text editor which works for all commands,
and you can even make an alias that will do precisely that.

   cmn
