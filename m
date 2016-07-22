Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56F53203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 20:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbcGVUVj (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 16:21:39 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33508 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbcGVUVi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 16:21:38 -0400
Received: by mail-it0-f67.google.com with SMTP id d65so3754416ith.0
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 13:21:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=28yskVGDnAopYP5kSmjXkBFfQyVdcmQwCiA6wY1GRwQ=;
        b=tVY7dTMepI3b3JJda6HO7Z3z0uZe0qzfHOEIOVhMiisWLoEYMwlYCDn82/VrREFyfI
         VGQ07bv732tbEDLfAdZCoeFF0BD+2amJADrrRtsyXRxx6w3gwg1gW4EoEioDyPs5GB1l
         C7t5s0nFLy4mZhod3kHorCSiCm0uzJpklWyQWwQIZbfdNDXMbCDTn2moejl2zlZDDhLY
         eQg9eqoIE7E9XSEvMN2spZgdYtsu/E0O28XZPxcTvvlVxi/MOOC8IwDZa3G1pjyfpEfi
         t1/R5ZTfxsu+cPUWJw1ocPXWVLP5w38U4t8QWgxWnxs5WQdcBa4xQ4FoWbVDKWBc3S1W
         yVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=28yskVGDnAopYP5kSmjXkBFfQyVdcmQwCiA6wY1GRwQ=;
        b=LW9Psxn49GRlZ5XfIx/40wm6xblPRxpVqtvYPOKFLTd0HjcW3sgjzYaCMszz2+sY+7
         XAZ8pZUnjvsSuV3L4L1JpCJBz1kz/UJouNClmUxm1o4ojTRS0JZNKsXcKJm9limWzo4H
         4h7CBPzYbdQLVY2YoMfefqcBXZuDklNuLUE0/ipmCsEZEUeFM+5Fw9868JvLBQHTdDKz
         I6tnw1m9pX4g5ezZBmg3atdBpE87nMIoqjBTQ6epi9ogehcxeBfcaqPI/D3g4WiQ3tba
         JUTRgzhcUWDp/hxLC+b2zNxY5uQvt35E/uUVBAjWCCeEI9jqBYY8w3mmL6CGSJsJTCHs
         045w==
X-Gm-Message-State: ALyK8tKNDDAVDm2O58YJuduBj4sbLBg+NW4RT6qYM/sdIKh0hJBuuN80lSI3/ZpP7uIN1M1brVIzb76Wv4SN0Q==
X-Received: by 10.36.73.70 with SMTP id z67mr76748499ita.33.1469218896799;
 Fri, 22 Jul 2016 13:21:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.10.97 with HTTP; Fri, 22 Jul 2016 13:21:36 -0700 (PDT)
In-Reply-To: <xmqqwpkda71x.fsf@gitster.mtv.corp.google.com>
References: <CAOiOGAfWfEy60qg3AbbPNqkvJDMsXBHY8ZSXBCKJYha_gDB8mw@mail.gmail.com>
 <xmqqwpkda71x.fsf@gitster.mtv.corp.google.com>
From:	Parker Moore <parkrmoore@gmail.com>
Date:	Fri, 22 Jul 2016 13:21:36 -0700
Message-ID: <CAOiOGAdV0+bg+=RAFgJyWFmdzZpB6KabGMN8Z57KTqqos3aTfg@mail.gmail.com>
Subject: Re: [PATCH] contrib/persistent-https: use Git version for build label
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> We tend to avoid catting a single file only to pipe the result into a different command

You got it. Here's a new patch:

From 432c0054a28a6c91b9fc1d9b53714061cb3d903c Mon Sep 17 00:00:00 2001
From: Parker Moore <parkrmoore@gmail.com>
Date: Wed, 20 Jul 2016 18:33:28 -0600
Subject: [PATCH] contrib/persistent-https: use Git version for build label

The previous method simply used the UNIX timestamp of when the binary was
built as its build label.

    $ make && ./git-remote-persistent-http -print_label
    1469061546

This patch aims to align the label for this binary with the Git version
contained in the GIT-VERSION-FILE. This gives a better sense of the version
of the binary as it can be mapped to a particular revision or release of
Git itself. For example:

    $ make && ./git-remote-persistent-http -print_label
    2.9.1.275.g75676c8

Discussion of this patch is available on a related thread in the mailing
list surrounding this package called "contrib/persistent-https: update
ldflags syntax for Go 1.7+". The gmane.org link is:
http://article.gmane.org/gmane.comp.version-control.git/299653/

Signed-off-by: Parker Moore <parkrmoore@gmail.com>
---
 contrib/persistent-https/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/persistent-https/Makefile
b/contrib/persistent-https/Makefile
index 92baa3b..9da1779 100644
--- a/contrib/persistent-https/Makefile
+++ b/contrib/persistent-https/Makefile
@@ -12,7 +12,7 @@
 # See the License for the specific language governing permissions and
 # limitations under the License.

-BUILD_LABEL=$(shell date +"%s")
+BUILD_LABEL=$(shell cut -d" " -f3 ../../GIT-VERSION-FILE)
 TAR_OUT=$(shell go env GOOS)_$(shell go env GOARCH).tar.gz

 all: git-remote-persistent-https git-remote-persistent-https--proxy \
-- 
2.9.2
