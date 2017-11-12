Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A79DF201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 20:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751081AbdKLUsg (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 15:48:36 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:41244 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbdKLUsf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 15:48:35 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:58776 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eDzBD-0001xx-5T
        for git@vger.kernel.org; Sun, 12 Nov 2017 15:48:35 -0500
Date:   Sun, 12 Nov 2017 15:48:10 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: aesthetic standard for synopsis line of man pages?
Message-ID: <alpine.LFD.2.21.1711121537440.7324@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-472592034-1510519692=:7324"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-472592034-1510519692=:7324
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT


  yet more aesthetic nitpickery ... was just perusing the man pages of
both "git clean" and "git rm", and noticed some striking
inconsistency.

  from "man git-clean":

  SYNOPSIS
       git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...

note how, in that sypnosis, even those options that are represented by
both a short form option (-f) and a corresponding long form (--force)
use only the short form in the synopsis, i'm assuming for brevity,
which makes perfect sense.

  "man git-rm" is a different beast entirely, with a hodge podge of
short forms and long forms with no apparent pattern:

  SYNOPSIS
       git rm [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <file>...

  ... snip ...

  OPTIONS

       -f, --force
           Override the up-to-date check.

       -n, --dry-run
           Don¢t actually remove any file(s). Instead, just show if
           they exist in the index and would otherwise be removed by
           the command.

       -r
           Allow recursive removal when a leading directory name is
           given.

       --
           This option can be used to separate command-line options
           from the list of files, (useful when filenames might be
           mistaken for command-line options).

       --cached
           Use this option to unstage and remove paths only from the
           index. Working tree files, whether modified or not, will
           be left alone.

       --ignore-unmatch
           Exit with a zero status even if no files matched.

       -q, --quiet
           git rm normally outputs one line (in the form of an rm
           command) for each file removed. This option suppresses
           that output.


  the strangeness above?

1) the synopsis itself lists the alternatives "[-f | --force]", which
seems unnecessary, as both forms are listed under OPTIONS

2) this is followed by *only* the short form (-n) of --dry-run, so
that's inconsistent

3) the SYNOPSIS weirdly includes *only* the long form (--quiet) rather
than the short form (-q)

4) is it standard to explain the "--" separator in a man page? i
don't recall seeing that in any other man page, but maybe i wasn't
paying attention. it seems unnecessary.

  in short, "man git-clean" seems reasonable, while "man git-rm"
appears somewhat disorganized.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
--8323328-472592034-1510519692=:7324--
