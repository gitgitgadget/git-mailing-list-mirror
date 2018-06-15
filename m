Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DDE61F403
	for <e@80x24.org>; Fri, 15 Jun 2018 19:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936211AbeFOTFE (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 15:05:04 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:36747 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932360AbeFOTFD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 15:05:03 -0400
Received: by mail-vk0-f74.google.com with SMTP id 2-v6so4064514vkc.3
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Va5ycrSqwxwyfhCQ8kxcF9sjdv+TjqtYo7+OUW6waaE=;
        b=hCFD1aRdEcp+ovGLl6GMWhBOorPOj9NpvmfdEQfLOx2NztSLlwEYONLa3WMLTdAVse
         yTuggTAbfqY/Ok3Pn3vSfoxh9/WzgpIUuf8jPYsmH5ebtV9iishXnnQm0TiusCcsHD04
         kISXCruRG2jR+uJ5PJx5FR/zOYUlNBpgBvxgzdMPgn+Ggy+IZn8VutUDSlPQMLQqyapi
         IQNlRry0iPurLVDlwn/VLES3Uf3cD23DTO2cPuKg+kXcJnAgazMUkwRyA22FcICqdCeL
         14c3Q+SVHE+PWukEnQV98URaGRPHEb391gk0tTK1nXjWuy7DTDOHQcRFBMUGcSUm4vjT
         pgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Va5ycrSqwxwyfhCQ8kxcF9sjdv+TjqtYo7+OUW6waaE=;
        b=UKI3xMVVpS4hx5r6Rvic4bUjVUSWuTDV58MqUOyUxKDuM6N3OHR93iVSt8cH/4Bpkc
         2H9oOFRlf9uyE1Z8PHCNqAc5EgkWr2B0XzvvzRxyC/MCJagi783s6SaATAesPCOFv1ML
         kCT+92TmQg6ZsTGQgDPlVVYqrFzcgISFXM2m+aCKThndoPpfUSt7+Ole9VBz1dPAHeQ9
         NbZEy7FPSfQYYcAHu1XnXA+oKRIRtqtZLMMXmuO58vvZgzPVz2Od8JMLH0yhaLsokGXx
         QdB+xscNCNIFaEM0Lmp78UYBG8XdcgpSXdt2dT0CvCDT6omxohJKEfxJcDsuTDeNScoD
         Q5lg==
X-Gm-Message-State: APt69E0F8M9eLs3UxB3px4wiM2K0Za/mg8qx/HmdMVvdR929LTQitoZn
        auLYSfXK04J+fY/S7UMN5Z+kmkJoj/2RGejbwUDN
X-Google-Smtp-Source: ADUXVKKTa8+MgtaZNKn+MR9Y9we6i8m3ghQ3zYArgn2u+kY6WOTa9Bl68+NR1AQ2RPPNlqvuGaIhZVoCM3zYNNPw707/
MIME-Version: 1.0
X-Received: by 2002:a1f:1bca:: with SMTP id b193-v6mr1196049vkb.68.1529089502152;
 Fri, 15 Jun 2018 12:05:02 -0700 (PDT)
Date:   Fri, 15 Jun 2018 12:04:58 -0700
In-Reply-To: <20180605175144.4225-1-bmwill@google.com>
Message-Id: <20180615190458.147775-1-jonathantanmy@google.com>
References: <20180605175144.4225-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c4
Subject: Re: [PATCH 0/8] ref-in-want
From:   Jonathan Tan <jonathantanmy@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(replying to the original since my e-mail is about design)

> This version of ref-in-want is a bit more restrictive than what Jonathan
> originally proposed (only full ref names are allowed instead of globs
> and OIDs), but it is meant to accomplish the same goal (solve the issues
> of refs changing during negotiation).

One question remains: are we planning to expand this feature (e.g. to
support patterns ending in *, or to support any pattern that can appear
on the LHS of a refspec), and if yes, are we OK with having 2 or more
versions of the service in the wild, each having different pattern
support?

Supporting patterns would mean that we would possibly be able to
eliminate the ls-refs step, thus saving at least a RTT. (Originally I
thought that supporting patterns would also allow us to tolerate refs
being removed during the fetch process, but I see that this is already
handled by the server ignoring "want-ref <ref>" wherein <ref> doesn't
exist on the server.)

However, after some in-office discussion, I see that eliminating the
ls-refs step means that we lose some optimizations that can only be done
when we see that we already have a sought remote ref. For example, in a
repo like this:

 A
 |
 O
 |
 O B C
 |/ /
 O O
 |/
 O

in which we have rarely-updated branches that we still want to fetch
(e.g. an annotated tag when we fetch refs/tags/* or a Gerrit
refs/changes/* branch), having the ref advertisement first means that we
can omit them from our "want" or "want-ref" list. But not having them
means that we send "want-ref refs/tags/*" to the server, and during
negotiation inform the server of our master branch (A), and since the
server knows of a common ancestor of all our wants (A, B, C), it will
terminate the negotiation and send the objects specific to branches B
and C even though it didn't need to.

So maybe we still need to keep the ls-refs step around, and thus, this
design of only accepting exact refs is perhaps good enough for now.
