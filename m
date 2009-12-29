From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 0/4] clone: use --progress to mean -v
Date: Tue, 29 Dec 2009 11:06:29 +0800
Message-ID: <be6fef0d0912281906p432d012av2a774e179294260f@mail.gmail.com>
References: <18831.46833.862.196815@hungover.brentg.com>
	 <1261761126-5784-1-git-send-email-rctay89@gmail.com>
	 <alpine.DEB.1.00.0912260952020.4985@pacific.mpi-cbg.de>
	 <be6fef0d0912261927p4aff3ecet5cc26bd6dfc7e1c2@mail.gmail.com>
	 <7vljgmpnxj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 04:06:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPSPz-0002Av-Ap
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 04:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbZL2DGb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2009 22:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbZL2DGb
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 22:06:31 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:57567 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbZL2DGa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2009 22:06:30 -0500
Received: by iwn1 with SMTP id 1so7639162iwn.33
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 19:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pwp8CPSYDoqTV3ckJBoEaPRStA55UtpEI13AGPFZYvY=;
        b=k1UZbnLN9BznkPoXLRHZpCXlxGBuOT65Wp3QNC2gj/wUkwxiyJkLTPY0NlIh7NsIzm
         50EjQEQ+mq6hTb7HSZScPr+VWIRZ1rEAwwiSl6nJpVHYJr3FoPxkHQKoia4t8uYq9xYY
         kLFP1IE61LhMM5ZNKmkd5ZhR7/5/lO7/MOV7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=O0tjDpqjzpzSu3KcZRkbINU+n24/0U+bw2phufP6QwChx5+69ds8Gl/siRn300xtGo
         E28Hb3UsKiss+xMI2wma8/dJrAOgfRdzizFlBqtXy7S/RkSxv58IcJMSaO/ioRvPhPmV
         3+FPt4NgGKdFhekILQ/17AhFrejWy+WUiUaaA=
Received: by 10.231.167.65 with SMTP id p1mr3319829iby.20.1262055989053; Mon, 
	28 Dec 2009 19:06:29 -0800 (PST)
In-Reply-To: <7vljgmpnxj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135778>

Hi,

On Tue, Dec 29, 2009 at 9:30 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> On Sat, Dec 26, 2009 at 4:53 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> On Sat, 26 Dec 2009, Tay Ray Chuan wrote:
>>>
>>>> This series makes git-clone follow the "argument convention" of
>>>> git-pack-objects, where the option --progress is used to force rep=
orting
>>>> of reporting. This was previously done with -v/--verbose.
>>>
>>> No objections from my side, although you might want to advertise mo=
re that
>>> this is a change in behavior. =A0(Meaning in the release notes)
>>
>> Indeed, -v/--verbose to force reporting of progress was done sometim=
e
>> last year (Thu Oct 9 2008) so there may be scripts/applications
>> dependent on this option.
>>
>> Junio, do you have any advice on this front?
>
> [1/4] sounds like a sane thing to do regardless of the remainder of t=
he
> series, as stderr is where we write the progress output anyway. [2/4]
> looks trivially correct.
>
> It is unclear what impact [3/4] has. =A0I can read "With this patch,
> transport can pay attention to the verbose option given from the end =
user
> and act more verbosely, which was not something they couldn't do befo=
re",
> but what is the practical difference our existing users would see? =A0=
IOW,
> which transports are silent without this patch even when the user giv=
es -v
> from the command line?

I know at least one transport which behaves in this manner (ie. silent
even when -v is supplied to git-clone), and that is the http (via
curl) transport.

> I however wonder if it is of lessor impact if we only added --progres=
s
> but without removing the progress from -v. =A0Is there a downside?

(Just to clarify: progress reporting will be done if stderr is a
terminal - it will be done even if -v or --progress isn't present.
What -v/--progress does is force progress reporting even if stderr is
not a terminal.)

Leaving -v as it is (ie. forcing progress reporting) while adding
--progress would be a "safe" option, as it won't break people's
existing setups (ie. those that depend on -v to force progress
reporting), which the patch series does. I have in mind IDEs/editors
that use this behaviour to monitor progress.

On the other hand, if we decide -v shouldn't imply forcing progress
reporting, then I think this breakable change should be made soon,
when only a small minority of git commands are affected (only one,
git-clone). That way, we don't give users/integrators the impression
that -v forces progress reporting with git commands. They won't get
annoyed when try -v to force progress reporting and find that it isn't
the case.

By the way, I got this "-v doesn't imply forced progress reporting"
rule from Jeff (added to Cc list), who mentioned it some time ago:

  Date: Mon, 8 Jun 2009 07:54:31 -0400
  From: Jeff King <peff@peff.net>
  Subject: Re: [Patch] Prevent cloning over http from spewing
  Message-ID: <20090608115431.GC13775@coredump.intra.peff.net>

  I was imagining:

    - without "-q", show progress if isatty(1).

    - with "-q", never show progress

    - with "-v", show the "getting pack" and "walk" output we show now;
      without "-v", don't show it. "-v" has no impact on the progress
      indicator.

--=20
Cheers,
Ray Chuan
