Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D9281F453
	for <e@80x24.org>; Tue, 29 Jan 2019 23:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfA2X7x (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 18:59:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35244 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbfA2X7w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 18:59:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so19859633wmt.0
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 15:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CybNhAafejy9YUF4wqrqaz38rsv1ED3qJicV0xp1fFI=;
        b=oPREb6qREuuefTyq8Q4giKMBFloN3Z/oc7rrcDVT2kfhT0nkjiS3wXLcIZKBVKyuQO
         tJ6InvPzugce/G8NKQddfHyYlzp7aeFinHIn2E0vCnN+oyHwSjM/mHD5vyfJla4yj9JM
         EHWdzyd0NYQ6zsefeSyDt6RqWawjR5scVBMAhg5RTQm2vKCpVIYyfLmXlORzOVXA5qWi
         HW0rzT9iXRE2O5AvGNwUrAbJfsZdNodO0AiZWgTOu+/y5DDbKzREzlrHlF6H2lTj39Lr
         fA2oH2Sm0V0q/f5gIpHS0Bge85tPt2G3EkcwJbiFqwy2XeHy0wZkJGHiRiavuwVfvTR6
         wY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CybNhAafejy9YUF4wqrqaz38rsv1ED3qJicV0xp1fFI=;
        b=FuvZ9qCHXhmpQi2S+trfu5Z1epduBpamAJhUt+VRaAUyfzlHaSb+jm/houn5jE/gYy
         MJZXnKaRSgL56UOotkdpuAdbF36H+7erNJFMQMzHAVnmaWTRnytDqzceFO9CKc3gpcLD
         E66BY6WIvA3v9CCm1puqxWKDzF4Kgn7aW3Jcw42WE5nziHKhqCqG3WwDRozNbclg5mPW
         7BXRfPLDOzWhnG19Jbqb0+K1xlQMSQrXRp9nCCmj2vplv8EOjVR+7JhBt6pWUY95i7BJ
         lm39waBMjUuP9RBLll1bBwdGHXuFyZaqIA/+r9pHCuTlXX2WpZMJh32SSXeZ4EcnvOPM
         Na+A==
X-Gm-Message-State: AJcUukeBXxCEiodBSTj+cyh0IfwErD3UpUA/quBBex9ZULBoZQbXMEHW
        Uj5lq/ZDt5cSPd7FZ+4Utg4=
X-Google-Smtp-Source: ALg8bN5O0rS/6ECrwqWh8TB3ujuxnQwhgqt9X8Z3YrNWrSeWyNOf7fW68hWJDYn/O50ogiRxduhgLw==
X-Received: by 2002:a1c:dc02:: with SMTP id t2mr22476217wmg.78.1548806390369;
        Tue, 29 Jan 2019 15:59:50 -0800 (PST)
Received: from szeder.dev (x4db3778b.dyn.telefonica.de. [77.179.119.139])
        by smtp.gmail.com with ESMTPSA id h16sm239039810wrb.62.2019.01.29.15.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 15:59:49 -0800 (PST)
Date:   Wed, 30 Jan 2019 00:59:47 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH (Apple Git) 02/13] test-lib: Export PERL5LIB for testing
 git-svn
Message-ID: <20190129235947.GG13764@szeder.dev>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-3-jeremyhu@apple.com>
 <xmqq1s4v6pzm.fsf@gitster-ct.c.googlers.com>
 <09281A61-1EDA-4226-AD59-6A97EDF1B1DB@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09281A61-1EDA-4226-AD59-6A97EDF1B1DB@apple.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 03:46:07PM -0800, Jeremy Huddleston Sequoia wrote:
> 
> 
> > On Jan 29, 2019, at 2:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:
> > 
> >> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
> >> ---
> >> t/test-lib.sh | 3 +++
> >> 1 file changed, 3 insertions(+)
> > 
> > This obviously won't be acceptable as-is to my tree.  Shouldn't this
> > be something to be dealt with in config.mak.uname or something that
> > is meant to define platform-specific customization?
> 
> The issue here is that we're not locating relocatable perl modules
> during testing.  This is a general problem with testing
> RUNTIME_PREFIX configurations, and a more general solution to this
> sledgehammer would be appropriate.  I don't think config.mak.uname
> really makes sense since it's a general RUNTIME_PREFIX issue and not
> specifically a darwin issue.

But this patch is very darwin-specific ...

> >> diff --git a/t/test-lib.sh b/t/test-lib.sh
> >> index 0f1faa24b2..4060a53f56 100644
> >> --- a/t/test-lib.sh
> >> +++ b/t/test-lib.sh
> >> @@ -1017,6 +1017,9 @@ fi
> >> 
> >> GITPERLLIB="$GIT_BUILD_DIR"/perl/build/lib
> >> export GITPERLLIB
> >> +PERL_VERSION=$(grep DEFAULT /usr/local/versioner/perl/versions | sed 's:^.*= *\([^ ]*\)$:\1:')
> >> +PERL5LIB="$GIT_BUILD_DIR"/perl:"$(xcode-select -p)"/Library/Perl/$PERL_VERSION

... because what other platforms could possibly have 'xcode-select'
installed!?  Consequently:

  $ ./t0000-basic.sh 
  grep: /usr/local/versioner/perl/versions: No such file or directory
  ./t0000-basic.sh: 1154: ./test-lib.sh: xcode-select: not found
  ok 1 - verify that the running shell supports "local"
  ok 2 - .git/objects should be empty after git init in an empty repo
  ok 3 - .git/objects should have 3 subdirectories
  ok 4 - success is reported like this
  not ok 5 - pretend we have a fully passing test suite
  <...>
  # failed 29 among 82 test(s)



> >> +export PERL5LIB
> >> test -d "$GIT_BUILD_DIR"/templates/blt || {
> >> 	error "You haven't built things yet, have you?"
> >> }
> 
