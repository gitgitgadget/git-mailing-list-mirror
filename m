Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3D031F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 19:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeKOGCm (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 01:02:42 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39350 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeKOGCm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 01:02:42 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5-v6so8281457pla.6
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 11:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=klqoGHccBgp+07knWJ0eygS26taImtbasevP+wgXo8A=;
        b=YCeZvmTGyiL5Zrh+amlOQeiCGD2ydACz7WarQuVWCxvcW7dpUjUyCydDiWGBkMyaH6
         5q59qOavsg0KwPmk53mwyzG0Lt0/jbsePJHIgCabtVgXeL9YI3hQIeFC/4622Ct1Pdhf
         TSwlrFIjOXTg08rWqYOiu9PzBpcRTup2CXbdqPhWQMocMPrXMRAwJXiedhMwelYpBKcc
         1qLaEq5FykXi8xRiWao+Iu9H0P4uGRIUMYUBWgTyFcDcP1bNJ6+iHQ4WzeJdme4xi2s5
         21cdBct4fHgAr8Ug1OlLJebvdNgkb77C4TSGT27bWr/T6Q5eetLGBcJmzPfe91OvCgwg
         E0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=klqoGHccBgp+07knWJ0eygS26taImtbasevP+wgXo8A=;
        b=Pp/5BplYq0OS8ambGoaWvr/kLEJNfF2JA0zmnYcMepO6BF8j+mZaLfIHeQ8ighlMhL
         6QAuxpVqpsC6rz2P6cAcpzLBtcpf8ueAh4LxG4CRoPy9oIcYgeYP9v1E2vID/RjK5RdE
         I5senCzfiQIEzv97UfaWCeBVijKadk2WwigAxYcAVBMBPo9PWuTqE8TuhpG6VfVpidE2
         cDf6FW+8G613DWTwLdNVgearDlRMcQ7kearYvwRW4PWearZT4bEsZiybVbTjWF8xA27F
         pf7WP/NMEUI78G79PaKwgSEJcIM++lRNPSDjfUAo2SlSlgDB2TRBEEQaLX8+OiuqHsES
         UZuA==
X-Gm-Message-State: AGRZ1gLejOELRjcHHHbpDPPjqRJBjs2h4ZUTDS4JEdNOURF7vXdGrzIW
        EtOZepycg+7m/UTSbP2W+TTFJg==
X-Google-Smtp-Source: AJdET5cQI/EXyosQ6Lx0dem2lZVlx/mGlAaaGxqV0g/xmeH8NHfgPf7NDtphhRX5XGkryN1dIKiKog==
X-Received: by 2002:a17:902:24c:: with SMTP id 70-v6mr3167810plc.120.1542225485424;
        Wed, 14 Nov 2018 11:58:05 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id u137sm7013892pfc.140.2018.11.14.11.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 11:58:04 -0800 (PST)
Date:   Wed, 14 Nov 2018 11:57:57 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 1/1] protocol: advertise multiple supported versions
Message-ID: <20181114195757.GJ126896@google.com>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sbeller@google.com, jrnieder@gmail.com
References: <cover.1539305180.git.steadmon@google.com>
 <cover.1542059029.git.steadmon@google.com>
 <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
 <xmqqr2fpwrqg.fsf@gitster-ct.c.googlers.com>
 <20181113225320.GG126896@google.com>
 <xmqq1s7os7rz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1s7os7rz.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.11.14 11:38, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > On 2018.11.13 13:01, Junio C Hamano wrote:
> >> I am wondering if the code added by this patch outside this
> >> function, with if (strcmp(client_ad.buf, "version=0") sprinkled all
> >> over the place, works sensibly when the other side says "I prefer
> >> version=0 but I do not mind talking version=1".
> >
> > Depends on what you mean by "sensibly" :). In the current case, if the
> > client prefers v0, it will always end up using v0. After the fixes
> > described above, it will always use v0 unless the server no longer
> > supports v0. Is that what you would expect?
> 
> Yes, that sounds like a sensible behaviour.
> 
> What I was alludding to was a lot simpler, though.  An advert string
> "version=0:version=1" from a client that prefers version 0 won't be
> !strcmp("version=0", advert) but seeing many strcmp() in the patch
> made me wonder.

Ah I see. The strcmp()s against "version=0" are special cases for where
it looks like the client does not understand any sort of version
negotiation. If we see multiple versions listed in the advert, then the
rest of the selection logic should do the right thing.

However, I think that it might work to remove the special cases. In the
event that the client is so old that it doesn't understand any form of
version negotiation, it should just ignore the version fields /
environment vars. If you think it's cleaner to remove the special cases,
let me know.
