Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B79207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 23:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757893AbdDRXbl (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 19:31:41 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35437 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756235AbdDRXbk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 19:31:40 -0400
Received: by mail-pg0-f42.google.com with SMTP id 72so3705834pge.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 16:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3vtjPtZf/nolsVmhfpoIh0q//Pk9M+esgaiySZkhfM4=;
        b=ggHlZlDscz2P+aKX5jprXBYqL+fG659Yx6n6Nja2OunbZ3D87j0stutMbF7zgolnP4
         kvLXR9xtGFqHEJ1JtEp5BLBzVomZWzC0aUNpBIHwsd4pAfYhxVQ8DrU49YawPhnBJa38
         7fwZMsRErI2oFOq6mzkdEXSNMVP8t5Ns8XYMKyIYgSlidAFeiBDFNYgYWJKLzg9Rqrjh
         2KyZAkunoHbvwpu57PS8huPziLpdC2uXTLxvh9kwRBoW5eNrt9JFkivzj8c/nIk+Ud+f
         uzeKtz6ZG0PD4M2IOr4Oud9IMEBsO+oayF0U5sBLtPD3G+wLXIF8SOUAw4ZMcSICZALA
         UGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3vtjPtZf/nolsVmhfpoIh0q//Pk9M+esgaiySZkhfM4=;
        b=Ch/dDoZAekaVKlnPIHv0MJuRDbTudLoXY4kseudNzfpU4OQHUoaRu64xXIVY4lpNc5
         ABh129CwG87vvwVswEXdybYIhzmiYJ+QXyQjjB0PIYzzeEDRE3cnWR1LWGaMahRteSF8
         UgZkqrA6i/pP7a3gbMENMSQR4KUbnrjvpZitTaK9tjXJ38MhqM8hhe9nMthi+U+czzVp
         ATLUbuvIzHTqL2OW76P+YlnuhSk5rowxX1rJ8lCQHarLhlMRAHcIx5BppNL5tJrEFmw/
         6v+qE/GGtva8QGHH2pCAoSPeFcndkMMb15GBs5Aag+3t2m/cE+G4khPkRRpV34FW2o4A
         vT1w==
X-Gm-Message-State: AN3rC/7ywJiZF271lveAEbn3x3NS4sGSnB5PzBkYARPjlz1BMcwK3nsk
        AYXDSdiff6ZLj7aSWJ+kCVuz1w6wIsMeIy62pA==
X-Received: by 10.99.44.140 with SMTP id s134mr20559455pgs.178.1492558299922;
 Tue, 18 Apr 2017 16:31:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Tue, 18 Apr 2017 16:31:39 -0700 (PDT)
In-Reply-To: <20170418231805.61835-6-bmwill@google.com>
References: <20170417220818.44917-1-bmwill@google.com> <20170418231805.61835-1-bmwill@google.com>
 <20170418231805.61835-6-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Apr 2017 16:31:39 -0700
Message-ID: <CAGZ79kai79=yZc5ywmG_gYcPnva7C8zVY7oGVqHR39TTyq_O-w@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] string-list: add string_list_remove function
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 4:17 PM, Brandon Williams <bmwill@google.com> wrote:

>
> +void string_list_remove(struct string_list *list, const char *string,
> +                       int free_util)
> +{
> +       int exact_match;
> +       int i = get_entry_index(list, string, &exact_match);
> +
> +       if (exact_match) {
> +               if (list->strdup_strings)
> +                       free(list->items[i].string);
> +               if (free_util)
> +                       free(list->items[i].util);
> +
> +               list->nr--;
> +               memmove(list->items + i, list->items + i + 1,
> +                       (list->nr - i) * sizeof(struct string_list_item));
> +       }

Looks correct. I shortly wondered if we'd have any value in returing
`exact_match`, as that may save the caller some code, as I imagine the
caller to be:

  if (!string_list_has_string(&list, string))
    die("BUG: ...");
  string_list_remove(&list, string, 0);

which could be simplified if we had the exact_match returned, i.e.
the string_list_remove returns the implicit string_list_has_string.

>  /*
> + * Removes the given string from the sorted list.

What happens when the string is not found?

> + */
> +void string_list_remove(struct string_list *list, const char *string, int free_util);

How much do we care about (eventual) consistency? ;)
i.e. mark it extern ?

Thanks,
Stefan
