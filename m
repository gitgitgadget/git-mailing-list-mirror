Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08A561F461
	for <e@80x24.org>; Tue, 14 May 2019 02:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfENCct (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 22:32:49 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:40412 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfENCcs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 22:32:48 -0400
Received: by mail-pl1-f181.google.com with SMTP id g69so37544plb.7
        for <git@vger.kernel.org>; Mon, 13 May 2019 19:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4kYm1/KVfCh3/gX7ca9xsP+QSkqw49fXrQLRQnvkwB0=;
        b=P7hEkOoNRjz/wUdZiSNJHyNONBE5FMaZ714+DaQGP4ztbf4a5toChYt9QMcFptBgrd
         KkpcrIKjnkruNWxlePz3hbiamB0xQbE1HFXWYA2XgEeKitQtWco0na8TBh/eaXLgZffA
         smXERdlDgSj5zotnPzj7LFUwIwbNV2iQKCVn0PuF2qdGCsTLUttgfnoW8OH9yNS2MPoa
         xzFgcOS9ulv/hr6avdAET5NkmHylr9CJx60uhsjvOCQm9OectdRbkPdBRTjbcZu+ixKn
         Er5jAJG0g/7fP2gxVdA+hKJgFNHPCEKfgaI27Zmp9/VQqIEBhmenSUMAlE76HDhdTK2G
         DyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4kYm1/KVfCh3/gX7ca9xsP+QSkqw49fXrQLRQnvkwB0=;
        b=NRDFMFGTixbpshXLzZcP10PiE+rTzRMeRxSedaLnGQbBzlW0Q9+MgZYO7kglET1YzH
         K5AngRJNz83Oi6gfuqDFJyh5bUk39w5ViCsLuqqNIqvXfWZ/9ffWWwcB6WX8MdZAkf/6
         DtcskMDdjNGNz0DfF4fE8MUdJ7WKBI8+Dxea76V03BtOOE7gQqOxJZKzo6N/Rmh1qqdG
         XH2+isdlJhAFYjYpmRrVF3GKNm4WEZsAIAVfPZKN/1B/2Wrwgv2DY8S38cESf4+LwT5E
         l7UlaNU+H9BicH0AXUxxg4JMVKAS5FJMLeSCu5vQcdT6hFq3T30hugn7v8OMcRvOWI4Y
         Imkw==
X-Gm-Message-State: APjAAAWPCDue7Ek/yfOVecpIyi0SB1dRS7f/iqL//zjEobPXFeZlZVMp
        CQ/LtEN4lGKWnra5OUaXDRXlIjza
X-Google-Smtp-Source: APXvYqx7m2QGaYVG/Vc8Gdh+Ao6X71ZYpenrWSOOFrC1vX9do7wTgHqH8d6QhjHFXrwy/NyAghCjIg==
X-Received: by 2002:a17:902:9a03:: with SMTP id v3mr36263875plp.27.1557801167940;
        Mon, 13 May 2019 19:32:47 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id r64sm50658452pfa.25.2019.05.13.19.32.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 19:32:47 -0700 (PDT)
Date:   Mon, 13 May 2019 19:32:45 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib: try harder to ensure a working jgit
Message-ID: <20190514023245.GB34155@google.com>
References: <20190514020520.GI3654@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190514020520.GI3654@pobox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger wrote:

> The JGIT prereq uses 'type jgit' to determine whether jgit is present.
> While this should be sufficient, if the jgit found is broken we'll waste
> time running tests which fail due to no fault of our own.
>
> Use 'jgit --version' instead, to catch some badly broken jgit
> installations.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> I ran into such a broken jgit on Fedora >= 30¹.  This is clearly a
> problem in the Fedora jgit package which will hopefully be resolved
> soon.  But it may be good to avoid wasting time debugging tests which
> fail due to a broken tool outside of our control.
>
> ¹ https://bugzilla.redhat.com/1709624

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

It would be nice to describe that bug in the commit message, to save
readers some head scratching.

Thanks,
Jonathan
