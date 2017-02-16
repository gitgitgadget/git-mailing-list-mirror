Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52F11FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 17:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933424AbdBPR7e (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 12:59:34 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34611 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932637AbdBPR7c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 12:59:32 -0500
Received: by mail-pf0-f195.google.com with SMTP id o64so2108654pfb.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 09:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QtKrHo6y6A5vLkfnyqaCTKajkN+NF68GWcMx8AzcWog=;
        b=vTFPNO/Nmhm2vqphpZb6WwsqObdFkJbxWzMIe2RVaYqrL9YcOAX9NPmeV0kI1BHQ7C
         5NIpUz/XFgdlt4qQFxTDhOuYHN7ajrTspjPtJt/Lb3YAB6Ls3L9u5Vqo4exw0PIfclbR
         5G8hX5ub1cau6Kb8DU8KDhiIR+qeym7CA/LMGOFJgVL2tivesoHnPB8fH4i/aE0OYvlq
         wDfbSB4cT/Qv4AsJSBiknCqY8FU5abTlaV+XeB6FieRK0B/SLOF9F11AlDbWbVWpEATv
         HdJStlJ9lZrzccprc7IFgc2GHLBJSqvjhJPujS64VAJms3oVkSZUW/y4HaGiz5oexDGI
         /vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QtKrHo6y6A5vLkfnyqaCTKajkN+NF68GWcMx8AzcWog=;
        b=Xp8XhgURUO0IyfLx3eWdhow+uQcDV2IjVlQnNeR+uEGI9nnzvmrvnu1DEWtxewMKOJ
         morAKbh4OkWHIFfUpUVyRl4f1RfjZtLgBj0MEWqlWeKM77FJ+BWLJXDEYm0sHQXl8LeY
         UFrl7Mq8q8IlpQaqCOLU063gkk+l/nS28btpuY1aLfXAQNiDMsjuoNIj0boeG0SpCCUP
         AyODdJtaLtU2nGjgBduHJOl5AG4zK0YES+66aXZ1zFSiMJ/brRgDI2w7INbUQHim556p
         h/yz9cgMBO8p6JB3L4xr9SQ6wSx0hJMbbzEkNzQ91/ekEuTgtYCZfAil4+wTqLzC5Yxq
         u1pA==
X-Gm-Message-State: AMke39lx3vXEu5K0nhKvHVh5Ys9Tw5gYhF9D+OaUjRUTytfuN6RE69DAWe10nDp0AKIysA==
X-Received: by 10.98.106.132 with SMTP id f126mr4113678pfc.1.1487267966961;
        Thu, 16 Feb 2017 09:59:26 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id m15sm14841845pfk.104.2017.02.16.09.59.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 09:59:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Kevin Daudt <me@ikke.info>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: body-CC-comment regression
References: <20170216174924.GB2625@localhost>
Date:   Thu, 16 Feb 2017 09:59:25 -0800
In-Reply-To: <20170216174924.GB2625@localhost> (Johan Hovold's message of
        "Thu, 16 Feb 2017 18:49:24 +0100")
Message-ID: <xmqq60kayq2q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Hovold <johan@kernel.org> writes:

> I recently noticed that after an upgrade, git-send-email (2.10.2)
> started aborting when trying to send patches that had a linux-kernel
> stable-tag in its body. For example,
>
> 	Cc: <stable@vger.kernel.org>	# 4.4
>
> was now parsed as
>
> 	"stable@vger.kernel.org#4.4"
> ...

It sounds like a fallout of this:

  https://public-inbox.org/git/41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net/#t 

and any change to "fix" you may break the other person.

> Can we please revert to the old behaviour of simply discarding such
> comments (from body-CC:s) or at least make it configurable through a
> configuration option?

If I recall the old thread correctly, it was reported that using
Mail::Address without forcing git-send-email fall back to its own
non-parsing-but-paste-address-looking-things-together code would
solve it, so can the "make it configurable" be just "install
Mail::Address"?
