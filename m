From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [GSoC Proposal/RFC] Rolling commit message writing
Date: Mon, 29 Mar 2010 16:31:00 -0400
Message-ID: <32541b131003291331y3ae5ca23la33466d588c1b9e1@mail.gmail.com>
References: <alpine.DEB.1.00.1003281834520.13534@pip.srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Thomas <drt24@srcf.ucam.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 22:32:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwLd0-00009g-EU
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 22:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727Ab0C2UbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 16:31:23 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:35723 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673Ab0C2UbU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 16:31:20 -0400
Received: by ywh2 with SMTP id 2so5248580ywh.33
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 13:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=g+5gsTVY/9Ou8XXHo6S/YBkVXnGNuky3cIKuMjaZsTk=;
        b=kvqHx4hKLO+w+8PthKABuvlZlriSXEN8VQ8MnxbUNyjF5aFrjlaqWpbyszXazamiXV
         Pc7B1YRu/6Fq3wuv4Uv+7W2nfUCRJFqIvdDGn6ZQrCloAaiqYlm55us9qpel0QPmINy6
         loyFkrimL+UJkfyNpd6sL7BsCTRgi+mg0HwDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Jfn6wtx6KjciayH7X2WI5aYikrxHgFmVzfonh7wPrkqEBIiAxKbR2WCFMDx5kv9PY2
         +5l2+VGeKkEdTcM6PGr5QkBDAbGbYb27sATn2J96J+7qSt8KP1wIJsSQeJ1Waa0n8SG2
         vfBWBYmQpcUsgu7UfxdV6GYUmQPL6LeDtAhXs=
Received: by 10.150.203.4 with HTTP; Mon, 29 Mar 2010 13:31:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1003281834520.13534@pip.srcf.ucam.org>
Received: by 10.150.120.41 with SMTP id s41mr5100567ybc.83.1269894680277; Mon, 
	29 Mar 2010 13:31:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143514>

On Sun, Mar 28, 2010 at 3:32 PM, Daniel Thomas <drt24@srcf.ucam.org> wrote:
> Currently it is fairly easy to write good commit messages but the effort
> that this requires of developers can be reduced still further.
>
> This would be achieved by adding a built in system for working on a commit
> message during the stage of adding changes.
>
> Currently this can be done manually using "-F <file>, --file=<file>" in git
> commit but we can do better than that. Specifically changes to git add
> [--interactive | -i] to add an 'am' or similar command to allow adding a
> file and then prompting for a message about the changes to that file. Also
> changes to git add [--patch | -p] to add 'm' and 'c' options to git add
> --patch to allow the addition of a message for the current hunk ('m') and to
> do a commit (prompting for review) before returning to the hunk currently in
> focus ('c').

The extra prompting seems to me like it would slow down the process of
'git add -p' by making it take too many steps.  Normally when I create
a commit, I like to think of "which lines will I commit?" and "what is
the description of the whole commit?" as separate questions, whereas
this workflow would interweave the two and confuse me.

Do other people prefer it that way?

Secondly, I'm concerned that if you can't remember the description of
your entire commit by the time you commit it, then your commit is too
big.  The usual solution is to create multiple, smaller commits that
are easy to describe.  If at the end you find yourself with too many
commits, you can always join them together with git rebase.

You might also like 'git commit -v', which shows the actual diff to be
committed as part of your default commit message.  Then you can write
your message while looking at it, making it easy to describe exactly
what you changed.

Given these existing capabilities, is it still worth adding the
feature you propose?

Have fun,

Avery
