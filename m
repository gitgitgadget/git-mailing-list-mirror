Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5974E20229
	for <e@80x24.org>; Tue,  1 Nov 2016 17:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbcKARXQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 13:23:16 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36637 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750889AbcKARXP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 13:23:15 -0400
Received: by mail-pf0-f175.google.com with SMTP id 189so44881335pfz.3
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MSEV5GpCDMsrUxdRiTlAuxPD5tRVxQ2zb+I+18whoUs=;
        b=HTKndpbVgOGUF+V2c8++LYQMRQ2SGQmrWJbjQRHnuyRSGl9oFoRqP0Wf2NkjUMz28S
         sgvUSkuWUFk45E/vVHgJXbtozSULYr5nJCGLRilOCRj6bxUgksKeVvd8aWll+PrpUCz6
         lmDkLHwmAACaKOsOCvRrUcjO3+OxbB7kirW2QMa9oPtHhAP6/RPkhUb9pSiQ6rOljtxL
         ZDHyK0Fzam5++109rC4u1OgTyjgM7uH9CalAa505bN/Y57iaKJi0T/BM0ZpuTlkO6FQl
         PsLIFvmsVmda3kzsdR1U8YQBsWFqgV4JTREUoTBD5j/c/OUbryhHDPnBS3yAQMSYRbNv
         9fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MSEV5GpCDMsrUxdRiTlAuxPD5tRVxQ2zb+I+18whoUs=;
        b=gNwyQQk1Yj9+AAgQOgOrqO2W0/o3zY87QpaQUODjuXD40z3jDmG07K/nXw+ICOtkeY
         4GGlCuiuz8Hwe2/YeldzfpdeCxMhbDu02j9kNQJvrIebaou4bNO9I12T4UtuTRS4Ylqr
         fkcZCH9X7+PacC7Elr5gFQdO9iK75FhM44L2+UvU9jrhxXUB4Hpgr9V2xvLgCGGQnfLu
         jSeJ86XCZD0XfVi55hmsckVh7nNaD13aIm9fjBFwXBYDCbRqAygKjhrwuWNaL/hw/rbS
         X+RrmdrlyouUps8aLo5Ko4eLRBMI9RKbF2tSNEH5H18aHRBYYyVzLIaRN7IIFFFyf98w
         dWbQ==
X-Gm-Message-State: ABUngvd0U6MT754nZU1tIsgXAJ+74W9X1B9BTXFJMB5SjG8kUbeCL/1BFDIn8IYDobxMpRMC
X-Received: by 10.99.67.7 with SMTP id q7mr50275286pga.74.1478020994571;
        Tue, 01 Nov 2016 10:23:14 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:3408:feb:5098:461b])
        by smtp.gmail.com with ESMTPSA id cp2sm43629542pad.3.2016.11.01.10.23.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 01 Nov 2016 10:23:13 -0700 (PDT)
Date:   Tue, 1 Nov 2016 10:23:12 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] submodules: add helper functions to determine
 presence of submodules
Message-ID: <20161101172312.GA13899@google.com>
References: <20161027223834.35312-1-bmwill@google.com>
 <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1477953496-103596-2-git-send-email-bmwill@google.com>
 <CAGZ79kamzSPyM65k9ugS0dAJCfGnGvk3m2p+XtCEozCvoZ5+OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kamzSPyM65k9ugS0dAJCfGnGvk3m2p+XtCEozCvoZ5+OA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/31, Stefan Beller wrote:
> On Mon, Oct 31, 2016 at 3:38 PM, Brandon Williams <bmwill@google.com> wrote:
> > +int is_submodule_checked_out(const char *path)
> > +{
> > +       int ret = 0;
> > +       struct strbuf buf = STRBUF_INIT;
> > +
> > +       strbuf_addf(&buf, "%s/.git", path);
> > +       ret = file_exists(buf.buf);
> 
> I think we can be more tight here; instead of checking
> if the file or directory exists, we should be checking if
> it is a valid git directory, i.e. s/file_exists/resolve_gitdir/
> which returns a path to the actual git dir (in case of a .gitlink)
> or NULL when nothing is found that looks like a git directory or
> pointer to it.

Sounds good.

> > +
> > +       strbuf_release(&buf);
> > +       return ret;
> > +}
> > +
> >  int parse_submodule_update_strategy(const char *value,
> >                 struct submodule_update_strategy *dst)
> >  {
> > diff --git a/submodule.h b/submodule.h
> > index d9e197a..bd039ca 100644
> > --- a/submodule.h
> > +++ b/submodule.h
> > @@ -37,6 +37,8 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
> >                 const char *path);
> >  int submodule_config(const char *var, const char *value, void *cb);
> >  void gitmodules_config(void);
> > +extern int is_submodule_initialized(const char *path);
> > +extern int is_submodule_checked_out(const char *path);
> 
> no need to put extern for function names. (no other functions in this
> header are extern. so local consistency maybe? I'd also claim that
> all other extern functions in headers ought to be declared without
> being extern)

From looking around at other sections of the code it seems like the
extern keyword is used for functions declared in header files. What's
the style guideline for the project say about this?

-- 
Brandon Williams
