Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94B211F404
	for <e@80x24.org>; Mon,  5 Mar 2018 19:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeCETsN (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 14:48:13 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:52295 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeCETsM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 14:48:12 -0500
Received: by mail-wm0-f44.google.com with SMTP id t3so18267320wmc.2
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 11:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KWpAu2JgwrUmggxxOPnPr+6dUILpCAEELa+LvmaQoY4=;
        b=hklV/Dv59JL2WCx9vvOpefyoWpZdznpihR2JMB+jlf4qlZ8MVg9WVKx6UdgLx/DfZQ
         5QLKTeHX+dg7dP1L1rzyAUfU6ML4IH37AomvpbMZoa5oo7ztywHOIk/a0+/7tJrbcyUZ
         G0G/HRYlTaInA2X8bk+kujWHQVuTWKejCFOXX2VlPebWZpJgZzKQTEEsuP0iKh5zpIt4
         Mh7KDwsc+FaBB9/+utdNsStzlhgKqeraYH2BNXAI9lgnW3fn57aCH2R54V+UABz4JMqg
         2u9Sf0ic4pE6WtBXmhn1c6s7X7VpA6al3qxXCniEG8N3+sila9bSlP98EsfgmZGrbIuk
         u8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KWpAu2JgwrUmggxxOPnPr+6dUILpCAEELa+LvmaQoY4=;
        b=LXxSdVpCdmYpBEvOHWBlfQcgUO5LBF83jmG88uHa9a+Hotoeeei8zdlJ30wZqfe7Rd
         +pGsjmQ4h2LC48HFqp3fjeMPuZJpsloMqns5jpG+A0LA+ncEF/WpsgcT6bNwfwcuuRPP
         D/dz2140at9Ul4sdrZDVuXW0X/TY1VFtySIlawUeDI7U1SWM1QYjFfDoCXbNsF+flv3e
         KVTcCfM+mGWoMjYxMmaugB0jTJnohKqDDSzXp/kkWPdtxA/IyKDrBWKeGhfCz/YZFdQk
         rxY2pdWwkE5roRR+ZNbZ6PEE0LL/U+1AKJqvwXN2ej04OknUHMWBPS/puk5FJypzJ1Ye
         d3fw==
X-Gm-Message-State: AElRT7G6YvuWDyoTbZHHGhF/APl7c5wjgUQ1ZVP46xXDIQWZBAy2EeKW
        R+PglkPPMZ7Ss6wozSPv07af8w==
X-Google-Smtp-Source: AG47ELv8vP80+jOWBce71XVVvepLGLXMrJ4F1CiwakqNdUbKvgiHyX+Ks3ZiqEu+IVp8eUXzrvD3Sw==
X-Received: by 10.28.169.79 with SMTP id s76mr9068002wme.48.1520279290977;
        Mon, 05 Mar 2018 11:48:10 -0800 (PST)
Received: from ?IPv6:2001:a62:81d:ab01:1464:abc5:81f1:7b9d? ([2001:a62:81d:ab01:1464:abc5:81f1:7b9d])
        by smtp.googlemail.com with ESMTPSA id b9sm15443994wrh.68.2018.03.05.11.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Mar 2018 11:48:10 -0800 (PST)
Subject: Re: [PATCH 1/2] git-svn: search --authors-prog in PATH too
To:     Eric Wong <e@80x24.org>, Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
References: <20180304112237.19254-1-asheiduk@gmail.com>
 <CAPig+cQARx4eZFHyRpikHJYaz42NKq18fjt-=KYOX2GddDPNDA@mail.gmail.com>
 <20180305175243.GA10325@dcvr>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <7767e8ea-5a4b-5088-47e3-f9f2eb7ffae9@gmail.com>
Date:   Mon, 5 Mar 2018 20:48:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305175243.GA10325@dcvr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Am 05.03.2018 um 18:52 schrieb Eric Wong:
> 
> Thanks both, I've queued 1/2 up with Eric S's edits at svn/authors-prog.
> I'm not yet convinced 2/2 is a good change, however.

I'm not sure which direction your argument points to: Do you object to a
$PATH search at all? Or would you like to remove the legacy code too?
Or is the code/doc/... in bad shape?
