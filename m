Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AD7520288
	for <e@80x24.org>; Thu, 20 Jul 2017 00:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932461AbdGTAgl (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 20:36:41 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34269 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932397AbdGTAgk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 20:36:40 -0400
Received: by mail-pg0-f47.google.com with SMTP id 123so7054653pgj.1
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 17:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MC4+fC/AQ405x5Hm4SWM+hS9R2qLDjnj//rvT5aS9X0=;
        b=CrH4Php0oslc26kDnQztgUwoJlsrQzmpqfyL6hNMI7pLwFaPM5rk+Y9Ty5Lo6crPwc
         /WEG4AHKTfzBPiYJS5PvCrfwlfOPISGE5RBwVTsp82ylTStt55I0fFhAO7l7UJNcsSHP
         dgSXMijo/yNx8S3nCJKLQjzcycR9N83Ft6xE2lD/lMBCI16pIFowU9MVXIzDmTaCwOhd
         PmgifqesjBvRq0ARdULMFk99ix6c7xT2cF+jZ+8tG86lt83gsn7jHSmj2ByarD87VYYV
         MZEAraCAxvAPkIhpkUmOJlcKjxTsmQKwxg06eW7rfhJ1GnzEs7qZfiscncdsMW51o3Y4
         Q8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MC4+fC/AQ405x5Hm4SWM+hS9R2qLDjnj//rvT5aS9X0=;
        b=NtZOznoJDhH0Jlr8X+CosWw84GOIuyzeAxKZ/ZUx7XydV9h+geqvxmHVwzMz7xeYON
         iKQzh2oFn+AhY56C5wQQh2OK/pYIWvUKzvZ3ZX9vhh9bSZlsiD+O+qqQmTkUvTWVKr97
         8WJZId1hrrxouvhtNphueqJAnuTAzezl6xiYnOiugPM44P+N7ArinPrh4UFpdkzxUL9Y
         lL0+idreKrkse66+6HO+UQ42Z7Xrh4AYUOBbUcf0i6pUA7MuU6HKHdRJVyHjhLtLiENq
         08Dw/PFYTfXWSoqvMzx9XTZ6pLVD94bopHbqALpuVOF3uokfDcJRbfhlBIRdvF2oyChT
         melA==
X-Gm-Message-State: AIVw113SqKPZnz+KjVzKBin4oWpxWYYsRCX+udL2UZqdME40z4AXJutp
        wu/23fP/t9p6SaGthSf6P4TI/F/9nfIn
X-Received: by 10.98.224.73 with SMTP id f70mr1933284pfh.12.1500511000263;
 Wed, 19 Jul 2017 17:36:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Wed, 19 Jul 2017 17:36:39 -0700 (PDT)
In-Reply-To: <0eb270f40095f132bf9383f230506e45d895e5e1.1500508695.git.jonathantanmy@google.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
 <cover.1500508695.git.jonathantanmy@google.com> <0eb270f40095f132bf9383f230506e45d895e5e1.1500508695.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 19 Jul 2017 17:36:39 -0700
Message-ID: <CAGZ79kbYebKkSBtiFOMO5+uknbNMnhyT6P6uu=MMhmFyOZRE+w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] object: remove "used" field from struct object
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Ben Peart <peartben@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 19, 2017 at 5:21 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> The "used" field in struct object is only used by builtin/fsck. Remove
> that field and modify builtin/fsck to use a flag instead.

The patch looks good to me (I would even claim this could
go in as an independent cleanup, not tied to the RFCish nature
of the later patches), though I have a question:
How did you select 0x0008 for USED, i.e. does it
collide with other flags (theoretically?), and if so
how do we make sure to avoid the collusion in
the future?
