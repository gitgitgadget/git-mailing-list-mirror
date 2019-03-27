Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69B7B20248
	for <e@80x24.org>; Wed, 27 Mar 2019 17:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfC0RuN (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 13:50:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41208 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfC0RuM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 13:50:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id k8so15201276lja.8
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 10:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ANzKOcyfHMQEury0g6YDOU8Sm0A2R96cz35xvWJw0O0=;
        b=J1upB7jDQkRDPfCGBrHvjkAo3OfPtn2v9uDjq2jpFWAC8+49Onop+XdwMxrmvOLxLo
         AZjxt2tnr1IF4tpnYrRkRrp5XLFFZtbwfD+gAPpGIwjMTU3KwJArtYGV+aBSDENAMgGF
         51OmExxbu2K12kdrqWwIlnTchcGgfb2jCb+UzZwpIsesLlHoUbcfoXKcjdYcITq6Pf3T
         8sVDGAUuvBgDb8rqaZPIEdTVjzqDvuUA4B8B+0ARt9KpCBCaXOHmBq3N7vA1yXv7mGmI
         e/8aDbSeCtLN6MBnFSpm56MntnPM+XkMrFMhSCdPaMJYXfvabOarf22D2SClTifjSrPm
         SFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ANzKOcyfHMQEury0g6YDOU8Sm0A2R96cz35xvWJw0O0=;
        b=kAxMpRJwOP0rlkQkc7dQIji2pZ0i6A/2Oguv/xD8ZnqD9t6zfo2XJL3vWbLoklBz4R
         70r6ugDEckpZhth4F4QYCGLXDaycQlVlr2id2urzn5GcTWgwxyQmMNOKCnxIDMFvmlyJ
         rtVhyZ5R3tbJm5De7OlHa9968i6ErN9So1YAaY/GzlauhfvkhsyE0lrn7lhbVLjbrTGd
         DBKGQNuswgPhDIaS97YNsSpEmklIqlpqxwApvW/ChH39y4DkG7rGpABfvwikQlw9CCm2
         kf6v6sEVMyYKLaUc/yuh6I9Fa2VNYMC9E18b/+5E+yfUTVHb7+YrAXxrcDEnpWQMBT6x
         ulvw==
X-Gm-Message-State: APjAAAU/7G6NpLdhzqEd9WHPNmJPNUMm7mHhmjf4WY9RXxlJkIwpXxIR
        KJekQ9FbWi7wZolLp/6NkUO3nC3Sp02yyd2J0HM=
X-Google-Smtp-Source: APXvYqwaniFlg79Po5AZn57K/d6R8VGmqBBUYDL9KrLrf4HFqjIargPY3wFPgA1wU4oe5+Wi80q1yXUqU+nZ5AKJzkM=
X-Received: by 2002:a2e:99d2:: with SMTP id l18mr12515531ljj.27.1553709010609;
 Wed, 27 Mar 2019 10:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190323041332.9743-1-alexhenrie24@gmail.com> <xmqq36ncpgpe.fsf@gitster-ct.c.googlers.com>
 <CAMMLpeQbz5qHyK8e4gZ0zKQ5na+zQCd49GZifKZ_iO-gXrs1Gg@mail.gmail.com>
 <20190325011717.GA5357@rigel> <CAMMLpeQGz85ogLgKX6DBMyz0wpRvW9fXCpK87m+JoT9i7hw1Kw@mail.gmail.com>
 <CAMMLpeStw=qg50nbAkuKRTUTvkAhjw8kvZxxrAmTcfuK4L8cmA@mail.gmail.com> <CACUQV59x-W+fCz_O5EnbZhjZ1CB2NhEQbkR8dAYMizAQGQ2SFA@mail.gmail.com>
In-Reply-To: <CACUQV59x-W+fCz_O5EnbZhjZ1CB2NhEQbkR8dAYMizAQGQ2SFA@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 27 Mar 2019 11:49:58 -0600
Message-ID: <CAMMLpeS1RyjCu6mKe2-oDzCfXheAdpTiXM28dUfd3TyCuZwUFA@mail.gmail.com>
Subject: Re: [PATCH] In `git log --graph`, default to --pretty=oneline --abbrev-commit
To:     =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 24, 2019 at 11:27 PM Rafael Ascens=C3=A3o <rafa.almas@gmail.com=
> wrote:
>
> Or just $git log --graph --oneline, since --oneline is a shortcut for the=
 longer --pretty=3Doneline --abbrev-commit.

Thanks for the tip! I didn't know about the --oneline option, but now
that I do, I suppose I don't really need an alias.

-Alex
