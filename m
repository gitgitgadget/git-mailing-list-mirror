From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] log: test for regression introduced in v1.7.2-rc0~103^2~2
Date: Sun, 15 Aug 2010 09:24:16 +0000
Message-ID: <AANLkTi=PAW_Owy_-DSQ32sboB28373Gb_aySbpeprwLg@mail.gmail.com>
References: <7vzkwqi10w.fsf@alter.siamese.dyndns.org>
	<1281748247-8180-1-git-send-email-avarab@gmail.com>
	<AANLkTi=Na_K=9oXM7iyeKodWXyXuSy-0UL792igTEjEe@mail.gmail.com>
	<7v39uggs5h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 18:19:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Okfw7-00005f-OQ
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 18:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348Ab0HOQTq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 12:19:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61312 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128Ab0HOQTp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 12:19:45 -0400
Received: by iwn7 with SMTP id 7so779772iwn.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 09:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W7zXXMu5TPWmil3shVTnoS8VzNUAXsRwJzduNplh1d0=;
        b=YBceNHFkI0W2f5zN/4+R78Ry1qKr36zd84g3N11m2sJKYYmjL0KXEd6Eyu5bTywFLj
         RECKjquA6CJID7HNBpMlfQkntQOyJW+vSTuqmtAzZWd3TPgeYSKn/xMMSYn/IVfwqHYr
         sAQJ6zXzum71QHDTGj3TWfcGqpNcFt9tUVZNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AnAhPy6DZiT1olCLt0p1ZaCXRnFGrquSUAiK4i8C8p59q12jrQDyw8qG7p/QvzmWMv
         0qiVxNwrpy3ZkwroKqM6T9EgQujNGglbKegmImNJb0EqBgbrlLr+XNuKy9VtXxzVqMq4
         1JrezkxdiUgMbD/FyBmJmwZyv6CtVipvqE8kM=
Received: by 10.231.12.77 with SMTP id w13mr3979397ibw.129.1281864256505; Sun,
 15 Aug 2010 02:24:16 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sun, 15 Aug 2010 02:24:16 -0700 (PDT)
In-Reply-To: <7v39uggs5h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153607>

On Sun, Aug 15, 2010 at 09:08, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Sat, Aug 14, 2010 at 01:10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n <avarab@gmail.com> wrote:
>>> Add a regression test for the git log -M --follow --name-only bug
>>> introduced in v1.7.2-rc0~103^2~2
>>
>> AKA "we didn't have any tests for log's --name-only *at all*".
>
> But this is not related to --name-only at all; anything that is "diff=
"
> related, e.g. -p, --stat, --name-status, will share the same issue.

I meant that as an extra benefit this is the first test for log +
--name-only.

>> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
>> index 95ac3f8..ff624f4 100755
>> --- a/t/t4202-log.sh
>> +++ b/t/t4202-log.sh
>> @@ -441,5 +441,14 @@ test_expect_success 'log.decorate configuration=
' '
>>
>> =C2=A0'
>>
>> +test_expect_success 'Regression test for v1.7.2-rc0~103^2~2' '
>
> This is uninformative and ugly at the same time.
>
> =C2=A0- Can't we describe the nature of the situation where the old b=
ug
> =C2=A0 triggers concisely? =C2=A0Perhaps 'show added path under "--fo=
llow -M"?'

I didn't grok why this was happening, but yeah, that description is
better.

>> + =C2=A0 =C2=A0 # Needs an unrelated root commit
>> + =C2=A0 =C2=A0 test_commit README &&
>
> This is not a "root" commit, is it?

s/root/first/

>> + =C2=A0 =C2=A0 >Foo.bar &&
>> + =C2=A0 =C2=A0 git add Foo.bar &&
>> + =C2=A0 =C2=A0 git commit --allow-empty-message </dev/null &&
>
> Does emptiness of the message matter?

No, I was just going for a minimal test case, no commit message is
more minimal than having one.
