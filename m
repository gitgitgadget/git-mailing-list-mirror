Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732F7202BB
	for <e@80x24.org>; Wed, 13 Mar 2019 04:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbfCMEYB (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 00:24:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45279 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfCMEYB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 00:24:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id h99so346271wrh.12
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 21:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qZ91a/iZo3wBz3Ww8a9AePz8d/1hIguhtgVGM8GDAqk=;
        b=gaq9vj/3UEK0HTuVK/sXfnNv4/eH4yQeV+lpCb0INexrrEPNAi+MNcX9ayiSwZeFJk
         oTCx1YK7lrrUiWXcimcXVTtNk/xPnMDBLU2cDm+dyKiUN11yhWoS2Jq8n6Z1FTuZXB69
         wvfbU5yUd14AjCsescaAOpdCrMjETc6UcihIVDmfU0OqpL6W8eSLs3kbE5S9YZUEbK3+
         +Nkk3+LPCuL51knQbyYN49tdGdomdDxuliERV5mTHnjePinmGVBOLiVpayldm8FbTbtU
         o9YIiQZm/uFkHn8O/YnWqBdtfhljVhrF4UTuosTLiXg9JL0wOMOPwPuQcPGrbQp1NjPM
         Db3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qZ91a/iZo3wBz3Ww8a9AePz8d/1hIguhtgVGM8GDAqk=;
        b=SD5b7AM2RNCTSKjbtycAek/JiqB8UWhyq9Mg7n6ALfTqd4gnM7KvPiEfCBfmJeGPdi
         owIp/XUnKH0w/+LDLRGjWaIr75HXSmSfGr2JAQtWp1hUz/IRCB8wvyWM66VyXLToVJAA
         vLiYPaKEjabH7ch8+fFk8qEnMG05AyDVTjhGpU3NMA/qFkTtJc+98yBbLDW4/Hs2EuSX
         wFTw6no02hQRYzE4/y/3PB3k9Qy29k2RKkbAz5bBUn6ntYOVGq7/n6glg3w/sCY1a3Sx
         oLt+YUAgxuo+UadHZddHiKD5vMf5kNneuHDuYUlKratn5toNC9EEXw2Q8vxork/MyLfP
         Kd3g==
X-Gm-Message-State: APjAAAUFBYP8aNM60knLWY+Gm0EIWBUtUX2naBqZ3efq/4cClPN4khZZ
        NX9+Xx+K0P4/D0GYQHBbpAU=
X-Google-Smtp-Source: APXvYqzk+kI75wJudWkELkTcR0W+8AeBiD+9bb7eY7x1L1XiwgNDDteVk2C31IiGlVpJCI5PaAui1Q==
X-Received: by 2002:adf:e38b:: with SMTP id e11mr10304740wrm.113.1552451039233;
        Tue, 12 Mar 2019 21:23:59 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id c21sm15908926wre.35.2019.03.12.21.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 21:23:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v3 03/11] promisor-remote: implement promisor_remote_get_direct()
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
        <20190312132959.11764-4-chriscool@tuxfamily.org>
Date:   Wed, 13 Mar 2019 13:23:58 +0900
In-Reply-To: <20190312132959.11764-4-chriscool@tuxfamily.org> (Christian
        Couder's message of "Tue, 12 Mar 2019 14:29:51 +0100")
Message-ID: <xmqqpnqve71d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> @@ -98,3 +99,19 @@ int has_promisor_remote(void)
>  {
>  	return !!promisor_remote_find(NULL);
>  }
> +
> +int promisor_remote_get_direct(const struct object_id *oids, int oid_nr)
> +{
> +	struct promisor_remote *o;
> +
> +	promisor_remote_init();
> +
> +	for (o = promisors; o; o = o->next) {
> +		if (fetch_objects(o->remote_name, oids, oid_nr) < 0)
> +			continue;
> +		return 0;

Suppose the caller asks to fetch 3 objects, A, B and C, from two
promisors.  The first promisor can give you A and B but cannot give
you C.  The second promisor only can give you C.

Does fetch_objects() return failure after attempting to fetch A, B
and C from the first promisor?  Then we go on to the second promisor
but do we ask all three?  That would mean the second promisor will
also fail because it cannot give you A and B, and then the whole
thing would fail.  It would be nicer if the mechanism would allow us
to fetch what is still missing from later promisor, perhaps.

As the original "fetch" protocol only allows you to fetch a pack
with everything you asked for in it, instead of feeding you a pack
with best effort, I think the answer to the above is "it is very
hard to improve over what we have here", but people may have
interesting ideas ;-)

> +	}
> +
> +	return -1;
> +}
> +

Adding trailing blank line at the end?

> diff --git a/promisor-remote.h b/promisor-remote.h
> index bfbf7c0f21..f9f5825417 100644
> --- a/promisor-remote.h
> +++ b/promisor-remote.h
> @@ -13,5 +13,6 @@ struct promisor_remote {
>  extern struct promisor_remote *promisor_remote_new(const char *remote_name);
>  extern struct promisor_remote *promisor_remote_find(const char *remote_name);
>  extern int has_promisor_remote(void);
> +extern int promisor_remote_get_direct(const struct object_id *oids, int oid_nr);
>  
>  #endif /* PROMISOR_REMOTE_H */
