Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37D0E208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 19:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbdH1S77 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 14:59:59 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35241 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdH1S75 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 14:59:57 -0400
Received: by mail-qt0-f195.google.com with SMTP id u11so1192911qtu.2
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 11:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ql4f9343zgKF05X1NEfLyavmk//seuX6tBGUx/7BXcc=;
        b=Qikhtplr+0j8C+BEzWayX9FV4+4QTf9gJq4x1hDX0HCMYBe5cx5eM8IX2bn8THyS3D
         gqUQ9aC9P/+uYM4WP5Bo4aFRedhE2aoTiH8hSbujnF3mVQ40mbTo3UEKl8lgZaN6SftU
         aehzIMqdqSSnyU0cPQxvp+MkasVYmJtLX0cJHc25iQb99OZPIQPZAeAFeOPPG7sK8+3n
         ZIplaDFYvoIV9peBeuGWhj5dASl4U/4/Gd//4WTUN2RqoqHIOKwObE7DtVM56HIwKrhq
         GLcHR5FlHNCI8YZvzweSpBJitIW0ZvfoEjcgz80qc4Bbsvr/a0WWdwTJU0echV1/HJvb
         Cblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ql4f9343zgKF05X1NEfLyavmk//seuX6tBGUx/7BXcc=;
        b=rY6XmGvacnPw5w28vGg+QOBZUQYSbCkiLEr/dpupSaOT3LneLtauQY7LANVGvFEjl6
         njPath4w+ewZI2BnbT9W0BPebFWsZYIqv6M6m10W2T48UjJFM0QHVYXs3jPmRBs97KRF
         8n1WIIAu7KerdrOaML1Fsd5z1EraOELlRcKiBNuQuEFcSAsuKfxw9H7TDYN5ySDrnYR2
         ckonFKjTRJbReMzI5d1Sk5LdItr18jQNFJGpF+ohVxSbJHaulM7T3hnyRtGjWV3g9VRv
         IMUUE59up147hcUtREnXgH2yVu/ZAAmOc98bpr0s5QBngXW94bmsMNBW5ImC1lMVKk0W
         kN1g==
X-Gm-Message-State: AHYfb5jFscWzTcQPDdMAoy+YGP9wfgH5VnnLmB2X10y5PsER0ZgmQMtD
        gGLSTInYFVNqog==
X-Received: by 10.200.23.146 with SMTP id o18mr2266858qtj.117.1503946796889;
        Mon, 28 Aug 2017 11:59:56 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id h22sm751367qtk.6.2017.08.28.11.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Aug 2017 11:59:55 -0700 (PDT)
Subject: Re: [PATCH v5 35/40] Add Documentation/technical/external-odb.txt
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
 <20170803091926.1755-36-chriscool@tuxfamily.org>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <e15513eb-aed9-8bd3-794d-009a91c1d20e@gmail.com>
Date:   Mon, 28 Aug 2017 14:59:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170803091926.1755-36-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/3/2017 5:19 AM, Christian Couder wrote:
> This describes the external odb mechanism's purpose and
> how it works.
> 
> Helped-by: Ben Peart <benpeart@microsoft.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>   Documentation/technical/external-odb.txt | 295 +++++++++++++++++++++++++++++++
>   1 file changed, 295 insertions(+)
>   create mode 100644 Documentation/technical/external-odb.txt
> 
> diff --git a/Documentation/technical/external-odb.txt b/Documentation/technical/external-odb.txt
> new file mode 100644
> index 0000000000..5991221fd5
> --- /dev/null
> +++ b/Documentation/technical/external-odb.txt
> @@ -0,0 +1,295 @@
> +External ODBs
> +^^^^^^^^^^^^^
> +
> +The External ODB mechanism makes it possible for Git objects, mostly
> +blobs for now though, to be stored in an "external object database"
> +(External ODB).
> +
> +An External ODB can be any object store as long as there is an helper
> +program called an "odb helper" that can communicate with Git to
> +transfer objects to/from the external odb and to retrieve information
> +about available objects in the external odb.
> +
> +Purpose
> +=======
> +
> +The purpose of this mechanism is to make possible to handle Git
> +objects, especially blobs, in much more flexible ways.
> +
> +Currently Git can store its objects only in the form of loose objects
> +in separate files or packed objects in a pack file.
> +
> +This is not flexible enough for some important use cases like handling
> +really big binary files or handling a really big number of files that
> +are fetched only as needed. And it is not realistic to expect that Git
> +could fully natively handle many of such use cases.
> +
> +Furthermore many improvements that are dependent on specific setups
> +could be implemented in the way Git objects are managed if it was
> +possible to customize how the Git objects are handled. For example a
> +restartable clone using the bundle mechanism has often been requested,
> +but implementing that would go against the current strict rules under
> +which the Git objects are currently handled.
> +
> +What Git needs a mechanism to make it possible to customize in a lot
> +of different ways how the Git objects are handled. Though this
> +mechanism should try as much as possible to avoid interfering with the
> +usual way in which Git handle its objects.
> +
> +Helpers
> +=======
> +
> +ODB helpers are commands that have to be registered using either the
> +"odb.<odbname>.subprocessCommand" or the "odb.<odbname>.scriptCommand"
> +config variables.
> +
> +Registering such a command tells Git that an external odb called
> +<odbname> exists and that the registered command should be used to
> +communicate with it.
> +

What order are the odb handlers called? Are they called before or after 
the regular object store code for loose, pack and alternates?  Is the 
order configurable?

[...]
> +
> + - 'get_direct <sha1>'
> +
> +This instruction is similar as the other 'get_*' instructions except
> +that no object should be sent from the helper to Git. Instead the
> +helper should directly write the requested object into a loose object
> +file in the ".git/objects" directory.
> +
> +After the helper has sent the "status=success" packet and the
> +following flush packet in process mode, or after it has exited in the
> +script mode, Git should lookup again for a loose object file with the
> +requested sha1.

When will git call get_direct vs one of the other get_* functions? Could 
the functionality of enabling a helper to populate objects into the 
regular object store be provided by having a ODB helper that returned 
the object data as requested by get_git_obj or get_raw_obj but also 
stored it in the regular object store as a loose object (or pack file) 
for future calls?


