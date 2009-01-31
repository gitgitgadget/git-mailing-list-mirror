From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: understanding index
Date: Sat, 31 Jan 2009 13:09:49 +0100
Message-ID: <adf1fd3d0901310409y28dc493ak358749e0c29154cc@mail.gmail.com>
References: <20090131111011.GA29748@ultras>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Sat Jan 31 13:11:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTEgz-0006XG-1S
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 13:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbZAaMJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 07:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbZAaMJy
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 07:09:54 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:49551 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbZAaMJy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 07:09:54 -0500
Received: by fxm13 with SMTP id 13so653128fxm.13
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 04:09:49 -0800 (PST)
Received: by 10.103.246.1 with SMTP id y1mr999223mur.116.1233403789085; Sat, 
	31 Jan 2009 04:09:49 -0800 (PST)
In-Reply-To: <20090131111011.GA29748@ultras>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107918>

2009/1/31 Nicolas Sebrecht <nicolas.s-dev@laposte.net>:
>
> Hey list.
>
> I'm having some understanding trouble with git index. As I understand,
> 'git rm --cached' is not strictly the opposite of 'git add'. It's a
> little embarrassing in this particular case : what if you want to
> commit and did a wrong 'git add -u' command ?
>
> Here's a minimalist sample :
>
> % ls
> foo     bar
>
> [ hack, hack, hack on both files ]
>
> % git status
> [...]
>        modified: foo
>        modified: bar
> [...]
> % git add -u foo bar
>
> [ optional hack on foo ]
> [ damn, you realize you don't want to commit changes on foo at all ]
>

You omitted the help message of git status, where it says how to unstage:
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)

So to not commit foo at all:

git reset HEAD foo

HTH,
Santi
> % git rm --cached foo
> % git status
> [...]
>        deleted: foo
>        modified: bar
> [...]
>
> If committed as is, foo will be marked as deleted (in 'git log
> --name-status' at least, which is not wanted).
>
> How to retrieve the state before the wrong 'git add -u' command _and_
> keep the working tree as well (including last hacks) ? Is there any
> command which is the exact opposite of 'git add -u' ?
>
> Cheers,
>
> --
> Nicolas Sebrecht
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
