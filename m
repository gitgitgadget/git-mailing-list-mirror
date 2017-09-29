Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD34720281
	for <e@80x24.org>; Fri, 29 Sep 2017 19:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbdI2TrH (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 15:47:07 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:55785 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbdI2TrF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 15:47:05 -0400
Received: by mail-pf0-f178.google.com with SMTP id r71so299446pfe.12
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 12:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ezAyepVFTg9GS99uA7hfWeyv2jiTzgjAsIZk+dAmbs=;
        b=EQzJpSVTyZQmJB6QYhvQCstUmMFlWjIqoKzJeheMhCE6o8CWgrExTmhOueLTIJTGFs
         T9ThBC4zLqlx/NLx7C4M0rheIO5JbhjJP8TdjbLqH3wPRz1xUn0BhpR6SbFfBfpqhCER
         iJv0c8M0WNNlk5F3UwPYTGX0OBbfTObFAysnBQkXiDO42XiAUNsN6Li+4hptpRpO9MUa
         6K5w/PNW4IMHWM3il+Zy/XTMJgE3yvdIXiMBRJ/Pbx5nKcSf/VxPZ5UXRSKTMg5hiZLh
         2gl1EFZ3VVZoFibgPKf0et+LdMM4BQnLvI9Ri1La8+PDTUJMTzLNF9qyr2j1vOIA3umD
         PLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ezAyepVFTg9GS99uA7hfWeyv2jiTzgjAsIZk+dAmbs=;
        b=GyZ+m0PyGlxyAqiIce5pFZojV72mbiHN8Mz9Pz6S7UuS/J06d/nW/aarQjSBV2mPXO
         gYtc3cQVq6rmk1i4lHTBxWJJRHzYOa+gKu9vQjhMse0hL7q9SJ6zmU53D/J/5pr9cXZt
         NSQB/c3hwqDIInNHrS/O58+8vS4TqXGoK7JIUmXUlgEQAi4ebwTnqj+DOMi7yWOQh2ir
         IlikTSd0s9A8xnrXbjaLWJwgvPNvraGOJPVmft3Tt2rCDQF4mYwGKv0nvGwl9kakb+sv
         UiPS+FGmaKr4n9IPyRCDZ33m0KkNYWDncSkBRJ8dOKBOdJ/8Rf/4/mDnai11JqU39E7h
         PbsQ==
X-Gm-Message-State: AMCzsaUX6zj9AUKisHUzKCZGx9uAgC+uwvlI+rez1QnwrH7m+Cka0mKF
        ozJGQeB1z3qUrId2pdPfUj73/Q==
X-Google-Smtp-Source: AOwi7QAfzJ5wJJXdjqPI82biJxE6fi03Y+yaddRD1JCnRO6KG7x2dYep+XV7K612/K3ZpPlnh3D6lQ==
X-Received: by 10.159.255.9 with SMTP id bi9mr1418362plb.106.1506714425227;
        Fri, 29 Sep 2017 12:47:05 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:95f1:13e:dc22:c4e5])
        by smtp.gmail.com with ESMTPSA id b65sm7465789pfg.30.2017.09.29.12.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Sep 2017 12:47:04 -0700 (PDT)
Date:   Fri, 29 Sep 2017 12:47:03 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 07/13] object-filter: common declarations for object
 filtering
Message-Id: <20170929124703.29539de1a7a72c34e7d8ebe5@google.com>
In-Reply-To: <3cab0259-f20e-5913-d886-e37c4da9fd04@jeffhostetler.com>
References: <20170922203017.53986-6-git@jeffhostetler.com>
        <20170922203017.53986-8-git@jeffhostetler.com>
        <20170926153950.a147c48ce62f73702eff7ebb@google.com>
        <7774ff8d-3a53-860d-9343-292938d59d12@jeffhostetler.com>
        <20170927170533.65498396e008fa148a3fda90@google.com>
        <3cab0259-f20e-5913-d886-e37c4da9fd04@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 28 Sep 2017 10:33:39 -0400
Jeff Hostetler <git@jeffhostetler.com> wrote:

> Maybe.  What I have here now is the result of adding these arguments to
> rev-list and pack-objects (in the current patch series), and also to
> fetch-pack, fetch, clone, upload-pack, index-pack, and the transport and
> protocol code (in a follow-on patch series that I've omitted for the moment).
> And there will probably be a few more, such as fsck, gc, and etc.  I hesitate
> to refine the macros too much further until we've agreement on the overall
> approach and terms.

Fair enough. My current opinion on the overall approach (others might
differ, of course):
 - Filtering based on a sparse checkout specification in rev-list and
   pack-objects sounds useful to me, and is worth the filtering
   mechanism.
 - Filtering based on size (or based on type) still doesn't seem useful
   to me in rev-list, but if we're going to implement the filtering
   mechanism anyway, we might as well use the mechanism.
 - Besides my comments in [1], I think the API could still be slightly
   better organized. For example, object-filter probably should be the
   one to define the traverse_ function that takes in struct
   object_filter_options, and optionally a set of excluded objects to
   populate.

[1] https://public-inbox.org/git/20170927170533.65498396e008fa148a3fda90@google.com/
