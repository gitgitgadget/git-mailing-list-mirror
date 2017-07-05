Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4288E202AC
	for <e@80x24.org>; Wed,  5 Jul 2017 00:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbdGEAgW (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 20:36:22 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35647 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbdGEAgV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 20:36:21 -0400
Received: by mail-pf0-f172.google.com with SMTP id c73so121079505pfk.2
        for <git@vger.kernel.org>; Tue, 04 Jul 2017 17:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ahcJqpAzEiZCw1CCJddJfO5TPlvxNsBcMU6uNQ5J8rk=;
        b=KYQ+iXVXDnRq2MGtlgrIWGh6N82yefF/vWtHM0x4RyricoFDCL73dUlzAUAz8oE447
         1oYSwJeIFSN9UseJQzeSQPuCI67e+5w2oGGOoY/iiogyaS0HBmCGe016LSWEuvfRFO8f
         mjl0qfUnRExKxFZvRS3ldyUcUl6wHNMkg2prmTZgr0wXQtH7WexpIxm7PdytywHS7oN6
         A7EBFIcXhX/X4EyIjlCi+z4UTtcgWMNq2OfYKQkNvxencJPb2b/0ri7y+AdPILBSw1QB
         bGuJni8RlX5YIZ8auZvyVcuH+E+wETikfTENvKnEay7NmSlsjwKs5sKLakPdwLc0Jtox
         0Y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ahcJqpAzEiZCw1CCJddJfO5TPlvxNsBcMU6uNQ5J8rk=;
        b=qulaiJf0tUIbnD3/ZbTPm+q7HwitdVKQM9i82ReLqSfRjZIabbTEhjSQh/YxbhxZXv
         1G/GB1plNw9rqGUNkBopZ51ryveeAtsQbvAO2Ema7Nm8pwjPJkPhWCTYkfIThVi4sZRC
         29CVBKYrbLn7QqWecPkg4CfYsW8+bVQZh84SJnukDZAdAgmL+96IqJI3ugztdAZFMXMq
         wir21aMWp4FVyPOLfDO8+VQAgcTUKbC1Lnj4OqZDElLCmr2570PnfDwADgvbLXXets0E
         nA3IsvLBR+MynZIEj7ixgd4yZKcgPmBDVXe09wwAwy55tyoa63CWBc8YK8r9JWLBP3dF
         YFRA==
X-Gm-Message-State: AIVw110vf85zTz3P3MAdt/85bNI9rfLbkUPBK3o0vUH6fhBCtprtDWUT
        R9Zw9mb3yMyEjJ+5BKgaIFD3zVYynkhBwAi+QA==
X-Received: by 10.84.232.205 with SMTP id x13mr19395697plm.245.1499214980464;
 Tue, 04 Jul 2017 17:36:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Tue, 4 Jul 2017 17:36:20 -0700 (PDT)
In-Reply-To: <87fuebbyvl.fsf@gmail.com>
References: <20170701220547.10464-1-avarab@gmail.com> <20170627121718.12078-1-avarab@gmail.com>
 <20170701220547.10464-3-avarab@gmail.com> <xmqqa84lmonj.fsf@gitster.mtv.corp.google.com>
 <874lutclie.fsf@gmail.com> <xmqq4luskt9l.fsf@gitster.mtv.corp.google.com> <87fuebbyvl.fsf@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Jul 2017 17:36:20 -0700
Message-ID: <CAGZ79kZqF3_PyrCnCMDyLNAUMRnvq96L3yoE0j=yzMigu4LUzg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sha1dc: optionally use sha1collisiondetection as a submodule
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
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

On Tue, Jul 4, 2017 at 3:50 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

>
> I think some invocation of "git submodule update ???" will do the same,
> but I can't from the docs see what that is right now.

'--remote' is what you are looking for.

When we have the branch field configured, the workflow for *creating*
the patch sent
to Junio might be different than it currently is. Currently, you would
send a patch that is
produced as:

  git -C sha1collisiondetection pull origin master
  git add sha1collisiondetection
  git commit -m "serious reasoning in the commit message"

This could be 'simplified' to

  git submodule update --remote
  git add sha1collisiondetection
  git commit -m "serious reasoning in the commit message"

but as we had different branches in the submodule field,
I wonder how much of an ease this is.

For Junio the workflow stays the same, as he would just
apply the patch, so I understand why he might see the
branch field as pollution.
