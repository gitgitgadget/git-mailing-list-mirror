Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196F41F407
	for <e@80x24.org>; Wed, 13 Dec 2017 23:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbdLMXKV (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 18:10:21 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:43928 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbdLMXKU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 18:10:20 -0500
Received: by mail-wr0-f173.google.com with SMTP id z34so3563984wrz.10
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 15:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=35ijJaAN3C6ezteNAer9+7LgJ3zn6EGmlMu4jmFLAvo=;
        b=dBdYohsnDqye93p00HhJqgnVqfxkSm24FKeTUlKAWgYMA1RxJcAam1LzxOemUFuLhQ
         uq6gqW2rki0oF9tmpvKcfAWvLgGCqWrEdYh06wVboRMMHxd72mDvaCpbVelvz1JMSMsP
         1EEVRaaJidQrm14htISjSgGYKLEe3tdMVcSA8sZAnUYRxcU/q75LJa5VgG5tAaTVKaGa
         hTmyGrkJrRX9REiExIciRjLArLWU7rsl2u19LlF2IMKsT9qjapL4k0G91fc0ygJaDnlK
         Gpx0HmPowBP++b8+JidkYRplsQiojh8u3mHL9lJ8rodSO+ezc19hLRVQT+mZbQLudXb1
         wo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=35ijJaAN3C6ezteNAer9+7LgJ3zn6EGmlMu4jmFLAvo=;
        b=MK+AH3npKUCEJOkYXRG74GuZo1f4QuU9eVui9HGtHjLYPSiddA3ynjhAplDwHNEhx6
         ISR3HvqQ36AmiDbEPTKxjCFELJUn7uVgyjrRu19qTrQKx3r5+oACXCTCe+ZeNhbVsXo6
         pTXHuIA7pJI/emwcapak/xrRweuiUeIYOr8mbGfFoZqS2aIN8Gl0sCDiTAWE6r4ZTfly
         fDk83eq2rtu7MdkqyP9Bx6U0InZKC4J+qoxThEe56k+n8xzKGQM05fM2bah+CnbA/TP5
         8gR/bR1QugoRYRwcSwxt81MI+FO+I52u4PMjJoAHtT3BOMIKuaFMKkjR9mO+/ldCe7QG
         tkHg==
X-Gm-Message-State: AKGB3mJpi+1pG9S1FGSkmHn1A9Asq6EizI8AvRoFZHI+KWU3llPxjROh
        RE6v9X+o2Mz5kKRSsp7Svmg=
X-Google-Smtp-Source: ACJfBouyyzkkPIXV19YLoARWokGgj1ky1qxZi1TfwF2tjzA2yal8pNjbAeoyR/FelY4FiTSRD3DcSw==
X-Received: by 10.223.134.1 with SMTP id 1mr3819809wrv.213.1513206619229;
        Wed, 13 Dec 2017 15:10:19 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB50E0.dip0.t-ipconnect.de. [93.219.80.224])
        by smtp.gmail.com with ESMTPSA id 139sm2294686wmp.7.2017.12.13.15.10.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Dec 2017 15:10:18 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/4] travis-ci: use 'set -x' in 'ci/*' scripts for extra tracing output
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAM0VKjkVw8QeDErDg9aXcQ1sAgY34eBEeA0QJGamvEEBOG8y9w@mail.gmail.com>
Date:   Thu, 14 Dec 2017 00:10:17 +0100
Cc:     Git mailing list <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <77E6AE23-44FF-42E0-94FF-C4B35D913D5B@gmail.com>
References: <20171101115535.15074-1-szeder.dev@gmail.com> <20171211233446.10596-1-szeder.dev@gmail.com> <20171211233446.10596-2-szeder.dev@gmail.com> <9AAC2BCC-AA06-46F9-8E6E-1D99CD959FDD@gmail.com> <CAM0VKjkVw8QeDErDg9aXcQ1sAgY34eBEeA0QJGamvEEBOG8y9w@mail.gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 12 Dec 2017, at 19:43, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> On Tue, Dec 12, 2017 at 7:00 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>>=20
>>> On 12 Dec 2017, at 00:34, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>>>=20
>>> While the build logic was embedded in our '.travis.yml', Travis CI
>>> used to produce a nice trace log including all commands executed in
>>> those embedded scriptlets.  Since 657343a60 (travis-ci: move Travis =
CI
>>> code into dedicated scripts, 2017-09-10), however, we only see the
>>> name of the dedicated scripts, but not what those scripts are =
actually
>>> doing, resulting in a less useful trace log.  A patch later in this
>>> series will move setting environment variables from '.travis.yml' to
>>> the 'ci/*' scripts, so not even those will be included in the trace
>>> log.
>>>=20
>>> Use 'set -x' in 'ci/lib-travisci.sh', which is sourced in most other
>>> 'ci/*' scripts, so we get trace log about the commands executed in =
all
>>> of those scripts.
>>=20
>> I kind of did that intentionally to avoid clutter in the logs.
>> However, I also agree with your reasoning. Therefore, the change
>> looks good to me!
>=20
> Great, 'cause I'm starting to have second thoughts about this change =
:)
>=20
> It sure helped a lot while I worked on this patch series and a couple =
of
> other Travis CI related patches (will submit them later)...  OTOH it
> definitely creates clutter in the trace log.  The worst offender might
> be 'ci/print-test-failures.sh', which iterates over all
> 't/test-results/*.exit' files to find which tests failed and to show
> their output, and 'set -x' makes every iteration visible.  And we have
> about 800 tests, which means 800 iterations.  Yuck.
>=20
> Perhaps we should use other means to show what's going on instead, =
e.g.
> use more 'echo's and '--verbose' options, or just avoid using =
'--quiet'.
> And if some brave souls really want to tweak '.travis.yml' or the =
'ci/*'
> scripts, then they can set 'set -x' for themselves during =
development...
> as the patch below shows it's easy enough, just a single character :)

Hm... in that case. Would it be an option to "set -x" only in the header
of "install-dependencies.sh"?

In "lib-travisci.sh" we could keep your "set -x" and execute
"set +x" at the end of the file. Wouldn't that give us the=20
interesting traces without much clutter (e.g. what is $PATH etc)?

- Lars


>=20
>=20
> G=C3=A1bor
>=20
>=20
>>>=20
>>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>>> ---
>>> ci/lib-travisci.sh | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
>>> index ac05f1f46..a0c8ae03f 100755
>>> --- a/ci/lib-travisci.sh
>>> +++ b/ci/lib-travisci.sh
>>> @@ -23,7 +23,7 @@ skip_branch_tip_with_tag () {
>>>=20
>>> # Set 'exit on error' for all CI scripts to let the caller know that
>>> # something went wrong
>>> -set -e
>>> +set -ex
>>>=20
>>> skip_branch_tip_with_tag
>>>=20
>>> --
>>> 2.15.1.421.gc469ca1de
>>>=20
>>=20

