Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A372C1F404
	for <e@80x24.org>; Mon, 22 Jan 2018 12:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbeAVMOc (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 07:14:32 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36193 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbeAVMOb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 07:14:31 -0500
Received: by mail-pg0-f53.google.com with SMTP id k68so6959413pga.3
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 04:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=albQuLAs2Tc8LtpTjA4B7Pk7kB9kc1oRZ/SQ/UthQQk=;
        b=n/fhBAc61FWlElXPoG9Ut1UzYL9fSpf91o6N7o1vj6ZOPwKACmI7+aXieA/i8WMH/H
         3pKp+w1PulxLeuixlnhEfYpBR7fmPDQEajtgDzKAzn8ndnG9AoWtnS9JlgJGNcHAvak5
         vLdD4yvxqtOQGMsPBVcWtDPrfNFQJ+ru+ABDGHRosOvpq60emYttl9NyQP3RCZsEh3UI
         2Af6trlDHnY+A1YoUOVbI79dhDRADr+ITj/aY6n+wg6zposFASSAyncO/mp2NwOBM8eZ
         Hz66ANgQVAtVVPhqGkIi8pcLWQy8TmuYSjenGi3za8Tb6JsU5TkJk9kd4Utezd89Lp/j
         rf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=albQuLAs2Tc8LtpTjA4B7Pk7kB9kc1oRZ/SQ/UthQQk=;
        b=NelrY78LGKrMfxLWif79TdKBaW8w7NTK35KrhtVO4l1Tus7sh7vDvwsy2Qm0LcG2RY
         diEMuhiSgJ+jfYtX9qxOh7chgsvhPmXzGzbj5svakfWJQLRydGi9dMIwQHWePYnquDMw
         eF5F6sFmzuHc+pu6d76OVspOn1Y2i8Sc7yZVEdGWVwe4F6qlEptUMDmvL4Xy+pMNRBc5
         ZOc94GVMMMFbdzvRvfNYDICDBB/D1cxQ1iHlzfSkzP5QrCq+AQvzYVCAXDvU4ibuKNy5
         VTd4CWsDARuR5fIaIdKEu6UPd3BSZoOHUxNAe8WWD1CP5+KxeIA8jnJZ9FeIAqtP0ySw
         /q/Q==
X-Gm-Message-State: AKwxytdiUVbNSOVRl303Eg4c+JWm7A4OmqBkj8yupQqERrUE+PudtK3d
        Ksrn41pdOzkAjwYLijk9x8E=
X-Google-Smtp-Source: AH8x225u0vGvjiIpdkjMxHdMc1CCwU5cKw47vjujHYDhctwVqDLorh73qND2JTcL7kQO6H38aVnO2g==
X-Received: by 10.99.125.72 with SMTP id m8mr7114689pgn.146.1516623271261;
        Mon, 22 Jan 2018 04:14:31 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id t69sm400629pfa.180.2018.01.22.04.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2018 04:14:30 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 22 Jan 2018 19:14:26 +0700
Date:   Mon, 22 Jan 2018 19:14:26 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.ath.cx,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 00/14] Some fixes and bunch of object_id conversions
Message-ID: <20180122121426.GD5980@ash>
References: <cover.1516282880.git.patryk.obara@gmail.com>
 <cover.1516617960.git.patryk.obara@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 12:04:23PM +0100, Patryk Obara wrote:
>  sha1_file.c                                   | 100 ++++++++++++++------------

You have started the invasion to sha1_file.c. Victory is near! (*)
2018 will be the year of something-other-shan-sha1 :)

I've read through the series quickly. It looks good. Patches 1 and 2
should be sent separately though.

(*) Technically the hashing part is still easy. I look forward to
seeing you deal with the object reading part, especially from pack
files. It's fun ;-)
--
Duy
