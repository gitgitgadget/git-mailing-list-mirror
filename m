Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82D191F859
	for <e@80x24.org>; Wed, 31 Aug 2016 21:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759682AbcHaVqN (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 17:46:13 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:38609 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752513AbcHaVqM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 17:46:12 -0400
Received: by mail-it0-f47.google.com with SMTP id c198so10579723ith.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 14:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4zNGljw77xjBlMqSfAo+x43zy0EKN5O5wrULNwyRhX0=;
        b=QhzFsz83Bty1Ud7K63o4IsU0iY9NFlH3U63vasMSxyE5bTdBAYQCc5UpfHf6YIWrlF
         0/qiFXiYD/Pxsusir2V6+XAOVqhRo4S0bKCB3OilVxyREbGmrwxjWpwnKL35oT0UB/Zc
         H9BBz5Kgbb1yrLX+dntoGoZkb0H08QHSU9DwPcqGVKElhd/UXJkxiQDB7SANlrGEdjeq
         4XmKQUhyd3B1oCgJYR17Or2VYE3bERHZiKzkIO5BqONhjmtELFI9X9VFpWgwxlnBNzit
         7+Kfo6Hd0ddrFDBsmyAXGcUtg+WhmXTZ/sQKxQDGWUrJmYb3xtyNQRG2Rh9F949Jra5d
         rm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4zNGljw77xjBlMqSfAo+x43zy0EKN5O5wrULNwyRhX0=;
        b=S/ab8HnRsIe2aassCteVY1ehaFUD89Fy32pnlyt1UPD7oHwPUWZ1Jzy7w0oGxkdFM9
         4fLvh4dHVi9bkDc1xDbkdEg3axPIiYnMWXWWj1vBlHCCWmIB4yARfBZjH4Xruv4GxmNf
         dAVWfWGE8FJzRM04BU4XwGfh1mDPKg+qlq4wxmPmOIBQ1mshpucrtfb8BiEowFFJEMUZ
         iGciACyWlaiL4FcT7U6jF++G+GrKVR6y8tMXdpfzQbRwDkn4pEiIYtYHuYfqfgXxyaLI
         5aG2U6ZfAPsWuSj+VWsBwSCzsMneSl+ddSAb5mh0bbn2sYWPBIKiTe0Jhz115F894XxT
         BANg==
X-Gm-Message-State: AE9vXwPRZO1irmct5GKdS81bJxKlZmusUbGL2oGanGVztUZZR1rLxzxyt+hlGX6vYEmeaG42GO/WDHFVDT8J+/RF
X-Received: by 10.36.93.201 with SMTP id w192mr10216389ita.52.1472679971343;
 Wed, 31 Aug 2016 14:46:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 31 Aug 2016 14:46:10 -0700 (PDT)
In-Reply-To: <20160827184547.4365-3-chriscool@tuxfamily.org>
References: <20160827184547.4365-1-chriscool@tuxfamily.org> <20160827184547.4365-3-chriscool@tuxfamily.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 Aug 2016 14:46:10 -0700
Message-ID: <CAGZ79kYzOh-trnnc2JH9QX21DX=6nz=q0M99tbpU_Q68tmH0Qw@mail.gmail.com>
Subject: Re: [PATCH v13 02/14] apply: rename and move opt constants to apply.h
To:     Christian Couder <christian.couder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 27, 2016 at 11:45 AM, Christian Couder
<christian.couder@gmail.com> wrote:
>  extern int check_apply_state(struct apply_state *state, int force_apply);
>

With greater scope comes greater responsibility. Nit of the day:
In case a reroll is necessary, consider putting a comment here.
(What are these constants? what do they control? How/where do I use them?)

> +#define APPLY_OPT_INACCURATE_EOF       (1<<0)
> +#define APPLY_OPT_RECOUNT              (1<<1)
> +
