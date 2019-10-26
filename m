Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8F801F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 18:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfJZSFs (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 14:05:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46407 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfJZSFr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 14:05:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id z22so199343edr.13
        for <git@vger.kernel.org>; Sat, 26 Oct 2019 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4kIoO5sbkH0Tn/tQCZbupOwIXpNRsBv3Ny23e4/OtY=;
        b=XkjDJvC50SLqRi00p02XezzxClWj+DF6JVIe8CS9aoJpibbHzIUm4U4IF4f+eClrNH
         e0GY3ugDVn/aRR/CQIUAEOkljJGa9WWqg2bv4Wwr3M4HmDaBhfxBIiijSUNDcizwCxzT
         ZhjSnBD+YfM+PETI/kLJzmsSlEig58CUFBLZzXJ0UXdYnS/+7lga0VSkjcGcfc1RNAYi
         VIwu+rlUbhrJvnvkngFsphUMdpb1yjXeIGbMvD7G8h8gRT5CGG8BSBneVU6/zkjMPLlK
         s/g0qPDShsK6JF1AUSVJeGZ+8TKWjXv2ubTCwccJZSWb5nN/snq+0FwyMK7dQzWSAK3t
         Fp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4kIoO5sbkH0Tn/tQCZbupOwIXpNRsBv3Ny23e4/OtY=;
        b=QWzaPCxCBrzpZkqoMpHRt9gIgAOVE3ax/KinL6Jxk8p3Ao21bLMzCbfNYDPfYhW7hf
         BDMhJdSgLCh2JrjSptAgTgtijBq3rb3ijQVYIEg0y/CV6D8+fXXGIngBGuLZ/t3rVZ94
         +NIoyp+o1nazyW+lrS2gZqrxcCr14oVEAgrk/vugJikd1KBrn4QGrL2zPAxBOgMyzAAl
         dD7PRHG/NUrqI3VMMzuN0aAlPcS2yCIHe9Xj9pSeZPjRXUaaymEnVBDrgrWBTkkMmb7m
         zCE2W1ynck63P0nQa99iXHwKzt0GVlCFGSaJVXZkiyE2zIIvCmpLxJkUC/+N3mqgA7C2
         4vbg==
X-Gm-Message-State: APjAAAW/A+oEIi7bggk+Oqe7J8BFhypKFUwwRmofyq59hW6zTjOCacEY
        7qU6lhGd/Wi5y8woq8sbnkQtH/OpE3cUH0MDbaU=
X-Google-Smtp-Source: APXvYqzXmz8J0kPUD/cRLarOuOYrYMwLXpzygarpQXjpR5nJAq/7zHnyYdrJm/tumjkz7kII0pPH2u0OSL609+J9BSw=
X-Received: by 2002:a17:906:c801:: with SMTP id cx1mr9360012ejb.266.1572113145897;
 Sat, 26 Oct 2019 11:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191024092745.97035-1-mirucam@gmail.com> <20191024114148.GK4348@szeder.dev>
 <xmqqmudpee57.fsf@gitster-ct.c.googlers.com> <CAN7CjDB9mRTNRKRoE8XfLz4in5gV6pxrKrqcjLPfthDHaf20nA@mail.gmail.com>
 <xmqqzhhpb1nx.fsf@gitster-ct.c.googlers.com> <CAP8UFD1_vnjApobt+aN3M12g8mLqOZJGyvr4oqqTax5=cmLhsg@mail.gmail.com>
 <CAN7CjDC169rv8p9ZJcoLMeisXh7eMVcE4_-bpz8XFiYUsWAakQ@mail.gmail.com> <CAN7CjDDr0vDBDi+RKA0BMTHSaVQofc=GTCEuy1mAOaQmVqhJXA@mail.gmail.com>
In-Reply-To: <CAN7CjDDr0vDBDi+RKA0BMTHSaVQofc=GTCEuy1mAOaQmVqhJXA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 26 Oct 2019 20:05:34 +0200
Message-ID: <CAP8UFD3pOL27VEO_42mXP_mfM689hRWLBU3KR0zJLgQKrX9ZPA@mail.gmail.com>
Subject: Re: [Outreachy][PATCH] abspath: reconcile `dir_exists()` and `is_directory()`
To:     "Miriam R." <mirucam@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Sat, Oct 26, 2019 at 5:31 PM Miriam R. <mirucam@gmail.com> wrote:
>
> Dear all,
> there is already a static function called path_exists() in archive.c
> so project does not compile.
>
> Maybe we could change the name of this static function and its
> reference in archive.c like archive_path_exists() for example, or some
> other you find more suitable.

Yeah, I think renaming the function archive_path_exists() in a
preparatory patch would be a good way to move forward on this.

Best,
Christian.
