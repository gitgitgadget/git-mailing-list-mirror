Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D04CA1FC96
	for <e@80x24.org>; Sat, 26 Nov 2016 12:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbcKZMWx (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Nov 2016 07:22:53 -0500
Received: from mout.gmx.net ([212.227.17.20]:53382 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751154AbcKZMWu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2016 07:22:50 -0500
Received: from virtualbox ([37.24.142.44]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNw0t-1c4GDN4ACh-007RMs; Sat, 26
 Nov 2016 13:22:31 +0100
Date:   Sat, 26 Nov 2016 13:22:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming
 builtin
In-Reply-To: <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1611261320050.117539@virtualbox>
References: <cover.1479938494.git.johannes.schindelin@gmx.de> <cover.1480019834.git.johannes.schindelin@gmx.de> <3a10fd72cf336743891d6bc9a003cfeb5c3f0063.1480019834.git.johannes.schindelin@gmx.de> <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611242211450.117539@virtualbox> <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net> <alpine.DEB.2.20.1611251201580.117539@virtualbox> <20161125171940.rizbqyhsygdsoujr@sigill.intra.peff.net> <alpine.DEB.2.20.1611251841030.117539@virtualbox>
 <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:a4VPERVLp3yug9FFb/n28fGWSxgx9ZoH3usSAAorPRSGKqwbqQB
 gboxD7OBQUrUYgenwlWCO3ZqVhhRVd8kT1J/0N05iqPCglu8VEpfO5dAgceNbfbWMt/fX9J
 ielk4NMQwkCEfkoOiuxbIX5tl9lkDMumCHu/mH7BJrQSzV/abvzfiJfg5jQSp4cbtGUF7CO
 f/Ttxlsz9vMFOFCLXVXCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GRa7gUm3E+0=:yWa71OAqYmbCGsq+pwJSSx
 RaB7MSBngrZW57q8vaOF5lwdkp8ewqbCTWCyMZYv3JsQVPyom6WmF5Djlg5qmHy5swLPnomUt
 hyG4v5sKLEoIkuqRUJy3Arm4Hd2ya5eVKHnub7uBILYIFVnv9X9izhIdUubpPHSvFTDNULPE1
 m/HFk1jHPt/heWvy7pthKyVW5K55O9jlQwDDRiNaFDymcUmTwqEr0GJejI6LIGQnhQ/wFnq81
 epIGc34MpDYvOYgkG+7Ixkve0NYd4PYZV5k05EtkSBh0Pe7dHyrn2Q+c47a6myTRqv7ieEz4d
 W+EMr7VlK3jmpgLmzqC4ozuGWahjM3Wnp3NXlI1Ickl33YdxrpFv9HH5u4lM65rMAWt8TSDWJ
 8oAb/Vj4YY5ekRs+3ofbG9WYNH6Ir6A/p1uqYaf7TJ22L/m+X++JLtNfv1C78kTG/THr2QlL5
 Nk++aoD0D4uTCUOZ1ZM+Lwt/9ApEPKlXEM7KEWgC2RV7saxlGP+XAhAmhzQt/IAZNHzmT4Vbt
 wCJ8vWHCetHwOK4IJJS8YDeTRrmK79kBub5095giGK6EX6UCv0EeTMZCIN/MLrmN/mI4VRzC1
 ddOd9R541dI7j+F0EzYDmqOnsERjIeSXJwLr8S5nLw6lDaTFaZJKjdDBYn/OrwEqjC7HVE3Sg
 j/STV42Sd/DwxwvUZfWkmbPYXZWWtDa1oMdaxLcsN5TiHvhBF2MvtCywOJCT3PmTT1yxybTCI
 tjdzdKA3kWwnZEB0xBa7Y1JkjRD7zDlgbZc/cSKSoxGiN7G9UP70ntri8o3C17kSrT+23tYY/
 FQq9azm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 25 Nov 2016, Jeff King wrote:

> On Fri, Nov 25, 2016 at 06:41:23PM +0100, Johannes Schindelin wrote:
> 
> > > Ah, I didn't realize that was a requirement. If this is going to be part
> > > of a release and real end-users are going to see it, that does make me
> > > think the config option is the better path (than the presence of some
> > > file), as it's our standard way of tweaking run-time behavior.
> > 
> > So how do you easily switch back and forth between testing the old vs the
> > new difftool via the test suite?
> 
> If it's for a specific tool, I'd consider teaching the test suite to run
> the whole script twice: once with the flag set and once without.
> 
> That is sometimes more complicated, though, if the script creates many
> sub-repos. An environment variable might be more natural. If you already
> support flipping the default via config, you can probably do:
> 
>   GIT_CONFIG_PARAMETERS="'difftool.usebuiltin=true'"
>   export GIT_CONFIG_PARAMETERS

Except that that does not work, of course. To figure out why, apply this
diff:

-- snip --
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 17f3008277..27159f65f3 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -10,6 +10,9 @@ Testing basic diff tool invocation
 
 . ./test-lib.sh
 
+echo "config $(git config difftool.usebuiltin)." >&2
+exit 1
+
 difftool_test_setup ()
 {
 	test_config diff.tool test-tool &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9980a46133..0ddeded92b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -86,6 +86,7 @@ EDITOR=:
 # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
 # deriving from the command substitution clustered with the other
 # ones.
+echo "before $(git config difftool.usebuiltin)." >&2
 unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
 	my @env = keys %ENV;
 	my $ok = join("|", qw(
@@ -104,6 +105,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e
'
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
 ')
+echo "after $(git config difftool.usebuiltin)." >&2
 unset XDG_CONFIG_HOME
 unset GITPERLLIB
 GIT_AUTHOR_EMAIL=author@example.com
-- snap --

and then weep at this output:

GIT_CONFIG_PARAMETERS="'difftool.usebuiltin=true'"; export GIT_CONFIG_PARAMETERS; bash t7800-difftool.sh -i -v -x
before true.
after .
Initialized empty Git repository in
/home/virtualbox/git/git-for-windows/t/trash
directory.t7800-difftool/.git/
config .
FATAL: Unexpected exit with code 1

In other words, GIT_CONFIG_PARAMETERS is *explicitly scrubbed* from the
environment when we run our tests (by the code block between the "before"
and the "after" statements in the diff above).

Ciao,
Dscho
