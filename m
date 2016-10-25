Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253242022A
	for <e@80x24.org>; Tue, 25 Oct 2016 09:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932586AbcJYJa5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 05:30:57 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:35389 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755405AbcJYJa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 05:30:56 -0400
Received: by mail-yw0-f182.google.com with SMTP id h14so9315158ywa.2
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EGqgRkReCZnp4SjJnc++TKdC/4U24o4gNTiKk/cBr3U=;
        b=S8xN2fdNrLgEbIAM83LNYsJ+IO+lbDHb57dHspsTMQwrLwMEyo2Ka+2QLxKT3ryPcj
         Jk40u42b+g5k/8DaPNcImKqq+EO12mIo4Cl+LFEBwrSM7kZjDmzXcpzJPEH6eYjhKLwD
         YmS6wSLOcjVveBs83IpwW3RcqkC6LLoDSB495AXTqeN3eH3+eYaOynlyc5axQ5gXUlnU
         wqcxeBK1YBzU0tl7SS2Xr6EdI//6k7535SK2GltwcD/z15cop9V+m/TF+OS17Jh4w2tY
         M+nwA7M/1FhM+6TAVQQF6rhyyGzHd0qehuA6I7MuxXQERGj9Vs3HV4Q5xs4aU36kc5An
         Y6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EGqgRkReCZnp4SjJnc++TKdC/4U24o4gNTiKk/cBr3U=;
        b=CPQI6/L/7CicgDTWRhpR5tUtLpdzJpoLtvCP4PAyDIdQDZ5TBC85aUI69gGgnXpZ0E
         eo1hdneg9cp5UqwYTTkj4OKvZ6vj3VK5EY3yml+8Axm8DKQEGhhLk+lPHc+c+el+mRH+
         dz1HZ0hpRFg8JQ93/5LlSKin8rKY9P+Bk5iZl0uDQjcn+LaTjaA1G/FTsy7TPKYF1Nnj
         KtmP7StDNijD//5H1wmRPo5dwUyPUecH2+CDLKHCLAFyRzuEBI2U9BGahdkLxDOsHxYD
         gAl7U2CmMq0Y0OoROcpKMBrekNHn2q4lc1+F/jFEk/LeZlYHeYw/tG0ouqKgeJWsjk14
         AW2Q==
X-Gm-Message-State: ABUngvcrxucLKlTgeimhjUccKgMzVVRRI4Y2NCNje1fHVYjIs852P0aV33In+hKLKyktI9/xaLErp47e9pqnTw==
X-Received: by 10.36.103.201 with SMTP id u192mr948994itc.3.1477387855733;
 Tue, 25 Oct 2016 02:30:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Tue, 25 Oct 2016 02:30:25 -0700 (PDT)
In-Reply-To: <xmqq8ttd7h8g.fsf@gitster.mtv.corp.google.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org> <xmqq8ttd7h8g.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Oct 2016 16:30:25 +0700
Message-ID: <CACsJy8BBwWRGSyJDYQ7THj7quu4=T1xT_-KojQd45Vye4Kgcng@mail.gmail.com>
Subject: Re: [PATCH v1 00/19] Add configuration options for split-index
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 1:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>     - splitIndex.sharedIndexExpire
>>
>>     To make sure that old sharedindex files are eventually removed
>>     when a new one has been created, we "touch" the shared index file
>>     every time it is used by a new split index file. Then we can
>>     delete shared indexes with an mtime older than one week (by
>>     default), when we create a new shared index file. The new
>>     "splitIndex.sharedIndexExpire" config option lets people tweak
>>     this grace period.
>
> I do not quite understand this justification.  Doesn't each of the
> "this hold only changes since the base index file" files have a
> backpointer that names the base index file it is a delta against?

Yes, but the shared file does not have pointers to all the files that
need it, which could be more than one. We know one of them,
$GIT_DIR/index, and possibly $GIT_DIR/index.lock too. But those files
people generate manually and refer to them with $GIT_INDEX_FILE, we
can't know where they are.

> Is it safe to remove a base index file when there is still a split
> index file that points at it?
>
> IOW, I do not see why it can be safe for the expiration decision to
> be based on timestamp (I would understand it if it were based on a
> refcnt, though).

Problem is we can't maintain these ref counts cheap and simple. We
don't want to update sharedindex file every time somebody references
to it (or stops referencing to it) because that defeats the purpose of
splitting it out and not touching it any more. Adding a separate file
for ref count could work, but it gets complex, especially when we
think about race condition at update time.

Timestamps allow us to say, ok this base index file has not been read
by anybody for N+ hours (or better, days), it's most likely not
referenced by any temporary index files (including
$GIT_DIR/index.lock) anymore because those files, by the definition of
"temporary", must be gone by now. We should definitely check and make
sure the file $GIT_DIR/index points to still exist. I'm going to read
the series now, so I don't know if the previous sentence is true.

It will probably be harder to handle race condition at updating
$GIT_DIR/index, which could be avoided by a sufficiently long grace
period with timestamps.
-- 
Duy
