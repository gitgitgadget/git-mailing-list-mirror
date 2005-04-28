From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: The criss-cross merge case
Date: Thu, 28 Apr 2005 22:25:01 +0800
Message-ID: <200504281425.j3SEP1H00534@freya.yggdrasil.com>
Cc: barkalow@iabervon.org, bram@bitconjurer.org,
	droundry@abridgegame.org, git@vger.kernel.org, tupshin@tupshin.com
X-From: git-owner@vger.kernel.org Thu Apr 28 16:35:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRA5D-000537-EX
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 16:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVD1Oiv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 10:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVD1Oiu
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 10:38:50 -0400
Received: from [61.48.52.188] ([61.48.52.188]:15852 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261948AbVD1Oid (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 10:38:33 -0400
Received: (from adam@localhost)
	by freya.yggdrasil.com (8.11.7/8.11.7) id j3SEP1H00534;
	Thu, 28 Apr 2005 22:25:01 +0800
To: ry102@rz.uni-karlsruhe.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 2005-04-28, Benedikt Schmidt wrote:
>AFAIK the paper mentioned in the GNU diff sources [1] is an improvement
>to an earlier paper by the same author titled
>"A File Comparison Program" - Miller, Myers - 1985.
[...]
>[1] http://citeseer.ist.psu.edu/myers86ond.html

	Monotone apparently uses a futher acceleration of that algorithm
from the 1989 paper, also co-authored by the Myers, "An O(NP) Sequence
Comparison Algorithm" by Sun Wu, Udi Manber, and Gene Myers.
http://www.eecs.berkeley.edu/~gene/Papers/np_diff.pdf .  The Monotone
implementation was apparently a port of an implementation originally
written in Scheme by Aubrey Jaffer.

	I don't fully understand the 1989 paper, but I get the
general impression that is a small change to the previous algorithm
(the one in GNU diff) that might be a 30 line patch if someone
got around to submitting it, and seems to make the code run more
than twice as fast in practice.  One of these days, I will probably get
around to coding up a patch to GNU diff if nobody beats me to it.

	Making diff run faster may have at least one potentially useful
benefit for merging.  A faster diff makes it more practical run diff
on smaller units of comparison.  I posted a note here before about
converting the input files to diff3 to have just one character per
line, and then undoing that transformation of the result to produce
a character based merge that seemed to work pretty well in the
couple of tests that I tried.

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
