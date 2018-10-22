Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0CBF1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 21:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbeJWGIW (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:08:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33910 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeJWGIW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:08:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id g12-v6so19636963pgs.1
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 14:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vEFFjSuO3q8SGIlK5SX60lF1GQJhpS3AO3CuBXTG2Xw=;
        b=vmE0OnfIU+AAs180gjClYAynBeSzz5zNPUpOtWVtWDpPAabggS38sOZRdiajHY/Moa
         hrBotNSlkdIQhgqVihulxiYvM3cU2NVYKCTaEh+ebb3jU/IvxwajALBcf00thUbmxyW/
         l27ew1F+62Ia/fNmWGwmbiR1nefhH3Dc0hlBP3DaMr3MKEf2+DFwqq/D8T2KB0ER74rj
         UGDAYVRH37CCkxZy5uMW++xz24WFbS31iIjIBp58AWX0szepGLdKU3qWCFo3ejktmzQM
         sC0eMTwH143xeTmQn8Cx3ExZaM7cZWTAyeRoc/qbC1/jkPk9nFVx+x5+iFqCFwXsMUMZ
         zKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=vEFFjSuO3q8SGIlK5SX60lF1GQJhpS3AO3CuBXTG2Xw=;
        b=j7C59//UfkmiJ2XFOgmNf+zbcfEmKXPxNNsaAEKHXAhArkcNADbCJoXdfo/5mGd3IF
         w6MVutVlVnbLy4U1VhSuma9vDJcdyXLicUHjTDRIQ/4PfYyUU/bMZPS7WkUw1dU/hiIU
         yugB5VjzgpxebBcI4xcXQUqV7IrsDXmWnP6x6LE8z1DNZExjfzIxxYbxPIaMjjWqzZhP
         S4+KY6IfesqbB2D7xOOjXztueZhAuAtzIbUxqAur1TX7b3OmnXn256XrvGwJgsflWJUB
         tKru1B/OUDb26dWNyRRIc8+QZHxuB+VrpEVwqBRMFC7RfFYYH7dmJJ3Y8r+82mWsUQ/W
         373g==
X-Gm-Message-State: ABuFfohLhMUUaB7QClmZoSLJZU2FVg89F9X5nYISbJBdG1WDwGUKzbhy
        bT1hC1K6BNoYwP8b4V9Ti42C4Q==
X-Google-Smtp-Source: ACcGV63CsD1olKvMfQB1XG+s+jvN68Qpru2aogUU0u3qA8rgLdlljyi0dMIs+1bbLt4qtgoWJEABqg==
X-Received: by 2002:a63:214d:: with SMTP id s13-v6mr44624570pgm.148.1540244882501;
        Mon, 22 Oct 2018 14:48:02 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id v189-v6sm42962200pfb.54.2018.10.22.14.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 14:48:01 -0700 (PDT)
Date:   Mon, 22 Oct 2018 14:47:56 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] archive: init archivers before determining format
Message-ID: <20181022214756.GC233961@google.com>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <cover.1539990488.git.steadmon@google.com>
 <b1f8e288dde9a9dd46386524189da66c7ad2c333.1539990488.git.steadmon@google.com>
 <20181019235945.GB7326@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019235945.GB7326@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.10.19 19:59, Jeff King wrote:
> On Fri, Oct 19, 2018 at 04:19:28PM -0700, steadmon@google.com wrote:
> 
> > diff --git a/builtin/archive.c b/builtin/archive.c
> > index e74f675390..dd3283a247 100644
> > --- a/builtin/archive.c
> > +++ b/builtin/archive.c
> > @@ -45,7 +45,10 @@ static int run_remote_archiver(int argc, const char **argv,
> >  	 * it.
> >  	 */
> >  	if (name_hint) {
> > -		const char *format = archive_format_from_filename(name_hint);
> > +		const char *format;
> > +		init_tar_archiver();
> > +		init_zip_archiver();
> > +		format = archive_format_from_filename(name_hint);
> >  		if (format)
> >  			packet_write_fmt(fd[1], "argument --format=%s\n", format);
> 
> Hrm. This code was added back in 56baa61d01 (archive: move file
> extension format-guessing lower, 2011-06-21), and your example
> invocation worked back then!
> 
> Unfortunately it was broken by the very next patch in the series,
> 08716b3c11 (archive: refactor file extension format-guessing,
> 2011-06-21). I guess that's what I get for not adding regression tests.
> 
> It's probably worth mentioning those points in the commit message.

Done.

> Does this work with configured archiver extensions, too? I think so,
> because we load them via init_tar_archiver().

If you mean things like .tgz and .tar.gz, then yes, they are affected by
the bug as well, and this patch fixes them. The test included in v2 uses
a .tgz file.

> Can we avoid repeating the list of archivers here? This needs to stay in
> sync with the list in write_archive(). I know there are only two, but
> can we factor out an init_archivers() call or something?

Done.

> We also should probably just call it unconditionally when we start the
> archiver command (I don't think there are any other bugs like this
> lurking, but it doesn't cost very much to initialize these; it makes
> sense to just do it early).

Done.

> Other than those minor points (and the lack of test), your fix looks
> good to me.

Thanks for the review!
