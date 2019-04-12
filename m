Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2521E20248
	for <e@80x24.org>; Fri, 12 Apr 2019 00:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDLARg (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 20:17:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52637 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDLARg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 20:17:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id a184so8925607wma.2
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 17:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=czEaVmjnep21cftf+WdWsC1MNNiFovnSMV0ll8v2OcI=;
        b=CUVoH3FaF47zIr72XkTjIj199ZX9W/i4w6+gJg0QPyVBj3ybjPxkRHmzskkqlzwv1d
         4DKPZB6kpd8+iahwIxDUferzOScbL7FXZutuPv9GxND80o+FyaMQQuXbKJMROLsutCLX
         DOAWpLuAODfhLkAXbMEAmgXNsFqHr99AJUv7dIy8luleYEKXyGH7XKmZCwgGpOl5IOv/
         YRvLO+dFB75t/912tgkzu4ttqrG2d/6swLHsos3U0guVpMaKkF7FVyKBi3vBSXAfWZWW
         ZQvfCodkM3wMGv4D4yMG0MKo2gdsLt4KAdw6YBLs8TelbEtwT3QGgCGAt0lINr5KfXPM
         P5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=czEaVmjnep21cftf+WdWsC1MNNiFovnSMV0ll8v2OcI=;
        b=IDsL1Eiwl7JWp0c7ApjQ9/Iugc56rpnoXv2ZVQnratXRcq15lvKuPhux1HvpxlnC3U
         8kGhWJRVJ/ZfFZ3u0AhagQ1OwhpnkrZd0bWFBoPs9VAwB9KXbTmSxqJq8i8h+NF/W5O7
         72a6IMyK/OMfxdYCAlEiGRJMX9fEza7BxgDrozRVDzQX2lghWbTHUNYONIUVlzzT0ggA
         sIFEop+91Ue5w1SmRf4IPfhgPiWwAUkijITOCM3We2sSjPfzVS1uI3SzeDWBsh5hO3Ik
         7T5+3JepUQSWhLjmoLW1BTO7J4ikVJiYd42mbaxHwxEPM2unfP5Kj3iXV5GPHTBGga8a
         ck9w==
X-Gm-Message-State: APjAAAVDtAZHfSA3fIBbbulV2d7Ao0heh4Y+KVNlGMef8G9KFW508esz
        BrbFwWTRUjNE/LTTp8bDuuE=
X-Google-Smtp-Source: APXvYqymfVR5pD0VWH6vdkZ5jYcsWwVXll0obQAOAf4yi8tmPedz5wXa0fmbQ9+ErcVKiVWcixH0JQ==
X-Received: by 2002:a1c:c00b:: with SMTP id q11mr8904247wmf.38.1555028254273;
        Thu, 11 Apr 2019 17:17:34 -0700 (PDT)
Received: from szeder.dev (x4d0c7202.dyn.telefonica.de. [77.12.114.2])
        by smtp.gmail.com with ESMTPSA id n11sm65016568wrt.63.2019.04.11.17.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 17:17:33 -0700 (PDT)
Date:   Fri, 12 Apr 2019 02:17:30 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 00/33] nd/sha1-name-c-wo-the-repository updates
Message-ID: <20190412001730.GM8796@szeder.dev>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
 <nycvar.QRO.7.76.6.1904102254500.41@tvgsbejvaqbjf.bet>
 <20190411205146.GK8796@szeder.dev>
 <20190411205857.GL8796@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190411205857.GL8796@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 11, 2019 at 10:58:57PM +0200, SZEDER Gábor wrote:
> On Thu, Apr 11, 2019 at 10:51:46PM +0200, SZEDER Gábor wrote:
> > On Wed, Apr 10, 2019 at 10:56:52PM +0200, Johannes Schindelin wrote:
> > > >         ...>}
> > > >
> > > >       @@
> > > >     + expression c;
> > > >     ++expression r;
> > > >     + expression s;
> > > >     + @@
> > > >     +-- get_commit_tree(c) = s
> > > >     ++- repo_get_commit_tree(r, c) = s
> > > >     + + c->maybe_tree = s
> > > 
> > > I think this is wrong, and admittedly I had the very same version
> > > originally.
> > > 
> > > When you have an arbitrary `r` in any `repo_get_commit_tree(r, c)` (as
> > > opposed to `the_repository`), the conversion to `c->maybe_tree` is most
> > > likely incorrect.
> > > 
> > > Therefore, I don't think that we can do that.
> > 
> > So, as far as I understand, the goal of these 'c->maybe_tree'-related
> > semantic patches is to prevent "generic" parts of Git from accessing
> > this field directly, as it might not be initialized in a
> > commit-graph-enabled repository.
> > 
> > Only three functions are explicitly exempt, while this last semantic
> > patch in question implicitly allows a few more that assign a value to
> > 'c->maybe_tree'.  These functions are release_commit_memory() and
> > parse_commit_buffer() in 'commit.c' and fill_commit_in_graph() in
> > 'commit-graph.c', 

... and make_virtual_commit() in 'merge-recursive.c'.

> and after a quick look these functions seem to be
> > rather fundamenal in the life-cycle of a commit object.
> 
> Erm, not "commit object"; I meant the life-cycle of a 'struct commit'
> instance.
> 
> > I think they deserve to be explicitly exempted, too, and then we could
> > remove this last semantic patch altogether.

And it would look like this.  Yeah, that's a very long line there, but
I don't think we can break it up.

  -- >8 --

diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.cocci
index 57c8f71479..fe814f313e 100644
--- a/contrib/coccinelle/commit.cocci
+++ b/contrib/coccinelle/commit.cocci
@@ -10,20 +10,15 @@ expression c;
 - c->maybe_tree->object.oid.hash
 + get_commit_tree_oid(c)->hash
 
-// These excluded functions must access c->maybe_tree direcly.
+// These excluded functions must access/modify c->maybe_tree direcly.
+// Note that if c->maybe_tree is written somewhere outside of these
+// functions, then the recommended transformation will be bogus with
+// repo_get_commit_tree() on the LHS.
 @@
-identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit)$";
-expression c;
+identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit|fill_commit_in_graph|parse_commit_buffer|release_commit_memory|make_virtual_commit)$";
+struct commit *c;
 @@
   f(...) {<...
 - c->maybe_tree
 + repo_get_commit_tree(the_repository, c)
   ...>}
-
-@@
-expression c;
-expression r;
-expression s;
-@@
-- repo_get_commit_tree(r, c) = s
-+ c->maybe_tree = s
