Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7558F1F404
	for <e@80x24.org>; Thu,  8 Mar 2018 17:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966297AbeCHR17 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 12:27:59 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52834 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932091AbeCHR14 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 12:27:56 -0500
Received: by mail-wm0-f65.google.com with SMTP id t3so757233wmc.2
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 09:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XKBIchh3kQpBR+65Mc3UUdfE+j0Z4s0ARP5NFrZdnQA=;
        b=Iq96PAJhqP3bin9RzO0eoaoD04uU802Q/kXdV7gJkSIfv4OFpny77Ht8VuVB/h6hlZ
         eYK8ZA7rbQnWxATvCYEFN3CKVVALHMSKnYwNHUi5nayjCtxMtftVjSKF7CoNArCwKpmb
         VOE2M3aqrnKXV+CTQ8JhnPRBK27wmjN6QplS7tlxUN0R9p4Z9o8oKIw4JlVIG9JZag4A
         vIvhMdvmS7hja6gyDGu2mDyCXgF9w+UGR/fMwE6GLLuN+vZYRYB3Y12jLso0mPfHhFpH
         l4VD8iiAxaogFlSh5/F/Yx2bZbHqc5CRSejqdlnSDXAoN+3lNBd0kmHfMbMGShmwfSxl
         D+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=XKBIchh3kQpBR+65Mc3UUdfE+j0Z4s0ARP5NFrZdnQA=;
        b=EDEHv1P3QxDatAq+FGCf41tuMELiJGHPCg4cIr9bX3RdUzPWlmzx0E5ijyZPYd8U3K
         jSStU1v3evsB3ky0MlqqBA2qAFCU9M015tmY/xMU9ZSp10Lhyo0y2F5vdwAf7Wgc2J2d
         aYvMQ6lwP3/msqvHb/QqNX3MpdbGpBRmGYddkuXKYgvGkXRAnkcG9GXuPjfr0DLIKwSj
         00d92s9JcsQyPa6//GlXRBlaeUJUxu4UpMWwKFh9QFYsvx3cFsagksFG/1npY0FllZo0
         zFmVzxdCmLp+OMiyYh3COdUV0uGy8MXJpY1WjVyu/B50x/iYHzAIQEOeYAzs8UW8YNbF
         igtg==
X-Gm-Message-State: AElRT7GQquGFBZXJEXicpd2WJKu6EXfKiEAkfoDYy7QvwTkpCar9ltcy
        d4jU9BO4huK4YaAB2ONnCFA=
X-Google-Smtp-Source: AG47ELtCfI6GkRhwu7tkxtw1whDi3vQ4B7QUYllKut9MXg/p5Th5RF8eNSaxDKtdEoNzv1eVPvB9Xw==
X-Received: by 10.28.202.26 with SMTP id a26mr17759194wmg.45.1520530074636;
        Thu, 08 Mar 2018 09:27:54 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 1sm9488459wmj.35.2018.03.08.09.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Mar 2018 09:27:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>,
        Dorab Patel <dorabpatel@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git{,-blame}.el: remove old bitrotting Emacs code
References: <87muzlwhb0.fsf@winehq.org>
        <20180308094544.7286-1-avarab@gmail.com>
Date:   Thu, 08 Mar 2018 09:27:53 -0800
In-Reply-To: <20180308094544.7286-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 8 Mar 2018 09:45:44 +0000")
Message-ID: <xmqq7eqmxysm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> On Tue, Mar 06 2018, Alexandre Julliard jotted:
> ...
>> I'd recommend that anybody still using it switch to Magit, which is
>> being actively maintained, and IMO superior to git.el in all respects.
>
> I think at this point it's best to remove both of these modes from
> being distributed with Git, per this patch.
>
>  contrib/emacs/.gitignore   |    1 -
>  contrib/emacs/Makefile     |   21 -
>  contrib/emacs/README       |   39 -
>  contrib/emacs/git-blame.el |  483 -------------
>  contrib/emacs/git.el       | 1704 --------------------------------------------
>  5 files changed, 2248 deletions(-)
>  delete mode 100644 contrib/emacs/.gitignore
>  delete mode 100644 contrib/emacs/Makefile
>  delete mode 100644 contrib/emacs/README
>  delete mode 100644 contrib/emacs/git-blame.el
>  delete mode 100644 contrib/emacs/git.el

I agree with the overall direction.  The only difference between
this and what I had in mind was if we want to leave README that says
what you said in the log message.  That way, those who just got a
new version of tarball and then wonder what happened to these
scripts would save one trip to the Internet.
