From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree info
Date: Tue, 23 Feb 2016 22:19:28 -0800
Message-ID: <xmqqtwkymxzj.fsf@gitster.mtv.corp.google.com>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
	<1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
	<xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
	<20160223014741.GA21025@wfg-t540p.sh.intel.com>
	<xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
	<20160223091740.GA3830@wfg-t540p.sh.intel.com>
	<xmqq1t8319z0.fsf@gitster.mtv.corp.google.com>
	<87d1rnjil4.fsf@x220.int.ebiederm.org>
	<xmqqtwkzyxkv.fsf@gitster.mtv.corp.google.com>
	<3FAB2030-8106-4114-99A4-B04A8A0D22FB@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: ebiederm@xmission.com, Fengguang Wu <fengguang.wu@intel.com>,
	Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Feb 24 07:19:44 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aYSnX-0004gp-25
	for glk-linux-kernel-3@plane.gmane.org; Wed, 24 Feb 2016 07:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756971AbcBXGTd (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 24 Feb 2016 01:19:33 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50154 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756638AbcBXGTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Feb 2016 01:19:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 127EE3C76F;
	Wed, 24 Feb 2016 01:19:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nid/dnFNA4TSb1/2SHyXSn8DsiM=; b=E6NSXf
	Raas6APvFU4mC06kf2ar9j8iKMim9lMzFumeC5JTpbVbl5Arg4TeepdmK9VhBtRv
	Y+/+aEXRtoWMLntOhaAG+cydXUnHnDX5ACgRhvRc1TPrONg6Gq+NflL4gxXWDHFx
	HOkskECBGraa+Qdb/n6Ao9TXOhwEEItBerIHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OBpT/UlkrwzUBpS6ip2cFqJFNkY4iZac
	aRmGLn/6pnV78JYnA0mhsynK9VnbwlzRnDfjV06QrNuls0DwKxnw/Iz7OBEXys3h
	gsQYCC3OLFz/IzMVcFyZq4WKt1tH0vR7Iz0pHwV5yFIwS8u3nHM0fzwrGnXN/oC3
	FXmaSaij/ys=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 08B8E3C76E;
	Wed, 24 Feb 2016 01:19:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6D17F3C76C;
	Wed, 24 Feb 2016 01:19:29 -0500 (EST)
In-Reply-To: <3FAB2030-8106-4114-99A4-B04A8A0D22FB@zytor.com> (H. Peter
	Anvin's message of "Tue, 23 Feb 2016 12:46:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8FC46A5C-DABE-11E5-8BBA-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287171>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Personally, as a maintainer, I would love to see the tree ID and
> ideally also the commit ID a series is based on.  The commit ID is
> in some ways less useful since it is non-recreatable (and
> therefore will never match for anything but the first patch of a
> series), but could be useful to the maintainer.

I admit that the very first "applies-to" proposal I made long time
ago was based on a tree object name, not a commit object name like
the proposal under discussion here, but I doubt that a tree object
name is that much more useful than a commit object name in this
context.

Below, I assume that you are envisioning that the "base tree"
recorded in a patch does not necessarily name a public, well-known
tree (e.g. a tree-ish that already appears in Linus's tree for those
who work with his tree, or other relevant trees like linux-next or
net tree) [*1*]. It would name an unknown tree that results by
applying a set of well-known patches in-flight on a public
well-known commit.  In that set-up, because you cannot guess
committer identity and timestamp that are used by the patch
submitter when these in-flight patches are applied to prepare the
base for these private commits, a commit object name is useless, but
it may still be possible for you to independently compute these
trees that would result from set of well-known in-flight patches.

But I do not think "it may be possible" above translates to
usefulness in practice.

Suppose we have only three well-known in-flight patches that are
unrelated and independent, and you somehow know that the patch
submitter built the first patch in the series by working on either a
recently tagged commit (say v4.4) or a result of applying some of
these in-flight patches on top of that commit.  Even with these
three commits, the base tree the patch submitter based his or her
work on could be v4.4 itself, v4.4 plus one of the three patches
(v4.4+A, v4.4+B, v4.4+C, three possibilities in total), v4.4 plus
two of the three patches in some order (v4.4+AB, v4.4+BC, v4.4+CA,
three possibilities in total) or v4.4 plus all of the three patches,
so there are 8 possible top-level tree objects in total.  Unless you
are doing something unusual [*2*], even if you have all of these
three well-known in-flight patches in your repository, you would
have only a subset of them (you would certainly have v4.4, and v4.4
plus all three patches, but you would likely to have only one path
between these two points, that's four commits recording four trees,
out of possible 8).

In the real world, of course you have far more than three well-known
in-flight patches, so even though in theory trees may have better
chance to be "figured out", I do not think it is practical to even
attempt to "figure out" an unknown state given a tree object name.

So assuming that it is a good idea to add some information to a
patch that identifies the whole tree it applies to, I think it is
sensible to (1) limit that identifiable set of tree-ishes only to
well-known public ones, and (2) use the commit object name, not the
tree object name, for the purpose of identifying these tree-ishes.

If I understand Fengguang's plan correctly, a new work based on a
public well-known base tree-ish plus other patches in-flight are to
be accompanied by the identifier for that well-known base tree-ish
and some identifiers for these in-flight patches, i.e. the robot
will be told to check out the well-known base tree-ish, apply the
prerequisite patches and then the patches for the work are applied
on top to be evaluated.  So the above two limitations I placed in
the previous paragraph would not hurt the identifiability of the
"base" tree-ish, I would think.


[Footnote]

*1* If you limit the bases to these well known ones, then there is
no practical difference between commit and tree, because we can
assume as a maintainer you would have these commits so you would
have both, and once located, a commit would be easier to reason
about (e.g. run "log" to see what changes there are between it and a
well known tags).

*2* By "something unusual" I mean you prepare the permutations of
in-flight patches in your repository, to make it possible to find
any of the 8 tree objects in this senario.
