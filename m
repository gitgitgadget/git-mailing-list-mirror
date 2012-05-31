From: Jeff King <peff@peff.net>
Subject: git version statistics
Date: Thu, 31 May 2012 07:48:02 -0400
Message-ID: <20120531114801.GA21367@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 13:48:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa3rU-0004er-0m
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 13:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017Ab2EaLsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 07:48:11 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:37771
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754625Ab2EaLsK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 07:48:10 -0400
Received: (qmail 20290 invoked by uid 107); 31 May 2012 11:48:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 May 2012 07:48:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 May 2012 07:48:02 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198884>

Just for fun, I've assembled a few statistics on git client versions
that hit github.com. These are collected from the http user-agent
strings provided by smart-http requests (we don't allow dumb http at all
these days, and the git protocol does not provide any version
information). It includes only the git/* entries (which are the vast
majority of clients hitting "info/refs?service=.*"; the second biggest
is JGit/*). And I counted each version only a single time from each IP
(so this would skew if you had a lot of clients behind a single IP;
their version would be counted only once).

Here are the results from the last few days:

  git/1.7.11.x |  0.1%   (0%) | 
  git/1.7.10.x | 21.1%  (21%) | **********************************
  git/1.7.9.x  | 11.4%  (32%) | ******************
  git/1.7.8.x  | 24.1%  (56%) | ****************************************
  git/1.7.7.x  | 12.2%  (68%) | ********************
  git/1.7.6.x  |  1.8%  (70%) | **
  git/1.7.5.x  |  8.2%  (78%) | *************
  git/1.7.4.x  |  7.2%  (86%) | ***********
  git/1.7.3.x  |  1.9%  (87%) | ***
  git/1.7.2.x  |  3.0%  (90%) | ****
  git/1.7.1.x  |  2.1%  (93%) | ***
  git/1.7.0.x  |  7.0%  (99%) | ***********
  git/1.6.6.x  |  0.0% (100%) | 

In this table, I've collapsed all of the x.y.z.* versions into a single
string to get an overview (a more detailed table is below). The first
percentage is the portion of the total requests; the second is a
cumulative portion (so, for example, 90% of clients are running v1.7.2.x
or higher, though only 3% are running v1.7.2.x itself).

Note that these numbers are skewed away from git versions lower than
v1.6.6, because that is when we added smart http support. Requests over
git:// or ssh are not included at all in these results.

For comparison, here's the same table from mid-September of 2011 (v1.7.7
was in -rc1 at the time):

  git/1.7.7.x |  0.2%   (0%) | 
  git/1.7.6.x | 19.3%  (19%) | *****************
  git/1.7.5.x |  8.0%  (27%) | *******
  git/1.7.4.x | 43.8%  (71%) | ****************************************
  git/1.7.3.x | 10.7%  (82%) | *********
  git/1.7.2.x |  4.9%  (86%) | ****
  git/1.7.1.x |  4.7%  (91%) | ****
  git/1.7.0.x |  8.2%  (99%) | *******
  git/1.6.6.x |  0.1% (100%) | 

So it seems that a large proportion of git users (or at least github
users) stay within a few versions of the most current. In both cases,
70% are within 4 major releases of the most recent version.

Here's a more detailed table (from recent data), showing individual
w.x.y.z versions:

  git/1.7.10.3 |  3.6%   (3%) | *******
  git/1.7.10.2 |  4.4%   (8%) | *********
  git/1.7.10.1 |  1.5%   (9%) | ***
  git/1.7.10   |  2.4%  (11%) | *****
  git/1.7.9.6  |  0.2%  (12%) | 
  git/1.7.9.5  |  9.2%  (21%) | *******************
  git/1.7.9.4  |  1.2%  (22%) | **
  git/1.7.9.3  |  0.3%  (22%) | 
  git/1.7.9.2  |  0.4%  (23%) | 
  git/1.7.9.1  |  0.4%  (23%) | 
  git/1.7.9    |  1.1%  (24%) | **
  git/1.7.8.6  |  0.3%  (25%) | 
  git/1.7.8.5  |  0.0%  (25%) | 
  git/1.7.8.4  |  0.7%  (25%) | *
  git/1.7.8.3  | 12.2%  (38%) | *************************
  git/1.7.8.2  | 18.8%  (56%) | ****************************************
  git/1.7.8.1  |  0.1%  (56%) | 
  git/1.7.8    |  0.3%  (57%) | 
  git/1.7.7.6  |  0.5%  (57%) | *
  git/1.7.7.4  |  0.2%  (57%) | 
  git/1.7.7.3  |  0.4%  (58%) | 
  git/1.7.7.2  |  0.1%  (58%) | 
  git/1.7.7.1  |  0.0%  (58%) | 
  git/1.7.7    |  0.7%  (59%) | *
  git/1.7.6.5  |  0.1%  (59%) | 
  git/1.7.6.4  |  0.2%  (59%) | 
  git/1.7.6.3  |  0.0%  (59%) | 
  git/1.7.6.1  |  0.5%  (59%) | *
  git/1.7.6    |  0.7%  (60%) | *
  git/1.7.5.4  | 10.9%  (71%) | ***********************
  git/1.7.5.3  |  0.1%  (71%) | 
  git/1.7.5.2  |  0.1%  (71%) | 
  git/1.7.5.1  |  0.2%  (71%) | 
  git/1.7.5    |  0.1%  (71%) | 
  git/1.7.4.5  |  0.4%  (72%) | 
  git/1.7.4.4  |  3.3%  (75%) | *******
  git/1.7.4.3  |  0.0%  (75%) | 
  git/1.7.4.2  |  0.0%  (75%) | 
  git/1.7.4.1  |  5.3%  (81%) | ***********
  git/1.7.4    |  0.2%  (81%) | 
  git/1.7.3.5  |  0.2%  (81%) | 
  git/1.7.3.4  |  1.2%  (82%) | **
  git/1.7.3.3  |  0.1%  (82%) | 
  git/1.7.3.2  |  0.4%  (83%) | 
  git/1.7.3.1  |  0.1%  (83%) | 
  git/1.7.3    |  0.1%  (83%) | 
  git/1.7.2.5  |  3.6%  (86%) | *******
  git/1.7.2.3  |  0.3%  (87%) | 
  git/1.7.2.2  |  0.1%  (87%) | 
  git/1.7.2.1  |  0.0%  (87%) | 
  git/1.7.2    |  0.1%  (87%) | 
  git/1.7.1.1  |  0.1%  (87%) | 
  git/1.7.1    |  2.8%  (90%) | ******
  git/1.7.0.6  |  0.0%  (90%) | 
  git/1.7.0.5  |  0.0%  (90%) | 
  git/1.7.0.4  |  7.0%  (97%) | **************
  git/1.7.0    |  2.6%  (99%) | *****
  git/1.6.6    |  0.0% (100%) | 

The interesting thing to me is how spiky it is, and where the spikes
fall. I would expect to see a spike around the highest maint release of
each major version (so v1.7.8.6, for example, with many fewer installs
of v1.7.8.5, v1.7.8.4, and so forth). But that's not what happens. The
most popular v1.7.8.x versions are .3 and .2, and hardly anybody
bothered to move to v1.7.8.6.

I can only assume these are skewed by some widely-used binary
distribution being locked onto particular versions (e.g., the spike at
v1.7.2.5 represents Debian stable).

If anybody has suggestions for other interesting analyses to perform,
let me know.

-Peff
