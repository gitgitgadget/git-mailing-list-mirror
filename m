From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 00/19] Introduce an internal API to interact with the
 fsck machinery
Date: Fri, 19 Jun 2015 02:04:52 +0200
Organization: gmx
Message-ID: <e3f2c023e59c3608ebbb7e88a6f18d27@www.dscho.org>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
 <cover.1434657920.git.johannes.schindelin@gmx.de>
 <xmqq8ubgd5vt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 02:05:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5joF-00043V-CT
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 02:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbbFSAFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 20:05:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:64296 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbbFSAFK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 20:05:10 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LsChr-1YzVRi2o0t-013roR; Fri, 19 Jun 2015 02:04:53
 +0200
In-Reply-To: <xmqq8ubgd5vt.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:/N01BLLQRhZJpzZ+M7ll84dkmtfg6wXZW/9ptf16wggOVyt9/gP
 meEbT9L321Ls2sheRMmhGU6kumwG3hetmQQNx48aq/U4ag+wHd2v/Bf7Cp7a2AUrFi2ilLW
 OiXif9ilE04cdyMfWLOlg72PWdhmCsItUjDQjBHZ8bX5e7Urlak4Vdrr53wYKHZpq+HHyJQ
 sOe/hxBbxQVOdG+qfrTbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8c/aCBJ96xs=:iXan7uUQNJ8OzYSD4UXv88
 gY3cqpG7OwGPnwylkqJp6Ttd3SDZ3moB+9XRQP7qg/wFmkJ1HDbivy2+3FHUEyr2Pn3zjQHda
 wERDMXZmV+H/lXKgey0Q2BtAWRf2Dvj33vNAai45onODaepsvGA7FOBGxQjYGRjeGDyK9qWtq
 xVVMjQEkzmCw+KQCmq/7ult/nhokNsGZXea4F+tbJQF6xTx+J0v82ZBpr1h3MxSKPBSW2KWqz
 e+RUN5+SvkLe+ah5je9pBDQjrrw9qMO9aPXpSLlKSPeIO1ok5j3ApKRVK7IvF25DyAIx2selX
 Srf883p+CxZxaOeNdR4sXGnzMvmG4bWwPO4/HIfHVrbVjOO+RkG0ix++D1tD1AqKUoNJaf9wg
 3K38mifbaFRX0CzkTLT7Hh9QRbDd8MFbGwPTbizuR85Itr+sSD09QDgFQQtnTTwVib3LI45Op
 cHz+Qv+HljHgIuSMDZsBULhIv2FYg5rkDoZyQifokHWbjaViX8VmBKMWbN+kgpre3HeJHjVMT
 8hgijdOhEoPZJ9dYbu2j2SN72h2LW5AWp/aEb/1OHYR7cSUqu+5/Gn8jf1oht8/azMl4egY/V
 Tw1HGC1Lgjp0AUtv89DYJplX/xue5eton1uGDQybNSjkHVVp2HqImmQ6u8HYNI7E35Fa81qL7
 ZT7PUP9d1F/4D68GOdAjdlxZofPFrx0pS7q4h+HeIF6Z8ecKjK1FasLX5fAzKsYWuaPU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272096>

Hi Junio,

On 2015-06-19 00:11, Junio C Hamano wrote:

> I haven't had a chance to go through the all the patches, but one
> thing I noticed that did not appear in the interdiff is that some of
> the message IDs are unclear.  For example, there are BAD_something,
> INVALID_something and MISSING_something.  The last one is in a
> different category and is good, but how are the former two
> differenciated?  Do they follow some systematic rules, or they are
> named after the way how they happened to be reported in the original
> textual error message?

I basically made up names on the go, based on the messages.

> Some of the questionable groups are:
> 
>     BAD_DATE DATE_OVERFLOW

I guess it should be BAD_DATE_OVERFLOW to be more consistent?

>     BAD_TREE_SHA1 INVALID_OBJECT_SHA1 INVALID_TREE
> 
>     BAD_PARENT_SHA1 INVALID_OBJECT_SHA1

So how about s/INVALID_/BAD_/g?

> Also it is unclear if NOT_SORTED is to be used ever for any error
> other than a tree object sorted incorrectly, or if we start noticing
> a new error that something is not sorted, we will reuse this one.

s/NOT_SORTED/TREE_&/ maybe?

> I also briefly wondered if fsck.skipList should be finer grained
> than "these are know to be broken, do not bother reporting problems
> with them" (e.g. I know v0.99 lacks "tagger" so I want to squelch
> MISSING_TAGGER_ENTRY for it, but I want to be notified on any other
> errors).  But that only matters if we update Git to a version with a
> new fsck that knows yet more kinds of breakages, so it is not a huge
> issue, and the simplicity of "be silent on these objects" is
> probably better overall.

Well, the idea of skiplist is to say: "I have inspected this object and determined that errors in it should be ignored." As such, it does not really matter what problems future Git versions report because the person populating the skiplist is supposed to test thoroughly, not just asking `git fsck` what is going on.

And yes, the motivation for this feature is to keep it super-simple. ;-)

Ciao,
Dscho
