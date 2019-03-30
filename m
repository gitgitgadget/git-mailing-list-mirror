Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE76220248
	for <e@80x24.org>; Sat, 30 Mar 2019 18:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbfC3SaR (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 14:30:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56008 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbfC3SaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 14:30:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 93EDD45D5A;
        Sat, 30 Mar 2019 14:30:12 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=9o7ikzeitQvEde/i1UkUEBkgn
        AA=; b=FdupqxJB23BAweDRxa6VUzbCiB6yfe6ltb7+mEjKrf5BDkEHG8ZMCU4DP
        6WfQpeem9EQsQ0RGhrQxBQaSgOVlEBWoEg6HdEcxfFP+QVs8sLyCMXH7l8q3NVzz
        5F3m9ZaA5+NlQ5Ld3Rry4GUO+vsrWQ5DO4wNe0rebbv8Nbqomw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=sFtyV8LT7PNyfp8hLED
        VUaJpieEj7EHdfHcPSynLAjoMBplFqDsA2WOFzSmMfMo2HOHfMfhfNQpK45AtpGr
        PGjB/FSNKZ76T/SPqarIg9X/dAuaLAq6vMzkT2cUonSVjTJb5vw1OfWgX6X+4c/T
        MpWeCfohfKSgGsy+Bl7V/Shk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8DD3745D58;
        Sat, 30 Mar 2019 14:30:12 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0EADF45D53;
        Sat, 30 Mar 2019 14:30:06 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v1 1/2] Documentation/rev-list-options: wrap --date=<format> block with "--"
Date:   Sat, 30 Mar 2019 14:30:00 -0400
Message-Id: <20190330183001.16624-2-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190330183001.16624-1-tmz@pobox.com>
References: <20190330183001.16624-1-tmz@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: D8A2A94C-5319-11E9-BC1E-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using "+" to continue multiple list items is more tedious and
error-prone than wrapping the entire block with "--" block markers.

When using asciidoctor, the list items after the --date=3Diso list items
are incorrectly formatted when using "+" continuation.  Use "--" block
markers to correctly format the block.

When using asciidoc there is no change in how the content is rendered.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

The issue this fixes can be seen in the git-log and git-rev-list docs on
git-scm.com:

https://git-scm.com/docs/git-log#Documentation/git-log.txt---dateltformat=
gt
https://git-scm.com/docs/git-rev-list#Documentation/git-rev-list.txt---da=
teltformatgt

 Documentation/rev-list-options.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-=
options.txt
index ca959a7286..7b415dff82 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -805,12 +805,13 @@ include::pretty-options.txt[]
 	author's). If `-local` is appended to the format (e.g.,
 	`iso-local`), the user's local time zone is used instead.
 +
+--
 `--date=3Drelative` shows dates relative to the current time,
 e.g. ``2 hours ago''. The `-local` option has no effect for
 `--date=3Drelative`.
-+
+
 `--date=3Dlocal` is an alias for `--date=3Ddefault-local`.
-+
+
 `--date=3Diso` (or `--date=3Diso8601`) shows timestamps in a ISO 8601-li=
ke format.
 The differences to the strict ISO 8601 format are:
=20
@@ -818,15 +819,14 @@ The differences to the strict ISO 8601 format are:
 	- a space between time and time zone
 	- no colon between hours and minutes of the time zone
=20
-+
 `--date=3Diso-strict` (or `--date=3Diso8601-strict`) shows timestamps in=
 strict
 ISO 8601 format.
-+
+
 `--date=3Drfc` (or `--date=3Drfc2822`) shows timestamps in RFC 2822
 format, often found in email messages.
-+
+
 `--date=3Dshort` shows only the date, but not the time, in `YYYY-MM-DD` =
format.
-+
+
 `--date=3Draw` shows the date as seconds since the epoch (1970-01-01
 00:00:00 UTC), followed by a space, and then the timezone as an offset
 from UTC (a `+` or `-` with four digits; the first two are hours, and
@@ -835,28 +835,28 @@ with `strftime("%s %z")`).
 Note that the `-local` option does not affect the seconds-since-epoch
 value (which is always measured in UTC), but does switch the accompanyin=
g
 timezone value.
-+
+
 `--date=3Dhuman` shows the timezone if the timezone does not match the
 current time-zone, and doesn't print the whole date if that matches
 (ie skip printing year for dates that are "this year", but also skip
 the whole date itself if it's in the last few days and we can just say
 what weekday it was).  For older dates the hour and minute is also
 omitted.
-+
+
 `--date=3Dunix` shows the date as a Unix epoch timestamp (seconds since
 1970).  As with `--raw`, this is always in UTC and therefore `-local`
 has no effect.
-+
+
 `--date=3Dformat:...` feeds the format `...` to your system `strftime`,
 except for %z and %Z, which are handled internally.
 Use `--date=3Dformat:%c` to show the date in your system locale's
 preferred format.  See the `strftime` manual for a complete list of
 format placeholders. When using `-local`, the correct syntax is
 `--date=3Dformat-local:...`.
-+
+
 `--date=3Ddefault` is the default format, and is similar to
 `--date=3Drfc2822`, with a few exceptions:
-
+--
 	- there is no comma after the day-of-week
=20
 	- the time zone is omitted when the local time zone is used
