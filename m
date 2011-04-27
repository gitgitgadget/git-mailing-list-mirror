From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 15:06:46 +1000
Message-ID: <BANLkTikUi5RKjgdmQHjg1-s0ND+ot4J3AA@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<20110427035825.GA4546@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 07:07:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEwxu-000799-BI
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 07:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578Ab1D0FGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 01:06:49 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36250 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab1D0FGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 01:06:48 -0400
Received: by eyx24 with SMTP id 24so396927eyx.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 22:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=AVLOkYlfCpmPVG1rZAA3+7zwYlwy3L3zLMjPbwSS044=;
        b=U9r4lyPCRB7TvHZEUou9MAr1kN6G02qS4YlfjcNjDlGtGuJ9le19aaQiUzKb7b8MKY
         dUXh7E464gplAi/JW3TuAZgLLf0xovU7Cl68RWSPNKmXhPF9X8uVSZrzfh8iKMTEnrtQ
         KFM/uZLPNyzP25jhk2NAUonDcFyi5CBFTnPJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=IWeb+yZMABV6Un2y8TMEckEKjoLM8yCMgOVh3Cpv566Mzx1RkdPXTPiLrabp5wxFes
         BUhKxrJVurARP/kpifUMyfZ0Pm0CdUQ7nv2vVaf7DBEqg/z5pe1uUYNGE3Ybc6USl/77
         dwk9VyGsKrmulQkSZ42b8MDBtLewONixuOae8=
Received: by 10.14.50.15 with SMTP id y15mr715969eeb.149.1303880807006; Tue,
 26 Apr 2011 22:06:47 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Tue, 26 Apr 2011 22:06:46 -0700 (PDT)
In-Reply-To: <20110427035825.GA4546@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172169>

On Wednesday, April 27, 2011, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Jon,
>
> I haven't looked into 'git work' yet, but for my own private tweaks,
> two mechanisms have sufficed:
>
>  * adding a program named git-foo to the $PATH introduces a
>    'git foo' command.  For the git command look and feel, scripts
>    tend to start with
>
>         . "$(git --exec-path)"/git-sh-setup
>
>    (see git-sh-setup(1) for details).
>
>  * various existing git commands can have their behavior modified
>    through configuration and hooks.
>
> Does 'git work' require changing the behavior of existing commands,
> and if so, are there hooks that could be introduced to help in doing
> that?

git work is all new, so such considerations don't apply. Actually
there is one thing - I proposed a new config variable whose
description I left out of the tar ball version because I didn"t want
to touch existing files in a git install. The other thing II needed to
do was include my man pages so they get picked up by git help.

I can see that there might be a class of extension that 'enhances'
existing git commands. No doubt that would be a tricky problem to
solve and such a solution would not necessarily be good for the git
platform in any case.

 I guess one thing a git plugin architecture could do is provide
management of the PATH for plugins, a way to manage man pages and a
way to manage plugin specific configuration help.

jon.

| missed the list unintentionally, the first time through
