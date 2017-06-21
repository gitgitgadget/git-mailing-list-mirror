Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD2D220401
	for <e@80x24.org>; Wed, 21 Jun 2017 17:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753247AbdFURet (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 13:34:49 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36173 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbdFURes (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 13:34:48 -0400
Received: by mail-pf0-f180.google.com with SMTP id q86so4053871pfl.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kR7cxoJ1kwlOzpId2p9myAq/5vv4jOC8Fr3nV9OT3HY=;
        b=FsYAWTCWx3wB0Kg21kBvbh9W/KYkrv6TpFqtKXi1rLVLH+BVGOErZ7UMCdgYosUFQ2
         hYdwcnOPkrmiRZxoMzgnEFFI/+nUuQ0fMxyh9A6/lwJERepdiMDSDpxyLpUNYdnf25Ji
         W+xTjbY4Y4QWdel5GQxZQgLUlBPBn1AcJzK+0dFhYeBS3vxMP4SnkHBhjUHHb1eBPT8c
         lfzfeTktWzKv2kue5s5vFWt2X0kPZ7eYgk8FeAxElJtMJV24THCj80uQyLMIqcG5kzhm
         k6sCQmFr5tXSlqOMgj86CsMW78YsysJOZguKzaOpqq+lY5RuYhntud4hHzRF+qQ7A+JI
         s1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kR7cxoJ1kwlOzpId2p9myAq/5vv4jOC8Fr3nV9OT3HY=;
        b=QLAbcx0KYx/4K011xidozeukQVy5vnnKER9QkP4k0g4uxCq7wH3T6CvG+to+pGNdeS
         vpAlfhSkppJp82NEE0bIK18kXE2yz1AGGd7VRLIZAJzES19E7ObUZSV8x2G/HOL8OK7j
         EPBLBXPl/veeUvdcMriZRhyzlwMA/vgOk4o35KfhFgxtzvyNYlZU3vJzbbaooxvrWEBD
         CaE7Me6H157t8/TPRWXf/aGPgP1lWzmXLR1R5KymCOvIA2b94gsRxFbL+7VWpOauSpXi
         XU+gRzfPDcZ/CDWnT4lEnaqDl4t41kjUTV4B0mzUXFPqmj4XhvMtwGb85vQt1h6i7Fe+
         bYSQ==
X-Gm-Message-State: AKS2vOxUJUrDVAmdgZLsf5Ym5xQf/yhf5Kivc2j9OFCIvbMC5Oa4lXpr
        3DF63AVF+L+22spW
X-Received: by 10.99.50.135 with SMTP id y129mr39149683pgy.238.1498066487285;
        Wed, 21 Jun 2017 10:34:47 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a12e:c584:e29b:1036])
        by smtp.gmail.com with ESMTPSA id 18sm11787639pfh.65.2017.06.21.10.34.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 10:34:46 -0700 (PDT)
Date:   Wed, 21 Jun 2017 10:34:42 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 2/8] sha1_file: rename LOOKUP_UNKNOWN_OBJECT
Message-ID: <20170621103442.3d21b9c4@twelve2.svl.corp.google.com>
In-Reply-To: <xmqqpodxqmqp.fsf@gitster.mtv.corp.google.com>
References: <cover.1497920092.git.jonathantanmy@google.com>
        <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1497920092.git.jonathantanmy@google.com>
        <93c459ee90fac0d040d262bef072188b7ea69af0.1497920092.git.jonathantanmy@google.com>
        <xmqqpodxqmqp.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 21 Jun 2017 10:22:38 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > The LOOKUP_UNKNOWN_OBJECT flag was introduced in commit 46f0344
> > ("sha1_file: support reading from a loose object of unknown type",
> > 2015-05-03) in order to support a feature in cat-file subsequently
> > introduced in commit 39e4ae3 ("cat-file: teach cat-file a
> > '--allow-unknown-type' option", 2015-05-03). Despite its name and
> > location in cache.h, this flag is used neither in
> > read_sha1_file_extended() nor in any of the lookup functions, but used
> > only in sha1_object_info_extended().
> >
> > Therefore rename this flag to OBJECT_INFO_ALLOW_UNKNOWN_TYPE, taking the
> > name of the cat-file flag that invokes this feature, and move it closer
> > to the declaration of sha1_object_info_extended(). Also add
> > documentation for this flag.
> 
> All of the above makes sense, but ...
> 
> > diff --git a/cache.h b/cache.h
> > index 4d92aae0e..e2ec45dfe 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -1207,7 +1207,6 @@ extern char *xdg_cache_home(const char *filename);
> >  
> >  /* object replacement */
> >  #define LOOKUP_REPLACE_OBJECT 1
> > -#define LOOKUP_UNKNOWN_OBJECT 2
> >  extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
> >  static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
> >  {
> > @@ -1866,6 +1865,8 @@ struct object_info {
> >   */
> >  #define OBJECT_INFO_INIT {NULL}
> >  
> > +/* Allow reading from a loose object file of unknown/bogus type */
> > +#define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
> 
> ... this contradicts the analysis given, doesn't it?
> 
> Does something break if we change this to 1 (perhaps because in some
> cases this bit reach read_sha1_file_extended())?  I doubt it, but
> leaving this to still define the bit to 2 makes readers wonder why.

The issue is that LOOKUP_REPLACE_OBJECT (which is 1) is also used by
sha1_object_info_extended(). So yes, it will break if
OBJECT_INFO_ALLOW_UNKNOWN_TYPE is changed to 1. I'm resolving this in
the next patch by also renaming LOOKUP_REPLACE_OBJECT and making it only
used by sha1_object_info_extended().

I'll add a comment in the commit message locally, and will resend it out
tomorrow (in case more comments come).
