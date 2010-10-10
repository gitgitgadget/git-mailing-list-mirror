From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v3 12/14] mingw: import poll-emulation from gnulib
Date: Sun, 10 Oct 2010 19:51:52 +0000
Message-ID: <AANLkTikRetnkmNc07Cd=1EeWZn8jC5PmFk87YffGs9Kx@mail.gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
	<1286716854-5744-13-git-send-email-kusmabite@gmail.com>
	<AANLkTim1BZR89M22tAkT0qtfk70QeN0QuyKi5Q2KQQKR@mail.gmail.com>
	<AANLkTikR4FMK31oJP24B+9QxLypSbO7PL8G5vEtUp=my@mail.gmail.com>
	<AANLkTimxFm+hgJBM2B+Eui6+fStM1JSfkyMsKRoqCXd-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 10 21:52:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P51w8-0005Uq-Kt
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 21:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993Ab0JJTvz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 15:51:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43726 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab0JJTvy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Oct 2010 15:51:54 -0400
Received: by iwn6 with SMTP id 6so2514325iwn.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 12:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6GboRnhWcM1P7g2Q6jmCvDrMM+J89KlEbi60cuwVU5E=;
        b=uoCdKJAvDu26cwDTTyb+RtYEgfwRfjUJ4rwplTJ761fXqclTZP5AP/4CYZHOG7qpiG
         gF3qOmt8Q2tbriv6OWpv+vIsYHyDOrzrYCjK5yBVkA83KAntLEXgzs35JHv3vD51m74L
         h+D5D0ccV/kShP9jp+rTcqoEEmc4x3cZVhUVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VkCdlmziRLkvvzjvSEAeJtdSFxesCuqOfJSJOwaWfxpB57c2G0VgRUmxq76RrWLTMp
         4YiCOUjlxk2w6RC73FLQZ6L0PObl+9fgrJWL96vY2Ibmcsn7dDCwtiFaFNfoWjoPQQJT
         X+t/u43IBikxur/xJKnkt3fPQ8tZGq5cdp6E8=
Received: by 10.42.27.134 with SMTP id j6mr1334428icc.493.1286740312946; Sun,
 10 Oct 2010 12:51:52 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 10 Oct 2010 12:51:52 -0700 (PDT)
In-Reply-To: <AANLkTimxFm+hgJBM2B+Eui6+fStM1JSfkyMsKRoqCXd-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158693>

On Sun, Oct 10, 2010 at 19:34, Erik Faye-Lund <kusmabite@gmail.com> wro=
te:
> On Sun, Oct 10, 2010 at 4:28 PM, Erik Faye-Lund <kusmabite@gmail.com>=
 wrote:
>> On Sun, Oct 10, 2010 at 4:15 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
>> <avarab@gmail.com> wrote:
>>> On Sun, Oct 10, 2010 at 13:20, Erik Faye-Lund <kusmabite@gmail.com>=
 wrote:
>>>> lib/poll.c and lib/poll.in.h imported from 0a05120 in
>>>> git://git.savannah.gnu.org/gnulib.git
>>>
>>> Having fought with importing things from gnulib myself using their
>>> tools it would be useful to note in the commit message *how* you
>>> imported this. Did you use the gnulib command with some archane
>>> options so it wouldn't touch the build system while it was at it, o=
r
>>> did you just copy the relevant files manually?
>>>
>>
>> Sorry if that was unclear - I just copied the files (verbatim).
>> Patching to make it compile for us comes in the next patch.
>>
>> I didn't even know that there was a gnulib tool to extract code, but=
 a
>> quick google-search shows that there is. I'll look into using the to=
ol
>> instead for the next round.
>>
>
> I've had a quick look at it, and it really doesn't seem like
> gnulib-tool is suited for us here. It seems to be intended on pure
> autoconf-projects, and starts including all kinds of things that we
> don't need. We only care about poll-emulation on Windows, and we don'=
t
> need autoconf to tell us if it should be used or not.

The only reason I asked was that I tried to use gnulib-tool at one
point and reached the same conclusion. But in my case I wanted it to
resolve dependencies (i.e. bring in multiple projects), so not using
it was its own pain.

I just thought I'd ask in case you'd spent more time on getting it to
work.

> So I'm not in favor of using gnulib-tool, and going with the current
> method of verbatim copy with a separate fix-up commit. But perhaps I
> should clarify the commit message so other people can easily upgrade
> the emulation later...

By all means don't use gnulib, but noting how to upgrade things when
we add anything external in compat/ is a good idea.
