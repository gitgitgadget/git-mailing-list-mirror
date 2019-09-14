Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 154F21F463
	for <e@80x24.org>; Sat, 14 Sep 2019 09:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfINJHg (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 05:07:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37417 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfINJHg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 05:07:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id c22so1478433ljj.4
        for <git@vger.kernel.org>; Sat, 14 Sep 2019 02:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=loFZzPySTzhawl3zeuZJSAgSEcJtXykRznLjZYEkCK4=;
        b=YOvcznHPZ6ROScb+tFZatW3my2iy68cUTTMfHnsrQFQVcCwISJsmxhVmkkYfN9hmpD
         AELCgghntkV+EAtQxNLL2uUNwKyVw4RxDiK2py0FEFxrf4JXvuFU7Kflecv0q2I89f1p
         Hw7mCeDvbI62plzcQbaZJ+vz6jL5Vh2dz07mKuI88gzaI8RRL1WhV3vfMGRibNTRbfLQ
         K9xsYl/39HxANEKuHcU9J4e8ij5Efgsk/yKe73bAU/65k7yNKr1+s2kBg0U9oc/WnI+r
         OF/XQJEnaaMo+179JjTsctutNTtR9a7rdejN+4i45+ha9d3gFB4d54NhsS7MnT9CysUt
         hkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=loFZzPySTzhawl3zeuZJSAgSEcJtXykRznLjZYEkCK4=;
        b=J7UGxUVajioNAS+N9Po6nSN4o19Z/oojnu+fGScPBJjHMWeUhMR8V0Ec8BJXgMOmEn
         ZvOBljvsXs2W3mLMh0zIf9LPQLY2U47x7Vi2wPVqtohQtbVz2whKcUghw8dBWuMVx4ly
         vFr5avpxrb9Px6CI3rY1lC1nEjIQWXPJzqdT7t144WVLZrvfJZ6LOcVTpwvFO+w1FB46
         v/NDsziFa0WhQP7uNl8U4tL8EHQCUQpEHdNcVf5SSIwaH8Hnwo2qopdlDy1upkDZV3E4
         EpvhQupaQpso6reximib7zfeUYcj7xDel0vXnlxDKHdJ/uWfTE69yNvgAu1ZAOYUNXju
         m2uA==
X-Gm-Message-State: APjAAAWwFvuXbBJqWBccHwnrVcsVpeArCpsDTHHp7AO6QkcmLNKFQKC4
        h84ZSra6HNwvONMnpX860fQlMTqlHS3eoMCp5gI=
X-Google-Smtp-Source: APXvYqxJXT7ZrtqbdifuecPpY3woDd2nA1ZykqsnVSiRIwmiNo7TzEwMgIgXRSxhl4NdFpwNOHxwjyMoiN8Plq6ggqY=
X-Received: by 2002:a2e:81d1:: with SMTP id s17mr27229926ljg.94.1568452054500;
 Sat, 14 Sep 2019 02:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190913143740.5zkrclivsvyj6k2o@yadavpratyush.com>
 <20190913211152.8860-1-birger.sp@gmail.com> <CAGr--=JhBYmYCJNNm8DyL+MKU0V0V-cwzH4WABX-dvE+uXNwDw@mail.gmail.com>
 <20190913221119.552477ff3cl2q5pc@yadavpratyush.com>
In-Reply-To: <20190913221119.552477ff3cl2q5pc@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Sat, 14 Sep 2019 11:07:21 +0200
Message-ID: <CAGr--=LmC2VwGCdfRuv_G2mXTt2H8XMDGsLnHU_2oHGhvbdNsg@mail.gmail.com>
Subject: Re: [PATCH v4] git-gui: add hotkey to toggle "Amend Last Commit"
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, I really appreciate you taking time to explain it thoroughly.

On Sat, Sep 14, 2019 at 12:11 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
> So while my advice above was to work on top of "master", that does not
> apply in this case since your patch is dependent on someone's patch
> which isn't in master yet. So in this specific case, you should base
> your patch on top of Bert's.

Okay, I might have to make another re-roll then. I based v4 on master.

Birger
