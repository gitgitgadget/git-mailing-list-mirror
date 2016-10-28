Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A024D2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 17:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030325AbcJ1RCS (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 13:02:18 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34548 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935654AbcJ1RCR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 13:02:17 -0400
Received: by mail-pf0-f174.google.com with SMTP id n85so40246878pfi.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 10:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5EGMzZX61Y4Qo6sx5Tm2yEigMP0vfWYduWusHQDMQkc=;
        b=LUFIUfkvHHrL2GDrlal3D1OtJF1RQjetO+4lDpzSCI9uo4umsw5+JRBurzXswaErAj
         Ah8962EcYYXfOIJeUN/JBiM2pzMqy0CiuTPPBQlHQBiF5Bx5D58qx8pEOax+vA9Jx99W
         wF7gRtKjAgVyhFFx6HcniOirZsytjP9nIYKxvOYUNvYiFDf4SD2306G0/1WUFOrzfmCx
         m5IAAaVQJLhD5Q68CY8UH08tQ7Fa42pOfIsUih/HnSnoQmtyGpsvoqMeucf6rl/ygH1Y
         7UwS2ryM/mo8lI++dvqC+yvxtEpJk6OmVkEjB7kd9Nbl5/f/4mA/Mx9vJ2IlR0ni/ZbT
         76sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5EGMzZX61Y4Qo6sx5Tm2yEigMP0vfWYduWusHQDMQkc=;
        b=YJ1ngEcErefqD3QJId0cncwEIwMkmFvjespjwH4ZocsYJs3luGwn/dTnr/Q6XtncfQ
         M7LPGNmfGqwXf7qJYlxkMyqhIEDKqH3MLzp0n/m95dGmOGCt3gqwtN4wDFA4+yBFRhvP
         3Yt1EwGlDxcGMyZ86J9F+ofn756hqs4R+hFBPY/ZvbJHZnmDlXYHZJsu3X1JpN30v48A
         bU4E5X7s0tz64Dqn1dVLynxy0Z6o74Cz0F+i94UkuZnRlSk58/+g6eHQGbfETaOv6j0u
         Qvvn/wkPqgGoVJUhqEWCJYFqan2lSRYEpIg6cOY8cc4NTGRhumsDqIuPdeum67zr102G
         SZIw==
X-Gm-Message-State: ABUngvcGiwFrU+az1VqsKYd9ghittEiy0+4LIoJ270p6L20TMf1wnPRfBWg5sFH0qOb8KVtX
X-Received: by 10.99.113.14 with SMTP id m14mr21680455pgc.57.1477674136139;
        Fri, 28 Oct 2016 10:02:16 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:9c44:585e:e62d:6b24])
        by smtp.gmail.com with ESMTPSA id y77sm20146772pfi.69.2016.10.28.10.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Oct 2016 10:02:15 -0700 (PDT)
Date:   Fri, 28 Oct 2016 10:02:13 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] recursively grep across submodules
Message-ID: <20161028170213.GA72114@google.com>
References: <20161027223834.35312-1-bmwill@google.com>
 <xmqqk2ct4bmr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk2ct4bmr.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/27, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > As for the rest of the series, it should be ready for review or comments.
> 
> Just a few brief comments, before reading the patches carefully.
> 
>  * It is somewhat surprising that [1/5] is even needed (in other
>    words, I would have expected something like this to be already
>    there, and my knee-jerk reaction was "Heh, how does 'git status'
>    know how to show submodules that are and are not initialized
>    differently without this?"  

Yeah I was also surprised to find that this kind of functionality didn't
already exist.  Though I guess there are still many builtin's that don't
play nice with submodules so maybe this kind of functionality just
wasn't needed until now.

>  * It is somewhat surprising that [4/5] does not even use the
>    previous ls-files to find out the paths.

The first attempt I made at this series used ls-files to produce a list
of files which was then fed to the grep machinery.  The problem I found
with this approach was when I started moving to work on grepping
history, at that point it seemed to make more sense to have a process
for each submodule.

-- 
Brandon Williams
