From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Help with rebase after cvsimport
Date: Fri, 26 Mar 2010 10:17:32 +0100
Message-ID: <4BAC7BAC.7030507@drmicha.warpmail.net>
References: <bcd06dea1003250935q324b2412g959309070491c73c@mail.gmail.com> <bcd06dea1003251037j492bfbbcx2f99ad5046169f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brice Ruth <bdruth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 10:20:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv5iP-0008Gq-FT
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 10:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545Ab0CZJUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 05:20:23 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33639 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751499Ab0CZJUW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Mar 2010 05:20:22 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DCF47EA537;
	Fri, 26 Mar 2010 05:20:21 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 26 Mar 2010 05:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=aeMdXtDEuFspFARv0TgRVGv2uG8=; b=bXQ1T7qkn6G79+0MkR05DUq4JdXyWxqbpdRc08f7/7rNqt0ejeZF46Lg2IZj9ah9FOUpu7XtLDG1kpkaWU2kPRviX/6Ce5NS3wgZjo/27zYGmyRnoDjNA5AXn6R2UVHzvzVZGpjcSgQmkoFN9EFwAO929I+FEnNR/Uic+EM+5UQ=
X-Sasl-enc: UNytgJf2YioC77FvguIk2iYZADFgagfIaotTElt0meMA 1269595221
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 655424CAF0D;
	Fri, 26 Mar 2010 05:20:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <bcd06dea1003251037j492bfbbcx2f99ad5046169f2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143218>

Brice Ruth venit, vidit, dixit 25.03.2010 18:37:
> Posted this to #git but it seemed like everyone was asleep (or clueless)
> 
> [11:22] <Brice> Good morning - I have a quick question on using git
> rebase with git cvsimport - I'm trying to eliminate the duplicate 'cvs
> import' commit created when the cvs import is merged in - I'm just not
> sure what 'rebase' I need to do after a git cvsimport. Help?
> [11:22] <Brice> I'm on master when I do cvsimport
> [11:23] <Brice> cvsimport is run with -r cvs
> [11:23] <Brice> so, am I in the right ballpark thinking I need to git
> rebase cvs?

You have basically 2 options, see, e.g., the last paragraphs of

http://grubix.blogspot.com/2009/11/git-over-cvs.html

It seems you want to go with 1. In that case you need to

git rebase cvs/master master

(you can leave out the second argument if you are on master). Note that
by doing that you basically discard your version of commits which made
the git-cvs-git roundtrip (committed in git, cvsexported to cvs,
cvsimported to git). That's why I use approach 2 mentioned there, but it
depends certainly on your usage scenario, whether cvs is the
central/authoritative repo on which you work with git, or the other way
round.

Cheers,
Michael
