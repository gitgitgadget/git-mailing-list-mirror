Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04A8A1F461
	for <e@80x24.org>; Sat, 24 Aug 2019 08:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfHXIZX (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 04:25:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41986 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfHXIZW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 04:25:22 -0400
Received: by mail-io1-f68.google.com with SMTP id e20so25538573iob.9
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 01:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5wVBbk47m8ogoTkEvq8yp7mUCIybxLft/+IbtM0unEk=;
        b=HQ7ifSyMGtyAZRhuX6Q6hT0ZM4KLBBCvLPDKG690rqh3NrxHdS6YmoViLOYctRhRb8
         k5hLNXAAsTr83a05cE+gK7s1xzulBw9Tbve7N9R//spllt/TGhWbyepBPMa1iUSdPvY6
         tN+ESh8ThPzD0ONn5orL1cTI23XMzDKvbTo17iHux1YFMFUKbe8S1B+K/wrR03SXQzLx
         QR4t3Tv/wK6MG60UpbKGMHfr2sFzP9eM7DS78TYDoQc9FxEG2BrDZZ+29Om1i6P71K4n
         fmtjDKlk0Vcfo0w1om8IqTkHr7+242cy+AvzxDK5Npk0AEhf6kDLygX23PBErIR1iAqS
         Xr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5wVBbk47m8ogoTkEvq8yp7mUCIybxLft/+IbtM0unEk=;
        b=DKUxqPdD5qPVEwavHNZBGmllm5iX3L//OdJNDotFs+DXiq7XS7YmE6qOS/3nV/G245
         KfWNYhK97oJ7NT10pAbgmP+0WbUychRue1dD5MIbiEyleXv7YcQ2RZ6UwDVMPZ3Quegs
         tGLF2CyEmDJ74xqduFIVCiTq+0I3mWL+APwydMcfjwqd/for+y80EDeVkZw0LM33FOiR
         6CjzgS5BnIHVTs/UiRpulPKvkbq19240/BECSqw0O3+Mnp78B/eZNk57Oza9ZdvXWYEE
         Cc4bnyb8NR1vy2lYBy29k2oRk0Xu57fBek6lqCP473fiGAqv7aVWyeLDv3GZmKjVgwL2
         +8lQ==
X-Gm-Message-State: APjAAAXoo7FLf1HhN+B6btZdm0b3iTQT/flG0Di3KRU5oAEPjumFBthq
        51gv2t4N5fZMx6jnDHTugnRRC6v0
X-Google-Smtp-Source: APXvYqzg4CjAumWJxDtzXBt9wsNskUhg3AKKH2+Pnr9GozEmg/U/mas+uvziqb6Jpma2L6hKRepHHA==
X-Received: by 2002:a02:a409:: with SMTP id c9mr9182367jal.74.1566635121568;
        Sat, 24 Aug 2019 01:25:21 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id s11sm4604942ioo.45.2019.08.24.01.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 01:25:20 -0700 (PDT)
Date:   Sat, 24 Aug 2019 04:25:17 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 00/13] format-patch: clean up tests and documentation
Message-ID: <cover.1566635008.git.liu.denton@gmail.com>
References: <cover.1566285151.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566285151.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

*** BLURB HERE ***

As one of the older parts of the Git, the tests and documentation for
format-patch have been needing cleanup for a while. Let's do that in
this patchset!

This patchset is based on v3 of "format-patch: learn
--infer-cover-subject option (also t4014 cleanup)"[1].

Changes since v3 of "format-patch: learn --infer-cover-subject option (also
t4014 cleanup)":

* Squash in Junio's and Hannes' suggestions

* Add 't4014: let sed open its own files'

[1]: https://public-inbox.org/git/xmqqwof3ljcz.fsf@gitster-ct.c.googlers.com/T/#m19570aff4828dfbd65d57cacf231c2938af1dc9f


Denton Liu (13):
  t4014: drop unnecessary blank lines from test cases
  t4014: s/expected/expect/
  t4014: move closing sq onto its own line
  t4014: use sq for test case names
  t4014: remove spaces after redirect operators
  t4014: use indentable here-docs
  t4014: drop redirections to /dev/null
  t4014: let sed open its own files
  t4014: use test_line_count() where possible
  t4014: remove confusing pipe in check_threading()
  t4014: stop losing return codes of git commands
  Doc: add more detail for git-format-patch
  config/format.txt: specify default value of format.coverLetter

 Documentation/config/format.txt    |   1 +
 Documentation/git-format-patch.txt |  23 +-
 t/t4014-format-patch.sh            | 814 ++++++++++++++---------------
 3 files changed, 421 insertions(+), 417 deletions(-)

Range-diff:
 1:  fb000bfca2 =  1:  fb000bfca2 t4014: drop unnecessary blank lines from test cases
 2:  568b3a03a0 !  2:  0a5ce9b95f t4014: s/expected/expect/
    @@ Commit message
         t4014: s/expected/expect/
     
         For test cases, the usual convention is to name expected output files
    -    "expect", not "expected". Replace all instances with "expected" with
    +    "expect", not "expected". Replace all instances of "expected" with
         "expect" except for one case where the "expected" is used as the name
         of a test case.
     
 3:  a205a920bd =  3:  5c49703aa4 t4014: move closing sq onto its own line
 4:  66bf2e3dd4 =  4:  02a11147fd t4014: use sq for test case names
 5:  6f1371275e =  5:  8d9791c061 t4014: remove spaces after redirect operators
 6:  b4295846f5 =  6:  90ad0fcf70 t4014: use indentable here-docs
 7:  34315412c8 =  7:  804b3163f8 t4014: drop redirections to /dev/null
 -:  ---------- >  8:  7d9a24a979 t4014: let sed open its own files
 8:  de08dd886d =  9:  d068d42098 t4014: use test_line_count() where possible
 9:  dec5a62e82 = 10:  6a9409cee0 t4014: remove confusing pipe in check_threading()
10:  64069c0c54 ! 11:  c580ce447b t4014: stop losing return codes of git commands
    @@ t/t4014-format-patch.sh: test_expect_success 'format-patch --ignore-if-in-upstre
      
     -git_version="$(git --version | sed "s/.* //")"
     +test_expect_success 'get git version' '
    -+	git_version="$(git --version | sed "s/.* //")"
    ++	git_version=$(git --version) &&
    ++	git_version=${git_version##* }
     +'
      
      signature() {
11:  c12534ab5d = 12:  a97f861e6a Doc: add more detail for git-format-patch
12:  a08273ebcc <  -:  ---------- config/format.txt: specify default value of format.coverLetter
13:  de599f7ca9 <  -:  ---------- format-patch: learn --infer-cover-subject option
 -:  ---------- > 13:  7c8522abf2 config/format.txt: specify default value of format.coverLetter
-- 
2.23.0.248.g3a9dd8fb08

