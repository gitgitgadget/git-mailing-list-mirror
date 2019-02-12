Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8571F453
	for <e@80x24.org>; Tue, 12 Feb 2019 12:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfBLMnc (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 07:43:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35940 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbfBLMnc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 07:43:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id r124so1215789pgr.3
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 04:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NqDmtpU2q8puhdVbGjLsM9Xxpj9tbQodSleAurbpKAo=;
        b=gE5PmWDdNKB4w7kTsH2RPudmcSdHsdJpk/fLFcUywnslxlBG/wywGX8PviYGNp9w19
         nAguYmfOLgJYBj5S43uyzTqlJyO10IVfEWv57UXOuhZSF1tN9Zs44Wi090GTjeE2NUqY
         5OV6Dr/Cx/1E3B+nB6FKILbVMniS2s26hYJ+qWHdgH2zwn1Wt9YCc5e4M/yVKtFst1PJ
         hHC3kUpBqDQcshbiZWq502isznHEyi4ZFgssFH65uoaQJLRxwn0hK/+/E70ul5vjUVo/
         r81pmHpINC2VbomwDmOAPOeQmGTYRog9NZmh32LEOBAuQcYuh9uvtm4z/vrLiogsOkkY
         ZkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NqDmtpU2q8puhdVbGjLsM9Xxpj9tbQodSleAurbpKAo=;
        b=dW1zINXh/bbZxpCkFR62DNnnr1JKJEuZN/bdpk/XKg44wtOZaV49ZJ4OLTRs8DwEVQ
         oP2YWCslGM0geRd514DI8mvMyhpq2/ZjMs9L+ucuHAj6CoSc6X3RtsDkAK/fmEA4z7PA
         OmBLblFyl9WjiaQ/s44MdlHwDeiuwWLVfixracxERsOx6KqTS4J+NVCS/OvEZpN5z5AC
         h03cCmdYDa8b/iqmJHD8s62tCp0d29dnkGtWBpF2cwqg2+0TPVWtaRt53+0pGkvL/37W
         k+x4H6MYZAq9vrrnYzUHYfUcN/L6TCN4byhV0K88tcCTkFe64YHWQbp+BPo+euK6Cxqk
         I9PQ==
X-Gm-Message-State: AHQUAua19Hlt0ZTlFpdGCas5t8D7y7Kq3ndO7AJvKOcYxhIzQ6JMY60M
        lCy3QurKp5Zn7t0bBj0lTzM=
X-Google-Smtp-Source: AHgI3IaoQqRmBfbtikQTVk9bV1Fg3pcJN2q4bbEeZ1GYyh3Lsqir3fEa6i59hJtqBPIMa53JJU7mOw==
X-Received: by 2002:a63:2b03:: with SMTP id r3mr3374325pgr.1.1549975410277;
        Tue, 12 Feb 2019 04:43:30 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id y9sm18481599pfi.74.2019.02.12.04.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 04:43:28 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 12 Feb 2019 19:43:23 +0700
Date:   Tue, 12 Feb 2019 19:43:23 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        git-packagers@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git v2.21.0-rc0 broken on *BSD, maybe others
Message-ID: <20190212124323.GA11677@ash>
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com>
 <87sgwtjjbk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sgwtjjbk.fsf@evledraar.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 12, 2019 at 01:13:35PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Feb 07 2019, Junio C Hamano wrote:
> 
> > An early preview release Git v2.21.0-rc0 is now available for
> > testing at the usual places.  It is comprised of 426 non-merge
> > commits since v2.20.0, contributed by 57 people, 13 of which are
> > new faces.
> 
> As seen on https://gitlab.com/git-vcs/git-ci/branches there are
> regressions since 2.19.0, e.g. we have hard compile errors on BSD now,
> and maybe AIX. I haven't dug into it.

The build problem on BSD is known and being worked on [1]. I was going
to install FreeBSD to examine it closey, but got distracted.

The AIX problem is from d1dd94b308 (Do not print 'dangling' for
cat-file in case of ambiguity - 2019-01-17). Apparently AIX compiler
is a bit picky about enum being a strong or weak type. I like this
compiler. The below patch should do.

The test failures on NetBSD and Solaris/Sparc, not sure if we can do
anything without test logs or access to these systems.

-- 8< --
diff --git a/sha1-name.c b/sha1-name.c
index d1cc77c124..6dda2c16df 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1820,9 +1820,11 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
 			       prefix, &oid, &oc);
 }
 
-int get_oid_with_context(struct repository *repo, const char *str,
-			 unsigned flags, struct object_id *oid,
-			 struct object_context *oc)
+enum get_oid_result get_oid_with_context(struct repository *repo,
+					 const char *str,
+					 unsigned flags,
+					 struct object_id *oid,
+					 struct object_context *oc)
 {
 	if (flags & GET_OID_FOLLOW_SYMLINKS && flags & GET_OID_ONLY_TO_DIE)
 		BUG("incompatible flags for get_sha1_with_context");
-- 8< --


[1] https://public-inbox.org/git/xmqqsgwwizf6.fsf@gitster-ct.c.googlers.com/
--
Duy
