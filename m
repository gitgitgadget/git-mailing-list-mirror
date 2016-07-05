Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3BD720706
	for <e@80x24.org>; Tue,  5 Jul 2016 13:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184AbcGENLP (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 09:11:15 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35558 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbcGENKV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 09:10:21 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u65D9hFT032269
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 5 Jul 2016 15:09:43 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u65D9irm028736;
	Tue, 5 Jul 2016 15:09:44 +0200
From:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:	Alexandru Zbarcea <alexz@apache.org>
Cc:	git@vger.kernel.org, Benoit Person <benoit.person@gmail.com>,
	=?iso-8859-1?Q?C=E9lestin?= Matte <celestin.matte@ensimag.fr>,
	David Aguilar <davvid@gmail.com>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Jeff King <peff@peff.net>,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Masanari Iida <standby24x7@gmail.com>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	Simon Cathebras <simon.cathebras@ensimag.imag.fr>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] add documentation to mw-to-git
References: <CAGycqjyzXg-FNrp8n9QFE8-uF=OecMyXgHerk_RERiMkpdoz9A@mail.gmail.com>
Date:	Tue, 05 Jul 2016 15:09:44 +0200
In-Reply-To: <CAGycqjyzXg-FNrp8n9QFE8-uF=OecMyXgHerk_RERiMkpdoz9A@mail.gmail.com>
	(Alexandru Zbarcea's message of "Mon, 4 Jul 2016 18:27:31 -0400")
Message-ID: <vpq7fd0jko7.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Tue, 05 Jul 2016 15:09:44 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u65D9hFT032269
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check:	1468328985.44989@yIlZBJNq7sTDnHoi46h1gg
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi, and thanks for your contribution.

Alexandru Zbarcea <alexz@apache.org> writes:

> Signed-off-by: Alexandru Zbarcea <alexz@apache.org>
> ---
>  contrib/mw-to-git/Makefile                 |  44 ++++++++++++-
>  contrib/mw-to-git/git-mediawiki.txt        | 100 +++++++++++++++++++++++++++++
>  contrib/mw-to-git/git-remote-mediawiki.txt |   7 --
>  3 files changed, 142 insertions(+), 9 deletions(-)

Git-Mediawiki did not contain any in-tree documentation, but already has a
user manual:

  https://github.com/moy/Git-Mediawiki/wiki/User-manual

I have no objection to moving the documentation in-tree (I even created
an issue a long time ago but never did it:
https://github.com/moy/Git-Mediawiki/issues/9 ). However, you patch
alone does not do that: it partly duplicates the existing user-manual,
and complements it with (useful) things that did not appear there (doc
for "git mw" and a recap of config variables). I think this is a step in
the wrong direction and I'd very much prefer a single documentation.

Two more things to know about Git-Mediawiki:

https://github.com/moy/Git-Mediawiki/issues/34
Move Git-Mediawiki's code out of git.git's contrib/

Essentially, having the code in git.git's contrib does not bring much
today, and reduces the number of potential contributors. There seems to
be a consensus to move it out of git.git and develop it separately.

One consequence is that asciidoc may not be the best choice as a markup
format. Having a format that renders directly on GitHub probably
overweights the benefit of using the same system as Git. GitHub can
render asciidoc, but needs *.asciidoc file names and won't read the
config file AFAIK.

https://github.com/moy/Git-Mediawiki/issues/33
Git-Mediawiki is looking for a new maintainer

Git-Mediawiki was a fun experience, but I'm not using it as much as I
planed, and my time budget for it approaches 0, so a new maintainer
would be very much welcome (typically to fix issue #34 above).

> +COMMANDS
> +--------
> +help::
> +    Display help information about git mw.
> +
> +preview::
> +    Parse and render local file into HTML. Preview a page without actually pushing it to the wiki.

Better write the commands completely like

git mw help::

to avoid ambiguity with git-remote-mediawiki (which is a separate
command).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
