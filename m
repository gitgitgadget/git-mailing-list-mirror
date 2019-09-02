Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C83BB1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 18:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfIBSW4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 14:22:56 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:40373 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfIBSW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 14:22:56 -0400
Received: by mail-lf1-f48.google.com with SMTP id u29so10972270lfk.7
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=66zsj4Xv0FMmsKIyKn0KfvrMoEmRUuvB2bNYlRR8HcM=;
        b=lCf47YgoUtJCf15K4EkUPd18a6X3K1hnFaKr8Q2PlUBHimNGc3QRkKA69aoeaGQOgq
         qAE8MeR7U/pnn/piqfHATS8JfcfiZ+1gCcVw6YqPtgoQZFbu6pYg2C2L8AEiFFVcycph
         PSVOO1LvBQ4NicsfOAL1KKxs9bznHFksdRez1ZKICffbIkaGV1DyrMiagWF4Dw5lsyAS
         lIh5Ued0dnhmWVm5qeclC56l0aNnLHB2IitoFkt0Bhkup/H8J/EZQ6+VQTzgJLrVrXNy
         HxcUmlqOCTxB93gvEKXbmj5aMtgaxvvJMfZd7Ot+7SoFtU3SQtZzamHsbUlq3gWRS/eR
         rwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=66zsj4Xv0FMmsKIyKn0KfvrMoEmRUuvB2bNYlRR8HcM=;
        b=TT0KVR7ZLYlwbYHZzoQAIv6O5uTZLtoGsR5TYzT55Y8g+fa4EkVdBbQRdJzvLRz4wF
         HObc9gT2p2y4uWGkgexVLKGvRDFKhOXb405uDLGu0hXZcEs8h+8jh/4aXYgv6k5+ttuu
         da6yrI0aE2Kix1yrBzJmd8CRI9ea6gTw6qemY8AME2RqTgrlFzbuB0+/wpafa/Fc/0qu
         AdsrBdWUCWBjWUNbdy5PtxYpobsC5+sPZcZelN6K3PiZBhMOxI8WmekjgxmJpIu9CkBz
         QDK/HxLXTh+LLC9HYQvyWMQWDabjvp3GGjLL/a4Beay6PmGowxjrpW8qdZIHF1X4OVpR
         IMjg==
X-Gm-Message-State: APjAAAX15367DNaxg9+7gTGwEpZE3P7ZjXoLndiS+HVqn/TiOev6VKPU
        JHpOzPBjJh5zAEfpu0fK1byq67fhxJGUHOL0iNcokPaSGEczjw==
X-Google-Smtp-Source: APXvYqz+Co79pPI5cujsWXTapvc2N78VN+U+DRLQFmz1513PA+gtXv1YWriCWzPGI9ozmmwTYymUPZ/hos5ndxJyuR0=
X-Received: by 2002:ac2:5445:: with SMTP id d5mr829398lfn.43.1567448574556;
 Mon, 02 Sep 2019 11:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=+ThYVyZUiU1wnt0yL+MzF1RXvHnbwo9NWyh95cLyhNRQ@mail.gmail.com>
 <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com>
 <CAGr--=+CEX-STDgT_ZwaA=n9UHSrsgcWnxCMY=9tGDA=9XLkew@mail.gmail.com> <20190902181213.7jqvoyctdm26g34z@yadavpratyush.com>
In-Reply-To: <20190902181213.7jqvoyctdm26g34z@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Mon, 2 Sep 2019 20:22:43 +0200
Message-ID: <CAGr--=JgqjC8FskqVFJTqAnQ5aq8J4z-Wje8s22VwBgVtkBF-Q@mail.gmail.com>
Subject: Re: git-gui: Long lines in commit message gets hidden, no scrollbar appears
To:     Pratyush Yadav <me@yadavpratyush.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 2, 2019 at 8:05 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> I cannot test windows easily, it looks good on Linux Tcl /Tk 8.6:
>
> https://kgab.selfhost.eu/s/f38GX4caCZBj4mZ

On Mon, Sep 2, 2019 at 8:12 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> Hmm, it looks fine for me. Which platform are you using? I am running it
> on Linux. Screenshot: https://imgur.com/sNp5Ktq

Try resizing the bottom right pane of git gui, you should see that the
scrollbar remains at the bottom while the input area moves upwards.
If not, then it must be a windows-only problem.
From Bert's screenshot you can see that there is a (small) spacer
between the scrollbar and the input area.

Please have a look at this: https://i.imgur.com/unAflET.png


Br,
Birger
