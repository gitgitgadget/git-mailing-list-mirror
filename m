From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: bug: unexpected output for "git st" + suggestion
Date: Tue, 23 Nov 2010 20:08:07 +0700
Message-ID: <AANLkTikxMXRiCYE=ny1tfrS64P0ywAHP_9eLJJzNUG3Q@mail.gmail.com>
References: <AANLkTimdKoGHapMTrA-bf_mEyMAEiiM0ALvLbZX8QJpv@mail.gmail.com>
 <AANLkTinFMn4V3c3yV6j72eqj5=v4jW7Uh3fmNDOyYjnT@mail.gmail.com> <AANLkTinj3ryChGKV8c6fHSD=aickmz0TMos4k0RYGKvo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VGFyZWsgWmlhZMOp?= <ziade.tarek@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 14:08:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKsc0-0006mx-Ns
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 14:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730Ab0KWNIk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 08:08:40 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46455 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568Ab0KWNIj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 08:08:39 -0500
Received: by wyb28 with SMTP id 28so8259104wyb.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 05:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=PKcIC0OFBI6oUIJYA74u2TQ1cSt4r0VUkO93xv/RuoY=;
        b=ZEvfd09wgJpZEq7Jci7YCoWgdd8aaNcT7wsY3W0DwkUKCFU00HgjM9vYTRNZrLaied
         wX4JF8aAxtCf6yJ8SdSDJ31Hzanelre9lnLhdtP/hPg3TlC24y+AypNb050IH9M2NLqz
         bD6qf167S2daYLVMhqtSwm5x3ojD4Nf6zmJ8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=d1z/5PMflju36wcM27JI8RXMVu8e0fP/QOvR8/mTjIWj5BwJrIvUBpqTQPKuZaIjMl
         KkvaPR4U6Q5NJzMkoSnOeuu6Ty4Xe8+MixVFohpqY1GALgOPRB8Nt8o7j99bLoXC8NUf
         biHVoIh0zVGyyceV84agDAtrw2LbNU3xy+p6E=
Received: by 10.216.175.73 with SMTP id y51mr6598360wel.41.1290517717631; Tue,
 23 Nov 2010 05:08:37 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Tue, 23 Nov 2010 05:08:07 -0800 (PST)
In-Reply-To: <AANLkTinj3ryChGKV8c6fHSD=aickmz0TMos4k0RYGKvo@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161956>

On Tue, Nov 23, 2010 at 7:49 PM, Tarek Ziad=C3=A9 <ziade.tarek@gmail.co=
m> wrote:
> On Tue, Nov 23, 2010 at 1:40 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.=
com> wrote:
>> On Tue, Nov 23, 2010 at 7:23 PM, Tarek Ziad=C3=A9 <ziade.tarek@gmail=
=2Ecom> wrote:
>>> Hello,
>>>
>>> I am new to Git and I tried to run "git st"
>>>
>>> I have found one small bug: "status" is not listed in the help scre=
en
>>> Git displays in that case.
>>>
>>> $ git st
>>> git: 'st' is not a git command. See 'git --help'.
>>>
>>> Did you mean one of these?
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0reset
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0stage
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0stash
>>
>> It's heuristics, based on the assumption that you mistype a command =
by
>> a letter or two.
>> It gives helpful suggestions most of the time, but
>> you can't expect it to be always right, especially when "st" is not =
a
>> mistyping. "git --help" does show "status" though so I guess it's ok=
=2E
>
> Yes, I understood this, but given the list of base commands git comes
> with, if "st" gives "stage" and "stash", it would find it logical to
> give also "status", by listing commands that starts with 'st'
>
> st
> stage
> stash
> status

There's another command that starts with "st": stripspace (it's a
lowlevel command by the way). It's going to be a lot more if you type
"git m" and expect all commands starting with 'm'. Personally I would
do "git help -a|grep st" in that case. Hmm.. "git apropos" could be a
good idea.

> That's what the tab completion does:
>
> $ git st<tab>
> stage =C2=A0 =C2=A0stash =C2=A0 =C2=A0status

And it does for tab _completion_ (notice stripspace is missing,
git-completion.sh only lists high level commands). The above case is
to help mistyping.
--=20
Duy
