Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB3A01F45F
	for <e@80x24.org>; Wed,  8 May 2019 10:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfEHKqG (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 06:46:06 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:44537 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfEHKqG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 06:46:06 -0400
Received: by mail-ed1-f43.google.com with SMTP id b8so21606088edm.11
        for <git@vger.kernel.org>; Wed, 08 May 2019 03:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Uq7pXYc+9KMZU6NRfMZaffoWvxTGFzkO6etEL+iRzz4=;
        b=PMUN5l8i4DtTZgmGpUq8UnfScilc+rD+ZNEk3y0HG3fyo/dNEDpXJe/GPnOLaGCyCK
         hkqa9hrcyQCE+H5VPKVuh9kNQ2T2uE0Y+GO/Nwwbz3hLa7uh2MjbS+YPFyBXnoKlP3FD
         ybcVMMYM+IbxIBHu+Z4yo5yuL72eSNvb4si1emSEjBYnAaI08UVMIopACpqG009Kkems
         YSCB/E2H4MpXKnrzzBXL/io6EuqMu87toSjMtl9M5MlwFn5MzfllKY9pE9X2coEtADR3
         3VOXWTsXkDzCT+PhSgVlTYeAGSMs4TPmUuDBlXp3S7crvseSC0fj7ZowUeWC8fn4htHt
         hf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Uq7pXYc+9KMZU6NRfMZaffoWvxTGFzkO6etEL+iRzz4=;
        b=pQov3w362rBtcmpnHxxNQQTbEVlQ+RY+KpkCxGGx1E5zFE5ulEverzze2eba2IbRys
         GmdIZ+plxTA6ipbci/OfPovSvNjqKqAP3ORaI52oDtpV5+5QjJ4xcYXUVLOlV+/t6y4m
         fey/SC5hUZggTSijtODk8YGXO0U+JtjEwtRBlZQnu9SpTZgnXAWlRRV2FoWpFhhv4oaf
         knlIDp+STCHKiFwJP7AmlCiU2sVwbktpp3F37d7LvO4nCU6wov2Z3T4KxlBvjN+PAnqc
         XGHw/Eqt394Ym2jHdL/YgqueDuuRgdVEh0Ivj4D8LA5o6kYms5SfHPkVYd9158IUXeCk
         QUrw==
X-Gm-Message-State: APjAAAWMzr74MKKlw50Jq5YlOjgDFUD1PkU3Z7qA6aw4VqZQFxs45zvr
        o7NHb1jPPOvUdKGGqVb+K+A1ShpCTF7wbD/KUuNYFUl7olUpG/vk
X-Google-Smtp-Source: APXvYqxvFVOUSRYJub9xEwGO36WkT35rZtgf4xkrBjOr72SiZ03skxPT4785reZNGjufrLD0cMksGinIAw1coyTfmdc=
X-Received: by 2002:a50:c942:: with SMTP id p2mr37469090edh.39.1557312364373;
 Wed, 08 May 2019 03:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.59.git.gitgitgadget@gmail.com> <pull.59.v2.git.gitgitgadget@gmail.com>
 <bcbffa141116f869db40e4572f9824a3d090c20c.1541026721.git.gitgitgadget@gmail.com>
In-Reply-To: <bcbffa141116f869db40e4572f9824a3d090c20c.1541026721.git.gitgitgadget@gmail.com>
From:   Git Gadget <gitgitgadget@gmail.com>
Date:   Wed, 8 May 2019 12:45:53 +0200
Message-ID: <CANg4QoEPWcnPpbUYcgR4PmECzjCOmroAmH2fMoX-vhw+W_dVnQ@mail.gmail.com>
Subject: Fwd: [PATCH v2 1/1] diff-highlight: Use correct /dev/null for UNIX
 and Windows
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        chris <chris@webstech.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Forwarding this mail to the Git mailing list, as the original did not
make it there (for reasons unknown).

---------- Forwarded message ---------
From: Chris. Webster via GitGitGadget <gitgitgadget@gmail.com>
Date: Wed, Oct 31, 2018 at 11:58 PM
Subject: [PATCH v2 1/1] diff-highlight: Use correct /dev/null for UNIX
and Windows
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Chris. Webster <chris@webstech.net>


From: "Chris. Webster" <chris@webstech.net>

Use File::Spec->devnull() for output redirection to avoid messages
when Windows version of Perl is first in path.  The message 'The
system cannot find the path specified.' is displayed each time git is
run to get colors.

Signed-off-by: Chris. Webster <chris@webstech.net>
---
 contrib/diff-highlight/DiffHighlight.pm | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/diff-highlight/DiffHighlight.pm
b/contrib/diff-highlight/DiffHighlight.pm
index 536754583b..7440aa1c46 100644
--- a/contrib/diff-highlight/DiffHighlight.pm
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -4,6 +4,11 @@ use 5.008;
 use warnings FATAL => 'all';
 use strict;

+# Use the correct value for both UNIX and Windows (/dev/null vs nul)
+use File::Spec;
+
+my $NULL = File::Spec->devnull();
+
 # Highlight by reversing foreground and background. You could do
 # other things like bold or underline if you prefer.
 my @OLD_HIGHLIGHT = (
@@ -134,7 +139,7 @@ sub highlight_stdin {
 # fallback, which means we will work even if git can't be run.
 sub color_config {
        my ($key, $default) = @_;
-       my $s = `git config --get-color $key 2>/dev/null`;
+       my $s = `git config --get-color $key 2>$NULL`;
        return length($s) ? $s : $default;
 }

--
gitgitgadget
