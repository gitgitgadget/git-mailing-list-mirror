Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCB40202BB
	for <e@80x24.org>; Wed,  3 Apr 2019 22:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfDCWIp (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 18:08:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33161 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDCWIp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 18:08:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so5814358wmi.0
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 15:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CUh7t9a+Fk8KaAqmzx6duCO3nXC6Fbqdc1c1Lf1d8Lo=;
        b=EiFPZVHON8kCeW49fFT1LMs18kiDmO6FQsvIuGN+7EZM3TzKyfdcKyz0l6L+dPdOcJ
         j06Hs9LXlBsHQv5E48RkTWa9/UvUn1lY15/XjLs0NDRCVeAbn8jLF0idC8Guwryp6a/B
         hUl0jz7NL6LwDIUlXbBjYa7gRExmjdWq7bAx2q59bpYTd8ma18RtR5LnDukk4+8A46Hs
         p3gY3GUQZ97VLKiaBbCVJMDT1cD3+vNulr7F4WWqkfZ1GwOcpbqdWYcWuZjIGAGaaCIj
         ZXIaE1a1+n+u3Gx8KeGtxcJ8TlKxwtPUF5+I9k7y3rPyCF0WnIUscYqOvLuK43oRgPU8
         y7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CUh7t9a+Fk8KaAqmzx6duCO3nXC6Fbqdc1c1Lf1d8Lo=;
        b=jG+Y8IKRs3re15ZsgenuoxFylHlzoWfVP5ViLgObcKGl9gZvoZy92sIK9VKJom5Z8a
         gvmyBsV4OsSEhOFIpoPrkbndJHAchLwjjcZeAmwsiSHrYgMYNRQ8JqBoaFvgkcZ1goHz
         Ho0FUlYx688tXdCH2FMhd6GY1PRlJG11oHtDJCyI3pgvRbDsn5CvMYfSgY9uHKhWps8L
         P45/7ldEPYQWl2hYZiYjWa+uZ5q8zi1nbkhcD7vVt4m92yO9RNzVvROZkZejwzG3g9Tw
         F+tIb/BNupCPmI/YalB4RZpEEjiZn4dRrk/o/7z4zxA6c7dJvTA++K6Zrjlp8JFxwBZ7
         RZpA==
X-Gm-Message-State: APjAAAVyoTlpR6Fa2mpfL6K0eable2qssYUeSOLEUuyJ/k/MwvvTwHUW
        cIvRLLPQ4HX3unaiRKaKa2s=
X-Google-Smtp-Source: APXvYqwDIP2hmQ3jyl4wKv+NkpVTzIugfZrHE6tgrtgyRUafSfQ7/ScHxnKlFYKEQOH3trxn6FwVkA==
X-Received: by 2002:a1c:40d6:: with SMTP id n205mr1383548wma.140.1554329323273;
        Wed, 03 Apr 2019 15:08:43 -0700 (PDT)
Received: from szeder.dev (x4db44034.dyn.telefonica.de. [77.180.64.52])
        by smtp.gmail.com with ESMTPSA id d7sm20361443wmf.31.2019.04.03.15.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:08:42 -0700 (PDT)
Date:   Thu, 4 Apr 2019 00:08:39 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v4 02/11] Add initial support for many promisor remotes
Message-ID: <20190403220839.GM32732@szeder.dev>
References: <20190401164045.17328-1-chriscool@tuxfamily.org>
 <20190401164045.17328-3-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190401164045.17328-3-chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 01, 2019 at 06:40:36PM +0200, Christian Couder wrote:
> diff --git a/promisor-remote.c b/promisor-remote.c
> new file mode 100644
> index 0000000000..0c768210ee
> --- /dev/null
> +++ b/promisor-remote.c
> @@ -0,0 +1,92 @@
> +#include "cache.h"
> +#include "promisor-remote.h"
> +#include "config.h"
> +
> +static struct promisor_remote *promisors;
> +static struct promisor_remote **promisors_tail = &promisors;
> +
> +static struct promisor_remote *promisor_remote_new(const char *remote_name)
> +{
> +	struct promisor_remote *r;
> +
> +	if (*remote_name == '/') {
> +		warning(_("promisor remote name cannot begin with '/': %s"),
> +			remote_name);
> +		return NULL;
> +	}
> +
> +	FLEX_ALLOC_STR(r, name, remote_name);
> +
> +	*promisors_tail = r;
> +	promisors_tail = &r->next;
> +
> +	return r;
> +}
> +
> +static struct promisor_remote *promisor_remote_lookup(const char *remote_name,
> +						      struct promisor_remote **previous)
> +{
> +	struct promisor_remote *r, *p;
> +
> +	for (p = NULL, r = promisors; r; p = r, r = r->next)
> +		if (r->name && !strcmp(r->name, remote_name)) {

r->name is a FLEX_ARRAY, and Clang complains about this condition:

  promisor-remote.c:34:10: error: address of array 'r->name' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
                  if (r->name && !strcmp(r->name, remote_name)) {
                      ~~~^~~~ ~~
  1 error generated.
  make: *** [promisor-remote.o] Error 1

