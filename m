Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0F641F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 01:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeKUMFi (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 07:05:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39643 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUMFi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 07:05:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5-v6so2958731pla.6
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 17:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1cOGy9khagdqfGvjfU9SDnLACAuA2e7zbPMPE9fwjRs=;
        b=NPT6W8pPLGgY6QX1bckvCjTDWQXDFIWo4gEBFHgTlvMWoIvfZmAU3VAlhFis+j0dpn
         DuasPvXmD0F8TaeDioJY+t3FQJuT51ctI6nUDMBPlA2REG3wbDh2QI31l1cboe7Rye5w
         Z6DQ0x739Nl7Q3ZK1EC/vc4KfN73FC24wi5qX0bfj2N2gYtZbuOlFoJXLuzfciclF97/
         0LH9X0Gn1yMyHfOGhTJmGWPyzkvOKvTYH4rG8X6EFD5VEkHEyTdwhSrcWknlNqvsckoy
         QFZraf8YKIba0J0cXS9ySuLglG+A0UFBQ/+VB04q5DR0L8YziJeQeu+CuPz9QvdPvUsS
         aADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1cOGy9khagdqfGvjfU9SDnLACAuA2e7zbPMPE9fwjRs=;
        b=Ipxm81Sf3dQ1g7VR/4as601hzjB5ey3z8UcMJGyGGua6qeyMp5s5OA0F/nI1urk/sU
         kgRcaVo/I3gpejj+fkmrmFSMj8/2XCqApN6jx57bitZNLruwZwcYIOcyCdprX+w2eidK
         8JC7MRFSqyWwQBvTfMzVyqCvayPWQkd1ZTWeADptAcbgAFDkvVFVbD+ylnjHomLnMrQ0
         AQrpd6XOni+WqC+5Klj54/8pF/xCbEg+S2WAz9gY28x2ApVA+avOlwshSXkKbzXZo34U
         MF7ffluYQkaBJQms0eS8MobfrZNLl63uo6RKyV/nupm/ohXbsnJY7a8ZmjUWXNh/qvx8
         cLsA==
X-Gm-Message-State: AA+aEWaqdAaSU/usTqsQGVf8ADrrqiWf8/BNvPVHP/6gqDKNJF9iftCX
        0OeRFPWXHZp3NTAk399UC/4=
X-Google-Smtp-Source: AFSGD/UdSvjCfg0+zxhcLdpTxL7Cmin0GdmzdHIQowlUkOO5qK3KlEG+Qb4LNza9R4SJ9bpbrAptQA==
X-Received: by 2002:a63:da45:: with SMTP id l5mr4156387pgj.111.1542764009206;
        Tue, 20 Nov 2018 17:33:29 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id l5sm450440pgp.82.2018.11.20.17.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 17:33:28 -0800 (PST)
Date:   Tue, 20 Nov 2018 17:33:26 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Xenos <sxenos@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
Message-ID: <20181121013326.GF149929@google.com>
References: <20181115005546.212538-1-sxenos@google.com>
 <87r2fm1hey.fsf@evledraar.gmail.com>
 <20181120011841.GB62243@google.com>
 <87r2fgyth8.fsf@evledraar.gmail.com>
 <CAPL8Zis6Jz3=Jb0JxuSyHczYQrrrqP3JGiov1ZuH2A_0x=dpVQ@mail.gmail.com>
 <20181120220626.GB149929@google.com>
 <CAPL8ZitZMSOLRZ3pQW_9qatdTPhZ69fG1A=zRk1QVLARAawiuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPL8ZitZMSOLRZ3pQW_9qatdTPhZ69fG1A=zRk1QVLARAawiuQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Xenos wrote:
> Jonathan Nieder wrote:

>> putting it in the commit message is a way to
>> experiment with the workflow without changing the object format
>
> As long as we're talking about a temporary state of affairs for users
> that have opted in, and we're explicit about the fact that future
> versions of git won't understand the change graphs that are produced
> during that temporary state of affairs, I'm fine with using the commit
> message. We can move it to the header prior to enabling the feature by
> default.

Yay!  I think that addresses both my and Ævar's concerns.  Also, if
you run into an issue that requires changing the object format
earlier, that's fine and we can handle the situation when it comes.

I don't have a strong opinion about whether this would go in the
design doc.  I suppose the doc could have an "implementation plan"
section describing temporary stopping points on the way to the final
result, but it's not necessary to include that.

Thanks for the quick and thoughtful replies.

Jonathan
