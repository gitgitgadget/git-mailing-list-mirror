Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A58420401
	for <e@80x24.org>; Thu, 15 Jun 2017 20:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbdFOUbH (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 16:31:07 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35776 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbdFOUbG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 16:31:06 -0400
Received: by mail-pf0-f174.google.com with SMTP id l89so12390559pfi.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 13:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tggLYcjegzNWoGbEz1dA9VvRlbRyxUe+VMJg3/yJDck=;
        b=FUKH6vnW9s3QBJHN85hWEfi5Xl2z/9sDFkE+guRd4vyJKTe4x9Ktef/IHgqTbTy4NA
         2cYZR2MUc5S4irkOIq4mEkFJzWqNrFdPRXkdCbBaZ1X8T1w9R69ZNiT8eJw8rodzCRDj
         rINOjJbSSgUEGWHiJyEaZNJnVUVITOK4m84w8Uz1ElCKc1qhnlmxp7LFtfejiwVfnzVl
         Q6hUqik9bMxKy8OuFmZCWqGfLejazXa3+prddhC/P7pPo9B2dJvwLsI6Bsn++uoHVbqm
         G74tyAdTDvKvbZgqwv6rCqTCfiJfs2lylm+3guXJ5jxbv6ZWNjBNYLad6CxmsXDlBiJi
         Bq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tggLYcjegzNWoGbEz1dA9VvRlbRyxUe+VMJg3/yJDck=;
        b=XjhKNUAcKq5FU/MYjH3bxh9o0Abi9kjqSQILiEhSZ0KUP9w7zYuiFNJRMlt19CDmam
         AOGrFLzEfQkDUITndWzNW95BdCDAu/yZWgcgvVlQk6V4GICBmD0TaLJ/Ok0kN1FlAToq
         PUQ77a752Ba3Vz2JJEAS8/WXc10KP/+aLQO0BD9vYw3Xe4O/5B98BJHcDkLM2UUZCuh2
         VmyqCW+1bjxLlUrGtLC+kpF3x9awKr65K9X+5MCppFINNZZvJTpWuF+oRPd/ra5NiBZs
         GwK9T/m1mWsy5LkTf+AXgi9/WPph9ijZm73TPHJOsImQHFoPPCJwQlklXOt7W+3VV160
         hgEA==
X-Gm-Message-State: AKS2vOxupmfIC9sGCXaHNvLllALYGyyLLLJ6tpI1GqhZAnthXjrCaRKm
        /eGIYXbg6KB8o3P9
X-Received: by 10.84.232.141 with SMTP id i13mr8228594plk.172.1497558665053;
        Thu, 15 Jun 2017 13:31:05 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a05c:fb80:1fb9:b013])
        by smtp.gmail.com with ESMTPSA id v62sm229039pfb.124.2017.06.15.13.31.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 13:31:04 -0700 (PDT)
Date:   Thu, 15 Jun 2017 13:31:00 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 4/4] sha1_file, fsck: add missing blob support
Message-ID: <20170615133100.55561be6@twelve2.svl.corp.google.com>
In-Reply-To: <xmqqy3st14my.fsf@gitster.mtv.corp.google.com>
References: <cover.1497387713.git.jonathantanmy@google.com>
        <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1497387713.git.jonathantanmy@google.com>
        <aa3904dbe16050188a6b70a209bfcbfa86ea3213.1497387714.git.jonathantanmy@google.com>
        <xmqqy3st14my.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A reroll is coming soon, but there is an interesting discussion point
here so I'll reply to this e-mail first.

On Thu, 15 Jun 2017 11:34:45 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > +struct missing_blob_manifest {
> > +	struct missing_blob_manifest *next;
> > +	const char *data;
> > +};
> > +struct missing_blob_manifest *missing_blobs;
> > +int missing_blobs_initialized;
> 
> I do not think you meant to make these non-static.  The type of the
> former is not even visible to the outside world, and the latter is
> something that could be made into static to prepare_missing_blobs()
> function (unless and until you start allowing the missing-blobs
> manifest to be re-initialized).  Your ensure_configured() below
> seems to do the "static" right, on the other hand ;-).

Good catch - done.

> Do we expect that we will have only a handful of these missing blob
> manifests?  Each manifest seems to be efficiently looked-up with a
> binary search, but it makes me wonder if it is a good idea to
> consolidate these manifests into a single list of object names to
> eliminate the outer loop in has_missing_blob().  Unlike pack .idx
> files that must stay one-to-one with .pack files, it appears to me
> that there is no reason why we need to keep multiple ones separate
> for extended period of time (e.g. whenever we learn that we receieved
> an incomplete pack from the other side with a list of newly missing
> blobs, we could incorporate that into existing missing blob list).

There is indeed no reason why we need to keep multiple ones separate for
an extended period of time - my thinking was to let fetch/clone be fast
by not needing to scan through the entire existing manifest (in order to
create the new one), letting GC take care of consolidating them (since
it would have to check individual entries to delete those corresponding
to objects that have entered the repo through other means). But this is
at the expense of making the individual object lookups a bit slower.

For now, I'll leave the possibility of multiple files open while I try
to create a set of patches that can implement missing blob support from
fetch to day-to-day usage. But I am not opposed to changing it to a
single-file manifest.

> > +int has_missing_blob(const unsigned char *sha1, unsigned long *size)
> > +{
> 
> This function that answers "is it expected to be missing?" is
> confusingly named.  Is it missing, or does it exist?

Renamed to in_missing_blob_manifest().

> > @@ -2981,11 +3050,55 @@ static int sha1_loose_object_info(const unsigned char *sha1,
> >  	return (status < 0) ? status : 0;
> >  }
> >  
> > +static char *missing_blob_command;
> > +static int sha1_file_config(const char *conf_key, const char *value, void *cb)
> > +{
> > +	if (!strcmp(conf_key, "core.missingblobcommand")) {
> > +		missing_blob_command = xstrdup(value);
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int configured;
> > +static void ensure_configured(void)
> > +{
> > +	if (configured)
> > +		return;
> 
> Do not be selfish and pretend that this is the _only_ kind of
> configuration that needs to be done inside sha1_file.c.  Call the
> function ensure_<something>_is_configured() and rename the run-once
> guard to match.

My thinking was that any additional configuration could be added to this
function, but individual configuration for each feature is fine too. I
have renamed things according to your suggestion.

> The run-once guard can be made static to the "ensure" function, and
> if you do so, then its name can stay to be "configured", as at that
> point it is clear what it is guarding.

Done.

> > +pack() {
> 
> Style: "pack () {"

Done.

> 
> > +	perl -e '$/ = undef; $input = <>; print pack("H*", $input)'
> 
> high-nybble first to match ntohll() done in has_missing_blob()?  OK.

Actually it's to match the printf behavior below that prints the high
nybble first (like in English).
