From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: html userdiff is not showing all my changes
Date: Wed, 15 Dec 2010 10:06:21 +0100
Message-ID: <4D08850D.3010402@drmicha.warpmail.net>
References: <561247.22837.qm@web110707.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: Scott Johnson <scottj75074@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 10:08:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSnLz-0003Bz-AN
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 10:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728Ab0LOJIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 04:08:49 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:39831 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751720Ab0LOJIs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Dec 2010 04:08:48 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8B862FEF;
	Wed, 15 Dec 2010 04:08:47 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 15 Dec 2010 04:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=VpkE+Qsdts6hefc3VtguvM5khqo=; b=mD2gZZyGHaC5B0QXVSNi3ZJaXmD45U9tgGC5E3mGD/j4ctUQ6EiG7Hb2YQUQunNJm90uShU4l0BXQVf2g8RaYp4gKl/JuNWRw605INXG0ltZ7Scx9zsQMy0L0PgJ4XOH1YtsLnui1LdcuCQFe/p0ZBsLnsdZya+SEiaJisZrh+8=
X-Sasl-enc: 8hsP3YsXsj+cJwarKWu9gzKToJK9oOqftEyTx+D0gvT0 1292404127
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DF665407A51;
	Wed, 15 Dec 2010 04:08:46 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <561247.22837.qm@web110707.mail.gq1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163746>

Scott Johnson venit, vidit, dixit 15.12.2010 04:47:
> I am attempting to do a word diff of an html source file. Part of the removed 
> html is disappearing from the diff when I enable the fancy html word diff.
> 
> Here's the output from basic `git diff`:
> diff --git a/adv_layout_source.html b/adv_layout_source.html
> index 18a81dd..c4ed609 100644
> --- a/adv_layout_source.html
> +++ b/adv_layout_source.html
> @@ -42,8 +42,8 @@
>        <ul>
>          <li class="ydn-patterns"><em></em><a href="#">ydn-patterns</a></li>
>          <li class="ydn-mail"><em></em><a href="#">ydn-mail</a></li>
> -        <li class="yws-maps"><em></em><a href="#">yws-maps</a></li>
> -        <li class="ydn-delicious"><em></em><a href="#">ydn-delicious</a></li>
> +        <li><em></em><a href="#">yws-maps</a></li>
> +        <li><em></em><a href="#">ydn-delicious</a></li>
>          <li class="yws-flickr"><em></em><a href="#">yws-flickr</a></li>
>          <li class="yws-events"><em></em><a href="#">yws-events</a></li>
>        </ul>
> 
> 
> Here's the default `git diff --word-diff`:
> diff --git a/adv_layout_source.html b/adv_layout_source.html
> index 18a81dd..c4ed609 100644
> --- a/adv_layout_source.html
> +++ b/adv_layout_source.html
> @@ -42,8 +42,8 @@
>       <ul>
>         <li class="ydn-patterns"><em></em><a href="#">ydn-patterns</a></li>
>         <li class="ydn-mail"><em></em><a href="#">ydn-mail</a></li>
>         [-<li class="yws-maps"><em></em><a-]{+<li><em></em><a+} 
> href="#">yws-maps</a></li>
>         [-<li class="ydn-delicious"><em></em><a-]{+<li><em></em><a+} 
> href="#">ydn-delicious</a></li>
>         <li class="yws-flickr"><em></em><a href="#">yws-flickr</a></li>
>         <li class="yws-events"><em></em><a href="#">yws-events</a></li>
>       </ul>
> 
> Which is correct, but less than ideal because it highlights much more than the 
> actual changes.
> 
> So I create a .gitattributes file with one line:
> *.html diff=html
> 
> And rerun `git diff --word-diff`:
> diff --git a/adv_layout_source.html b/adv_layout_source.html
> index 18a81dd..c4ed609 100644
> --- a/adv_layout_source.html
> +++ b/adv_layout_source.html
> @@ -42,8 +42,8 @@
>       <ul>
>         <li class="ydn-patterns"><em></em><a href="#">ydn-patterns</a></li>
>         <li class="ydn-mail"><em></em><a href="#">ydn-mail</a></li>
>         <li[-class="yws-maps"-]><em></em><a href="#">yws-maps</a></li>
>         <li><em></em><a href="#">ydn-delicious</a></li>
>         <li class="yws-flickr"><em></em><a href="#">yws-flickr</a></li>
>         <li class="yws-events"><em></em><a href="#">yws-events</a></li>
>       </ul>
> 
> Yikes! What happened to the second line of changes? The removed code is not 
> displayed at all.
> 
> This is running git 1.7.3.3.
> 
> I suspect the problem is in the html patterns in userdiff.c, but I don't 
> understand the word-diff-regex well enough to fix it.

The wordRegex should really only control what comprises a word, i.e. the
granularity of --word-diff. (Where do we insert additional line-breaks
before running ordinary diff?)

If a wordRegex can make parts of diff disappear than there is problem
deeper in the diff machinery. Can you trim this down to a minimal example?

Michael
