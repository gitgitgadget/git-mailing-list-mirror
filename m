Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA5F1207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 17:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972059AbdDXRUa (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 13:20:30 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33928 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758585AbdDXRU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 13:20:28 -0400
Received: by mail-pg0-f48.google.com with SMTP id v1so4546972pgv.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 10:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DJDqZRIE8uy5Ns3iIXRnt0v5vjiB+tp+BJLRq7z5k+g=;
        b=NgJXet6JNPR9WozuEoz9sEvOShA9ONCveu8dTMW+djZaaglthy9HKC6UUNBYEoYQyE
         /+/NfxGSdcV/gwNu8ew4s4t7zAB7xW2adWg0FamZbZw59CPUGFUgURK9uvlEWKNTdWjX
         9xutcDRCiT5sHdrhu87bGRdLF6vu5ahRwYKC5V8kD8hENmoKFzpEqHIDg2fydWpjlmdq
         6vyOEAOpfiDXvecke773Pkg5SJipw5kd5hov6UZLfFA8IXeUp/Dtmz/cgLhta39yBU9s
         cUUl5j6PiMKbLaDlN9AoEATKZ8VGdb3ZGIwVTE+U8G9s6Ai5E3Ln31fTC76C6kqmUAbB
         kelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DJDqZRIE8uy5Ns3iIXRnt0v5vjiB+tp+BJLRq7z5k+g=;
        b=avHoJQJfT6ltEq3t5EPuaC8iSoIem1aeLBaMFFULyFE8sxgTBYTgK/IFRwmw9LINci
         jsmAHIaurk+r4bo87OLD8lcej3rkhAnHXjDBvW+FhoR10gPuLYP9z1+Lxvsp5glkzfrM
         CkD3FZhAUKNFUlvVVpXwxbVFMKiL4/1yIJTo0Z6DQJBpSk9Nd+5+sQKetzjqWzIRdaL1
         cOvKZvpWvCT5JOHVIJ7xI3NoHBwKZ/v1ubXab1/aTyJww4KwHl6edg2mvbJUmXfjLv8j
         jBBNscetrUewBfdSehzwAUDJBbgFG53/TQVRco088Hrsqaq25qMTVvP0TzKwluYXNGmb
         oFhA==
X-Gm-Message-State: AN3rC/7M7x7BpDy986b88LdOSkSWji7xmXW01TsDWb5yoMGRNRN6Dh2Z
        Wrkf5RecHPoD9prgi1NAIcD2kYpTBP/X7L0=
X-Received: by 10.84.248.76 with SMTP id e12mr21298841pln.76.1493054427875;
 Mon, 24 Apr 2017 10:20:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Mon, 24 Apr 2017 10:20:27 -0700 (PDT)
In-Reply-To: <20170423213453.253425-12-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net> <20170423213453.253425-12-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Apr 2017 10:20:27 -0700
Message-ID: <CAGZ79kbdVEhcxP4dhSR6GaOKjgTD+bPn_+5edV4TjV3A84HQ-A@mail.gmail.com>
Subject: Re: [PATCH 11/53] fast-import: convert to struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 23, 2017 at 2:34 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Convert the remaining parts of fast-import.c to use struct object_id.
> Convert several instances of get_sha1_hex to parse_oid_hex to avoid
> needing to specify constants.  Convert other hardcoded values to named
> constants.  Finally, use the is_empty_tree_oid function instead of a
> direct comparison against a fixed string.
>
> Note that the odd computation with GIT_MAX_HEXSZ is due to the insertion
> of a slash between every two hex digits in the path, plus one for the
> terminating NUL.

Up to and including this patch are
Reviewed-by: Stefan Beller <sbeller@google.com>

I may continue reviewing this series once my eyes are refreshed.

>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

> @@ -2823,12 +2821,10 @@ static void parse_new_commit(const char *arg)
>         strbuf_addf(&new_data, "tree %s\n",
>                 oid_to_hex(&b->branch_tree.versions[1].oid));
>         if (!is_null_oid(&b->oid))
> -               strbuf_addf(&new_data, "parent %s\n",
> -                           oid_to_hex(&b->oid));
> +               strbuf_addf(&new_data, "parent %s\n", oid_to_hex(&b->oid));
>         while (merge_list) {
>                 struct hash_list *next = merge_list->next;
> -               strbuf_addf(&new_data, "parent %s\n",
> -                           oid_to_hex(&merge_list->oid));
> +               strbuf_addf(&new_data, "parent %s\n", oid_to_hex(&merge_list->oid));
>                 free(merge_list);
>                 merge_list = next;
>         }

This is a funny one. The only change is line rewrapping, as it fits
into 80 cols easily.
I was reviewing this series using colored --word-diff output, and this hunk does
not produce any red or green. I wonder if this is the intended
behavior of the word diffing
or if we rather want to insert a <RED> - \n - </RED>.

Thanks,
Stefan
