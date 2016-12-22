Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454671FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 17:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1765900AbcLVRdF (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 12:33:05 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36600 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760440AbcLVRdE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 12:33:04 -0500
Received: by mail-pg0-f51.google.com with SMTP id f188so99876824pgc.3
        for <git@vger.kernel.org>; Thu, 22 Dec 2016 09:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uumroQguwsR6TSURPu5EAeTvplnfmJ0MJ4VdOsxzRBA=;
        b=uGQBm7cpDsxN5tmtpzocH/qDMezA2AU6sWfqH63i0W4DM+kEnRBhBEDxdFbaadEPhk
         07SsO0pzBMY8Ez/+BBDz9gUgZ/CEMirMEG8DksRUZD2EaWv4Rst2Orsd9c1fCV2UuWv3
         7NWkvqP4YdOuadYaKjCb7KlJtiNWx5MtBn1K9CINmtfmH8QdUSKJN/DyR0Rs22PyDkGO
         fFmyT9G3cc/OVLOb9wXhDwexaWEKl8M3YlA+RiMlCl4iWiUduqdz+RkXsf4vA90x7aJQ
         hTk6ZIIVPm7T9nn8Ftw/LIoyc8hLLhqUFku9YSlMSEuky8xhO9i6hPntHWh7R4uGOO0Y
         Q0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uumroQguwsR6TSURPu5EAeTvplnfmJ0MJ4VdOsxzRBA=;
        b=T4/JOw3jhjgEHhaZz8LpwTRSdEY0K7WUyiaoeTUyIOfGux3mgQDh4tM5KrCLs9g3Do
         18Vc8YZRNBr2DJ5aMslminoWbMpcAakqPNjnh8Jhxj3WFL2WT45mHnwTYlNQ+wAvUYvt
         1BsLmvTsrvc5mtFK7tnErCr8EuAEXfYdT9JBOuSV8AvZ6QACUdjw79Hbyp2Sgbf4+0xV
         13oR15RwpL5rldBAfPNCbRkmJ8oYrp8i2MaNXM5koyOz5qFKZ0oWmbdXHJcx3n6o6Fmh
         fR11QzAjW92YtmQIg6yH2vCoSs0eAEufvxFaC55qv+H5uUJ6e2rMPGOc5ouzLTSDAito
         imBw==
X-Gm-Message-State: AIkVDXKmM7HKsq/68mFJN7o3ghP2IMn4TrKifaGbQTHV0O6DFjpQauCSnEMd/vyQiQ4/585L
X-Received: by 10.84.170.195 with SMTP id j61mr21723218plb.13.1482427983700;
        Thu, 22 Dec 2016 09:33:03 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d088:6946:f252:36bf])
        by smtp.gmail.com with ESMTPSA id o126sm56611790pga.34.2016.12.22.09.33.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Dec 2016 09:33:02 -0800 (PST)
Date:   Thu, 22 Dec 2016 09:33:01 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, pclouds@gmail.com
Subject: Re: [PATCH bw/realpath-wo-chdir] real_path: canonicalize directory
 separators in root parts
Message-ID: <20161222173301.GB119874@google.com>
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
 <1481566615-75299-1-git-send-email-bmwill@google.com>
 <097e3e2e-f46d-b0aa-be9c-68c274c5e3dc@kdbg.org>
 <20161221223304.GA119874@google.com>
 <0c9aa347-d64e-b7d7-9b07-52d844d76252@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c9aa347-d64e-b7d7-9b07-52d844d76252@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/22, Johannes Sixt wrote:
> Am 21.12.2016 um 23:33 schrieb Brandon Williams:
> >On 12/21, Johannes Sixt wrote:
> >>+/* copies root part from remaining to resolved, canonicalizing it on the way */
> >>+static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
> >>+{
> >>+	int offset = offset_1st_component(remaining->buf);
> >>+
> >>+	strbuf_reset(resolved);
> >>+	strbuf_add(resolved, remaining->buf, offset);
> >>+#ifdef GIT_WINDOWS_NATIVE
> >>+	convert_slashes(resolved->buf);
> >>+#endif
> >
> >So then the only extra cononicalization that is happening here is
> >converting '\\server\share' to '//server/share'? (or 'c:\' to 'c:/')
> 
> Correct. All other directory separators are canonicalized by the
> primary function, strbuf_realpath.

Sounds good. Logically everything looks good to me.  And I like that
setting 'resolved' to the root of an abs path is pulled out into a
helper function.  It took me a couple extra seconds to realize that
offset_1st_component returns 0 with a relative path, which makes causes
the call to get_root_part to essentially be a noop (ie nothing is
resolved).

Thanks for helping get this to work on windows!

-- 
Brandon Williams
