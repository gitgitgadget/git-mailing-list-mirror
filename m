Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2062F531
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZYCRM0p0"
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B7E116
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:41:19 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-66d0ea3e5b8so45414066d6.0
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697650878; x=1698255678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc0vBgkvrMnBjb40TtEwPDCkntre3qkJ2ZP7s1PVKNs=;
        b=ZYCRM0p0qeXSOQafR8OpBkwcCvcSHtXIAySbN6qA2V8mT5pXId9O3dChNGJKAZf0UV
         7qq33Z1HW6D90s8Py0JqYs5IdyiE9bY6/v4c/rNjQMmzEdRC5VoAWZ+oRLXwqbvR4zlJ
         yKopAFrAksen++VDcwiylY+zv1kPoq5scgRec109kv/b+/dMhTsyIeJQQ0aqSPEeMJPI
         98Aoz4lQOy01jiaen5qmy8XrQQCXw4wefERwz+qTH5BtEoSUrIL1TFtu81bfcCSrNFiY
         hJbBJY1l8yzxdjMNZTBnLqEx8c+tNVnFTD0Q3ryJzgAL1gujy8T9O9q1VIsK5w+nSp9E
         gj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650878; x=1698255678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uc0vBgkvrMnBjb40TtEwPDCkntre3qkJ2ZP7s1PVKNs=;
        b=nPFlJh/+6V6q3lpRb0lhlSRe0/INy6FliwwJ+ZluagHyP5DyiybmuNUO/mlhUl45sK
         VoIHl+gqHsp06lp2dYtn46+pXwB29LHPCUsYBvEg5ll6Kgl0367thXjRTOfy4M6yX73O
         gXZ+FKMI8G4WHDswnxjmWt1Ynt3oY7I0Q9B/gnRALgQ1sOhSQoFkgXqtIAF87bAyEypE
         z0xcJugg+jZlIEBysph+hk+VxPCExhJCIKIdD8AJ2tApdMBxlvYVQ+GA3AegSxwLXXT/
         0riPMaD9G4mjD+afUNsb7q74ERfm3AqWAmPsmCu+D5c0edDuNICUmEo0i9rw/zSsbkrj
         tr+w==
X-Gm-Message-State: AOJu0YwoF9oInrLQCHLNlCG9Xk2UB2Bi6hN6VqI4WIOHPOlsQ3JkExSl
	enIVdK3rj2SmhsNfH7+nSRTbHw==
X-Google-Smtp-Source: AGHT+IGjeEQuvk83YBLV+gzPo8yeB+KmWxHDkXhOH7F2u0RurF3Nksujf7ge1ety6jmMHlFJCIe2Fg==
X-Received: by 2002:a05:6214:29cc:b0:655:d6af:1c37 with SMTP id gh12-20020a05621429cc00b00655d6af1c37mr5903279qvb.65.1697650878094;
        Wed, 18 Oct 2023 10:41:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b5-20020a05620a0f8500b0077402573fb4sm115519qkn.124.2023.10.18.10.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:41:17 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:41:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 08/17] t4216: test changed path filters with high bit
 paths
Message-ID: <ZTAYvKBeqUyU7o4W@nand.local>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
 <cba766f224b0d2b4fd952b11bef8068c07dfcf88.1696969994.git.me@ttaylorr.com>
 <ZS5JmQib3onjirC6@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZS5JmQib3onjirC6@tanuki>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 10:45:13AM +0200, Patrick Steinhardt wrote:
> > +test_expect_success 'setup check value of version 1 changed-path' '
> > +	(
> > +		cd highbit1 &&
> > +		echo "52a9" >expect &&
> > +		get_first_changed_path_filter >actual &&
> > +		test_cmp expect actual
> > +	)
> > +'
> > +
> > +# expect will not match actual if char is unsigned by default. Write the test
> > +# in this way, so that a user running this test script can still see if the two
> > +# files match. (It will appear as an ordinary success if they match, and a skip
> > +# if not.)
> > +if test_cmp highbit1/expect highbit1/actual
> > +then
> > +	test_set_prereq SIGNED_CHAR_BY_DEFAULT
> > +fi
> > +test_expect_success SIGNED_CHAR_BY_DEFAULT 'check value of version 1 changed-path' '
> > +	# Only the prereq matters for this test.
> > +	true
> > +'
>
> Doesn't this mean that the preceding test where we `test_cmp expect
> actual` can fail on some platforms depending on the signedness of
> `char`?

Great catch, I am surprised this slipped by in earlier rounds. This
should do the trick, since we don't actually care about conditioning
that test's passing on test_cmp coming up clean. We check that in the if
statement you pointed out here, so:

--- 8< ---
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 114672e904..400dce2193 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -502,8 +502,7 @@ test_expect_success 'setup check value of version 1 changed-path' '
 	(
 		cd highbit1 &&
 		echo "52a9" >expect &&
-		get_first_changed_path_filter >actual &&
-		test_cmp expect actual
+		get_first_changed_path_filter >actual
 	)
 '
--- >8 ---

Thanks,
Taylor
