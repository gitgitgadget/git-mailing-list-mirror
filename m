From: Junio C Hamano <gitster@pobox.com>
Subject: Re: combined diff does not detect binary files and ignores -diff
 attribute
Date: Tue, 24 May 2011 08:36:21 -0700
Message-ID: <7vsjs48616.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com>
 <4DDA618E.4030604@drmicha.warpmail.net>
 <BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com>
 <20110523181147.GA26035@sigill.intra.peff.net>
 <20110523201529.GA6281@sigill.intra.peff.net>
 <BANLkTikvPjO=bbhAoPCftdXzGSYtryNvzw@mail.gmail.com>
 <20110523234131.GB10488@sigill.intra.peff.net>
 <7v39k4aeos.fsf@alter.siamese.dyndns.org>
 <4DDB5C0F.1080102@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 24 17:36:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOtey-0001Ka-2K
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 17:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364Ab1EXPge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 11:36:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57360 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab1EXPge (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 11:36:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 70D6550FB;
	Tue, 24 May 2011 11:38:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hRP3NU21y0gc4QQ4RcQdFN4ji/Y=; b=PlLZxW
	1zt4uFz6k4wwzvReom46PsWqdWBneJuDvRW6QfcgneVS1xWlSzcQL9LFOojiVeZv
	PrUOfEqRICQUPcC0pHZK6mUG4fxkGDcaqwD7b5k71aUB/DE9CtEn9ul/s7vllgsw
	XL+dpIKyWhYAVYo/poaQvF0sUf7fIFRpLb22E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iDV/5DyXNIBeWSfWRtdVbcbfYEn1tQfD
	i+O+BCjEB1xziCeLFcorGHtrL5yF/hICPMlmmDQtpoHqjJzid5DJ8+2iEUEY9A0P
	DOHW9swv/ChbetTaYj8hSnorVAK9GzSg/x/uDHFvFOdEPJt4cMg4eENlxomptBt4
	D1XKAuUcSf4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2655D50F3;
	Tue, 24 May 2011 11:38:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 82FFA50ED; Tue, 24 May 2011
 11:38:31 -0400 (EDT)
In-Reply-To: <4DDB5C0F.1080102@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Tue, 24 May 2011 09:19:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E41FE178-861B-11E0-86BB-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174321>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Jeff, thanks a bunch for taking this up again! That's a great
> improvement. (I'm not sure I can devote enough time to reviewing, but
> I'll see.)

Thanks. I've given a cursory look at the rest of the series (including the
addendum to be squashed in) and they seemed Ok. Will give it another round
of eyeballing before merging to "next".

>> I however highly doubt that such an interface would make sense. For
>> example, what would be the desirable format to compare three versions of
>> "What's cooking" postings, and how would the updated compare-cooking.perl
>> script would look like?
>
> Yeah, currently --cc with external makes no sense, but there are several
> external tools which could present a 3-way diff in a useful way (or even
> n-way with n>3), e.g. vimdiff, kdiff3, meld.

With an external command that can make 3-way diffs of arbitrary three
directories, you can trivially do something like:

	#!/bin/sh
	mkdir tmp-head tmp-index &&
        ( cd tmp-head &&
          GIT_DIR=../.git GIT_INDEX_FILE=$GIT_DIR/.index-head &&
          git checkout -f HEAD
	) &&
        ( cd tmp-index &&
          GIT_DIR=../.git &&
          git checkout -f .
	) &&
        $ext_diff3_cmd tmp-head/ tmp-index/ . &
        wait
        rm -fr tmp-index tmp-head

But that seems totally offtopic and has nothing to do with the "combined
diff" discussion, no?

If you want to plug in an external command that can make n-way diff of n
files when some paths are still shown using the usual --cc codepath, then
you would need an interface totally different from the diff.<driver>.cmd
interface for two-way diff to the external diff.  I pointed at where to
plug such a thing, but I do not think it would be of much use unless you
are handing the whole n-trees to the external command (which essentially
is what the above outline does). How would the user read the output that
comes out mixed from different codepaths, some from our own --cc while
others come from the external command, possibly opening separate windows
and even worse grabbing control and getting the caller stuck until the
user closes that window?

	Side note: about getting stuck, will we see an update to the
	diffstat count series by the end of this cycle? I do not mind
	carrying it over to the next cycle at all, but I'd rather see
	something already started gets finished.

> When the --cc/textconv issue came up I looked into this, and maybe
> difftool is a place where one could plug this in first in the sense of
> refactoring that even more and providing a diff3tool or such to view a
> merge commit (or compare any 3 versions), or/and provide "git diff3 A B
> C" which creates a fake merge (A+B -> C).

You do not need "git diff3 A B C" for a fake merge.

	$ git diff 61d7503d 2d22086 5bf29b9

already is a way to show you how the commit 61d7503d was created by
merging the other two (the merge result comes first and then its parents).
You could put the index into the mix by doing something like:

	$ git diff next master $(git write-tree)

Trying to show combined diff to merge the index and the working tree into
the current HEAD (which may be an example that does not make much sense)
would look like this:

	$ git diff HEAD $(git write-tree) $(
		git read-tree --index-output=.tmp-index HEAD &&
		GIT_INDEX_FILE=.tmp-index git add -A :/ &&
                GIT_INDEX_FILE=.tmp-index git write-tree
	)

But for the "working tree" set, which paths should be included? The same
set as what is in the index? Or would we use the set that is the union of
other tree-like things that are being compared, including the ones that
are not in the index? Or everything in the working tree, as we are
interested in what the user _could_ add?  That is one of the reasons why I
do not think it makes much sense trying to throw the working tree into the
picture, as it would have to open a large can of worms.
