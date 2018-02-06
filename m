Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD4DD1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 18:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753078AbeBFSBI (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 13:01:08 -0500
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35957 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752792AbeBFSBF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 13:01:05 -0500
Received: by mail-yw0-f178.google.com with SMTP id q6so1959033ywg.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 10:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/76EY4WLfzmzi9ApuIKMJ32IZkoLm1A0M12QENsjbbo=;
        b=MvNXsQA4RBEbTL2ogT2A8iHE+WGWFRm02I89gnPJy86ws3E9stVlWxW6rcHXit7s5u
         26kYtHzL/9WzcRs8HfHQETWAHew+i6inXcBuvcxFT2iZKnU0l3siMoOpqPwqnJQFYGlq
         YCnSLTds8uEjHarLNLzE7Iw21RsXRb0d2H8SAPjuxrtciobSYGU3MgbAILjLTIZL5vIt
         vPTcGhaADd0pEg0QN3sADbP19PCWaZdstdGRV3jNXodGIBBYzraQ/Bp9vtppZqyoBof8
         UMS2KUdNtGk5+bm0XOpZC1FvXuN9GCTftloro6jRGvdEKlVp4TILqr/lzhd5Ykme0JBV
         smyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/76EY4WLfzmzi9ApuIKMJ32IZkoLm1A0M12QENsjbbo=;
        b=IIAe3CoRRMmRsQMIKZWzdCbvavkqPAh4dCni35n9M+yOlsUjt09xdJvETKdAK0rPDY
         flObv4CToMpP/lxn2GWaQ2kOc/BUlRYO+WjsETKilSVvXo7m0udKTMrv/UdDd5lFpiNW
         IChUATxODtg45+8hgHYtorOvL8Oe5s4m4hhwKFY1VV26feOpzrwJs6puKl3wB9q/DtKL
         GG5ZY+ETnJikPWxcWja3ZYvys55d1H47WoXqB3AOQbjK6s9W0NNqTU765JGO5bxpS2Ar
         py+jjZtKaynv14lhBzO9k5e8OGxi10Z6WjC+LtLY6Q0vYc1LCQAcukJS3b5Iplpa63O3
         wGEw==
X-Gm-Message-State: APf1xPAaipo/LRAA8zchJAbyIxNkHv5h44ZUrJ0J2iq2I2k484OZeRkH
        YzoOGx6LTx+lfYsNZjZfhGwVnunvJ5fKijWO4/0TkA==
X-Google-Smtp-Source: AH8x226ldU/XBkeVcg1tTed0eQWv5N4ogPbkcQ4jjla1U6nGX45SN1S7wyQgDfihGehHTax4K7TbjV5676u3rLY9ydM=
X-Received: by 10.129.156.134 with SMTP id t128mr2005523ywg.108.1517940064378;
 Tue, 06 Feb 2018 10:01:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 6 Feb 2018 10:01:03 -0800 (PST)
In-Reply-To: <CAPig+cTnucxCf5=24UBKGU5q_n0mwn0eB1pCLdiA77qXn-1n7Q@mail.gmail.com>
References: <20180205235508.216277-1-sbeller@google.com> <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-39-sbeller@google.com> <CAPig+cTnucxCf5=24UBKGU5q_n0mwn0eB1pCLdiA77qXn-1n7Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Feb 2018 10:01:03 -0800
Message-ID: <CAGZ79kZYZfb1cWX1oeJ6=X6HGs9tCVHik4gs8n7j8WjGKjkK-g@mail.gmail.com>
Subject: Re: [PATCH 059/194] refs: store the main ref store inside the
 repository struct
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 8:27 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Feb 5, 2018 at 6:55 PM, Stefan Beller <sbeller@google.com> wrote:
>> diff --git a/refs.c b/refs.c
>> @@ -1609,9 +1609,6 @@ static struct ref_store_hash_entry *alloc_ref_store_hash_entry(
>> -/* A pointer to the ref_store for the main repository: */
>> -static struct ref_store *main_ref_store;
>> diff --git a/repository.h b/repository.h
>> @@ -33,6 +33,11 @@ struct repository {
>>          */
>>         struct object_store objects;
>>
>> +       /*
>> +        * The store in which the refs are hold.
>> +        */
>> +       struct ref_store *main_ref_store;
>
> Do items moved to the 'repository' structure need to be freed when the
> 'repository' itself is freed? Is that being done by a different patch?
> If so, it would ease review burden for the freeing to happen in the
> same patch in which the item is moved to the 'repository'.

There are two cases:

* the_repository
  In the_repository we'll mostly have the globals as they exist
  (the_index, the_hash_algo, the_ref_store) and just as before
  these globals will not be freed at the end of the program.
* arbitrary repos:
  For arbitrary repos, we usually need to allocate memory in repo_init
  and clear it out in repo_free/clear

This patch is incomplete and is leaking the main ref store for arbitrary repos.

Thanks for spotting the mem leak!
Stefan
