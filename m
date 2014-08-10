From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] checkpatch: Add test for commit id formatting style in
 commit log
Date: Sun, 10 Aug 2014 14:28:01 -0700
Message-ID: <1407706081.4082.21.camel@joe-AO725>
References: <20140702130210.fd40d67f0819cfb5f3e9e5ca@linux-foundation.org>
	 <1404331746.14624.95.camel@joe-AO725>
	 <20140702131534.c613f55f79519b3862f79e40@linux-foundation.org>
	 <1404338448.14741.8.camel@joe-AO725>
	 <CAMuHMdV1TXLmuAofwrUuT-KKUfkEYdXsM34VRrfhB6FxXfdeeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-From: linux-kernel-owner@vger.kernel.org Sun Aug 10 23:28:38 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1XGafO-0006Td-49
	for glk-linux-kernel-3@plane.gmane.org; Sun, 10 Aug 2014 23:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbaHJV2I (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 10 Aug 2014 17:28:08 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:55159 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751224AbaHJV2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2014 17:28:06 -0400
Received: from filter.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtprelay05.hostedemail.com (Postfix) with ESMTP id 04831268E17;
	Sun, 10 Aug 2014 21:28:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:800:960:968:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3165:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:4605:5007:6119:6691:7522:7652:7903:9010:9121:10004:10400:10483:10848:11026:11232:11658:11914:12043:12050:12296:12517:12519:12555:12663:12740:13071:13161:13229:14093:14097:19901:19997:21060:21067:21080,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:1:0
X-HE-Tag: watch43_c16ab9cb601f
X-Filterd-Recvd-Size: 4193
Received: from [192.168.1.162] (pool-71-103-235-196.lsanca.fios.verizon.net [71.103.235.196])
	(Authenticated sender: joe@perches.com)
	by omf11.hostedemail.com (Postfix) with ESMTPA;
	Sun, 10 Aug 2014 21:28:02 +0000 (UTC)
In-Reply-To: <CAMuHMdV1TXLmuAofwrUuT-KKUfkEYdXsM34VRrfhB6FxXfdeeg@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255106>

On Sun, 2014-08-10 at 23:08 +0200, Geert Uytterhoeven wrote:
> Hi Joe,

Hi Geert.

> On Thu, Jul 3, 2014 at 12:00 AM, Joe Perches <joe@perches.com> wrote:
> > Commit logs have various forms of commit id references.
> >
> > Try to standardize on a 12 character long lower case
> > commit id along with a description of parentheses and
> > the quoted subject line
> >
> > ie: commit 0123456789ab ("commit description")
> 
> Now this is in mainline, checkpatch starts complaining about my "too long"
> (40 chars) commit IDs in commit messages :-(
> 
> 40 chars may be too long (but it's quick to copy-and-paste, as "git show"
> shows that by default), but 12 sounds a bit short, as that's only 48 bits.

Right now, this test allows 12 to 16 byte length commit ids
without emitting a warning.

Andrew wanted this test, I don't care how long the commit id
is in the commit log.

> According to the Birthday Paradox (en.wikiipedia.org/wiki/Birthday_problem),
> there's a probability of 50% of a collision if you use 48 bits IDs in a
> repository with ca. 16 milion (2^24) objects. A Linux kernel repository
> counts ca. 4 million objects, so we're getting close...
> 
> So soon we'll get "error: short SHA1 is ambiguous".
> 
> BTW, is there actually an easy way to make "git show" show all options for
> an ambiguous SHA1?

Not so far as I know, but I'm nothing like a git expert.

The script I used before adding this to checkpatch was:

$ cat format_commit.sh 
#!/bin/bash

regex1="^error: short SHA1 $1 is ambiguous\."
regex2="fatal: ambiguous argument '$1': unknown revision or path not in the working tree\."

tmp=$(mktemp --tmpdir format_commit.XXXXXXXXXXXXX)

git log --format='%H ("%s")' -1 $1 > $tmp 2>&1

read line < $tmp

rm -f $tmp

if [[ $line =~ $regex1 ]] ; then
    echo "checking commits $1..."
    git rev-list --remotes | grep -i "^$1" |
    while read line ; do
        git log --format='%H ("%s")' -1 $line | 
        echo "commit $(cut -c 1-12,41-)"
    done
elif [[ $line =~ $regex2 ]] ; then
    echo "No matching commit"
    exit 1
else
    echo "commit $(echo $line | cut -c1-12,41-)"
fi

exit 0
$

so that using "$ format_commit.sh 1234" looks
at _all_ the commit references by using git rev-list
then greps that output for the matches, but it is
darn slow...

$ time ./format_commit.sh 1234
checking commits 1234...
commit 1234351cba95 ("xfs: introduce xlog_copy_iovec")
commit 1234471e2d11 ("perf header: Fix numa topology printing")
commit 1234f4bada54 ("hwrng: Kconfig: remove dependency for atmel-rng driver")
commit 12340313cf94 ("MAINTAINERS: add new cgroup list to CC notice")
commit 12346037a718 ("UBIFS: dump more in the lprops debugging check")
commit 12342c475f5d ("iwlwifi: proper monitor support")
commit 1234010684bb ("Add notation that the Asus W5F laptop has a short cable instead of 80-wire.")
commit 123411f2d0da ("[CPUFREQ] dprintf format fixes in cpufreq/speedstep-centrino.c")

real	0m24.535s
user	0m21.668s
sys	0m5.332s
