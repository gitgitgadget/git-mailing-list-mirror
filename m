Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F1CA1FC44
	for <e@80x24.org>; Mon,  8 May 2017 21:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbdEHVxs (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 17:53:48 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36845 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdEHVxr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 17:53:47 -0400
Received: by mail-pf0-f172.google.com with SMTP id m17so9984187pfg.3
        for <git@vger.kernel.org>; Mon, 08 May 2017 14:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=gUmbgIXUrWzHZD8rxsikkbyjbyxCY2Atn50T99wicrc=;
        b=mS9dmv8yVIcry9DAUq20cZ2XdoyrYuOhIjdClFlgdXtM4vJ0ntGnAZ574xWGeYPcVm
         cQoHNivXC/xD87ayD9yZjHDw+YcwCf9gsaH/xkF9qv1yV/PT9Tx9tItWSG9hDCn45pt7
         PBrxpQ5LzMZ+1oYEZV7rZcURKXGyQTNMUSJIcbxWSynfZFEQE0TZEF0NpQbI4D8sOE+j
         Ks9TgJ2FPBkxxfmTp8Kt4unWLKUOakO6C/Cdcg8a1IvzlfDTWdNjh8rhChdIEFjbRBaH
         q9Vc9/rqDcdubZrqqI64qi5nkwzzmy3HG5nl/6Ea1kycmZRQhHxI0WmPoN3mHjjKyPsl
         LSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=gUmbgIXUrWzHZD8rxsikkbyjbyxCY2Atn50T99wicrc=;
        b=X+UrF/8dEPO6lmSXUQa5nleaswy+hoJRwACk9E424ypOiNJ1dj6AbKO1lKgTDOqk0i
         ukAS6PXdMySBz9rmbT+L1kgTyZnYw93j2mqYcGQK57osk/jYP5JhqMJJwnEbYUWZK5cN
         VxSNgsDdKksFE8sApXoN3RItYKxX0EfQTfLP5B2M8eGCVpGO5YlcY/Dpf15zIFXRL/ot
         /+JucRdy+WS5LGqNA+zNQ7vBpi7gMTwDdikX4/5Rt4NwA/fP4SNVJupJlSg84GTKL6aJ
         s6lR9l+W1HfpORJCjutbRFIm8l//mfdcSLJHo7lZ+NhxFUOI+VzkXw08MZJ96Jd7kFEb
         wtFw==
X-Gm-Message-State: AN3rC/4fNui2LP/5YSTjeWVhMQ4GuBwfA8ik8uoJQVzCfBTu0XZm1wAq
        XGEToSTgs4bAwti4
X-Received: by 10.99.225.83 with SMTP id h19mr21084034pgk.38.1494280426291;
        Mon, 08 May 2017 14:53:46 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:91e9:5a9b:243a:fa47])
        by smtp.gmail.com with ESMTPSA id z62sm18485623pgb.1.2017.05.08.14.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 May 2017 14:53:44 -0700 (PDT)
Subject: Re: [PATCH v3 00/53] object_id part 8
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <5973919a-e282-a02e-9b04-d313c77e250d@google.com>
Date:   Mon, 8 May 2017 14:53:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/06/2017 03:09 PM, brian m. carlson wrote:
> This is the eighth series of patches to convert unsigned char [20] to
> struct object_id.  This series converts lookup_commit, lookup_blob,
> lookup_tree, lookup_tag, and finally parse_object to struct object_id.

I patched v2 (which I have reviewed) and v3 against master, and diffed 
the two, and it looks good to me. (There was a conflict in 
builtin/tag.c, but it is a trivial one.)
