Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E5BE20705
	for <e@80x24.org>; Mon,  5 Sep 2016 21:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933270AbcIEVrR (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 17:47:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34046 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932217AbcIEVrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 17:47:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id w12so5969834wmf.1
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 14:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DuyoWbMBGFP92P/P8tj/l9MTmeKowK0pNxiuKU3/8ug=;
        b=0KAyilLNhg3TXGTJ9BD1c6PJOi2yJ+uz+Q5JRYC4vzgSg2FIHucOPvHrmlsUy+dyqp
         0OCp+9Xe/YZP4dfwEg2sf5HoBs5p7dJlDMKOk18a9L35Mbf/oNUOZ1l1ObzI8l1VzobC
         p0ILwo4QgKC3JeCG+lHfAjha+u98f6S/vPm9bBJGzHEMeFmMAce9ibmZLVtLqjNDOOtB
         EJwc3VFHyVTQieEUfRWAEAfsIOpPL4QIEfx9yJNAeXhzFAyfBr2IzUbx+7uAgMv9OsBZ
         4KGiI5x9hYdnMTtJSCYj8SmLKkNj77ZB7xtEQGdq3KLmY3VtZOodxsJW6JlYB8+om0RP
         tkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DuyoWbMBGFP92P/P8tj/l9MTmeKowK0pNxiuKU3/8ug=;
        b=m7ev5rXC0aCUuM+1ytaIWB6yKdoC4zHHjG84u1KUT6IqZ12j5Q44MKa12lw6hzGld2
         yPE7kBmsVx3YizhjxtID2E9mWj8Lz/biCPGRDXi1O8QoUMlgmJkpU3gXYBsbFrUIiFy+
         ehuH+E1Fj/ozrk8MOK5Ni/AjcckWk3nqXxDAgU+Aup11RxcT9P0OPJrlUGsSWaE+g31u
         myEQT1Mw3wx+WAyYRamw83cdTQtZsZtq7qiMFq+IijELSKywZl3fYmrcFCZ2xQdPF+Pb
         SmZp3uIe3d3rt7SNHjb5MsmR4jVVeJL7hGi6Av+fvMx7+5KuynkBR94S1sxDN/g48fZz
         N4PQ==
X-Gm-Message-State: AE9vXwP7uD/ravgAnHqRKP0YQUatd2/a4V+B6sLhGbKpZa0BvXgh6A9MWgGjL7z48OC/kw9RE2A9cT1fuMhk+g==
X-Received: by 10.28.212.211 with SMTP id l202mr17974464wmg.109.1473112035510;
 Mon, 05 Sep 2016 14:47:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.185.67 with HTTP; Mon, 5 Sep 2016 14:46:34 -0700 (PDT)
In-Reply-To: <20160904015209.ba6arov46ntr2ouq@sigill.intra.peff.net>
References: <1472944878.19860.4.camel@gmail.com> <20160904015209.ba6arov46ntr2ouq@sigill.intra.peff.net>
From:   =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Date:   Mon, 5 Sep 2016 23:46:34 +0200
Message-ID: <CAFaJEqu-JUcwLjrQBk_huSa3DZfCf8O4eAZ=UgcXHzN=CLgtpw@mail.gmail.com>
Subject: Re: [PATCH] stash: allow ref of a stash by index
To:     Jeff King <peff@peff.net>
Cc:     Aaron M Watson <watsona4@gmail.com>, Git <git@vger.kernel.org>,
        Jon Seymour <jon.seymour@gmail.com>,
        David Caldwell <david@porkrind.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, guys

I like this idea. It makes stash easier and quicker to use, and it
"hides" the fact that it uses the reflog for keeping track of the made
stashes. *Not* to say I discourage interested people from peeking under
the hood. I just think it's nice to sometimes think of the stash as a
separate concept instead of being built on top of strange merge
commits constructed in temporary indexes :)

The bash-specific code is a no-go, so here's a way to do it in a way
that I think is in line with Git's code style for shell scripts. I took
the liberty of removing the '|| exit 1' since the rev is verified later
on anyway, as can be seen in the last piece of context. That way the
argument munging can be done at a later stage where we don't have to
loop over multiple ones. The first rev-parse's purpose is just to apply
--sq.

(Besides, the only way to do it at the top like in the original patch
was   for arg in bleh "$@"   where bleh is a marker to indicate that the
positional arguments should be cleared in a separate case branch so that
they can be rebuilt with multiple invocations of set later. Not pretty,
in my opinion.)

Regards,
=C3=98sse

diff --git a/git-stash.sh b/git-stash.sh
index 826af18..b026288 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -384,7 +384,7 @@ parse_flags_and_rev()
     i_tree=3D
     u_tree=3D

-    REV=3D$(git rev-parse --no-flags --symbolic --sq "$@") || exit 1
+    REV=3D$(git rev-parse --no-flags --symbolic --sq "$@" 2>/dev/null)

     FLAGS=3D
     for opt
@@ -422,6 +422,15 @@ parse_flags_and_rev()
         ;;
     esac

+    case "$1" in
+        *[!0-9]*)
+            :
+        ;;
+        *)
+            set -- "${ref_stash}@{$1}"
+        ;;
+    esac
+
     REV=3D$(git rev-parse --symbolic --verify --quiet "$1") || {
         reference=3D"$1"
         die "$(eval_gettext "\$reference is not a valid reference")"
