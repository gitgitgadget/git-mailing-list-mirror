Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF4D120248
	for <e@80x24.org>; Tue, 26 Feb 2019 19:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfBZTjS (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 14:39:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46894 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBZTjS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 14:39:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id i16so15263019wrs.13
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 11:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qpsB0AxRuE1cshhViUoNiKBIHRIhH5C7zx4r9Mln2dM=;
        b=mCeED41Xf9t52sVNURNACHN8aX1P+C4psJ8IxuGFvIONYtZPvYGtm8o+zXBpALDpBE
         Oj2rn1VPfdMY9rEcnCrSteKmB11FCNymj1f7KQyMPyeUlc7VAoymW2EMeFSG2FycBXQ5
         pVS0LIwVS5+kWv93hrMg1feadkZuTA4LVUSdnFo5Yj5gydji12Byz2f7kBNvH6WIBb1U
         wvREnZqj6ATBYfXX02CoG2qBL0sw5AadhkH2XsB47TZTzgArEG8Et0K9Gz0Kpu+cd89x
         c+5uLua8ZlTXer84Mu0X91O98pALbhS6RdMOtWto7Rd/81DpOrPfjHmd5ubjnO72PefD
         mnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qpsB0AxRuE1cshhViUoNiKBIHRIhH5C7zx4r9Mln2dM=;
        b=GEtSS478J0IRX7sR26ppN0sqIDoAeIefBtEYwLPq8uztCrKwpn2KY4VffhvKUKAZu9
         vW/QeeqSmlJxXbBgSElB7SDfPQEots1KYTEjTP9X0HYBhJAqLwVC1PrtUCN0ZxfYguPT
         Gr78wizA1zASMp51E7XR8cPgl9V20JHEFbMB3INXO1V+sO1tsHyZzNsVblgWT7SPJ9GF
         NP2VJvrS4njdPVGWcRfrduap8h8OMPQNe+bSKL8xDv1RXeC/U5M0+b+CajGlsK8mEPxr
         +Rhv+DObSXK/4CNqMnde2GlF6NzjGJa9g+uLwz9aBQ9G+fr+SoTFFuIQhStDTnzR2SqS
         HChg==
X-Gm-Message-State: AHQUAuYNa7ThiHiCpcR6ymJZoR/zm4VQyOxq3I9dS+DC+ernY9KNX9g1
        6RyUJI/6E7OhWvRcRlsmUIqwMq2a
X-Google-Smtp-Source: AHgI3IZdJ3t3KSaKAFAxNwiqZ+/gXKeZSzi39pFZI6Wm5T9/NLL9qzCCHkCp1kEXiqgVfbvJHXudvg==
X-Received: by 2002:a5d:680d:: with SMTP id w13mr16743525wru.196.1551209955947;
        Tue, 26 Feb 2019 11:39:15 -0800 (PST)
Received: from szeder.dev (x4db46559.dyn.telefonica.de. [77.180.101.89])
        by smtp.gmail.com with ESMTPSA id d9sm16152724wrn.72.2019.02.26.11.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 11:39:15 -0800 (PST)
Date:   Tue, 26 Feb 2019 20:39:12 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: Do test-path_is_{file,dir,exists} make sense anymore with -x?
Message-ID: <20190226193912.GD19739@szeder.dev>
References: <pull.152.git.gitgitgadget@gmail.com>
 <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
 <CACsJy8DG6+mmA5NT67V46=n1-5H_eh3779eE28YN4kcjb0Cq0A@mail.gmail.com>
 <87sgwav8cp.fsf@evledraar.gmail.com>
 <20190226170400.GC19739@szeder.dev>
 <20190226174316.GD19606@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190226174316.GD19606@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 12:43:17PM -0500, Jeff King wrote:
> On Tue, Feb 26, 2019 at 06:04:00PM +0100, SZEDER Gábor wrote:
> 
> > > Whereas:
> > > 
> > >     + test -f doesnotexist
> > >     + echo File doesnotexist doesn't exist.
> > >     File doesnotexist doesn't exist.
> > >     + false
> > >     error: last command exited with $?=1
> > > 
> > > Gives me the same thing, but I have to read 5 lines instead of 2 that
> > > ultimately don't tell me any more (and a bit of "huh, 'false' returned
> > > 1? Of course! Oh! It's faking things up and it's the 'echo' that
> > > matters...").
> > 
> > I didn't find this to be an issue, but because of functions like
> > 'test_seq' and 'test_must_fail' I've thought about suppressing '-x'
> > output for test helpers (haven't actually done anything about it,
> > though).
> 
> I'd be curious how you'd do that.

Well, I started replying with "Dunno" and explaining why I don't think
that it can be done with 'test_must_fail'... but then got a bit of a
lightbulb moment.  Now look at this:


diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 80402a428f..16adcd54c9 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -664,7 +664,15 @@ list_contains () {
 #     Currently recognized signal names are: sigpipe, success.
 #     (Don't use 'success', use 'test_might_fail' instead.)
 
+restore_tracing () {
+	if test -n "$trace"
+	then
+		set -x
+	fi
+} 2>/dev/null 4>/dev/null
+
 test_must_fail () {
+	{ set +x ; } 2>/dev/null 4>/dev/null
 	case "$1" in
 	ok=*)
 		_test_ok=${1#ok=}
@@ -679,24 +687,29 @@ test_must_fail () {
 	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
 	then
 		echo >&4 "test_must_fail: command succeeded: $*"
+		restore_tracing
 		return 1
 	elif test_match_signal 13 $exit_code && list_contains "$_test_ok" sigpipe
 	then
+		restore_tracing
 		return 0
 	elif test $exit_code -gt 129 && test $exit_code -le 192
 	then
 		echo >&4 "test_must_fail: died by signal $(($exit_code - 128)): $*"
+		restore_tracing
 		return 1
 	elif test $exit_code -eq 127
 	then
 		echo >&4 "test_must_fail: command not found: $*"
+		restore_tracing
 		return 1
 	elif test $exit_code -eq 126
 	then
 		echo >&4 "test_must_fail: valgrind error: $*"
+		restore_tracing
 		return 1
 	fi
-	return 0
+	restore_tracing
 } 7>&2 2>&4
 
 # Similar to test_must_fail, but tolerates success, too.  This is


Yeah, it's a hassle, especially in a function with as many return
paths as 'test_must_fail', but look at its output:

  + test_must_fail git rev-parse nope --
  fatal: bad revision 'nope'
  + test_must_fail git rev-parse HEAD --
  48ab21c1a5972e0fa9d87da7c5da9982872b8db2
  test_must_fail: command succeeded: git rev-parse HEAD --
  + return 1
  error: last command exited with $?=1

Not even the 'set +x' shows up in the trace output!  Unfortunately,
that line is not particularly pleasing on the eyes, but I don't see
any way around that...

Perhaps we could even go one step further with this 'restore_tracing'
helper and add a parameter specifying its return code, so we could
make it the last command invoked in the test helper function, and then
even that 'return 1' would disappear from the trace output.
Furthermore, this would be helpful in those functions where the last
command's return code is relevant, e.g: 

  test_cmp() {
        { set +x ; } 2>/dev/null 4>/dev/null
        $GIT_TEST_CMP "$@"
        restore_tracing $?
  }


There are a couple of tricky cases:

  - Some test helper functions call other test helper functions, and
    in those cases tracing would be enabled upon returning from the
    inner helper function.  This is not an issue with e.g.
    'test_might_fail' or 'test_cmp_config', because the inner helper
    function is the last command anyway.  However, there is
    'test_must_be_empty', 'test_dir_is_empty', 'test_config',
    'test_commit', etc. which call the other test helper functions
    right at the start or in the middle.

  - && chains in test helper functions; we must make sure that the
    tracing is restored even in case of a failure.



