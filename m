From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Sat, 4 Feb 2012 17:46:05 +0200
Message-ID: <CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
	<20120202084859.GC3823@burratino>
	<7v8vklvxwh.fsf@alter.siamese.dyndns.org>
	<CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
	<7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
	<7vehuboe5g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 16:46:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rthod-00020g-L6
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 16:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064Ab2BDPqK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 10:46:10 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:62169 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750847Ab2BDPqI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 10:46:08 -0500
Received: by lagu2 with SMTP id u2so2323938lag.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 07:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=gKfQX0JTRoCRbF/MACBK+V7v+suH2LlpX4FzBwunaj0=;
        b=ecnwB3KkWhUq18RVhrT2dVT7B7YTtxZd7RGz5qCnxBY0tAiXeahzTLMf5asq4uzXji
         Fzjh7ziHtv1VK9A9xdLyhIPKmr9F+YvHRO0OoLcE+Fj3w+umt24MbYi1EIzShC7eOseO
         qheWc4F2ebnZVr97rJNYOhRAIeSji/OOINjZI=
Received: by 10.152.125.20 with SMTP id mm20mr1321472lab.6.1328370365875; Sat,
 04 Feb 2012 07:46:05 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Sat, 4 Feb 2012 07:46:05 -0800 (PST)
In-Reply-To: <7vehuboe5g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189872>

On Fri, Feb 3, 2012 at 10:28 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Fri, Feb 3, 2012 at 2:17 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> ...
>>> Here is what I ended up in preparation for queuing the series. I st=
ill
>>> haven't seen any version of 4/4, but please check $gmane/189683 and=
 see if
>>> that matches what you intended. Also I am assuming $gmane/189606 re=
layed
>>> by Jonathan is a squash between your 2 and 3 (which didn't reach me=
), so
>>> please advise if that does not match what you want to have.
>>
>> This is getting ridiculous, now I sent the patches directly to you, =
is
>> your pobox.com server also silently dropping them for no reason?
>
> Do not blame pobox.com; they have nothing to do with the corruption o=
f
> your headers.

No, but they have everything to do with *silently* dropping it. Why
couldn't they _at least_ return an error saying that the headers are
wrong? Note that other servers didn't even complain, they processed
the mail happily.

In any case, the one to blame for the header corruption is git:

% git blame -e -L 947,+7 contrib/completion/git-completion.bash v1.7.9
eaa4e6ee (<jrnieder@gmail.com>   2009-11-17 18:49:10 -0600 947)
__git_compute_porcelain_commands ()
eaa4e6ee (<jrnieder@gmail.com>   2009-11-17 18:49:10 -0600 948) {
eaa4e6ee (<jrnieder@gmail.com>   2009-11-17 18:49:10 -0600 949)
 __git_compute_all_commands
eaa4e6ee (<jrnieder@gmail.com>   2009-11-17 18:49:10 -0600 950)
 : ${__git_porcelain_commands:=3D$(__git_list_porcelain_commands)}
eaa4e6ee (<jrnieder@gmail.com>   2009-11-17 18:49:10 -0600 951) }
f2bb9f88 (<spearce@spearce.org>> 2006-11-27 03:41:01 -0500 952)
c3898111 (<szeder@ira.uka.de>    2010-10-11 00:06:22 +0200 953)
__git_pretty_aliases ()

Notice the mail is wrong.

And then, 'git send-email' is happy to send such headers. I sent a
patch to the list to improve that situation, but looks like
sanitize_address() could be improved a lot.

You can blame it on 'git send-email', or 'git blame', or my cccmd
script[1], but as I discussed before, this is *precisely* the reason
why it would be nice to have an official cccmd script.

> You just caught me at the wrong moment when there were much more impo=
rtant
> messages on the list (more refers to the volume, not all of them are =
more
> important) and I was working on them (not limited to your issue) from=
 top
> to bottom in the mailing list "newsgroup". =C2=A0I however wanted to =
get the
> zsh issue resolved sooner, and because you seemed to have been having=
 so
> much trouble with your MUA (I only so 0/4 even for v4), I tried to he=
lp
> out by sending what I thought is already good, hoping that a message =
that
> only has to say "that looks good, thanks" would be easier to make it =
to
> the list.

I was not nor am I blaming you, I am just saying the situation is ridic=
ulous.

And my MUA is 'git send-email'.

> People say "Oops, our mails crossed." and go on without making too mu=
ch
> fuss about it. =C2=A0E-mail communications are asynchronous. =C2=A0Ge=
t used to it.

That's not the problem, but problem is these sanctimonious mail
servers that drop mails without warning. And sure, also the code that
sends malformed mail.

In any case, fixing 'git blame', and/or 'git send-email', and/or have
an official cccmd script, would solve the problem.

> I think your mail breakage, from looking at your mail header, is this=
:
>
> =C2=A0From: Felipe Contreras <felipe.contreras@gmail.com>
> =C2=A0To: git@vger.kernel.org
> =C2=A0Cc: Junio C Hamano <gitster@pobox.com>, SZEDER G=C3=A1bor <szed=
er@ira.uka.de>, Jonathan Nieder <jrnieder@gmail.com>, Thomas Rast <tras=
t@inf.ethz.ch>, Felipe Contreras <felipe.contreras@gmail.com>, "Shawn O=
=2E Pearce" <spearce@spearce.org>>
> =C2=A0Subject: [PATCH v4 1/4] completion: work around zsh option prop=
agation bug
>
> Notice the excess '>' after the last address on Cc:?

Thanks for pointing that out :)

> It's not like this is your first serious submission to the list, so i=
t is
> curious why only this time you have been having so much trouble. Perh=
aps
> you have changed your mail set-up lately?

Yes, people asked me to CC more relevant people, so I enabled by
cc-cmd script that I sent to the list long time ago, but didn't
receive any more replies, and I also asked if it wouldn't make sense
to have an official one [1] -- no replies.

Cheers.

[1] http://article.gmane.org/gmane.comp.version-control.git/189360

--=20
=46elipe Contreras
