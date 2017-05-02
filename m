Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD5251F829
	for <e@80x24.org>; Tue,  2 May 2017 09:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751089AbdEBJ7P (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 05:59:15 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:34215 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdEBJ7O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 05:59:14 -0400
Received: by mail-io0-f170.google.com with SMTP id a103so150174621ioj.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 02:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RxBWAQef9X91GxGBBm72piqgeHOKhur0IGcWtQIK8Rw=;
        b=BmA0E9NTb1Dsu+EIqITQCG1+v/Ulr7fX+ce6w2M1tEs1j44qghOeWhWoKuHFw3PhVw
         jBRAm661+9tQiStRMCoQeY022fMiaqOh8dmDTOj2KOqIPRNNKQHGvz9VuABm6S6+q7td
         ierzXhdGt4JkBZar+D/SUfhbemSoKA0BDFGNMIIISRaskwpd1tmPS4IYtb4swV8JvCSH
         32v33WEl6M5qumQH9iZLY53OxwIDCZSHJWjnaW/w3qEDZUZCKNYBPPaWGSo2raVL++PB
         yN8i09xcY1wCqKEZKoFA3Y6rPnAsY92wPYVOqvoQlB5uwvaV6ecNQQzBKa4uPYw0R5I0
         YWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RxBWAQef9X91GxGBBm72piqgeHOKhur0IGcWtQIK8Rw=;
        b=pmNuKzi+G3U/i2FeU+fssES0X7YXWdKXTCT/nhR2DvmX9Nkv6T6/8r/0IAiH499Jjs
         hz9KmXHYHTSkRjwrg3FnG1IuMD/EEkplp2cGWAptSFAIseYQqO8p2s9SKtJCUFQ90Syj
         ACPjSSfyKAdv1Ya3is96raWNdy+d6oDr5Yk0annqSxzscZ/ADaDvxOT3/BagZYuyJt7t
         yFHQ5DJhBcogYqxZL/dwE74GaSSCnsp+Lyk85ldKIb6IaQw6kLpTzQDNzmgLXDl3UTKn
         IIM1kQMUC4sbl0QrpVBr3u27uXE/vObSxao2qPRajG0c3KbuJ/ynRLk+gcbwqZIaP0k/
         CyQg==
X-Gm-Message-State: AN3rC/6P9QtYT+YHBYFxKNHkN4pndsy1E/bGFeisksshyZPTSdGTzXlf
        41S8F57uQgrcQ2gRS3idJO5p6db9Wg==
X-Received: by 10.107.146.139 with SMTP id u133mr25347225iod.160.1493719153233;
 Tue, 02 May 2017 02:59:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 2 May 2017 02:58:52 -0700 (PDT)
In-Reply-To: <743D62FA-65B9-4DCC-978E-DAF442AE0B0D@163.com>
References: <20170429122632.7122-1-zxq_yx_007@163.com> <xmqqo9vdiboz.fsf@gitster.mtv.corp.google.com>
 <743D62FA-65B9-4DCC-978E-DAF442AE0B0D@163.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 2 May 2017 11:58:52 +0200
Message-ID: <CACBZZX6fursxEaBGr9raz+x8qBm0WZrmHCkMbtpajRzOM3B6qA@mail.gmail.com>
Subject: Re: [PATCH] send-email: new option to walkaround email server limits
To:     =?UTF-8?B?6LW15bCP5by6?= <zxq_yx_007@163.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        viktorin@rehivetech.com, mst@kernel.org, pbonzini@redhat.com,
        mina86@mina86.com, Ramkumar Ramachandra <artagnon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2017 at 8:03 AM, =E8=B5=B5=E5=B0=8F=E5=BC=BA <zxq_yx_007@163=
.com> wrote:
>
> Thanks for your reply , Junio !
>
>> =E5=9C=A8 2017=E5=B9=B45=E6=9C=881=E6=97=A5=EF=BC=8C09:54=EF=BC=8CJunio =
C Hamano <gitster@pobox.com> =E5=86=99=E9=81=93=EF=BC=9A
>>
>> here.  We need to find a better name for the option.  Perhaps
>>   "--batch-size=3D<num>", "--max-messages-per-connection=3D<num>" or
>>   something?
>>
>
> --batch-size is ok with me
>
>> - The code seems to do the "logging out and the logging back in"
>>   dance without any delay in between.  Is it something we want to
>>   consider to add a small (possibly configurable) delay in between?
>
> It' s a good idea to have a configurable delay.

It makes sense to have a configurable delay for git-send-email
unrelated to this option, I'd use a facility like that.

A lot of mail clients just sort based on date/msgid or whatever not
date/subject, so the rapid-fire output of send-email often arrives out
of order because it's all sent at the same second. I'd use some option
where I could send a series as "all" and have it sleep(N) in between
sending mails.
