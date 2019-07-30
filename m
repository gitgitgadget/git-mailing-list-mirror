Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3A21F462
	for <e@80x24.org>; Tue, 30 Jul 2019 22:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbfG3WDE (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 18:03:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36446 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387981AbfG3WDE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 18:03:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so29441199plt.3
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ia9O2pqnJIlHnc41wqgTclJ/YC5JsJS3Li4ltsBj5e8=;
        b=GZ+FBvGCeE2mZiiyKK4o7qy8XEv+pmfR9jfZ2Oe4DCJmWxR6N318hN0EMsnKbGCZ05
         JuXhjqhT6eLHpMc/ETSU+W5M79XUgE3I4Ae6jOVMR3O0d6wUkoyRWNMxnAC07oDSwEux
         BcCUT89pN1ufY+0h3socoz2+DHXcEHMGEhPZVBnDD/j31G/UcJ/VjsKmh1yCYd+Jbawt
         8vGbxunyRRAquwArVSW71JPn5Ffe0EjvBIMjlot6E5PhuxPkkeJaLBTwLXKNn8/ayAVb
         gaVRwoxO9e4iq2aVq0/rtDTU5l4grCtM3Hcbzx9Yp4yNP2LBStcG2KIJSkjpxlxUs6BY
         r28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ia9O2pqnJIlHnc41wqgTclJ/YC5JsJS3Li4ltsBj5e8=;
        b=BB7/c6VIPgeIr2eRrq7gbrERwqalxX73PHKdPAiW7qWwLRbomqs1i5g48iwBsl7iTi
         PGe8OtBaPs6mDVDRHRS+vWZTypDISO/mP1GX/hgIt30QO2RQrkR63UUE89h1SkXN6bvg
         NotSLa2FOciEGESDqxxevRqIaFnUnXqor6J1F0mFygsL3dAoRboIR0wJDG4evHXQAcEt
         W7UofHE9PzWEKh+csWPGocIwXseieIyE7xtTSIbfoKYsGqr5ghXvc4beWY+f8FqWY/zZ
         GQ+k7yPEAP5PHdGwYA0dF/4DfybaDHZTSRB0SLSuO9iNMjXXaxiiy5lAZWkcVFD9Xiwb
         V3DQ==
X-Gm-Message-State: APjAAAXbzr77BoSKuNOXQkDxymoILNe8cl/M4gdRSfCKgAbYCwc6eBsr
        2/MTVApJGIkxhJRNmEaBNs+bsA==
X-Google-Smtp-Source: APXvYqwFiO01OSlYQH+kobM0JkGTCE6JpNcgSse5JmpXX536UmzOUeL5zmXl1AVe1nYTgnRJmri+2A==
X-Received: by 2002:a17:902:b603:: with SMTP id b3mr118803094pls.9.1564524182835;
        Tue, 30 Jul 2019 15:03:02 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id u23sm68186298pfn.140.2019.07.30.15.03.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 15:03:02 -0700 (PDT)
Date:   Tue, 30 Jul 2019 15:02:57 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] trace2: don't overload target directories
Message-ID: <20190730220257.GM43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <8612596d-1dfe-1b8e-9e01-c091e43c0556@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8612596d-1dfe-1b8e-9e01-c091e43c0556@jeffhostetler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.07.30 12:46, Jeff Hostetler wrote:
[snip]
> Also release sentinel_path ?
> (And in both of the return statements below.)

Thanks for the catch. Fixed in V2.
