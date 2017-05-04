Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31DD3207F8
	for <e@80x24.org>; Thu,  4 May 2017 01:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbdEDBZD (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 21:25:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35594 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752687AbdEDBZB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 21:25:01 -0400
Received: by mail-pf0-f194.google.com with SMTP id o68so794872pfj.2
        for <git@vger.kernel.org>; Wed, 03 May 2017 18:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=qWcX0htSNfnno8jCfVc90VyeRhweB63d/RQE3Co1Ctw=;
        b=sO6KPAL33Evu2A+1nXMY7sjitrUcnHtr89hmXB2+34+Goz1Do0SDrAIknas11h5WT5
         CsNYdn8bNmu4L0h38wlPsuxWezVswFPNgR6Xv8h7+WEQsFt9x1VhbW5oJBdvB2isV6zv
         Bi5w2qFelglkAO+2HHGObJCfByOu85wGmS28DNPERQXoWw5DUmFSV2ZeqCJATJ82ihep
         vw4RZHJvVZfreAu2eTM8Yh6zNSBE9wwP8soT5k40CXUPxxGH66eoDwcVIBsxaXMOJARs
         IYpl6ZQnzwNTHzkEoKmRwlnzDYS72I9F7FSdLXeVwvJC2pJHWZ2e9RngQLFi9yK9eohM
         sOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=qWcX0htSNfnno8jCfVc90VyeRhweB63d/RQE3Co1Ctw=;
        b=Vetuf2lvNoH7icEZ0RtVHLPRVIL14oHD4a/yAp3OhdSDlF1gMPNakwuDqmF7ok/7UD
         QzGFBUCZb6kW7u72ReCwCIyThDv2+6JTDdYjvrEAt7n39ryBgd0lnsTn+s4awwlz/3u5
         NZ4s0pn/4DexzbSxYjF9EYgbT/lPBZpwXaZ+ZOFyxzm6JeXOPECJQzTRx/vxspMD/Nei
         cpkmhgLjp1B95/zD0qYGz5xSJDCuCkXZaHFRGXSlZ/Rz6SSR3ZwrYY/KcpP+yWmeRQ6k
         BGb4fXh0aU6P1LHsX6KMdJzlYlLd6owx8k7q87Nk0P6xF7H94n6BvMOLkDLHvFQeHqKQ
         pl7A==
X-Gm-Message-State: AN3rC/7IayWGI9G0Y1eDYxgNhu4BjaKlMg2wTQgpVV5cThAIKNHKvET1
        HdLN7zjJaGzorA==
X-Received: by 10.99.97.68 with SMTP id v65mr32432856pgb.76.1493861101222;
        Wed, 03 May 2017 18:25:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:21be:aa3e:8063:4b3])
        by smtp.gmail.com with ESMTPSA id w5sm576118pfd.23.2017.05.03.18.25.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 18:25:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?6LW15bCP5by6?= <zxq_yx_007@163.com>,
        Git Mailing List <git@vger.kernel.org>,
        viktorin@rehivetech.com, mst@kernel.org, pbonzini@redhat.com,
        mina86@mina86.com, Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] send-email: new option to walkaround email server limits
References: <20170429122632.7122-1-zxq_yx_007@163.com>
        <xmqqo9vdiboz.fsf@gitster.mtv.corp.google.com>
        <743D62FA-65B9-4DCC-978E-DAF442AE0B0D@163.com>
        <CACBZZX6fursxEaBGr9raz+x8qBm0WZrmHCkMbtpajRzOM3B6qA@mail.gmail.com>
Date:   Wed, 03 May 2017 18:24:59 -0700
In-Reply-To: <CACBZZX6fursxEaBGr9raz+x8qBm0WZrmHCkMbtpajRzOM3B6qA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 2 May
 2017 11:58:52
        +0200")
Message-ID: <xmqqk25xct1w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> It makes sense to have a configurable delay for git-send-email
> unrelated to this option, I'd use a facility like that.
>
> A lot of mail clients just sort based on date/msgid or whatever not
> date/subject, so the rapid-fire output of send-email often arrives out
> of order because it's all sent at the same second. I'd use some option
> where I could send a series as "all" and have it sleep(N) in between
> sending mails.

Hmph.  When sending many messages, send-email first grabs the
current time, counts backwards N seconds for N message series,
and uses that timestamp that is N seconds in the past for the first
message, incrementing the timestamp by 1 second per each subsequent
ones.

I found that this trick is sufficient to cause receiving MUAs sort
messages based on date, as the Date: field will have the timestamps
that increases by 1 second in between messages in a batch.  

There might be MUAs that do not use the value of the Date: field
when told to sort by date (perhaps they use the timestamp of the
message file they received at the final hop to them?), but it is
hopeless to help such MUAs unless the mail path guarantees the order
at the originator, which is not how "store and forward" e-mails
work.

So...
