Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A183F1F744
	for <e@80x24.org>; Tue, 12 Jul 2016 01:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbcGLBIg (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 21:08:36 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34964 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbcGLBIf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 21:08:35 -0400
Received: by mail-io0-f173.google.com with SMTP id m101so3376513ioi.2
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 18:08:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=Y20D84LkfeFTIR+qHijTvpNXsV3MgPj2YSWG1CywUeQ=;
        b=O62fgLEN5VxtASRa5fnwA4fxLkbIMMECdoOnrzdZ37OkH+OZ7660UJfU7G7GYPaTTo
         72zwkbvuSND/1Rtqc8H7+F7Vb1WVtGpHWQ+Zsraz8ds3mbk0d4slQNuxcrDE0thjxOU5
         SI9kOKbW26eHyCnUzolbuam+T9R2sEZP8B87kmkFkAIZxbBUUBw1Tp+/+A/S/zY9BQ8S
         as16SjsrBGDyZu/zVtE1xueFK89+23ZLkXijDtIFkz205b/eEm1F8PPaQXQQz+Zm7JS5
         9Y3VYaYwNUMKv0/A5PAXtCvqBWTRVQao1w5SWYOJ2kzVj0ncn1Cnb79tPwARtA7mhaFr
         csqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Y20D84LkfeFTIR+qHijTvpNXsV3MgPj2YSWG1CywUeQ=;
        b=GPioP0wa72b9fniZMxjsdXdn0FzHAxmCQbmZKCgvK07Q/KoMHECdU4Gu/Wcoz6nZyg
         70VzTMZfjlqIUHqvy7yWg5MEinsmUDpJORlAs1UYzd3zhm8BWCvfKoTEoGrClbiZw/Th
         GL3OqvdBXg95tDlrlr/gAIx3SUXXfO/eLJFQTeOaPHGMblZA5z5Z8Qoa3i88gb+5DOK8
         wVFVfeISwfPZutRtT05w4LA8+e8LMon6PLEMIYoQj3nk8lKoZadrIVY4vEYq9trBUuHQ
         CxUagMxgItEXXUkTqiPNGudmRIO2Zg5FG5WrPXjRxqG5dTHWqnTj9R82SS4d0IJx18WQ
         Kszg==
X-Gm-Message-State: ALyK8tLFJRCbh8XSGsC9DQQPDityAu6cv00JGRCEglVMkt8QDpgEeiZfkLsTW/YpspSIWuDLPP5aEFLTMZz6L+Ce
X-Received: by 10.107.178.129 with SMTP id b123mr35434iof.83.1468285714065;
 Mon, 11 Jul 2016 18:08:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Mon, 11 Jul 2016 18:08:33 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 11 Jul 2016 18:08:33 -0700
Message-ID: <CAGZ79kZ=wk9ofaEAHFROrEf_AZqURLOnB5F4v3PEVFNYta8H4w@mail.gmail.com>
Subject: verbose fetches not overly verbose
To:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

        $ git clone https://github.com/gitster/git tmpgit2 -v -v -v
        Cloning into 'tmpgit2'...
        Server supports multi_ack_detailed
        Server supports no-done
        Server supports side-band-64k
        Server supports ofs-delta
        Server version is git/2:2.6.5~dgit-checksum-v5-1484-gfc2423c
        want 867ad08a2610526edb5723804723d371136fc643 (refs/heads/ab/hooks)
        want 4a6ada32cb64b0eba8b6f995e4230f0c722fd580
(refs/heads/ad/bisect-cleanup)
        want 06e6a745064c4f2f827177f6d92f4b9adb018200
(refs/heads/ad/bisect-terms)
        ...
        [a lot more wants, cut]
        want 47e8b7c56a5504d463ee624f6ffeeef1b6d007c1 (refs/tags/v2.9.1)
        done
        POST git-upload-pack (gzip 63203 to 31673 bytes)
        remote: Counting objects: 201614, done.
        remote: Total 201614 (delta 0), reused 0 (delta 0), pack-reused 201614
        Receiving objects: 100% (201614/201614), 88.76 MiB | 32.86 MiB/s, done.
        Resolving deltas: 100% (147442/147442), done.
        Checking connectivity... done.

Now the same for fetch:

        $ cd tmpgit2
        $ git fetch -v -v -v
        From https://github.com/gitster/git
         = [up to date]      master     -> origin/master
         = [up to date]      ab/hooks   -> origin/ab/hooks
         = [up to date]      ad/bisect-cleanup -> origin/ad/bisect-cleanup
         = [up to date]      ad/bisect-terms -> origin/ad/bisect-terms
        ...
         [a lot more wants, cut]

It is missing the want lines completely. I guess that is not that intentional,
but rather we forgot to add the verbosity option correctly to the
fetch in the transport layer.
Looking at the transport code, I am confused on both how the wants are
printed in the clone
case as well as how they are not printed in the fetch case.

Any hints?

(I could use GIT_TRACE_PACKET as a work around, but it's just a hack.)

Thanks,
Stefan
