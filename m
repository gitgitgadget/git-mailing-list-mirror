Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D6D120248
	for <e@80x24.org>; Mon,  8 Apr 2019 21:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDHVS7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 17:18:59 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:36985 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDHVS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 17:18:59 -0400
Received: by mail-pf1-f173.google.com with SMTP id 8so8353774pfr.4
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 14:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Q6HGcF1Ok43dKm9hY/nIS2AF+6GGQI5y/1ymZItEMQo=;
        b=YuQEmb+R639oHEdj8GFFc62xbi1v9et+oFOHCpQ0s+sxkoM7+U+K2z3UZHHl+H67bZ
         pf4oLXK7BjfWFRGgv6qZOSjj8icMfXE1BHLTEgqMOpE+V0cYqfveTzNwPSdyQelruvGJ
         PcqNF+nA0bfLFGsGUwvUiF8iq6quppWbxwXQ1BSqZhFMjqnYcYPJR6UNnQoIY6D/JccC
         t9cJYkHqoMC2URXqAi1w/V12RSrxIUaSljaZl9eqUhTjgtD412ZBVLowB2BZ7YVNHyhZ
         d30mPGJtKz2Mr0YJjedpnHdmGqM8A8BFgtIK68OWFsff/oDTxaxoxen8W0GWOd5TjYDk
         MNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Q6HGcF1Ok43dKm9hY/nIS2AF+6GGQI5y/1ymZItEMQo=;
        b=dyfq+ILhOE8FmYNw4iZR1ugtm9P2n6bS0StUIVE2fVI8wGyrOaQxNTZYlWEKaTmfW2
         khlel8Dk0nCYlbE9YyZoPJ/7fIK2Hzb4SKCXu2ikoALOle91rv9na2sHXAqcLMS6cSrc
         NCRa3dIorruKxMIdwIx/KfuApU5cehFhwlEaRWq6OfZpQas48sBSxMMEycXShz69TXDs
         VxIWsnqoj+8XWmfgdPpE9nOtfcpd8WOwEY49j+S8D/iGX3erg82hJMOs7kaCX2/Y8cLi
         bIyI5JvsL2es40WecABv+IYNfnZikm0xXPsu+7+wwX4djbUqdEcXdrUH4bvIi5eiCz0t
         rHRQ==
X-Gm-Message-State: APjAAAV9tD2oNzdaT8EG6SLfjJQeSLi4uXj6bqnrnG2yTHNhTJDgNJMx
        JJDfe07pHfL//mpSfuv3/9VY5w==
X-Google-Smtp-Source: APXvYqz2GvTgonmW3z2e94EdgXc2jv59NjCMKsU73Zu5fEW6nzXc6E91oTPElJGy2jKnSRih8Co2xA==
X-Received: by 2002:a62:ed10:: with SMTP id u16mr32686498pfh.187.1554758338116;
        Mon, 08 Apr 2019 14:18:58 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id 10sm18686712pft.100.2019.04.08.14.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 14:18:57 -0700 (PDT)
Date:   Mon, 8 Apr 2019 14:18:50 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: What's cooking in git.git (Apr 2019, #01; Thu, 4)
Message-ID: <20190408211850.GJ60888@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
References: <xmqqr2aidpxw.fsf@gitster-ct.c.googlers.com>
 <87ef6eaoub.fsf@evledraar.gmail.com>
 <xmqqa7h1aznl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa7h1aznl.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.04.08 13:28, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > unique (AFAICT "actually unique" in practice) in the parallel in-flight
> > jh/trace2-sid-fix
> > (https://public-inbox.org/git/4352952677a11776a18ec9b6862cf358307cfafd.1553879063.git.gitgitgadget@gmail.com/)
> >
> > I think it's fine to merge js/trace2-to-directory down as it is, but do
> > you/Josh think that retry logic needs to stay with that sort of SID?
> 
> I do not speak for Josh, but I think the only two logical choices
> are to open with (O_CREAT|O_EXCL) and
> 
>  (1) fallback with .%d suffix, making it clear that we are not
>      willing to lose log files even when SID generation is botched; or
> 
>  (2) die/BUG when it fails, making it clear that we do rely on the
>      guanateed uniqueness of SID.
> 
> A distant third may be to warn when open with O_CREAT|O_EXCL fails,
> but I am not sure what its value would be to do so---especially if
> we trust in the "actually unique in practice".  Between (1) and (2),
> I have a slight preference to (1) over (2), as that is much easier
> to explain.
> 
> Those who want to have a "fixed width" thing could just ignore the
> ones with suffix---as long as the "actually unique in practice"
> claim holds, doing so will not lose any non-negligible amount of
> information anyway.

I prefer (1) as well, although I would be happy to re-write this if the
list consensus goes the other way.
