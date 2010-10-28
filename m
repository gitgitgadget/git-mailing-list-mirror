From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: fatal: ambiguous argument 'HEAD^': unknown revision or path not
 in the working tree.
Date: Thu, 28 Oct 2010 15:42:45 +0200
Message-ID: <AANLkTimbOZwHDez6iAN828AoiqL+EvAV92-WqvhP6ZpP@mail.gmail.com>
References: <loom.20101028T150254-457@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Todd Wells <ttopwells@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 15:43:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBSl8-0005hJ-5x
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 15:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758772Ab0J1NnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Oct 2010 09:43:09 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45397 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758694Ab0J1NnI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Oct 2010 09:43:08 -0400
Received: by qyk10 with SMTP id 10so2154359qyk.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 06:43:06 -0700 (PDT)
Received: by 10.229.28.140 with SMTP id m12mr10070169qcc.93.1288273386619;
 Thu, 28 Oct 2010 06:43:06 -0700 (PDT)
Received: by 10.229.80.210 with HTTP; Thu, 28 Oct 2010 06:42:45 -0700 (PDT)
In-Reply-To: <loom.20101028T150254-457@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160176>

On Thu, Oct 28, 2010 at 3:09 PM, Todd Wells <ttopwells@gmail.com> wrote=
:
> I was using GitX to prepare a commit. Something happened -- I don't
> know what -- =A0and suddenly my branch only had a single commit
> in it that appears to contain all =A0the files in my tree. So I went =
to the
> command line and did this:
>
> $ git reset --soft HEAD^
> fatal: ambiguous argument 'HEAD^': unknown revision or path not
> in the working tree.
>
> When I do 'git log' in this branch, there's only one commit. Now, I
> had many commits in this branch a few minutes ago. I really,
> really, don't want to lose this.
>
> What steps should I take to attempt to recover?

You could try:

git log -g

which will show you the reflog, a log of recent tip commits of HEAD.
You could also try to see other local branches and their reflog.

If all this fails you can:

git fsck --unreachable

that will output all the unreachable commits/objects, those not in
your branches or reflogs.

Once you have the correct commit you can reset the HEAD to this commit:

git reset HEAD

(or with --hard as necessary).

HTH,
Santi
