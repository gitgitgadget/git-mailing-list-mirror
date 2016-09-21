Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 436691F935
	for <e@80x24.org>; Wed, 21 Sep 2016 22:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756253AbcIUWpU (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 18:45:20 -0400
Received: from sdaoden.eu ([217.144.132.164]:39310 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756237AbcIUWpT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 18:45:19 -0400
Received: by sdaoden.eu (Postfix, from userid 1000)
        id 25E0C1604A; Thu, 22 Sep 2016 00:45:15 +0200 (CEST)
Date:   Thu, 22 Sep 2016 00:46:16 +0200
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: v2.10.0: ls-tree exit status is always 0, this differs
 from ls(1)
Message-ID: <20160921224616.GuR6adBwB%steffen@sdaoden.eu>
References: <20160921132655.h49HMsHbp%steffen@sdaoden.eu>
 <xmqqr38d9ova.fsf@gitster.mtv.corp.google.com>
 <20160921194004.QOizfyGm8%steffen@sdaoden.eu>
 <xmqqeg4d6l7k.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqeg4d6l7k.fsf@gitster.mtv.corp.google.com>
Mail-Followup-To: Steffen Nurpmeso <steffen@sdaoden.eu>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
User-Agent: s-nail v14.9.0-pre1-42-g7211cd5
OpenPGP: id=95F382CE;
 url=https://www.sdaoden.eu/downloads/steffen.asc
X-BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors
 in the world can make no bugs.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
 |Steffen Nurpmeso <steffen@sdaoden.eu> writes:
 ...
 |Sorry, but I did not notice that there was an attached patch when I
 |was reading your response for the first time.  Risk of using an
 |attachment to e-mail ;-)
 |
 |I think this issue does not need a separate bullet point.  The
 |existing text says:
 ..
 |and what caused your surprise is already covered by the first bullet
 |point, if the reader knows what "patterns to match" means in Git's
 |command line tools; it just needs to be extended to be more
 |meaningful to those who don't, I think.
 |
 |How about rewriting the first bullet point like so instead:
 |
 |  - the behaviour is different from that of "/bin/ls" in that the
 |    '<path>' are actually patterns to match, e.g. so specifying
 |    directory name (without `-r`) will behave differently, the order
 |    of the arguments does not matter, and a '<path>' argument that
 |    does not match any path is not an error (i.e. if there is no
 |    path that matches any pattern, nothing is shown in the output).

Not an error would have been an enlightenment to me.

But now i'm even getting nervous to read about patterns.
We have patterns for tags/remotes/branches, author/committer/grep
patterns, (most of those, maybe all today, with fixed string,
extended or basic regex), the git-grep patterns ("leading paths
match and glob(7) patterns are supported").  Is that all?
I would assume glob-style for ls-tree:

  ?0[steffen@wales ]$ git ls-tree HEAD `ls mime*`
  100644 blob ee47419c209da789b606ab6d979c22f4ae632712    mime.c
  100644 blob 0cfe3766bd5f035eac06b728a4f63224455e13ca    mime.types
  100644 blob 7d890df7553522691ed09f266ea7f9effb6a2f4e    mime_enc.c
  100644 blob 430e300d9a8887c5cd48d1cc63034168e47e9721    mime_param.c
  100644 blob 0338a46d3247ea00b5bcedb2d82ff30fe5d18d48    mime_parse.c
  100644 blob d62fa8defae27240a5ce81ad2239dd7f94b6c5c5    mime_types.c
  ?0[steffen@wales ]$ git ls-tree HEAD 'mime*'
  ?0[steffen@wales ]$ git ls-tree HEAD 'mime.*'

No, ls-tree is not part of what i use every day, "Git's command
line tools" is (too) wide afield, in that sense.

Thank you (also in general, for git), and ciao from a country with
a pretty real autumn,

--steffen
