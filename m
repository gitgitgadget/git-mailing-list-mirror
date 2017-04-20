Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A6501FE90
	for <e@80x24.org>; Thu, 20 Apr 2017 02:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936991AbdDTCBz (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 22:01:55 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:36137 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936985AbdDTCBx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 22:01:53 -0400
Received: by mail-io0-f170.google.com with SMTP id o22so51472250iod.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 19:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=V05w0wAzlkbKYMi02/QCiJrcVqq+ad3lp7bAud9z/pc=;
        b=q1E00Dc+1o+sowUgIwRZNymxRkBzXJkB2VjOtn4TNfxt6ZGwrCIqT39bGCGwuYcEl1
         qVgMt+VTzdfwMBxW31z8AWd6/Qcu9SxTUPp1c9mpAgpctvcv9xaazCOdVThjG5R2FQ4H
         fYbmsBTPxj5IfJ7OLN30YSKovK7sE4E6WyHpXgBZz2yOM4/10Vo5WWRqLI19fKXQTYa+
         +9PtCYyjE/mbZoJmKRL+LEE+y2/LfwQiWEtUNjXowfuYJLOYhmpiGrVW8k9BEIKE6dGV
         bBAblungLA176Pa+RWptDi2S3gdFA6Rwedrdn7xpmn/20x06l4vuOFUC4lwaGf96Fsur
         tyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=V05w0wAzlkbKYMi02/QCiJrcVqq+ad3lp7bAud9z/pc=;
        b=UmQ4aU7ZBQegUifNAk79v7I1EF8r5+Gghv8el3o+WJIL43c47Fl0E4Xm0ooVoi1Dux
         W7IxvhV/QpwHanFTlsTXjQzxrdlvDcBvSmzpXC4P1eqyBE9+XpsW7Ez0Iwl3iS2Av01T
         CRhT/LnafDYwpdpEfqW0ghS66HyUbGGM0TIPjKqjgymHorvlVAPaBb5T/2Ta4iId+f4B
         rSWWTg7QxJidwDLvnyPZqjGMZQHVv/Jfn37Jx4ZGU42RoWYOccMDJqRA4RXykSqkTSkN
         ksCqp5loVyD/jbhmbqyFEC/lvckeEfpWk92FAsKx3SJGdAWUdlSGhPYbRqyYu8z4nuVX
         oELg==
X-Gm-Message-State: AN3rC/5MzLuuf68We1F4ePdLf6WPJpr4D7EQiIJDw7Tf7hESUFMawNiU
        szbMU8XQBBDJ4A==
X-Received: by 10.99.107.72 with SMTP id g69mr5759201pgc.149.1492653712796;
        Wed, 19 Apr 2017 19:01:52 -0700 (PDT)
Received: from duynguyen.vn.dektech.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id z22sm6709197pfg.117.2017.04.19.19.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 19:01:52 -0700 (PDT)
Date:   Thu, 20 Apr 2017 09:01:47 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 05/12] refs: move submodule slash stripping code to
 get_submodule_ref_store
Message-ID: <20170420020147.GA8879@duynguyen.vn.dektech.internal>
References: <20170419110145.5086-1-pclouds@gmail.com>
 <20170419110145.5086-6-pclouds@gmail.com>
 <a74cf309-fb16-2f45-8189-d1d0c655dea4@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a74cf309-fb16-2f45-8189-d1d0c655dea4@kdbg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 12:02:08AM +0200, Johannes Sixt wrote:
> Am 19.04.2017 um 13:01 schrieb Nguyễn Thái Ngọc Duy:
> > @@ -1558,7 +1543,17 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
> >  {
> >  	struct strbuf submodule_sb = STRBUF_INIT;
> >  	struct ref_store *refs;
> > +	char *to_free = NULL;
> >  	int ret;
> > +	size_t len;
> > +
> > +	if (submodule) {
> > +		len = strlen(submodule);
> > +		while (len && submodule[len - 1] == '/')
> 
> What is the source of the value of 'submodule'? Is it an index entry? Or 
> did it pass through parse_pathspec? In these cases it is correct to 
> compare against literal '/'. Otherwise, is_dir_sep() is preferred.

This is a code move from resolve_gitlink_ref(), which goes back to
0ebde32c87 (Add 'resolve_gitlink_ref()' helper function - 2007-04-09)
and it looks like a dir separator back then.

Can I convert that in a separate topic? I think Michael even wanted to
kill all these path manipulation in refs code, which makes sense, but
I would need to audit the callers carefully before making that move.
--
Duy
