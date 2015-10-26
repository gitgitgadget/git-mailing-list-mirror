From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Why are submodules not automatically handled by default or at
 least configurable to do so?
Date: Mon, 26 Oct 2015 13:56:52 +1300
Message-ID: <CAFOYHZAKvN8xMKePCNFgo_ySHr0dc0+ASY0ux7j0p8UF1fuWCQ@mail.gmail.com>
References: <D4E5E890658.000004DCjohsmi9933@inbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	sbeller@google.com
To: John Smith <johsmi9933@inbox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 01:57:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqW6O-0003HO-Pk
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 01:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbbJZA5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 20:57:07 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35166 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbbJZA4w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 20:56:52 -0400
Received: by igbkq10 with SMTP id kq10so48467532igb.0
        for <git@vger.kernel.org>; Sun, 25 Oct 2015 17:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0ifkr9JmHavsLpMirs3ariImpEeU20WJDSghtS2l51c=;
        b=0uAP6qBjn1Xftx7yEIpdcT+hsCkpCt2pKf1sIqodFuWRnT7uaJ9KRGDo5u/mU57HAa
         Z7IcM4kPvVVXDfdKX9H3mcc5Ww9QQKxo1c50qm/UNtTyZ8TPdwj1UfotAZugBzodb5t3
         Ep1JlQIwTW9B+5nSH2B9mGg8YHg2IzrltDDNeNvcINBxBfFbU8KsfvwmTWNgEi9BtCQK
         m6vJUqTNbBoe56/Wwk3uDG36IP+ziT9AS2zIiA4J1ptmFA5mjcORWCfLAItB5wJQkcd/
         X461alNrCO5r7QwcMC0rbosPCBHoWcOpHAEgjkvaUTCnv15VsDcRjzdKfUWjCoru6hEZ
         AgyQ==
X-Received: by 10.50.49.80 with SMTP id s16mr15963497ign.49.1445821012160;
 Sun, 25 Oct 2015 17:56:52 -0700 (PDT)
Received: by 10.79.84.195 with HTTP; Sun, 25 Oct 2015 17:56:52 -0700 (PDT)
In-Reply-To: <D4E5E890658.000004DCjohsmi9933@inbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280168>

On Mon, Oct 26, 2015 at 12:10 PM, John Smith <johsmi9933@inbox.com> wrote:
> I found that I use submodules much, much more often in my git projects than I used externals
> in Subversion and the reason is that git encourages/forces to organize large projects into
> smaller repositories, one reason for this being that subversion allows to check out parts of
> a repository while git does not.
>
> But when I clone a git repository with subprojects, I (and everyone else) has to remember to
> add the --recursive option. When switching between branches with different versions/commits of the
> submodules everyone has to remember to update the submodules. When updating a submodule
> everyone has to remember to recurse there too.

The config option fetch.recurseSubmodules exists. It's not quite the
same as what git clone --recurse-submodules does but it's a start.

>
> Basically, everything with submodules has to be done manually every time and there seems
> to be no way to change that default.
>
> Why is that? Basically all the time I use submodules I would want automatic handling of
> submodules to happen and I cannot  remember having had a single situation where I would
> not have wanted it to happen. So  why does git default to doing nothing?

It's hard to pick a default that suits every workflow that submodules
support. Also with submodules there is a chicken-and-egg scenario.
While you can put things in ~/.gitconfig most of what you'd want to
configure when using submodules would be in super/.git/config but that
doesn't exist until you've cloned super.git.

> Why does it not provide a way to enable automatic
> pulling/updating of submodules e.g. when cloning or switching branches?

I believe Jens and Stefan (Cc'd) have been doing some great work in
this area. Jens even posted his todo list a few days ago
(https://github.com/jlehmann/git-submod-enhancements/wiki).

> When would people routinely check out a branch and want to stay with the submodules as
> the have been checked out for the old branch?
>
> I honestly do not understand it.
>
> John
>
> ____________________________________________________________
> Can't remember your password? Do you need a strong and secure password?
> Use Password manager! It stores your passwords & protects your account.
> Check it out at http://mysecurelogon.com/manager
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
