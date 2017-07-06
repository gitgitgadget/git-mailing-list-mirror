Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70A39202AE
	for <e@80x24.org>; Thu,  6 Jul 2017 03:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbdGFDgD (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 23:36:03 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34626 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752315AbdGFDgC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 23:36:02 -0400
Received: by mail-pf0-f176.google.com with SMTP id q85so4370013pfq.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 20:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ad20J+UEPG8Eu+9lLpQpVCACqHjcNFwfByZ1OHAL8/Q=;
        b=OYXsM3Bjgi6yKonexYuh0ZQOJeezeyMe/3kMNBl7AwsHiCO4trhalzxfr5IRHnHzRT
         c06wrKFKhTBgWp1Rix6gFyljzbUhE0qY+Q4PCI+SF6ofma13aDZ1rsZyr7N7MiIbfFEV
         yYLfJ89M6nGnWYbneEqpXw/0tWNJVVigSmH89tPj2cw3gZWjr7I1GtLMsqx9xbBSYS5s
         a1WJvmYn8JCzM7wkSr8EBFm78BhB80NozllYKwqD7Xp1lBI4d8E0/l6172zox2qViOPP
         MifdQ6Qbw8iGYlC0HqKQRXDJB7Na8SGmOzdJ45L3/oWEBKclhEgrAoiluRcTLIQWqdRD
         QJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ad20J+UEPG8Eu+9lLpQpVCACqHjcNFwfByZ1OHAL8/Q=;
        b=bz8711+4WAKxJcSj/gc7KpkGEaWSfsplBh4/Co0pQfYAprN8QBGm1zLIH1R3sf3OWO
         VOW5szHw9vPYAdpDKR7MxYNA4sxHVP99QrS3L7O329mTYTmsgmu1pa4QRzXTDGGxrdvS
         K4O+QzlG0a6AjGYv4XJBtwpq2qi0n7WM59OUFCIOrG8juNSfnESOUtAt/cIhpQ2cFoKF
         mXFf/6OxGvrwFwuaXHTrZWS7UoKxcCsdjlvkxH7P8Cq9hR5XZlrjPiY0fTZGi/S9m10p
         OkprYFcVb3CFTMT4CX2mUvxpjvamTVdl0U+/KA2dyko2CUVIEcRR7z29Z5RqxCsyi1O2
         XObg==
X-Gm-Message-State: AIVw113Z0afDh4IQXUSYjeIM3GrM6Hl4gPuPovitG0h0iH/va7RGvIK2
        qkaY1fFnKGQvxw==
X-Received: by 10.99.157.131 with SMTP id i125mr23770802pgd.130.1499312161997;
        Wed, 05 Jul 2017 20:36:01 -0700 (PDT)
Received: from lenny.localdomain ([136.24.158.154])
        by smtp.gmail.com with ESMTPSA id 10sm994000pfj.61.2017.07.05.20.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jul 2017 20:36:01 -0700 (PDT)
Date:   Wed, 5 Jul 2017 20:35:54 -0700
From:   Kenneth Hsu <kennethhsu@gmail.com>
To:     Konstantin Khomoutov <kostix+git@007spb.ru>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git ML <git@vger.kernel.org>
Subject: Re: Should "head" also work for "HEAD" on case-insensitive FS?
Message-ID: <20170706033554.GA9195@lenny.localdomain>
References: <87ziclb2pa.fsf@gmail.com>
 <20170704071909.phs4bf5ybdord2lv@tigra>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170704071909.phs4bf5ybdord2lv@tigra>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 04, 2017 at 10:19:09AM +0300, Konstantin Khomoutov wrote:
> On Tue, Jul 04, 2017 at 12:00:49AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> > I don't have a OSX box, but was helping a co-worker over Jabber the
> > other day, and he pasted something like:
> > 
> >     $ git merge-base github/master head
> > 
> > Which didn't work for me, and I thought he had a local "head" branch
> > until realizing that of course we were just resolving HEAD on the FS.
> > 
> > Has this come up before? I think it makes sense to warn/error about
> > these magic /HEAD/ revisions if they're not upper-case.
> > 
> > This is likely unintentional and purely some emergent effect of how it's
> > implemented, and leads to unportable git invocations.
> 
> JFTR this is one common case of confusion on Windows as well.
> To the point that I saw people purposedly using "head" on StackOverflow
> questions.  That is, they appear to think (for some reason) that
> branches in Git have case-insensitive names and prefer to spell "head"
> since it (supposedly) easier to type.

The use of "head" also appears to be leading to some strange behavior
when resolving refs on Windows.  See the following issue in the
git-for-windows project:

https://github.com/git-for-windows/git/issues/1225

In summary, it seems that head and HEAD can resolve to different
revisions when in a worktree.
