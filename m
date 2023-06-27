Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20015EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 08:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjF0IVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 04:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjF0IVD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 04:21:03 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FDB173C
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 01:21:02 -0700 (PDT)
Received: (qmail 1520 invoked by uid 109); 27 Jun 2023 08:21:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jun 2023 08:21:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14931 invoked by uid 111); 27 Jun 2023 08:21:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jun 2023 04:21:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jun 2023 04:21:01 -0400
From:   Jeff King <peff@peff.net>
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, msuchanek@suse.de,
        sandals@crustytoothpaste.net, lessleydennington@gmail.com,
        me@ttaylorr.com, mjcheetham@github.com,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2] doc: gitcredentials: link to helper list
Message-ID: <20230627082101.GG1226768@coredump.intra.peff.net>
References: <pull.1538.git.1685303127237.gitgitgadget@gmail.com>
 <pull.1538.v2.git.1687332624780.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1538.v2.git.1687332624780.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 07:30:24AM +0000, M Hickford via GitGitGadget wrote:

> From: M Hickford <mirth.hickford@gmail.com>
> 
> Link to community list of credential helpers. This is useful information
> for users.
> 
> Describe how OAuth credential helpers work. OAuth is a user-friendly
> alternative to personal access tokens and SSH keys. Reduced setup cost
> makes it easier for users to contribute to projects across multiple
> forges.

Kind of seems like two topics in one patch, but OK.

I don't have much of an opinion on either topic, but...

> diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
> index 100f045bb1a..a266870a042 100644
> --- a/Documentation/gitcredentials.txt
> +++ b/Documentation/gitcredentials.txt
> @@ -104,6 +104,18 @@ $ git help credential-foo
>  $ git config --global credential.helper foo
>  -------------------------------------------
>  
> +=== Available helpers
> +
> +The community maintains a comprehensive
> +https://git-scm.com/doc/credential-helpers[list of Git credential helpers]
> +available.

I'd note that full hyperlinks like this are kind of lousy in the manpage
builds. You get:

     Available helpers
	The community maintains a comprehensive list of Git credential
	helpers[1] available.

in the text, and then way down at the bottom of the manpage:

  NOTES
	1. list of Git credential helpers
	   https://git-scm.com/doc/credential-helpers

Something like:

diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index fd5ecede13..1c7d302f18 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -106,9 +106,8 @@ $ git config --global credential.helper foo
 
 === Available helpers
 
-The community maintains a comprehensive
-https://git-scm.com/doc/credential-helpers[list of Git credential helpers]
-available.
+The community maintains a comprehensive list of Git credential helpers
+at https://git-scm.com/doc/credential-helpers.
 
 === OAuth
 

yields nicer text in the manpage, and asciidoc is smart enough to turn
it into a hyperlink in the html version.

-Peff
