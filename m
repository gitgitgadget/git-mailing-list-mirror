Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45BE420A40
	for <e@80x24.org>; Tue,  5 Dec 2017 20:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbdLEUHc (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 15:07:32 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:47035 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbdLEUHb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 15:07:31 -0500
Received: by mail-io0-f177.google.com with SMTP id x129so56776iod.13
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 12:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CPy37iQuoRzmdxffqwC5Y0syxO4h3EJ6ykbSS+MYVvs=;
        b=qj8gPP/DrBaBHrQHuyVQ6BU9GK706Idu/AMFigscSg7OEYnHZzeaIigVt3sB/CqLUP
         xwshtrda/6mstrmRIXrwP1HuOXkW92CTHfoupXyGer2jH1Oze+xWsXVrAqGyvGgvUf6c
         0Jy0FM69eUNI3uP1uJDiYt5s00XRIqegrE4AR8XWcS9VyrktbIvPyRpItmEz8SbHBewy
         usoFfITE+HwSntOnlV28p2DCMaUYSxP/tkOD0kKnMFLNYsDgTqtDxuqMOggiHj0xY7AJ
         jWO9p3FF9tHAySI9FwAl+1qYo3TvB0dD4Y50wC7OGU/8nPLvG22XpheEbfZs55IgQi4c
         tBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CPy37iQuoRzmdxffqwC5Y0syxO4h3EJ6ykbSS+MYVvs=;
        b=kkn+G9k88K6zuhMKkfi0uyBT6IzF9FF9atUgcpzbYzK6eYoSbgtL54X5CUDNkZElaO
         f7Mkywtm7/+sFI6C5jQJBTgKRf5ZAoyIRTRi7D3FXfTv5fxq/K/mMbq3W11HCtfyMT6I
         BXhfnV233tIKjVsH5qEWzEii+iZ7naS4F50KLhSendKQHk7NKrCDVAw96uZS9mKS3STm
         zmQmyLFIkg+TYuM5QLYIMzQoCa4zZW90bZgtF/Y5xvSKhoiU4i0wkRGX1EnPa3BPJNbL
         QtiZvutrmw+MhIZDSBXYqMekGbooxa7pvF9cTWH0tjYCMbXL9f0WrWusEymugU0yMBqR
         nLQw==
X-Gm-Message-State: AKGB3mIRmQx7/Y2b3VZlCv7sOGXH5D+QKhNfsaJodw6F7cbJNWYDfEgB
        q9ElCemVLfb9dvwDvOm3NAA=
X-Google-Smtp-Source: AGs4zMbAsGtjz2asOrbccCZXwrzlzGf4Yyqt54eaurf3gFAAJWgEIeBspSZOD5lH7Js/dv/1zd+3hA==
X-Received: by 10.107.139.196 with SMTP id n187mr25867653iod.54.1512504450241;
        Tue, 05 Dec 2017 12:07:30 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id p198sm544007itp.11.2017.12.05.12.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 12:07:28 -0800 (PST)
Date:   Tue, 5 Dec 2017 12:07:26 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Vitaly Arbuzov <vit@uber.com>, Git List <git@vger.kernel.org>
Subject: Re: How hard would it be to implement sparse fetching/pulling?
Message-ID: <20171205200726.GC8183@aiede.mtv.corp.google.com>
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
 <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com>
 <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com>
 <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com>
 <C89EEDA4D8F84C6290111C04ADAE6872@PhilipOakley>
 <0e851e08-0dcc-da3b-b2c4-42afcdbf6ca4@jeffhostetler.com>
 <6C1247A43F8841F98E070C264045BF49@PhilipOakley>
 <7bcdbd52-0cfa-58b2-e40a-1852cc70ce69@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bcdbd52-0cfa-58b2-e40a-1852cc70ce69@jeffhostetler.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff Hostetler wrote:
> On 12/2/2017 1:24 PM, Philip Oakley wrote:
>> From: "Jeff Hostetler" <git@jeffhostetler.com>
>> Sent: Friday, December 01, 2017 5:23 PM

>>> Discussing this feature in the context of the defense industry
>>> makes me a little nervous.  (I used to be in that area.)
>>
>> I'm viewing the desire for codebase partitioning from a soft layering
>> of risk view (perhaps a more UK than USA approach ;-)
>
> I'm not sure I know what this means or how the UK defense
> security models/policy/procedures are different from the US,
> so I can't say much here.  I'm just thinking that even if we
> get a *perfectly working* partial clone/fetch/push/etc. that
> it would not pass a security audit.  I might be wrong here
> (and I'm no expert on the subject), but I think they would
> push you towards a different solution architecture.

I'm pretty ignorant about the defense industry, but a few more
comments:

- gitolite implements some features on top of git's server code that I
  consider to be important for security.  So much so that I've been
  considering what it would take to remove the git-shell command from
  git.git and move it to the gitolite project where people would be
  better equipped to use it in an appropriate context

- in particular, git's reachability checking code could use some
  hardening/improvement.  In particular, think of edge cases like
  where someone pushes a pack with deltas referring to objects they
  should not be able to reach.

- Anyone willing to audit git code's security wins my approval.
  Please, please, audit git code and report the issues you find. :)

[...]
> Also omitting certain trees means you now (obviously) have both missing
> trees and blobs.  And both need to be dynamically or batch fetched as
> needed.  And certain operations will need multiple round trips to fully
> resolve -- fault in a tree and then fault in blobs referenced by it.

For omitting trees, we will need to modify the index format, since the
index has entries for all paths today.  That's on the roadmap but has
not been implemented yet.

Thanks,
Jonathan
