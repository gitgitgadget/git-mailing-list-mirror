From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] test-lib: make test_expect_code a test command
Date: Fri, 1 Oct 2010 17:46:19 +0000
Message-ID: <AANLkTimUe39Z1Ce2NbfsJUyXe0-mY_CcmMmgk+kO_1a8@mail.gmail.com>
References: <7vd3rtholo.fsf@alter.siamese.dyndns.org>
	<1285953391-29840-1-git-send-email-avarab@gmail.com>
	<AANLkTim1_Zfbrt4G_S2hj1zfF0VX-fM1AkwFyPp0B1qE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 19:46:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1jgo-00084n-CD
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 19:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822Ab0JARqV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 13:46:21 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61892 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab0JARqU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Oct 2010 13:46:20 -0400
Received: by iwn5 with SMTP id 5so4079668iwn.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cGkNk8i6Zb9ipwq/PtxUW8BNhRq4THPSPeGG68ZXT7I=;
        b=S6QmT/arMGUGhq5KkiXDwCEC8hFGSXWvW3bUM0uOZ2pxVowNB8VnvM4zZFTbu4uqOE
         RUrNkoThKnUTi0JdDLUhg1ElTTlymgRjopYAF54WmZjog91VSoW/igDOO3nobfC1ZBAw
         EhCPgk8oyc+hgn/yzK5uKg168RCanbc7fDPwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nAE//o8MZLZSsGtCrPxeAhvAkea4f4yXz7hukuCgfJkJ3WzCGlmMzVLPWn80DPGvg+
         yBKotEYRJK6hfPtrF7XIwn4OdbzhXXcDv4Fn54kE5iY79VWgBJ+MZenxrbkJxk0l7Elo
         FAb6ad5PNr+xam7PgBevdMfQ9yfoToIdpzGgI=
Received: by 10.231.11.9 with SMTP id r9mr6049016ibr.47.1285955179674; Fri, 01
 Oct 2010 10:46:19 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 1 Oct 2010 10:46:19 -0700 (PDT)
In-Reply-To: <AANLkTim1_Zfbrt4G_S2hj1zfF0VX-fM1AkwFyPp0B1qE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157767>

On Fri, Oct 1, 2010 at 17:39, Sverre Rabbelier <srabbelier@gmail.com> w=
rote:
> Heya,
>
> On Fri, Oct 1, 2010 at 19:16, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>> converted that code to use an external test similar no the TODO test=
 I
>
> s/no/to/

Thanks, fixed.

>> +cat >expect <<EOF &&
>> +not ok - 1 tests clean up even after a failure
>> +#
>> +# =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0touch clean-after-failure &&
>> +# =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_when_finished rm clean-aft=
er-failure &&
>> +# =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(exit 1)
>> +#
>> +not ok - 2 failure to clean up causes the test to fail
>> +#
>> +# =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_when_finished \"(exit 2)\"
>> +#
>> +# failed 2 among 2 test(s)
>> +1..2
>> +EOF
>> + =C2=A0 =C2=A0test_cmp expect out)
>
> I still like the putting-the-code-in-a-separate-harness, but I'm
> wondering if we can't come up with something better than comparing
> with test output that could change in the future... unless we decide
> to standardize on TAP and not deviate from it?

Since t0000-basic.sh is the sanity test for the test-lib.sh itself
having at least some comparison of output is a good thing. It's a nice
sanity check in case something ends up changing it.

It's easy to change it if we change the output, but at least we'll be
testing for it explicitly.

> Either case, wouldn't it at least be a good idea to get rid of the
> parts after the # in the comparrison?

I thought it was simplest to just compare the complete output.
