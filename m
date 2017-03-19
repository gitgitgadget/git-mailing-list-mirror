Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC02420323
	for <e@80x24.org>; Sun, 19 Mar 2017 14:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbdCSOnv (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 10:43:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35040 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbdCSOns (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 10:43:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id z133so10454484wmb.2
        for <git@vger.kernel.org>; Sun, 19 Mar 2017 07:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ozmhaq+reCO1HoR/n7zCriMPsL6N861gwQWaoaoB0+k=;
        b=KIV+LvRp7T7C+4l0GWDK3zo9azYlmdQrz3t7uo4xtkda6Ho7BS7rOfV2n1IPZ/HKXd
         l658B/KwcbRDFBii+Nr67BZqUScPOo4WaC1wpSwhFS2Zj89lBs9G5OSbhQpNwZdl3iyw
         uoLzuSVXgmdADKiD0KiBCq7vJYY3iMmCknv9psUXtzer0Ivo6xUzqyFL0ribo1+0rkML
         AW5ez3hIbrPyICLtWXmFsMzB81Ek98Vt/n4eaZ3xHWKQbTvYlYx3gSsv6V0wSHSYD1cl
         CRotBed0oQ6DJU/TIVRNObrTg4z6DmQCa2vrVvNndW0Rp7PBN4sjvjaS2W5hzjFtHRVv
         1wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ozmhaq+reCO1HoR/n7zCriMPsL6N861gwQWaoaoB0+k=;
        b=bRogyu8rfpAhjY/k+KIGLw+B79lYYV6t4zeboETqRDkGuDmFhOkdHVUEr5AGtTQPIo
         oOqM2vOQdmI9gJJZRmEfYSWXCZ/0aMIfaOn30NW7DagyKEAgZWJWJrs5zzg6ksiOVPg4
         Wr5dz2/pmlrtk1MszEJpHYlTpNwL9XzXXB5Jm4ayhTZJXUKOZzty9b3eWXbACjEyje4a
         uCNqQe8xoJ72xBN09VReCBDsRQHhH+O2rUubWxXdeHhxir0SIqxkxtQBEfeISp8jzZur
         IMfmKlpk0we28/nqUNLNq5pXF6R9EKG8irivX6+ZNEnp3JQBR/iSQe+A/s5DXopuM4Bs
         EYJw==
X-Gm-Message-State: AFeK/H3AbFA+oCnbYsM1wtusa+cyJ6PgN6TmCZXGXZ10Z1UcVI+Ev+Fe5ZMSXsE1aQ1G5Q==
X-Received: by 10.28.107.13 with SMTP id g13mr5338439wmc.117.1489934215156;
        Sun, 19 Mar 2017 07:36:55 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 134sm7960705wmj.6.2017.03.19.07.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Mar 2017 07:36:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johan Herland <johan@herland.net>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] push: Re-include "push.default=tracking" in the documentation
Date:   Sun, 19 Mar 2017 14:36:36 +0000
Message-Id: <20170319143636.23810-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <xmqqint5l4i9.fsf@gitster.mtv.corp.google.com>
References: <xmqqint5l4i9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the documentation for push.tracking=* to re-include a mention
of what "tracking" does.

The "tracking" option was renamed to "upstream" back in
53c4031 ("push.default: Rename 'tracking' to 'upstream'", 2011-02-16),
this section was then subsequently rewritten in 87a70e4 ("config doc:
rewrite push.default section", 2013-06-19) to remove any mention of
"tracking".

Maybe we should just warn or die nowadays if this option is in the
config, but I had some old config of mine use this option, I'd
forgotten that it was a synonym, and nothing in git's documentation
mentioned that.

That's bad, either we shouldn't support it at all, or we should
document what it does. This patch does the latter.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Thu, Oct 6, 2016 at 8:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Sorry, I wasn't paying attention to this thread.

And neither was I it would appear, and for a much longer time...

> It seems that 87a70e4ce8 ("config doc: rewrite push.default
> section", 2013-06-19) removed that mention by accident?  The log
> message of the commit does not say it actively wanted to remove
> mention of `tracking` and/or why it wanted to do so, so I agree that
> resurrecting that parenthetical mention is the easiest course of
> action at this point.
>
> However.
>
> With today's description of push.default choices, each of which is a
> full fledged paragraph, I no longer have the objection I had in
>
>     https://public-inbox.org/git/7vip6dgmx2.fsf@alter.siamese.dyndns.org/
>
> against having `tracking` as a separate bullet item.  If we add
>
>     * `tracking` - a deprecated synonym for `upstream`; do not use this.
>
> to today's list, it would stand out as something different from
> others and it will not cause the confusion I feared in the
> discussion we had in early 2013.  As Jonathan Nieder argued in the
> thread back then, having it as one of the bullet point would help
> people locate it without using "search" \C-s or / feature.

Makes senes. Here's a re-send that fixes this. I slighly changed the
wording you suggested to be consistent with the other existing cases
in config.txt:
    
    5 matches for "eprecated.*for" in buffer: config.txt
       2328:	This is a deprecated synonym for `repack.writeBitmaps`.
       2462:* `tracking` - This is a deprecated synonym for `upstream`.
       2813:	Deprecated alias for 'sendemail.smtpEncryption = ssl'.
       2853:	Deprecated alias for `sendemail.signedoffbycc`.
       3180:	Deprecated alias for `versionsort.suffix`.  Ignored if

 Documentation/config.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index eccc012672..988659e16c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2459,6 +2459,8 @@ push.default::
   pushing to the same repository you would normally pull from
   (i.e. central workflow).
 
+* `tracking` - This is a deprecated synonym for `upstream`.
+
 * `simple` - in centralized workflow, work like `upstream` with an
   added safety to refuse to push if the upstream branch's name is
   different from the local one.
-- 
2.11.0

