Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4BCA2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 23:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbdKUXo2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 18:44:28 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34114 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbdKUXo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 18:44:27 -0500
Received: by mail-wm0-f51.google.com with SMTP id y82so11740787wmg.1
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 15:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=GwOatsucztU9I4tpkvRDYnYjWFn/tdACALgvBHgQw6A=;
        b=MQTFU2nqk6emviXBEr3Z/NCt6pd3TNYW3me/Mzg1R0s2zhAVueNEg2iZa89gxOlcrO
         B2NVQzgG6JT0A+APPPVkgcp8sriU7EjRcwwHD8vslWkVxkaHSPH6CgRtinws7XAg2Abn
         kQXdVYd2p5G6LFopxZmi58mITYr7FN3VS+sYlqvcfrnkyu9NaEuPA/nOzVFzvR+Fv+rq
         PwQ16PUd1eFCdVX9v1ml0RvGeJwA/m3xztYeqbPDRG8PstJqvXqsWXW5Qf3J9BulHx9R
         KMgzehsHfY8extBAZWV4JhvpHL0tvO17zpKva7HXHAxowAuSpvwmegft5bMZvg0OUKaB
         /CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=GwOatsucztU9I4tpkvRDYnYjWFn/tdACALgvBHgQw6A=;
        b=Pm+zmUIJjtFLSXUhMHc+K2BJ5nFMbGHxrdPF/uCB6bkQEdg23jVtavHvvAZFpLlRiD
         QknoeWfOGqtvPRX4lFtqrR9j8vQxn3vDSRmy6lNGxbuHgmLFbZi+k7W7ZS+qZVhR+KxL
         7FbvMeNVQ7mKUm7LDAAhC+oAIHwgJ2FLpCwvMTGKWUwl0GqZ76q8YXzP3pt0Cw2j1MS7
         ySUHAzZsVBiv3oB++URCgdxlFmMT5opCRPk9VEhOwk/8FcBB5k0cWoQqMniFgymWW2lX
         DOy1ykPVrWtzwRqySHGCLgymfXtn/wAKFhPHD8dayrWEPmmQ6PbSWvNEZHijSpzrVM07
         LxVQ==
X-Gm-Message-State: AJaThX6nxt7wfAK/po1H/tI1RVNv/s/VgcbjPwSZuuCRRmd4524FbpOr
        m192wiZF4o+3NPO0uEEQSQs=
X-Google-Smtp-Source: AGs4zMb83tXW32U3EDfT9fkh7suvq1ms3M/P+linKyf+DIb27Czpmh2FZHyEmOtz8/NWZKJZ8NbQZA==
X-Received: by 10.28.95.7 with SMTP id t7mr2819412wmb.86.1511307866474;
        Tue, 21 Nov 2017 15:44:26 -0800 (PST)
Received: from ?IPv6:2a02:8071:3185:fe00:49e7:d49b:c24c:dad6? ([2a02:8071:3185:fe00:49e7:d49b:c24c:dad6])
        by smtp.gmail.com with ESMTPSA id a5sm10071632wra.87.2017.11.21.15.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2017 15:44:25 -0800 (PST)
Date:   Wed, 22 Nov 2017 00:44:47 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqq1sktoiih.fsf@gitster.mtv.corp.google.com>
References: <1510872031.23230.7.camel@gmail.com> <xmqqpo8hu1fi.fsf@gitster.mtv.corp.google.com> <xmqq375dtwnr.fsf@gitster.mtv.corp.google.com> <1511112703.8109.5.camel@gmail.com> <xmqq1sktoiih.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Documentation of post-receive hook
To:     Junio C Hamano <gitster@pobox.com>
CC:     git@vger.kernel.org
From:   Christoph Michelbach <michelbach94@gmail.com>
Message-ID: <A82275FD-C9AC-4632-A5E8-ED86CE2AC67D@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On November 20, 2017 2:17:58 AM GMT+01:00,=20
>How about this rewrite?  Would it consider all the points raised and
>make it easier to understand?
>
>    This hook is invoked by 'git-receive-pack' when it reacts to
>    'git push' and updates reference(s) in its repository=2E

I think it's much more intelligible but a hint as to when this happens wou=
ldn't hurt=2E E=2Eg=2E: "This does not happen if the user receives the mess=
age 'Already up-to-date'=2E" That is if this is correct, of course=2E 
