Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D66F20323
	for <e@80x24.org>; Mon, 20 Mar 2017 02:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbdCTCLN (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 22:11:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61215 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751513AbdCTCLM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 22:11:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 211B07432F;
        Sun, 19 Mar 2017 22:11:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iUffvsufWMEj+1DcAEy/BEh0+eI=; b=xnOhuQ
        3YzhKN/2QF4ZS5BlSfEQmIjzFP4764X8mX79p/5+xOoMhpLgUVAZkfdAIUwz+K2b
        6WXQ5rQZgCIj/fBrpXTdjo3wJDBs0UCQXwS+q3Jbh1vH0zpgd3+DM4MqK84K7DnD
        Nj39L0MYBugbRBpkf3NGHOacMcTWB3P/XkGoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gm8eNJXjwUbLjgwMfIT9EMJoGXbzsUcd
        k0ZnSIccAprQw90XTYADiuDI0HqfzPve8Q1r9trYgvSQQAnFE3LiNSuN0egmyZKM
        6UymjRxkxztfdDjXz/0DaHZimnu3tDeq7pYlwb4nkC1ke1DoyYFd05cZKcuNth34
        GjPvyFquqhQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 190CB7432E;
        Sun, 19 Mar 2017 22:11:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7EB587432D;
        Sun, 19 Mar 2017 22:11:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] l10n: Introduce framework for localizing man pages
References: <20170312200248.3610-1-jn.avila@free.fr>
        <20170312200248.3610-1-jn.avila@free.fr>
        <20170318175353.24578-1-jn.avila@free.fr>
        <xmqqfuia1ifx.fsf@gitster.mtv.corp.google.com>
        <xmqq37ea192h.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 19 Mar 2017 19:11:09 -0700
In-Reply-To: <xmqq37ea192h.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sat, 18 Mar 2017 16:03:50 -0700")
Message-ID: <xmqqr31sy9xe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C601312-0D12-11E7-AE91-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Travis seems to have failed.  Perhaps something like this is needed,
> at least?
>
>  .travis.yml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index 591cc57b80..719e5cdb00 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -20,6 +20,7 @@ addons:
>      - language-pack-is
>      - git-svn
>      - apache2
> +    - po4a
>  
>  env:
>    global:

Here is what I have for now on top of yours in an attempt to make it
work with the public Travis, which is still not working X-<.

  https://travis-ci.org/git/git/jobs/212839039

shows how it breaks, which is somehow different from how it does not
fail on a copy of Ubuntu I seem to be running, even though I seem to
have the same 0.41-1ubuntu1 installed).  

Can you take it over from here?

-- >8 --
Subject: [PATCH] DONTMERGE: (blind trial for travis build)

The update to INSTALL shown here is bogus, but was made only to show
where necessary information to make use of the new feature needs to
be added.

Specifically, the patches by Jean-Noel Avila requires po4a even for
those who do not want localized documentation, and what is described
in INSTALL pretends that this has already been fixed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .travis.yml | 1 +
 INSTALL     | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 591cc57b80..d0e1f99161 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -68,6 +68,7 @@ matrix:
           packages:
           - asciidoc
           - xmlto
+          - po4a
       before_install:
       before_script:
       script: ci/test-documentation.sh
diff --git a/INSTALL b/INSTALL
index ffb071e9f0..acfcd886df 100644
--- a/INSTALL
+++ b/INSTALL
@@ -179,7 +179,12 @@ Issues of note:
 
    All formats require at least asciidoc 8.4.1.
 
-   There are also "make quick-install-doc", "make quick-install-man"
+ - To build and install localized documentation suite, you need to
+   have the po4a package, too.  The build and install steps are the
+   same as outlined above, and the build documentation pages can be
+   accessed by doing "git help <commandname>" in your locale.
+
+ - There are also "make quick-install-doc", "make quick-install-man"
    and "make quick-install-html" which install preformatted man pages
    and html documentation. To use these build targets, you need to
    clone two separate git-htmldocs and git-manpages repositories next
-- 
2.12.0-399-g9d77b0405c

