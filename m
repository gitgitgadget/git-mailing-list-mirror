Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9258C20951
	for <e@80x24.org>; Fri, 17 Mar 2017 18:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbdCQSrM (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 14:47:12 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34778 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdCQSrK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 14:47:10 -0400
Received: by mail-pg0-f43.google.com with SMTP id 21so14172629pgg.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 11:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BHLm5QBDdlZNJtQUnTUbgSL9L7B4J0byxhZ9/2bFkdc=;
        b=tiqT8SeHgGvWjdYl5wNl9NQLG4ml2+ucQty5A97ROJ4r7o7YOgggTyniXOvEGfexiH
         VQM3d6g5Xn5I1fUJ+XnRZDeAekJ9Chgsvw4xjynz1Gy1uxSQhLSIOMco44JkzPvVVWNO
         qaE4Ot5T835iQur7A4l7Zn9Vl40vur/8VJ8n1uMJhgH+o0sh9StrQa/IEPY/a8amQ5Jf
         +5I7p3V2yh0SVwDA5RSBeRtgzBOSfNSkn4oP8KndyXl0dqY0GMTPl49D3nStgQyx+AHN
         DaMFzXqlSadWhMAgt5zeCeIhi7s44SU/5cSd/CB0RMTKLhS7Lvu4jiO6GgIBbnY1wFY0
         GVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BHLm5QBDdlZNJtQUnTUbgSL9L7B4J0byxhZ9/2bFkdc=;
        b=b7Dpfb34t8x3ZKiaDBHKZpHOVrGBArggi6HEKQkZ+r8BKj5Wfzva4oqZhje4ZU74GI
         gpfPdisQjbXvvYfHr2Pjv6s1M0+cFQCLNGzrV4fIN9CD8riQ8EqaAAuysAamjiWQRb52
         FW/45K8SSLMRMimoejEAdulNY5f6v2K6n60de1UhDvRY3fP/JZe2Nb2UtMALkyYXLDU6
         8nl+H8FoCstxRO+46OTyHf1/BXRQINZ+x/rIU0sW7x4h05E7sJ4UI5Pp9WZnP44vKZkU
         KgpywpBBbR+UhIVIpCwwJ7V9I4T9G1/MJf14TKxQKOCx1cWlSLM+zn/z/6TLWZECqjtW
         XHmQ==
X-Gm-Message-State: AFeK/H0CRmqy2/b8VTYi9QPjXkSzSKto1IkbNKrtOg8iRJXcVxQJES6zZnGx/7tRI+1YIJVD
X-Received: by 10.99.147.68 with SMTP id w4mr17904221pgm.32.1489776423977;
        Fri, 17 Mar 2017 11:47:03 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:c001:d329:ba91:25ca])
        by smtp.gmail.com with ESMTPSA id w29sm18182383pfi.131.2017.03.17.11.47.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 11:47:03 -0700 (PDT)
Date:   Fri, 17 Mar 2017 11:47:01 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rahul Bedarkar <rahul.bedarkar@imgtec.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: fix build with no thread support
Message-ID: <20170317184701.GB110341@google.com>
References: <1489729656-17709-1-git-send-email-rahul.bedarkar@imgtec.com>
 <xmqqy3w37ptd.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3w37ptd.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While taking a look at this bug I discovered that the test suite doesn't
pass 100% of the test when compiled with the NO_PTHREADS option. The
following tests seem to be failing:

t1060-object-corruption.sh                       (Wstat: 256 Tests: 13 Failed: 3)
  Failed tests:  7-9
  Non-zero exit status: 1
t5306-pack-nobase.sh                             (Wstat: 256 Tests: 4 Failed: 1)
  Failed test:  4
  Non-zero exit status: 1
t5504-fetch-receive-strict.sh                    (Wstat: 256 Tests: 12 Failed: 2)
  Failed tests:  4-5
  Non-zero exit status: 1
t5530-upload-pack-error.sh                       (Wstat: 256 Tests: 10 Failed: 1)
  Failed test:  10
  Non-zero exit status: 1

I didn't take a close look at it but this would seem to indicate that we
don't worry to much about systems without pthreads support.  Just food
for thought.

-- 
Brandon Williams
