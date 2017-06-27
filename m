Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EDB620401
	for <e@80x24.org>; Tue, 27 Jun 2017 18:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753157AbdF0S5H (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 14:57:07 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:35205 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbdF0S5F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 14:57:05 -0400
Received: by mail-it0-f44.google.com with SMTP id v202so18605943itb.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 11:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aghVpBgIH4U/ycN22f0TsjxAfmeWmm3iS2i5OPOtdS4=;
        b=o5zYJ6XnWLpB6xSXE/c9A2YbE+wLlsOhH35DavWEZYFZj8elgm0YKr6riV7sO11Nr3
         311F8JqttlOIOuLe8grwBADShRNR46IFEyS0bhfuY6ki4iHgNctgboTSeumr+6opnAp0
         zTYL8czlJ2PjBJWAnckl2zpbQFXkA373d1XH7Iuu/k+0wWXtx+VJqPjyGWUAuv82ZHqK
         wqXuQMFTHtbhWF+mJnr3UcxeHLbDWgf1Wqbo65wEU110jlYQk+0G3bVdK+iI34Isr2+3
         qN9JtZ1spvLFoQtnMdsMKJ1/7EdCEVv8zUKe8HUmLpR//KlPh5VdLj5laD94opbkUY6u
         AwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aghVpBgIH4U/ycN22f0TsjxAfmeWmm3iS2i5OPOtdS4=;
        b=p8tlR8XlWo0tp/6qGazNF/bz74iHT/Pl4VigDb7BUEeYI5VQoW3fk9RBaSuBvbBmkU
         vwD/KuStnFFCyCu2Jmaahcw7ldtyK/onGNkLbg+EKGHNaRY0U1tUddbduH3Ek3rNEJ9F
         qK9a3MIhiHR3DkVaS1tBsuTKAfB/vS5tBHsbYaXWstzIzsuHuIrY8e78Tg1386QJEDqD
         QrTGLpNPtkKPMUZ1wAtAUhVcCRDRrr+ehv9QRw1NlykXOu+phftZczkDGURMa9WGdbar
         CIJpw2m+ZW/QezSbZrlk7VptE6HVpsqsRTg2QLhvsMJTmrsfXdmmV8iB9b8mIYAXdyRy
         KiEw==
X-Gm-Message-State: AKS2vOyBHZ6b1UQcf1PxCsGrjE6pc1Z5/TLPn7kuw0ECbCQQB8K5yKpU
        VIlNwB8FKSfRhEa7HqpryPNtDXpmwY+N
X-Received: by 10.36.127.208 with SMTP id r199mr3973854itc.66.1498589824924;
 Tue, 27 Jun 2017 11:57:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.31.10 with HTTP; Tue, 27 Jun 2017 11:56:44 -0700 (PDT)
In-Reply-To: <CAGZ79kYzZqAm9AgiXAanBTzJfHStebCy9Z6MvhniRjS3s1wG-Q@mail.gmail.com>
References: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
 <20170627121718.12078-1-avarab@gmail.com> <20170627121718.12078-3-avarab@gmail.com>
 <CAGZ79kYzZqAm9AgiXAanBTzJfHStebCy9Z6MvhniRjS3s1wG-Q@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 27 Jun 2017 20:56:44 +0200
Message-ID: <CACBZZX7nP8ZRg_VC_z14BsYKWzAws-dsRosaKRB+3T=unTyHzA@mail.gmail.com>
Subject: Re: [PATCH 2/3] sha1dc: optionally use sha1collisiondetection as a submodule
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2017 at 8:46 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jun 27, 2017 at 5:17 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Add an option to use the sha1collisiondetection library from the
>> submodule in sha1collisiondetection/ instead of in the copy in the
>> sha1dc/ directory.
>>
>> This allows us to try out the submodule in sha1collisiondetection
>> without breaking the build for anyone who's not expecting them as we
>> work out any kinks.
>>
>> This uses my own fork which integrates PR #36. See the preceding
>> commit ("sha1dc: update from my PR #36", 2017-06-27) for details.
>>
>
>> +++ b/.gitmodules
>> @@ -0,0 +1,4 @@
>> +[submodule "sha1collisiondetection"]
>> +       path =3D sha1collisiondetection
>> +       url =3D https://github.com/avar/sha1collisiondetection.git
>> +       branch =3D bigend-detect-solaris-again
>
> What is the motivation for the branch field here?
> While this series fixes a hot issue, in the long run we'd rather
> want to plug in the original upstream with the master branch?

Just so we can cook this in pu (including for those cloning with
--recursive) until upstream merges my patches.

We're now in a chicken & egg scenario where the patch I have (minus
nits mentioned on list, will fix) should work, but needs testing, and
once it has testing upstream is willing to merge it, and getting it
into pu (with my clone/branch) will give it more testing).
