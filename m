Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CAAA20437
	for <e@80x24.org>; Tue, 31 Oct 2017 18:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753515AbdJaSJi (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 14:09:38 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:54908 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdJaSJh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 14:09:37 -0400
Received: by mail-io0-f180.google.com with SMTP id e89so676749ioi.11
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WvqtD0XKWzQHwdyZseQNpqH5jzJ5duzZsjxupefNt2s=;
        b=J3i6y7/n9LY1O+idnDz9L0NArxMutC4/V8trAFjMjhl4oDbYKE2e/4/7HAWymRwYy+
         8QKGE+oJVGK6SuYKXPJNhECe1lB20FW3m08SlVJpGHkEyP/rmngNQ2HDPER2myUdgCO6
         B+CK/f0v+8XM41aVCKVViJW9IWdu4mtGGVeqRTHlz9F4QNz35yUbbt8ojHWiMSOdD6pN
         aT4RKM7l82Mq5ccTN3t+aCEO4vw5LvK2b6rn7HMHfiS2xvsOmFj2Oh1lkkGdrzLLYlIM
         q7qhtuhS1u4LauRzzEf0UI2gQoPoPFYQfra8p8Lp7MpDhNWvhIEBVnSDUGaH180qmHrn
         vosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WvqtD0XKWzQHwdyZseQNpqH5jzJ5duzZsjxupefNt2s=;
        b=brMfUrJbOYo50VbKKPXN3Q4bTBbNdQt9V/JZ/HhhkXsgXx+xDDwQeROh1zXHq/srI+
         2GmQUbQRmsNLpZ6zTYNewEjh8PwBkB/cMBO9W6O2JdtrXhLx7hGH8tLjs8snIDtGBj7r
         ZKYuRlXVvAyzVwLDVCJkPBMqQMXimrSQ+KJBUUtf6x9YeIZfBuuWKO4QxXf0/tb/NUpc
         bO/RPH0HmOmtfjzRZBnj6igm31K/Bj/LxQTuWhjGWrEgPOpqaY9Ff7cNjsBulf1VGqlg
         heaEZPz5MzDDRy6OVQWjHzaTKu6naGJEixOzxq3Aw2zimvAHularUNt9RSoyIRqlZthO
         3aIA==
X-Gm-Message-State: AMCzsaUBU3DY2wbh6/iv4TVDiAgToTIWw0ZN3yOW078SKsjo11h6yffV
        A/889A7os7chYRm1e0Ddda0PH3Z8
X-Google-Smtp-Source: ABhQp+Shk+w6j09jDl2xrdaLdPUNf4j6k89dwh1gH8GzZHPpQjOS0siuBja//2NNFKHt4xZldj7y8w==
X-Received: by 10.36.178.77 with SMTP id h13mr4388014iti.114.1509473376354;
        Tue, 31 Oct 2017 11:09:36 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e77sm1121522itc.25.2017.10.31.11.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Oct 2017 11:09:35 -0700 (PDT)
Date:   Tue, 31 Oct 2017 11:09:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] mingw: introduce a way to avoid std handle
 inheritance
Message-ID: <20171031180933.styinoik4npmd53b@aiede.mtv.corp.google.com>
References: <cover.1509382976.git.johannes.schindelin@gmx.de>
 <20171030205522.hur26cumwusk7wwa@aiede.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1710311809570.6482@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1710311809570.6482@virtualbox>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:
> On Mon, 30 Oct 2017, Jonathan Nieder wrote:

>> Can this rationale go in the commit messages?
>
> I thought I had done exactly that in 1/3...

Okay, I'll be more specific.  This cover letter includes some
information about the rationale and motivation for the series.  That's
great: it makes reading the patches easier.  But TBH I'd rather that
it hadn't included that information at all, since if it said "see
patch 1/3 for rationale" then I could save the trouble of reading the
same information twice.

And unfortunately much of the relevant information is not repeated
there.  The cover letter mentions:

- that Visual Studio is a motivating example
- that this is conceptually similar to Unix sockets
- that those do not need to be marked as inheritable, as the process
  can simply open the named pipe. No global flags. No problems.
- that this has already seem some testing in Git for Windows (i.e.
  analagous information to what a Tested-by footer would say)

It is also just more readable than patch 1/3's commit message.  That's
to be expected, since it was written later.  My second draft of
something is often clearer than the first draft.

Thanks and hope that helps,
Jonathan
