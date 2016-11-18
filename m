Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C14E41FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 22:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752668AbcKRW4Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 17:56:24 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35615 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752176AbcKRW4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 17:56:24 -0500
Received: by mail-pg0-f46.google.com with SMTP id p66so107310403pga.2
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 14:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GLhde21I4l6Qjq/avdMy/qWlL0WRruCNrFu3rOZzmRI=;
        b=mcwcPA9g0IvMf4cUsoZSLPuKKYxv0Ht+otBs680eOoxV8GRKIcSvnd2yZaCvjAHeti
         5ed4a624KPQO2mqcXM1bo5XCAbPPVPQGJbtgq9l8caZL4RLm+bpVnpjsYTTYbVcv4cGz
         SuiUJWyHp9H/A7Bzkvw0w7MyDsrv56O7JVII6sWrj2fib9ktBek6t2NCBliaTboadGTy
         I8Q+r4k7RS+EKybXxWUt+XZ+Pn14+sXoLo2ouJO2mkDAPf5Swsr5b7IcGx+LQTRLxiaZ
         bZehxNQA0iP+ZY3XrDZgsa9jSEuKEzKSvKwckZp93r58Bv7LHJtI1y8D0EvGitq6CP1y
         W+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GLhde21I4l6Qjq/avdMy/qWlL0WRruCNrFu3rOZzmRI=;
        b=EGJYic/0kYclx8VMv1K7nbV8IAmcIxlvVK2yEeT+GI0ORb7CIvIpqVnXb1TiVmYEn+
         wv49ymgHxfme9lj1cuRRZeZilFx+DEkAqkcFq7UzZdKwO+iX7joOym3KhIVK4CvDemvF
         cReJ0xwP/LDn8fZNsh00PFztkThib8qCjmLF2P3HTuHAQQz46nihGDrgEUCj2sVklHzb
         eza6qRxH3I8dClA8XZyPLSjWeE7cQvhwBNV97MA6JT/I7QAup5jfzRgEWc00sRA0LEEz
         Tj4i4aj4tCNvnNWlFEIljZZUPQECCaARBzI9XjvLizZHXr98j5Diopwio61ijUgFPbGA
         yMJw==
X-Gm-Message-State: AKaTC02GOqxvcWEdhMhlgvl547cuX2aZHGeGyGn6G+id9T6UQbL8gGsaitwv4FGbGGYOk0pG
X-Received: by 10.99.166.2 with SMTP id t2mr4259052pge.149.1479509783304;
        Fri, 18 Nov 2016 14:56:23 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:dc40:d740:d9f4:37a3])
        by smtp.gmail.com with ESMTPSA id c8sm20305597pfe.15.2016.11.18.14.56.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 18 Nov 2016 14:56:22 -0800 (PST)
Date:   Fri, 18 Nov 2016 14:56:21 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 3/6] grep: add submodules as a grep source type
Message-ID: <20161118225621.GB76630@google.com>
References: <1478908273-190166-1-git-send-email-bmwill@google.com>
 <1479499135-64269-1-git-send-email-bmwill@google.com>
 <1479499135-64269-4-git-send-email-bmwill@google.com>
 <xmqq60nkmpud.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq60nkmpud.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/18, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > diff --git a/grep.h b/grep.h
> > index 5856a23..267534c 100644
> > --- a/grep.h
> > +++ b/grep.h
> > @@ -161,6 +161,7 @@ struct grep_source {
> >  		GREP_SOURCE_SHA1,
> >  		GREP_SOURCE_FILE,
> >  		GREP_SOURCE_BUF,
> > +		GREP_SOURCE_SUBMODULE,
> >  	} type;
> >  	void *identifier;
> 
> Hmph, interesting.  We have avoided ending enum definition with a
> comma, because it is only valid in more recent C than what we aim to
> support.  This patch is not introducing a new problem, but just
> doing the same thing that would have broken older compilers as the
> existing code.  Perhaps those older compilers have died out?

Perhaps it is time to move to a new C standard! :P

-- 
Brandon Williams
