Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 290E01F406
	for <e@80x24.org>; Tue, 12 Dec 2017 23:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbdLLXRm (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 18:17:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54381 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752690AbdLLXRk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 18:17:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E2B4CB8FE;
        Tue, 12 Dec 2017 18:17:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ATSbPOFS707X
        YLKm8ZhxWjzjMf4=; b=WvbqMkasgRFt+CRa9A1Ed5tNAsj3qHmmXnBvY9dkBYxL
        21Jh1+Yv/owU+DrL2G/Sri3kPjPaeevNv51HNHpIr59xW3BYzDp3BGezd+FaLZPS
        bAgy/jkwl+RmnOtsYCE3nERBu4xKswMj6B8fwwmDNeysPm8e5bmZKQevaOevMcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NqLkXs
        xgvQu/pEywbFjIVXl5IMvdN1APCvSoJc1q6FVrzpCT4gAB16uVcsZGvNTU+YZqas
        Y1SNgNkZk2OHj6kv+EW+HEWLhr9oTHRh9idUkHrlnN6i7i005zVtyXaxsbDFyIfU
        2qQAL0clJZzeMST66WGjDqQQ3Kv4PpVwVwa8g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 44E87CB8FD;
        Tue, 12 Dec 2017 18:17:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B0882CB8FC;
        Tue, 12 Dec 2017 18:17:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [Proposed] Externalize man/html ref for quick-install-man and quick-install-html
References: <000801d3713a$2f1259d0$8d370d70$@nexbridge.com>
        <xmqqindc4zhp.fsf@gitster.mtv.corp.google.com>
        <006301d372df$e82cf410$b886dc30$@nexbridge.com>
Date:   Tue, 12 Dec 2017 15:17:38 -0800
In-Reply-To: <006301d372df$e82cf410$b886dc30$@nexbridge.com> (Randall
        S. Becker's message of "Mon, 11 Dec 2017 19:26:46 -0500")
Message-ID: <xmqqtvwvy1rh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A5C3B0A8-DF92-11E7-82A1-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> Sorry about the response positioning...
>
> I can send you a pull request on github, if you want =F0=9F=98=89

I don't.  It's not that I can or cannot take a pull request.  I just
do not want to queue anything that is not reviwed on list.

I however could queue this (typed to mimic what I saw in your
message), but you'd need to say what you see here is OK (and
preferably, you applied this version and it tested fine); I may have
made a typo or two, and I would really prefer extra set of eyes.

Also we need your sign-off, of course.

Thanks.

-- >8 --
From: "Randall S. Becker" <rsbecker@nexbridge.com>
Date: Sat, 9 Dec 2017 17:07:57 -0500
Subject: [PATCH] install-doc-quick: allow specifying what ref to install

We allow the builders, who want to install the preformatted manpages
and html documents, to specify where in their filesystem these two
repositories are stored.  Let them also specify which ref (or even a
revision) to grab the preformatted material from.
---
 Documentation/Makefile             | 5 +++--
 Documentation/install-doc-quick.sh | 9 +++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2ab65561af..4ae9ba5c86 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -39,6 +39,7 @@ MAN7_TXT +=3D gitworkflows.txt
 MAN_TXT =3D $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML =3D $(patsubst %.txt,%.xml,$(MAN_TXT))
 MAN_HTML =3D $(patsubst %.txt,%.html,$(MAN_TXT))
+GIT_MAN_REF =3D master
=20
 OBSOLETE_HTML +=3D everyday.html
 OBSOLETE_HTML +=3D git-remote-helpers.html
@@ -437,14 +438,14 @@ require-manrepo::
 	then echo "git-manpages repository must exist at $(MAN_REPO)"; exit 1; =
fi
=20
 quick-install-man: require-manrepo
-	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO) $(DESTDIR)$(mandi=
r)
+	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO) $(DESTDIR)$(mandi=
r) $(GIT_MAN_REF)
=20
 require-htmlrepo::
 	@if test ! -d $(HTML_REPO); \
 	then echo "git-htmldocs repository must exist at $(HTML_REPO)"; exit 1;=
 fi
=20
 quick-install-html: require-htmlrepo
-	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REPO) $(DESTDIR)$(html=
dir)
+	'$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REPO) $(DESTDIR)$(html=
dir) $(GIT_MAN_REF)
=20
 print-man1:
 	@for i in $(MAN1_TXT); do echo $$i; done
diff --git a/Documentation/install-doc-quick.sh b/Documentation/install-d=
oc-quick.sh
index 327f69bcf5..17231d8e59 100755
--- a/Documentation/install-doc-quick.sh
+++ b/Documentation/install-doc-quick.sh
@@ -3,11 +3,12 @@
=20
 repository=3D${1?repository}
 destdir=3D${2?destination}
+GIT_MAN_REF=3D${3?master}
=20
-head=3Dmaster GIT_DIR=3D
+GIT_DIR=3D
 for d in "$repository/.git" "$repository"
 do
-	if GIT_DIR=3D"$d" git rev-parse refs/heads/master >/dev/null 2>&1
+	if GIT_DIR=3D"$d" git rev-parse "$GIT_MAN_REF" >/dev/null 2>&1
 	then
 		GIT_DIR=3D"$d"
 		export GIT_DIR
@@ -27,12 +28,12 @@ export GIT_INDEX_FILE GIT_WORK_TREE
 rm -f "$GIT_INDEX_FILE"
 trap 'rm -f "$GIT_INDEX_FILE"' 0
=20
-git read-tree $head
+git read-tree "$GIT_MAN_REF"
 git checkout-index -a -f --prefix=3D"$destdir"/
=20
 if test -n "$GZ"
 then
-	git ls-tree -r --name-only $head |
+	git ls-tree -r --name-only "$GIT_MAN_REF" |
 	xargs printf "$destdir/%s\n" |
 	xargs gzip -f
 fi
--=20
2.15.1-525-g09180b8600

