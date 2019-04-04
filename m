Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AA99202BB
	for <e@80x24.org>; Thu,  4 Apr 2019 07:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfDDHYA (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 03:24:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32805 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfDDHYA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 03:24:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so2316082wrp.0
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 00:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=/T4ToK6Kpy+e2996t91+37sWi3sVTsD485NGAOR/DpA=;
        b=TJZHUHCQJj4OaSmbYuNdVaGyAhZfX0Qg2QXFde14ZVGyesY9msHPkWhhYEl0Fp1PQK
         v0H8QFdTupK4A302nfal6GIPouph8ucDptB17NDxTMbT08OfQ2HMDEyw9hrWYvDHmLof
         R+Kd+wRK2hOMaDL61OGRJ7+3KqfuvccZBDHWihwhcre9GW/QOz1eR28z5MrRqafhGMaD
         tpRqK2FufKwqyGEnx4x0JJiZIq80q/iFKAOdow1AG7KNYuGpdiwG5fL/8baUZvr7Joo4
         F7I8vt3zEd5jueBOmxg4G18TwEGpdLk/5v5fQknQzayKQkpdv3PXGiTh1Mvw/35h2WQn
         EgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=/T4ToK6Kpy+e2996t91+37sWi3sVTsD485NGAOR/DpA=;
        b=lYW02fy+YGdVmQQ3U68yhTcET1ornPA+oe6WeP+JCYzfIEGfIBmqmoY1h1eC9Y+sM8
         bhK+JSjXnUMu0lRq9bSt4Y1lEtiEjQaIBpk3TSPIQjXgyvraF9kwYwVgjgp+tNFkn2ia
         XN6ax9WmCptqRMDfEh/i9YBH9KKOT8DiKid4RSLnvzSy73hPosUl/E44az+hkzSqTi30
         mzC7zknALh9IExjOxHIjHpCW+t9ap1r4J8XqWcGeSnxU2RYXRLCpgHWIiSLu6dbtSg0A
         dG1Bd+MpBogJEX6N7/D7ZlVGMSyO2w0JRP4lUaPahy9WoXIn1/oKs+MC3PFNqyr4SPW4
         dH0w==
X-Gm-Message-State: APjAAAVpJe59TaKdp6BGXEWvQspNARjnT8u0syMxUlIYVy11dW2WKYAd
        aoIrtCqyc6cm03kdOUtY7/Q=
X-Google-Smtp-Source: APXvYqyDIzBW2kTdOUSOQmnxvgDnzKFMGGKP97Q9GP39lNQSwryPljeToiJe6MP69vVafRCg2cgXhg==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr2699695wro.232.1554362637938;
        Thu, 04 Apr 2019 00:23:57 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o1sm21525381wmh.47.2019.04.04.00.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 00:23:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v4 00/11] Many promisor remotes
References: <20190401164045.17328-1-chriscool@tuxfamily.org>
Date:   Thu, 04 Apr 2019 16:23:56 +0900
Message-ID: <xmqq36mygrn7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> This path series is a follow up from the "remote odb" patch series
> that I sent last year, which were a follow up from previous
> series. See the links section for more information.

When this topic gets merged with the "diff: batch fetching of missing
blobs" topic, the result seems to break t4067.





