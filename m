Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 834F71F404
	for <e@80x24.org>; Fri, 20 Apr 2018 21:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbeDTVQu (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 17:16:50 -0400
Received: from mail-yb0-f178.google.com ([209.85.213.178]:33655 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbeDTVQt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 17:16:49 -0400
Received: by mail-yb0-f178.google.com with SMTP id y5-v6so3506147ybg.0
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 14:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K2MYkfN+FcrO+r0ifTqxy+EZUt35TqIsMLSb4j5Ykyc=;
        b=vBLn30QDDg7AvHt8tdsq88QfedAQA59aem9qe+p6VVlMUi5G6YkkmWJrVeUHcM+8aK
         HE7VPF5aPRdf+ZV5nfXjyyxMU4vaVBJ2Ayf1ypEltAaXxg1KotBlT2+mXz7CZx84VsCh
         oE7nS5X1nEkKrrI0PxR5bUWDXyWiIS5opCryap4FE4bBb1Yu6VoGKggz0pGs/4eki/xF
         u3G3uAqmqHzsfBz0rb6jrBRbahdUFVe1SkHiAugWSXBreF5brJMW5EwzZCA+EQJOlwD8
         Dbk/cGuKTnOVo9kml1Rd9rxY2FfrUSOVhP5aWnNp9flWjpnbPdNoasovFP7ZFV9/iKYN
         L7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K2MYkfN+FcrO+r0ifTqxy+EZUt35TqIsMLSb4j5Ykyc=;
        b=oyh3CKh7+RihcuDKhdzS+UeMgqSYseVSH/CPD/2sJP0S0FpiYhshbnnL7Cos2IdZal
         bkUlFSDpxYzDQqbFCyUQp51y0S6jyyjLpC04P1xGzUmFC7HcqP9Cug6MiDXqH8Zq+SE4
         EDvWg383bfvH2yZmWyXu/h8ClgkHfnLb+dDo4iADTkq/ITq+fca4os80viaatRVwItMw
         /j4wrN5hmTTg0VWJaud+ebCpMFfUkf7KyCFxV4U89B683W3IN+uaNfh6tXKW3q4TL35O
         hWsEVyYo2XrgVTR+z3lreT/YLjgBj8HVviGzAyhITG4vA7QY/zZbcGEseHTvQHrB0eMX
         Jtlw==
X-Gm-Message-State: ALQs6tCxBFQslz5sguc5WOZzEcrPe8KMWStg7zLgS3E8dVt6pYrDUvp7
        XT4oEHNTeseatVMQ9fY6GND6h3r6imXMvcXERkYrfw==
X-Google-Smtp-Source: AIpwx4+qQOFw+rhQo0+4V2hQmyY2n3ZqHSHjTEMXeCHwmPfLvWxXRm30vGeH6DTrDBFu2YHGcBYZHA9TuBmpsFHzF6s=
X-Received: by 2002:a25:8e09:: with SMTP id p9-v6mr7280763ybl.352.1524259008321;
 Fri, 20 Apr 2018 14:16:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Fri, 20 Apr 2018 14:16:47
 -0700 (PDT)
In-Reply-To: <6fe8b38c7097c826f17e5f45e39ffbc35a529849.1524258351.git.johannes.schindelin@gmx.de>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
 <cover.1524258351.git.johannes.schindelin@gmx.de> <6fe8b38c7097c826f17e5f45e39ffbc35a529849.1524258351.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Apr 2018 14:16:47 -0700
Message-ID: <CAGZ79kZM3Q-HnPAqMUZM_NtfCumsWBtwrFT2HPkU_d95iJdzOQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] rebase -i: Handle "combination of <n> commits"
 with GETTEXT_POISON
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 20, 2018 at 2:07 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> We previously relied on the localized versions of
>
>         # This is a combination of <N> commits
>
> (which we write into the commit messages during fixup/squash chains)
> to contain <N> as ASCII.
>
> Thisis not true in general, and certainly not in GETTEXT_POISON, as

This is

Apart from this typo, this patch looks good.
