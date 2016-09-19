Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55E052070F
	for <e@80x24.org>; Mon, 19 Sep 2016 23:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbcISXoq (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 19:44:46 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35612 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752758AbcISXop (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 19:44:45 -0400
Received: by mail-yw0-f194.google.com with SMTP id u82so48667ywc.2
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 16:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qX3tw26uYVd1nVegbKFDX1AjCh2o4YndHoO1H+n9uE0=;
        b=1BlmPBtbledMDCVmGJjavTbBnOGDDcyyrgguQX64tD5R4IIYcqj6SO0V0YVCXtIbWF
         16y26bR3B/55tkws4wF/64fcKEEuQ9tEVMbFqZVaEaKvmBa9sR6oWM4isUlmDvXo1NVR
         xdFXz7Bgp8Qyxg9czMuzE7/stD6auOzjXiJ6RZT6gyFc3uFNr+8CFU7+jucQf6Bd9mwV
         l47GJd4qa9MLzz/gKjChu/vILu45k9LJpOPt2RcNrldWXYUkW+sKqrZ7Q4xYRJNm9ZvF
         EE2sR34NdcpwLjfWtVKj9suj/8y5LlsOQLFwbk83THXXgtXqPg6FsyJpXEnxDAKCHt78
         Z5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qX3tw26uYVd1nVegbKFDX1AjCh2o4YndHoO1H+n9uE0=;
        b=kTndhcd2WK/RGt3eTWhfRKW5oAkrobhKMlvEfHAQbN1Vt580u7YtQgEqf/lr148m5V
         zKei8uK0ODI9sjZQa2c+tW1GZBJQpH1PDmIUlGO6bSkfyCdxiVdfkLphv964Wr9zPZTj
         aji/05BDbSjI1Sgy+zRTVPq0Jhds04ebwWywJcpjPQVK55pMgFlLalKYi2GsBuNzAdNs
         M2vS+vebmWtZ/h3AR9pNymxsBRYF5EdFr5GQwIuryQmnGlrTph4Hm2+t1zOKxjHTdQJf
         lkuQn6xk2LUGhVhN66cDkdgbd2B3/xDYZOSxUXnAu0LrZH8h444dAuAvKnNeLWv/xKXi
         JpZQ==
X-Gm-Message-State: AE9vXwM8Ql5U4HgigTivPTHJ2iGNzzKlT3trnSDakGaCleWDXPTGfpV2xCCwg8o5jLA3cOSxHQcKuGJopBZAXg==
X-Received: by 10.129.78.18 with SMTP id c18mr28118920ywb.160.1474328684459;
 Mon, 19 Sep 2016 16:44:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 19 Sep 2016 16:44:24 -0700 (PDT)
In-Reply-To: <20160919233434.fhkikksi4cxzrzb5@sigill.intra.peff.net>
References: <b5bf39015fdd20dd0aa4f38eb365bbbd0d07a4ca.1474096535.git-series.josh@joshtriplett.org>
 <3df15bbb-7eac-86ec-2ccb-74a973482e8c@au1.ibm.com> <xmqqa8f3g4pu.fsf@gitster.mtv.corp.google.com>
 <20160919204408.GA28962@cloud> <20160919233434.fhkikksi4cxzrzb5@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 19 Sep 2016 16:44:24 -0700
Message-ID: <CA+P7+xoGNEYbMKom5yqVDfMcyb1nJyP5nrQoRbWjGkPffyM+AQ@mail.gmail.com>
Subject: Re: [PATCH v2] format-patch: Add --rfc for the common case of [RFC PATCH]
To:     Jeff King <peff@peff.net>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Junio C Hamano <gitster@pobox.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 4:34 PM, Jeff King <peff@peff.net> wrote:
>   - there are a non-trivial number of patches for other projects (JGIT,
>     EGIT, StGit, etc). This is somewhat unique to git, where we discuss
>     a lot of related projects on the list. But I wonder if other
>     projects would use subsystems in a similar way (though I guess for
>     the kernel, there are separate subsystems lists, so the "to" or "cc"
>     header becomes the more interesting tag).

Working in the net-next community, we often use "[net PATCH]",
"[net-next] [PATCH]", or even just replace "PATCH" with "[net-next]"
and similar (though this is served just fine by --subject-prefix, and
may be an artifact caused because -P doesn't exist).

For the netdev, there are both "net" and "net-next" trees, and so
there is some need to distinguish between these. I prefer "[net
PATCH]" style myself.

I think --rfc is common enough to warrant its own tag, even if we add
"-P tag" just because it encourages its use for whenever you want to
comment about a patch without necessarily wanting it immediately
applied.

I also happen to prefer "RFC PATCH" instead of "PATCH/RFC" but I think
that's mostly preference.

>
> So I dunno what all this means. I do think "--rfc" to standardize on
> _some_ form of "RFC PATCH" or "PATCH/RFC" would serve the most people,
> and would make things more consistent. But at least in Git, people would
> be served by having arbitrary prefixes, too.
>

A general way to do this would be helpful, but i don't think it avoids
the usefulness of --rfc on its own.

I know that some formats are also generated by tools such as stgit
which has its own way to generate emails and doesn't use exactly the
same format as git.

Thanks,
Jake
