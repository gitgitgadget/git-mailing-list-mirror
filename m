Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43A641FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 22:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755336AbcLUWkA (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 17:40:00 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36266 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbcLUWj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 17:39:59 -0500
Received: by mail-pg0-f48.google.com with SMTP id f188so89894905pgc.3
        for <git@vger.kernel.org>; Wed, 21 Dec 2016 14:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FnKs36M+m/cf3FuCh5/tZt733hrksPn+xECOsQFtw/w=;
        b=XWlJYFFKK48DRufpq+aroXiu3Mfe9xek+L5O83ZShYf/12Apd3hLwzEMGveJ4aP4vo
         7VWpvuEstm/KYT0HDrQZY8Ht+jB+AG0T+QPKbpWlv/+X5XAXwNFx6L5quPjr0h5dJsD2
         Vl0BUdTp9mdTuJA/qkOZomtbWG4hnuh/hOB1f24vJhYep3eGcBJlXDyD/yySGCzwZZ6R
         tHU3R2Hc1az5S6VC/Eyg1GhUI1SbNrNvWqrYHoppEiLrVOyJYoui/IwSdjG+UaMT343j
         CqU8Z4+QNF07nkpF9t1HFBcFbi1P9lsu9a8Hkc20zaWmL/5ziTHVE9NXUUvvH/4b3jBW
         ee4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FnKs36M+m/cf3FuCh5/tZt733hrksPn+xECOsQFtw/w=;
        b=b2rwQ8WIRox5n7CLmtykFdxzf0L8KL0jsMg0/RKqf64UkPxbesFXiuRs0REEqG+ZJ1
         9GQx3gkO+gWhL7uiiOt7pPihKspV4kVsmwvLa24Khh9p8HUaoVHvcMIDZxE3yNPX+NM8
         pj5ZladX8/swY7ro1lXKD3ChYbH1BDye9GLsM0If3CrhC1VHF4bqDf+FIl58cpKsKl8q
         ASWiBP3jz0PY31i/sww2MoamvHWOb0CtRw0JbIONWbrqGMpwkMOjDYu7JXr6teFmSxms
         AeGYiGcnVhrsnvq/pw+HTgYlnkjlK5Oih9mlxTDwAkISd8TjZKM5ykKeSz3Ptjce3BVl
         zXLg==
X-Gm-Message-State: AIkVDXK6mi48zobs5u4k69mryuYL3zmtxu5t23jYf1sd/wD47mqpO9zpkclXFGbQOlhhA1Z0
X-Received: by 10.84.142.70 with SMTP id 64mr12940488plw.177.1482359587028;
        Wed, 21 Dec 2016 14:33:07 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:9106:6579:af50:bf2a])
        by smtp.gmail.com with ESMTPSA id b71sm49172550pfj.62.2016.12.21.14.33.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Dec 2016 14:33:06 -0800 (PST)
Date:   Wed, 21 Dec 2016 14:33:04 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, pclouds@gmail.com
Subject: Re: [PATCH bw/realpath-wo-chdir] real_path: canonicalize directory
 separators in root parts
Message-ID: <20161221223304.GA119874@google.com>
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
 <1481566615-75299-1-git-send-email-bmwill@google.com>
 <097e3e2e-f46d-b0aa-be9c-68c274c5e3dc@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <097e3e2e-f46d-b0aa-be9c-68c274c5e3dc@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/21, Johannes Sixt wrote:
> When an absolute path is resolved, resolution begins at the first path
> component after the root part. The root part is just copied verbatim,
> because it must not be inspected for symbolic links. For POSIX paths,
> this is just the initial slash, but on Windows, the root part has the
> forms c:\ or \\server\share. We do want to canonicalize the back-slashes
> in the root part because these parts are compared to the result of
> getcwd(), which does return a fully canonicalized path.
> 
> Factor out a helper that splits off the root part, and have it
> canonicalize the copied part.
> 
> This change was prompted because t1504-ceiling-dirs.sh caught a breakage
> in GIT_CEILING_DIRECTORIES handling on Windows.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  This introduces the second #ifdef GIT_WINDOWS_NATIVE in this file.
>  It could be avoided if convert_slashes were defined as a do-nothing
>  on POSIX, but that would not help the other occurrence. Therefore,
>  I suggest to leave it at this.
> 
>  abspath.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/abspath.c b/abspath.c
> index 79ee310867..1d56f5ed9f 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -48,6 +48,19 @@ static void get_next_component(struct strbuf *next, struct strbuf *remaining)
>  	strbuf_remove(remaining, 0, end - remaining->buf);
>  }
>  
> +/* copies root part from remaining to resolved, canonicalizing it on the way */
> +static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
> +{
> +	int offset = offset_1st_component(remaining->buf);
> +
> +	strbuf_reset(resolved);
> +	strbuf_add(resolved, remaining->buf, offset);
> +#ifdef GIT_WINDOWS_NATIVE
> +	convert_slashes(resolved->buf);
> +#endif

So then the only extra cononicalization that is happening here is
converting '\\server\share' to '//server/share'? (or 'c:\' to 'c:/')

-- 
Brandon Williams
