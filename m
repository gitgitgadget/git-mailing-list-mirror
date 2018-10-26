Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13C41F453
	for <e@80x24.org>; Fri, 26 Oct 2018 07:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeJZQft (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 12:35:49 -0400
Received: from mout.gmx.net ([212.227.15.19]:40861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbeJZQft (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 12:35:49 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfEZG-1fvXnj21Yg-00Oqve; Fri, 26
 Oct 2018 09:59:41 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfEZG-1fvXnj21Yg-00Oqve; Fri, 26
 Oct 2018 09:59:41 +0200
Date:   Fri, 26 Oct 2018 09:59:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     gitster@pobox.com, christian.couder@gmail.com, git@vger.kernel.org,
        pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH v3 2/3] shallow: offer to prune only non-existing
 entries
In-Reply-To: <20181025185459.206127-1-jonathantanmy@google.com>
Message-ID: <nycvar.QRO.7.76.6.1810260956230.4546@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1810241756390.4546@tvgsbejvaqbjf.bet> <20181025185459.206127-1-jonathantanmy@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zWEre0TzZAlbfpJ/DmJ+im8/Qmt6gwXxdo+xQgk8OpLkgkAkRKq
 ymquZnRURtt5pNd1enDTkoTfFwZ1L2RcQ+wcaGTy54DeTNCJSze1QK+ty8jH5MxO/S4Btb4
 iDn8rA1trHFOzELh3eo/6NrWEVeNKHAAKhO1W0kFYKC7stRLRXqFGnFMuh+KibRQX0xDwqy
 Xj3hUoFDMvj22uL8NvYjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ov7pnHAFkJ0=:ZmWf+0OD9et0hqhdLXXg3v
 CeN2ix9upaDZ0Hgy2wYUnyl57w6t61NxYcOFzWooDceVq4wut9GJHaDss/8L2xcsEnyQHqRm+
 qmYstgp43CcyA4+iBzwcI+MHK6aAJNgVdHJRqMnp+/ckY0Ae9dxeXQ6i/HSsEXuET5POYxrzD
 c4FQEi2uezZL/t3RVjqYl3SK3RjJ6iQ+DN5X+QqdgM5rWoyI2RQPmsE2lpUj0G7IHl1TFNoNh
 SDqPxZIdKPmIhKGgpMldWlwD3zgqcq7tIIqHHgaoFAR+lJcnNJG5WUaWsDeZGfXFGXbTBfR7z
 ltfSN3r2qEHt6ZkKI2SLncyL3b69C0cBPdJr5MjQRDzEFOTOO5BmSt4RQfNHh+El6Z+96QAkH
 qNpvo7+QTz+BPl1DAHiESoWbmbJh0Fy2z+9Iibh2O9Z19QJo+HohP3q6xj0J2GheyBeX/hYtC
 gWPBATMdVfxnJA23gxTXCRc+Z0F8QT6LzRu1FS/xvYob3+PxNYZBk1EWtNsBf5ukP7y0/bUaw
 /DA+LsOmv20B0JIDqs5x1Wd034hEOa0ZKG7/nVjrlH3kql+/3UmQZvicLj2rWCkCnBSh/yev+
 K9tOEapqbHYrpCTuPaViB+J8oUBklJiri0rfvi7gkt0oUT7yrw0WGJzWIOcusv+JaQk/RtHWp
 FgF5eZV1leeXFjorQjEK01nf3a5hg8RiD0Nci3TM1066+gIwtSWk6cog4LTuwBJg5xmAcTKCF
 phwnPXLn6pxSGGQ+kzLbDOd0dmC8IDmU1UVPSNUf52/fqyCcvezC9G34LSpA2kijIj29psu+X
 V9BsI1+o9cjbI0zIu3ItpmGunITU+yYMwFSvMAVEYaZw5+ZMcY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Thu, 25 Oct 2018, Jonathan Tan wrote:

> > On Wed, 24 Oct 2018, Johannes Schindelin wrote:
> > 
> > Coming back to my question whether there is a better way to check for
> > the presence of a local commit, I figured that I can use
> > `has_object_file()` instead of looking up and parsing the commit, as
> > this code does not really need to verify that the shallow entry refers
> > to a commit, but only that it refers to a local object.
> 
> Note that has_object_file() also triggers the lazy fetch if needed, but
> I agree that it's better because you don't really need to parse the
> commit.

Thanks for confirming.

So even better would be to use `is_promisor_object(oid) ||
has_object_file(oid)`, right?

This is something that is probably not even needed: as I mentioned, the
shallow commits are *expected* to be local. It should not ever happen that
they are fetched.

> There is the possibility of just checking for loose objects (which does
> not trigger any lazy fetches), which works for builtin/prune since it
> only prunes loose objects, but doesn't work in the general case, I
> guess.

In the test case I added, the commit object is actually packed. And then,
because it became unreachable, it is dropped.

If I only checked for loose objects here, the shallow line would already
be removed when the commit gets packed, which would be the wrong thing to
do.

In short: thank you for confirming that the current version of the patch
seems to be the best we can do for now.

Ciao,
Dscho
