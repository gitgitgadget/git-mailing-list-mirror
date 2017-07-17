Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A94E20357
	for <e@80x24.org>; Mon, 17 Jul 2017 17:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbdGQRRD (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 13:17:03 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:32774 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdGQRRC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 13:17:02 -0400
Received: by mail-pg0-f46.google.com with SMTP id k14so83109745pgr.0
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 10:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3rDyBaCZnmajzBEDosPWBGeq6f+X4bd5ibJGwHVQGn8=;
        b=pzrmneAQl/RdMZGxkgAD5Zj8QVc5ukXKu7bfQR9/SSjhU9eYD+LhPmWzlSDmNK1C8Q
         nBCgWpYaPgrBnAkLYMEVjXmsfB6uOQHwJRGenGCvYk4pyq8PuR+RslefdreCKUEigjs5
         9oTfPX1Q8bkJmIraybcRmyGvfgTjyHbfPFf8CULtH4xpqIs59ZBilIkuRN6viBsNkEfd
         SMWF3JDypygTSL4bt8+cv9Cgx1EC3BEU4nW74AE8q5OzncE7ActrzqFleCB+UaSIwSfC
         zVMjUlnmxU5W1zLS2FFKQXUm+MXSt58NBPmhvUllv/Xbs86oXYITtvMrQbhDMMmywZQF
         R2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3rDyBaCZnmajzBEDosPWBGeq6f+X4bd5ibJGwHVQGn8=;
        b=sHP1Z1nYTrFnrelJr3SD8bdeoDf1rq3tarOz59mI3lZ+4bJ+SfgtJ+XG9jay4/wUX8
         jTtmag7apcOIkZ3y0OyJxtEagOFp90/E83diYcsidd6UDqSDxOXHHwQScc+hFa2WfJD9
         9ETQvXloC+hJh0Xakwc5mu9Md6tjuysN3Q3n/FKXyO1wXQSPqml6DFUdtFyl6tCdZYn1
         06ZxlXBxpvTI5a9RrJ6Mtw1+8O8tj3gjKD31CeSJopXNwtWU9bc/ZECGWNA8pgy0M00Z
         6maVnx5cTil+8ZmpWJ3XunW9ySnAA48J6Lqe/F/QP1tI+4EfJIctvOkZleMw57Wj8VAH
         Qyhw==
X-Gm-Message-State: AIVw112qtpSem77T8jrkK58tF/m6Cc0UrkPl+ubrwKG/3eXGybBAoQy5
        k5JKE96k0VvO44o83yw=
X-Received: by 10.98.209.22 with SMTP id z22mr19916819pfg.141.1500311821269;
        Mon, 17 Jul 2017 10:17:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:480d:579b:4a3b:27f3])
        by smtp.gmail.com with ESMTPSA id t78sm42399930pfa.48.2017.07.17.10.17.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 10:17:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Brabandt <cb@256bit.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit & merge: modularize the empty message validator
References: <20170706044640.GA11020@alpha.vpn.ikke.info>
        <20170711141254.7747-1-kaarticsivaraam91196@gmail.com>
        <xmqq8tju3eqp.fsf@gitster.mtv.corp.google.com>
        <1499950837.2427.1.camel@gmail.com>
        <xmqqr2xkxlpo.fsf@gitster.mtv.corp.google.com>
        <20170717090838.GA17826@256bit.org>
Date:   Mon, 17 Jul 2017 10:16:59 -0700
In-Reply-To: <20170717090838.GA17826@256bit.org> (Christian Brabandt's message
        of "Mon, 17 Jul 2017 11:08:38 +0200")
Message-ID: <xmqq379vhtkk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Brabandt <cb@256bit.org> writes:

> On Do, 13 Jul 2017, Junio C Hamano wrote:
>
>> I think many people know about and do use the "delete all lines"
>> (i.e. ":1,$d" in vi, or \M-< \C-SPC \M-> \C-w in Emacs) to abort out
>> of a commit or a merge.  I just do not think it is likely for them
>> to leave Sign-off lines and remove everything else, which is more
>> work than to delete everything, hence my reaction.
>
> In Vim you can also abort the commit message using :cq which exits the 
> editor with an error code.

Sure, but it's not like we are trying to come up with an education
material to teach people how to abort their commit in progress in
this discussion, so I do not quite see a relevance of your comment
to the topic at hand here.
