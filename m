Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B835F20248
	for <e@80x24.org>; Wed,  6 Mar 2019 23:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfCFXpG (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 18:45:06 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:38852 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFXpG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 18:45:06 -0500
Received: by mail-wr1-f41.google.com with SMTP id g12so15354637wrm.5
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 15:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/k9L+cJ4dGL18lr+X/n919BqvLQo3427VYkJnaFjrC8=;
        b=Q0x7GvFNb60eJOGQzXHGYc7oiX2TUJMOcderK+nGy/Pf68f08dvv96yltK6AT0hvBY
         tXSEqDtoRHXjBfQ5BoYcnaVWgHF6AZr9pKErtKuZ6Yk2JJhAbnIMFnFMQm3Y9vVEHNUw
         lgC8zuUHJkuKIAEBtr//YtrIWPJQPy6aa78Z+SHSChPGCsnQ2K8rR5cCyf81lmBBluuO
         6atgz38VrVuVvW/6AfBZVIqwe2qvSBfS8cz3vQ8VLLxhIDrbDMQ29JsBzkWtkDZf1wWE
         0ggmVrWsx5Wg/yL0hO0+ULFNwK5GwrRIeU+JyRIChW8OhX3WeVdzPoPM0SVZ2q5dfjJN
         a6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/k9L+cJ4dGL18lr+X/n919BqvLQo3427VYkJnaFjrC8=;
        b=ufjt9yoLybhLyO0Vz4akwSiljBXJ2/vTMan3+MBZlKekM1lwFIPOt/dZDLHlinMEt4
         r07oVc39Yu9v8GFeiCyKjbqScCoa3iCjHToKge9CSGPP8BcJl17N9/75kfXdmrhKxV5p
         kSqjXfD80Ic8hGDTnO5bRQSycQhfyE71bCHkgvkit0vm4ZZqVFVrA3l2hpWQ8rcrNTQY
         tsd7lA3gcVbhx5V1wSJgN9PsCmix3CXIFmZftLzl8zicdUPdlZRK2QJtLgL0dWmbL5C5
         bzrx84a/o8LDQqEg4IUthxj8O78tU+KsOckEh5b3LXGIz05V/0D6xWb0PbgonV7uRU7+
         zoIw==
X-Gm-Message-State: APjAAAWdMYPEsaBOrdCjVsPQJ2qYQ7fSNulsVlS58s/FYoXyHyVhb/Wd
        /qwtb5e75OXXSLXFjZArMao=
X-Google-Smtp-Source: APXvYqznIgmXZTv+K3TyzNxhB+C0OpUBBw5Qw1sZTR1Gc7HEdInA2yoz7IhSXftMVw6iGXBQY/g0Dg==
X-Received: by 2002:adf:cd87:: with SMTP id q7mr4991388wrj.92.1551915904414;
        Wed, 06 Mar 2019 15:45:04 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u17sm7435893wrg.71.2019.03.06.15.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 15:45:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
        <20190306044302.GB6664@sigill.intra.peff.net>
Date:   Thu, 07 Mar 2019 08:45:03 +0900
In-Reply-To: <20190306044302.GB6664@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 5 Mar 2019 23:43:02 -0500")
Message-ID: <xmqqlg1rpny8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think this merge message needs a slight tweak with this v2; we don't
> document the failing now, but instead just fix it.

True. Thanks.
