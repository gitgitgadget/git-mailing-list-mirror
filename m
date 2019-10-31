Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63EAA1F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 16:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfJaQ4h (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 12:56:37 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:43275 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfJaQ4h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 12:56:37 -0400
Received: by mail-wr1-f54.google.com with SMTP id n1so7043811wra.10
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jPFXgEZOWQPa6Fb0jVYuCFyMgAIb4aofH2F+Z63QlJk=;
        b=ehWMrsnh0Dndj8xtEg/OU4R6slh04fuey6B70csc1xyIzvZySL50Sw5YCBfS8Gp9Vl
         PHrFGonAvW9hupIfA/asv2ks82tx7qWw7ZCQR5O6fUe53WXWlw2PBvesbZDSekfoU6OO
         8f4eIfzQmJsmD40gxmEp8e3Mn8uI0vjwzlhyUx1Im23kYLbEMq3e+Hll9IMNzpKwIW/g
         4sLgj97+gm/YWy497VIpBTTc24SUktyeu+iO+xqzAVc739CF1zwmZkJ5emgxAYVLRW1s
         I+OMYIaSVl37dSECvJEqTeMdO/OBVBBfp3L3UeZu+gXlDnHgfHD+b2c4WslCj0qUOHAQ
         C6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jPFXgEZOWQPa6Fb0jVYuCFyMgAIb4aofH2F+Z63QlJk=;
        b=SnjvjKKc2F0FElfXqZduZydcfGIf62PHGvYUZBjd/biJgfZ+PZBo72Vq24WudH3aXr
         vDsfbfLOiSrE4z+cfmjN/2ZVRUE3CHj7/ONlVGE6JOTJB+32sos93KzWrNFEsKFA4edW
         31VOzIk0GhFyvU2OKHRSOlnGjeWoFnS6iGhdGQT/lhpsVbZL3KxMBzTfLDIEuys+I5Fa
         ytAtI0m30lfHpNfAKeLEW1QENYnam94KmGcqx7Dw0DM7SZ+Ng46yAXZHLsIlq2/B8060
         pgfkvTQWwoly64xxzSansfiwImda5ylsihLQpTLEGCruNlhGNuHImH4DTFU1MIOgTLPX
         s66Q==
X-Gm-Message-State: APjAAAXa025oqgGBcWhQWlIWy17yuOqjo5qsZpuZ1Po+GR6gP6LdqIi9
        SKhdBhxOHi4kn7j6Hg7owo3aswxT
X-Google-Smtp-Source: APXvYqy/nvyM99JxDQCgT0opG1mdu9fxkT6h+eWg56GTDqMyOBFiSe8+jb1N2I/UikCUVLdQlZ26WQ==
X-Received: by 2002:adf:f192:: with SMTP id h18mr6983734wro.148.1572540995663;
        Thu, 31 Oct 2019 09:56:35 -0700 (PDT)
Received: from szeder.dev (x4dbe1c44.dyn.telefonica.de. [77.190.28.68])
        by smtp.gmail.com with ESMTPSA id a23sm4042578wmj.2.2019.10.31.09.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 09:56:34 -0700 (PDT)
Date:   Thu, 31 Oct 2019 17:56:32 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     git@vger.kernel.org
Subject: Re: git fsck, badDate: invalid author/committer line - bad date
Message-ID: <20191031165632.GA4348@szeder.dev>
References: <20191031092749.074ed112.olaf@aepfle.de>
 <20191031101539.GY4348@szeder.dev>
 <20191031142118.747693c1.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191031142118.747693c1.olaf@aepfle.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 31, 2019 at 02:21:18PM +0100, Olaf Hering wrote:
> Am Thu, 31 Oct 2019 11:15:39 +0100
> schrieb SZEDER Gábor <szeder.dev@gmail.com>:
> 
> > However, I don't know how to tell about the skiplist file to GitHub,
> > or any other Git hosting service for that matter.
> 
> Thanks for all the details.
> 
> Is there a way to "replay" a git repository, so that all the commit contents
> and author/committer data are preserved? I think it is more important to have
> a clean repository than to preserve irrelevant commit hashes.

Those commits can be fixed by simply transforming the fast-export
stream, e.g.:

  $ git init new
  $ git -C virt-top/ fast-export --all |
    sed -e '/^\(author\|committer\) Richard W\.M\. Jones <rjones@redhat.com> </ s/<"Richard W\.M\. Jones <rjones@redhat.com>"> //' |
    git -C new fast-import

BUT!

All the usual warnings about rewriting already published history
apply.  The hash of a couple of commits from 2009 might seem
irrelevant now, a decade later, but after correcting those author and
committer lines the hashes of all subsequent commits will inherently
change as well.  This is, in general, upsetting for everyone who have
cloned the repo and built their own work on top.  Furthermore, some
commit messages refer to older commits by their hash (e.g. in
431dbd98ba: "Simplifies and updates commit
dbef8dd3bf00417e75a12c851b053e49c9e1a79e"); those references will go
stale after rewriting history, unless you put in extra work to update
them.

I would advise against rewriting history.

