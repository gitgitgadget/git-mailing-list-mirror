Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A53B1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 00:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932649AbeCNAHq (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 20:07:46 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:38390 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932511AbeCNAHp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 20:07:45 -0400
Received: by mail-pl0-f42.google.com with SMTP id m22-v6so759583pls.5
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 17:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ahLGeiZoBSqD/34MlrGGNmxnP54uQC8HBgpiFl1uAOk=;
        b=P9WJQ25svGN1CPesBonCdoWThQmojQmx1N1tqhzGlqTquu8eDB1WDl3oT8GciCOZJF
         sbrUL5x75necIpQaL49FN3bwx5rtVs1D3Wb58ZnP7RN6Il9Mf5fWzlQsUrAfnFbAt+1N
         QGJdvL0HywueQu1TPm4MSoiu5SgkwumYF+KR8ddq9kQPiCvXOdwDH1BTZeG3hkCkRTR5
         qzklmwTq0bnQWGn1U5G9beOnwu0DRIZCZ+J/CHD2hsClug7tJd0TAR3LsMnFATGDswLd
         uocDEVd6f/uvOSu6umoDvP13dTY6wZRVJjg/gGqtwNLEFH9t2zhwJvRNwkPitXrXyWuY
         3iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ahLGeiZoBSqD/34MlrGGNmxnP54uQC8HBgpiFl1uAOk=;
        b=sWVvuV1K5KvDOpByJGSW5jlMAz6nMteGZTYQcgiETba8pdFCphW38v0XyCktf6q4/k
         fI0u+P99yqzHxY2uoxPPav6XZZpKdhLMJXf+K2D4lhdQESWKJbU5rQMS6HPI8VlXC1wp
         GlImC+OOyAlpjFnI3Iw3X3SeJN3dGojv/Fvso/Kur7tMeBU7YUPaGrD2jfZoxBk5Hoi+
         hz3RBhH6+wDuQxyFSsPJeBvJxLggk5SybHo0qRTlcxzlje50WQUUhc24d5Ih6HR+Dhbr
         2PTVhkhp2cCw8nDKQWr9g9mS98AeoqSxPPLIvuHgLk+xeHOP+o6CQPGTWs4f6OcMPTR6
         bwjg==
X-Gm-Message-State: AElRT7FOuduv70ajlfnmuZdoL+y65HY1S3s4J1EDB38Nj3vI4MyTRhTO
        aKR0fbB7o8PJAGpTFN7uBYk=
X-Google-Smtp-Source: AG47ELt7X6qMKRavL3a3NjxDdrYpGEaAEDZenuPMoP3JVAhN/dnaokmVmn6urG9Cb22b+UG8JRxeOg==
X-Received: by 2002:a17:902:c1:: with SMTP id a59-v6mr2161372pla.284.1520986064991;
        Tue, 13 Mar 2018 17:07:44 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n76sm2168942pfi.93.2018.03.13.17.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 17:07:44 -0700 (PDT)
Date:   Tue, 13 Mar 2018 17:07:43 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Michal Novotny <clime@redhat.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: allow "~" to be present in a tag name
Message-ID: <20180314000742.GD147135@aiede.svl.corp.google.com>
References: <CANT8FXTF41-4zvqvrEek262D8OZRhA4nsiPguyNTL9mwF1+mkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANT8FXTF41-4zvqvrEek262D8OZRhA4nsiPguyNTL9mwF1+mkg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michal,

Michal Novotny wrote:

> currently, if I try to create a tag that has tilde "~"  in name, an
> error is raised. E.g.
>
> $ git tag rpkg-util-1.4~rc1
> fatal: 'rpkg-util-1.4~rc1' is not a valid tag name.

As Ævar mentioned, this is disallowed to prevent a collision with
Git's revision specifying syntax.

While I'm sympathetic to wanting the tag name to match the version
number used by the package manager, the line has to be drawn
somewhere.  "git help check-ref-format" describes the current
namespace:

	Git imposes the following rules on how references are named:

	1. They can include slash / for hierarchical (directory)
	   grouping, but no slash-separated component can begin with a
	   dot . or end with the sequence .lock.

	2. They must contain at least one /. This enforces the
	   presence of a category like heads/, tags/ etc. but the
	   actual names are not restricted. If the --allow-onelevel
	   option is used, this rule is waived.

	3. They cannot have two consecutive dots .. anywhere.

	4. They cannot have ASCII control characters (i.e. bytes whose
	   values are lower than \040, or \177 DEL), space, tilde ~,
	   caret ^, or colon : anywhere.

	5. They cannot have question-mark ?, asterisk *, or open
	   bracket [ anywhere. See the --refspec-pattern option below
	   for an exception to this rule.

	6. They cannot begin or end with a slash / or contain multiple
	   consecutive slashes (see the --normalize option below for
	   an exception to this rule)

	7. They cannot end with a dot ..

	8. They cannot contain a sequence @{.

	9. They cannot be the single character @.

       10. They cannot contain a \.

If anything, I suspect the current namespace is too wide.  For
example, it has issues with Unicode normalization in filenames on some
platforms, and it allows some potentially problematic characters like
` and |.

So my first instinct is to recommend that you apply some mapping
between your packager manager's version syntax and Git's tag syntax
--- e.g. using -rc1 as Ævar suggested, or using urlencoding %7Erc1 as
you hinted.

That isn't to say that this would be impossible to loosen.  But my
worry is that it's hard to decide where to draw the line: there are a
number of sets of names that might want to be valid tags, and it is
hard to say which are worth the complexity of expanding the set of
valid ref names.  That's why my first reaction is to look around for
another way to accomplish your goal.

Thanks,
Jonathan
