Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D6882018B
	for <e@80x24.org>; Mon, 18 Jul 2016 21:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbcGRV0g (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 17:26:36 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36418 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbcGRV03 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 17:26:29 -0400
Received: by mail-pa0-f53.google.com with SMTP id pp5so54339818pac.3
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 14:26:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T7beTRhQUrnJsA3FlHJbm3lsaWIft5uD3BM/ZtPNBeQ=;
        b=WPKa8GJvOnkLfsH+I1qfXo2o/8fVOIIsYT/DIKkegRLxBpg5xngLt0IU+7c5ZBkYT6
         LpLeRWchZd8B7stECyqYHUSlYa5xXW+lU9yMV8eyZRPaYr/3OJYGAB7+Gb8t4bBFU70f
         HMyilYEJXtJhnrk23C2nPbxwkyex0ih1tW4Eonw0WRLSBHihtbB+VT8H0R6939huhPsX
         P6Bq1x3WS+4YsG6Q7UZ93nWOxrnp4IZ5V5nqCKl7vB0STVBC9hmH/DI7KwsM8Cdyn7Qc
         bBB5eVLwVKDtpje1IG7OjL3J7oNeGAfc4x2tCw0i7+SAsf5wEG1FiliUH8AECTkSkKjV
         LNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T7beTRhQUrnJsA3FlHJbm3lsaWIft5uD3BM/ZtPNBeQ=;
        b=PqkaSU0QTO9mfP74aXJrXa55hVaINBIFy1rc8suVg/ewDdEY/DgJfPHUhbVuBRU/ZW
         c92fbSQfHR7wAuuoGO66EX0eZM3qk/zV9rKyPi3pNeoKeWIKFSFxHbxhWn+gA5Zm40Am
         bn8162rhorSd6IjZZAfrLN6k8N5pQi8/GlmdR/74veyoRPABOoiDAv2haXdO0kx0z0H5
         +VsLWW4NACoJLGRQFCtAzDMHN91ExbTxg6T/kcP+JAdknXSlMrijLMaspc/p/6flTN7d
         4wv7of3ArkDXEDX0UcHxN2ZyDz9kmVwv2E5RxI62UrwnuJKeUG6aDeQcgxh2ADxWmgD0
         1BEw==
X-Gm-Message-State: ALyK8tJ65POT63a1n2fkExYs65heEeh/dH0S8eZHs36/TO4gjINbwuZzInlpX2PPr1RS4g==
X-Received: by 10.66.254.39 with SMTP id af7mr58922958pad.37.1468877189044;
        Mon, 18 Jul 2016 14:26:29 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:9154:f831:1491:8d12])
        by smtp.gmail.com with ESMTPSA id k29sm7157874pfb.2.2016.07.18.14.26.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Jul 2016 14:26:27 -0700 (PDT)
Date:	Mon, 18 Jul 2016 14:26:26 -0700
From:	Jonathan Nieder <jrnieder@gmail.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Theodore Ts'o <tytso@mit.edu>, Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
Message-ID: <20160718212626.GD29326@google.com>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net>
 <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
 <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
 <20160717154234.GC6644@vauxhall.crustytoothpaste.net>
 <20160717162349.GB11276@thunk.org>
 <20160717220417.GE6644@vauxhall.crustytoothpaste.net>
 <xmqq4m7mltbw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4m7mltbw.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano wrote:

> Continuing this thought process, I do not see a good way to allow us
> to wean ourselves off of the old hash, unless we _break_ the pack
> stream format so that each object in the pack carries not just the
> data but also the hash algorithm to be used to _name_ it, so that
> new objects will never be referred to using the old hash.

Taking a step further: I don't think that any backward-compatible
format change would address the security concerns with sufficiently
old hashing algorithms.

As long as my favorite repository is allowed to contain objects
identified by SHA-1, my adversary can exploit a SHA-1 collision using
signed tags referring (possibly indirectly) to backdated objects.  The
Git object format does not include a proof of commit date, so I cannot
guarantee "Only old objects are named by SHA-1".

There is a way to get a backward-compatible *user experience* without
the format change being backward-compatible, though.  Name all objects
in the repository using FuturisticHash.  Also store enough information
to recover the old hashes, either in objects as a new field or in a
side table.

If the old hash is broken, signatures using the old hash cannot be
trusted.  An adversary could generate a collision to retroactively
change the meaning of an existing signature.  To maintain the meaning
of old signatures, someone has to record the new names of all involved
objects, either before the state of the art in breaking the old hash
advances far enough or using a copy of the repository from before the
state of the art had advanced --- in effect you need new signatures to
maintain the meaning of old signatures.  This could happen as part of
the process of updating a repository to use a new hash.

E.g.

	object a787a87b98a7s98798a798b7a98b798a7b98a7b987a9b87a9b87a98b79a87b98a7b98a7b987a987987a878a78a
	sha1tag object 04b871796dc0420f8e7561a895b52484b701d51a
	 type commit
	 tag signedtag
	 tagger C O Mitter <committer@example.com> 1465981006 +0000

	 signed tag

	 signed tag message body
	 -----BEGIN PGP SIGNATURE-----
	 Version: GnuPG v1

	 iQEcBAABAgAGBQJXYRhOAAoJEGEJLoW3InGJklkIAIcnhL7RwEb/+QeX9enkXhxn
	 rxfdqrvWd1K80sl2TOt8Bg/NYwrUBw/RWJ+sg/hhHp4WtvE1HDGHlkEz3y11Lkuh
	 8tSxS3qKTxXUGozyPGuE90sJfExhZlW4knIQ1wt/yWqM+33E9pN4hzPqLwyrdods
	 q8FWEqPPUbSJXoMbRPw04S5jrLtZSsUWbRYjmJCHzlhSfFWW4eFd37uquIaLUBS0
	 rkC3Jrx7420jkIpgFcTI2s60uhSQLzgcCwdA2ukSYIRnjg/zDkj8+3h/GaROJ72x
	 lZyI6HWixKJkWw8lE9aAOD9TmTW9sFJwcVAzmAuFX2kUreDUKMZduGcoRYGpD7E=
	 =jpXa
	 -----END PGP SIGNATURE-----
	-----BEGIN PGP SIGNATURE----
	...
	-----END PGP SIGNATURE

This example uses a signature to attest that mapping
04b871796dc0420f8e7561a895b52484b701d51a->a787a87b98a7s98798a798b7a98b798a7b98a7b987a9b87a9b87a98b79a87b98a7b98a7b987a987987a878a78a
is correct.  A more straightforward approach would be for the
conversion process to produce an out-of-band signed mapping list to
make the sha1tag usable without such a signature.

Summary:
 * Git's properties depend on using a single hash function throughout
   a repository.  I don't think we should change that.

 * A safe and mostly painless migration to a stronger hash function is
   possible using a signed assertion (for example generated by the
   conversion process) of the mapping from old object names to new
   object names.

 * Dealing with multiple such signed mappings (for example due to
   separate conversion of repositories based on linux.git) is left as
   an exercise to the reader.

Hope that helps,
Jonathan
