From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: [RFC/PATCH] git put: an alternative to add/reset/checkout
Date: Mon, 23 Jan 2012 09:56:37 -0500
Message-ID: <CADo4Y9j5MwKr+rWza0ncLWuthY6x+s68CQYbY2+c8-E5pAa=Sw@mail.gmail.com>
References: <20110607200659.GA6177@sigill.intra.peff.net>
	<CACsJy8BCGi3s8gXr4kk-u8tDWztV6ozg1Tap23Q=TxA5d9iL+g@mail.gmail.com>
	<CADo4Y9iH+J-X-TdqTN2Y9KhQnprnCVvC4Xy6qhVHwsBRmsZUrg@mail.gmail.com>
	<CACsJy8AB-6b_PMvyM7hRV3b=5o0Cn4CtosygUQOevTzVJhU=hg@mail.gmail.com>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 15:56:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpLK8-0006vZ-5p
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 15:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086Ab2AWO4j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jan 2012 09:56:39 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:40044 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816Ab2AWO4i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jan 2012 09:56:38 -0500
Received: by vcbgb30 with SMTP id gb30so936654vcb.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 06:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=Q5GjyVKKDHSXG9MiXqCm9dV+RqpNn+f2nlp5EFtxMII=;
        b=eH96rftC4cVc7TSLuXLwy9EadHHVyg8g0apOMZLfZDx8M+sZEdMU8B2iFW2ht+7y1a
         wyOi0blUgDyHo9P8v57Z1i2e+F92gIuC2cQ6n2RZTNubSFnSr9aWBeQaSHSUXB2+IbLz
         lYAf5CzDBVBFAhzuF6OexG7Rk0W+ns1yitdX0=
Received: by 10.220.108.138 with SMTP id f10mr729046vcp.16.1327330597481; Mon,
 23 Jan 2012 06:56:37 -0800 (PST)
Received: by 10.52.64.231 with HTTP; Mon, 23 Jan 2012 06:56:37 -0800 (PST)
In-Reply-To: <CACsJy8AB-6b_PMvyM7hRV3b=5o0Cn4CtosygUQOevTzVJhU=hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188994>

Hi Duy,

I've contributed no code to git. =A0I've come up with plenty of ideas,
which seem to have gotten little traction.

Your ideas are similar to mine (and others), but the last attempt to
get them into git did not accomplish anything.  I don't know how much
work you have done on git, but before participating with git again, I
suggest you look at why the last attempt failed and we ask an
experienced person how things work.

It obviously isn't the design-first-then-find-a-willing-programmer of
the project I ran. =A0I don't know if it's the IETF's "running code and
a general consensus".=A0 The only thing I've found is that people did
not want to discuss theory.  (I believe the feeling is that theory is
only worthy of DARCS.)  I also got the feeling that improving the user
interface (e.g., replacing "git checkout --" and "git reset --") was
not a priority.

So, please plan out a strategy before recruiting me to help push this
idea forward.

Mike


On Mon, Jan 23, 2012 at 9:35 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
>
> On Mon, Jan 23, 2012 at 8:53 PM, Michael Nahas <mike.nahas@gmail.com>=
 wrote:
> > "git put" is "git cp".=A0 It copies from one filesystem (or a snaps=
hot
> > of a filesystem) to another filesystem.
>
> Exactly.
>
> > Without multiple working directories, a modifiable "stash", or a
> > (useful) name for the filesystem referred to as
> > "index"/"cache"/"staging area", there is only one filesystem that t=
he
> > command can write to: the (singular) working directory.
>
> No there are two writable "filesystems": working directory and
> "index/cache/staging area"
>
> > So, "git put <src filesystem> -- <path>" is fine.=A0 It will copy f=
rom
> > the path in the src filesystem to the path in the current working
> > directory.=A0 I don't think the command "put" is a great name for t=
hat.
> > Since we already have some strange double-usage commands like "git
> > checkout --" and "git reset --", perhaps this should be "git
> > cherry-pick --".
>
> The "-- <path>" thing may save you a few keystrokes when you want to
> copy from more than one path(spec). The two below commands are
> equivalent
>
> git put HEAD:a/ HEAD/b/ HEAD/c/ .
> git put HEAD: . -- a/ b/ c/
>
> But of course if you just need to copy from one pathspec to another
> place, "--" syntax is redundant.
>
> > <rant>
> > But for my money, "git cp" is clearer and I'd love to get rid of th=
e
> > user-confusing double-usage commands.=A0 I'd replace "git checkout =
--"
> > with "git cp NEXT WTREE -- <path>" and replace "git reset --" with
> > "git cp HEAD NEXT --" where NEXT is the filesystem represented by t=
he
> > "index"/"cache"/"staging area" and WTREE is an alias for the workin=
g
> > directory.
> > </rant>
>
> I thought of "cp" (naturally, I was driven by "scp" syntax as I said)
> and maybe if we think this through, we may be able to enhance cp to
> support "remote locations" (and --patch option). So "put" vs "cp" is
> not important to me now. What I'd like to hear is whether the syntax
> makes sense.
>
> My "hidden" plan if this works out would be to deprecate (or
> discourage) everything in git-checkout except branch switching. I
> don't have anything against git-reset. It's a kind of dangerous
> command from the start (while git-checkout is more user friendly) and
> can stay that way. The new "git <cp, put or whatever name>" should
> fill 90% the needs for git-reset.
> --
> Duy
