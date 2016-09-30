Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C744220986
	for <e@80x24.org>; Fri, 30 Sep 2016 16:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933576AbcI3Qdx (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 12:33:53 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34274 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932988AbcI3Qdv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 12:33:51 -0400
Received: by mail-pf0-f179.google.com with SMTP id u78so16482955pfa.1
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qB4lsv6Elpe21m/tDhlcHAnm2qVzkcrGkYQjxwZR20E=;
        b=fhQCM6TZm2mLai5dd5edUcq2ZR8W9dUHCwiBIWyD7rG5hE1U5mYZajrUEkr4SzFvvm
         +RtobMj3MXXtki4jzcGOvCP3sMCafKdLBErT2ANdYp7JJOIZxeMP8V70/VmZDGXZDUpK
         QCHu5uzOlD1shSzizEvOClgj63kVuiFuTsy0h06sRf2HZ8UFK429CFwnzqKN5vcnXDy0
         7rnfXLOBVNkp0GXWRTfKK989iDTyZUrFwzaiC1HCgijnJcB/r+dU8xDQew0GjbvC9ZtS
         oh3GPBm7M8+OcaW0waINmyM9hZrY2tPJCiP5XuJjM7AJ/LkxdxMUXOa1SwemHVHB4vp0
         D1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qB4lsv6Elpe21m/tDhlcHAnm2qVzkcrGkYQjxwZR20E=;
        b=ksl4ueSTWXppYSvM+mj07ZuWp4CIOSmLoHQVRlP2uWwZxynhevSkSYoD3V+Qcspg4P
         iQ01ivnoTYbQd29JoD7Mg8KzAXTT/vdqueUz35e6iI7v3hH4bU+mtKjQKNfm8rF0oGWE
         GXSNrnxE5Sew7HPtMfdA/gMAkTKOeNYPA0IU8MS9gl9JClo8823ssHlIq5PvnV1XozpA
         kTRg4c1TUzI0BE7Wy8cRRIZcoQv7gzjKboC666ZZKqXuFlkMVo1TkGFMIGJBaoeibNzz
         htdLJ51veyyQDwO5J+FJXSoCR8wAIRacOZgLHVGbhVNBlJDox4FHgXs4IDp/CX6pIhNE
         MAbA==
X-Gm-Message-State: AA6/9RngvGUKr7seWgkH2fG8hy7fmS+D/qAjMDZwGbAR+d7f7tU/hjczNbSp/vAqbwwrd0qq
X-Received: by 10.98.59.146 with SMTP id w18mr12944965pfj.153.1475253230837;
        Fri, 30 Sep 2016 09:33:50 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:8826:94df:73a:c97f])
        by smtp.gmail.com with ESMTPSA id y11sm29125031pfa.4.2016.09.30.09.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2016 09:33:50 -0700 (PDT)
Date:   Fri, 30 Sep 2016 09:33:47 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net
Subject: Re: [PATCH v6 3/4] ls-files: pass through safe options for
 --recurse-submodules
Message-ID: <20160930163347.GA11126@google.com>
References: <1475099443-145608-1-git-send-email-bmwill@google.com>
 <1475185723-36871-1-git-send-email-bmwill@google.com>
 <1475185723-36871-4-git-send-email-bmwill@google.com>
 <xmqqy42ab5ww.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy42ab5ww.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/29, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > +static void compile_submodule_options(const struct dir_struct *dir, int show_tag)
> > +{
> > +	if (line_terminator == '\0')
> > +		argv_array_push(&submodules_options, "-z");
> > +	if (show_tag)
> > +		argv_array_push(&submodules_options, "-t");
> > +	if (show_valid_bit)
> > +		argv_array_push(&submodules_options, "-v");
> > +	if (show_cached)
> > +		argv_array_push(&submodules_options, "--cached");
> > +	if (show_deleted)
> > +		argv_array_push(&submodules_options, "--deleted");
> > +	if (show_modified)
> > +		argv_array_push(&submodules_options, "--modified");
> > +	if (show_others)
> > +		argv_array_push(&submodules_options, "--others");
> > +	if (dir->flags & DIR_SHOW_IGNORED)
> > +		argv_array_push(&submodules_options, "--ignored");
> > +	if (show_stage)
> > +		argv_array_push(&submodules_options, "--stage");
> > +	if (show_killed)
> > +		argv_array_push(&submodules_options, "--killed");
> > +	if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
> > +		argv_array_push(&submodules_options, "--directory");
> > +	if (!(dir->flags & DIR_SHOW_OTHER_DIRECTORIES))
> > +		argv_array_push(&submodules_options, "--empty-directory");
> > +	if (show_unmerged)
> > +		argv_array_push(&submodules_options, "--unmerged");
> > +	if (show_resolve_undo)
> > +		argv_array_push(&submodules_options, "--resolve-undo");
> > +	if (show_eol)
> > +		argv_array_push(&submodules_options, "--eol");
> > +	if (debug_mode)
> > +		argv_array_push(&submodules_options, "--debug");
> > +}
> 
> With this and 4/4 applied, the documentation still says "--cached"
> is the only supported option.
> 
> Does it really make sense to pass all of these?  I understand "-z"
> and I suspect things like "-t" and "-v" that affect "how" things are
> shown may also happen to work, but I am not sure how much it makes
> sense for options that affect "what" things are shown.
> 
> What does it even mean to ask for say "--unmerged" to be shown, for
> example, from the superproject?  Recurse into submodules whose cache
> entries in the index of the superproject are unmerged, or something
> else?
> 
> I am inclined to say that it is probably better to keep the
> "--cached only" as documented, at least on the "what are shown"
> side.
> 
> Thanks.

You're right that probably makes the most sense for now.

-- 
Brandon Williams
