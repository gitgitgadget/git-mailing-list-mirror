From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/14] Officially start moving to the term 'staging area'
Date: Thu, 17 Oct 2013 12:50:50 -0700
Message-ID: <xmqqwqlbznfp.fsf@gitster.dls.corp.google.com>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
	<1381789769-9893-4-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s3u_SMyZOe5jxkvoGn5MBJ_g70iHRT5v_3u1rZwFoqiVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 21:51:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWtb0-0001LP-D2
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 21:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759041Ab3JQTuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 15:50:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35580 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758100Ab3JQTux (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 15:50:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E1924ADF5;
	Thu, 17 Oct 2013 19:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=DuVoIJQ6lHF5eLwPuClElC0GGuw=; b=q/SRGzJibf0eV3qf4Vvp
	TukVRx5qcIerWDNROj1uxDzpz8LBp6uERmr1mPua6tjmNhKBIk1SvlcWxCvL2YSQ
	0nSSpCEfvJV1nBeyjOsBRpzSXiyvaNRrUwlzjL+8F6E9AM3RYAY4BLCwwKwUPPBl
	xzTRPnZXjaeOSPwfcL/rSlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=eE2mVglpecoHYRfTIg8c+Pt8eSf+F81TmsZDN0r/aDezZX
	QS3fzLx+RxIvOgYszFvPmPMIdqVtDSM8cLIyAdDHKZVrWQyOrHqpou+ncg4baZq3
	HrhSHvkbpgPiW3nMC18s1KxR5kpf0h6V3z89F0Mb0R4S2+HgxSk073RZD/QnI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CDA24ADF4;
	Thu, 17 Oct 2013 19:50:53 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 685B14ADEE;
	Thu, 17 Oct 2013 19:50:52 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6DD4B4BE-3765-11E3-A53F-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236310>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio, can you make an exception and reply to this thread? The change
> to move away from the term "the index" has been suggested many times
> since many years ago, it is an extremely important change to users,
> and all the Git developers agree it must be done.

"It must be done" is different from "any change is good, as long as
it introduces more instances of word 'stage'". As we established, we
do not seem to be able to do a sensible design discussion with you
without wasting time for nothing, I won't directly comment on that
patch series, at least for now.

However, since you asked, I would share a couple of comments
regarding the index, cache and staging area.

(1) "Staging area".

The phrase "staging area" is not an everyday phrase or common CS
lingo, and that unfortunately makes it a suboptimal choice of words
especially to those of us, to whom a large portion of their exposure
to the English language is through the command words we use when we
talk to our computers.

I personally do not mind explaining the index is "like a staging
area, where an army piles up ammunition to a temporary dump before
starting a major campaign." to native speakers, though ;-).

The index can also be thought of "like the buffer cache, where new
contents of files are kept before they are committed to disk
platter."  At least, non-native speaker with CS background would
understand that, much better than "the index" (no, I am not saying
that we should call it "the cache"; I am just saying "the index" is
not a good word, but we may need to find a better word than "the
staging area").

The noun phrase "staging area" and the verb "to stage" are good
(especially when we do not worry too much about us foreigners), but
we need to make sure "stage" is not mistaken as a noun when used in
a context that talks about the index as a whole, to avoid confusion
with the use of the word "stage" long established since

    http://thread.gmane.org/gmane.comp.version-control.git/231/focus=286

to call "ours" stage#2, etc.


(2) "cached" vs "index".

I think this is the more major issue between the two issues (the
other one being "why do we force people to say 'index'?").  Some
commands take "--cached", some others take "--index", some take
both.  What these two mean are documented in gitcli manual page, but
that is far from sufficient.  The users can get confused by this UI
mistake in different ways.

 * We do need to have "git apply" that mimics "patch" (i.e. works
   only to a working tree files, or even outside Git repository)
   without any option, "git apply --mode1" that only applies the
   change to the index, and "git apply --mode2" that applies the
   change to both the index and the working tree. No renaming of
   "the index" does not change this need to have three different
   mode of operation.

   It was a major UI mistake to call one of the modes "--cached" and
   another "--index", because there is no way, other than rote
   learning, for people to choose the one between the two depending
   that is right for the situation they face.

   If "--cached" were called "--index-only", it might have been a
   lot more learnable (and then "--index" could be renamed to
   "--index-and-working-tree" at the same time to reduce the
   confusion further).  Alternatively, with the synonym "--staged"
   for "--cached" already in place for "git diff", we could
   introduce "--staged-and-working-tree" as a synonym for "--index"
   to achieve the same effect (of course we need to find a way to
   shorten "-and-working-tree" part in a sensible way).

 * "git grep" barfs when given "--index", even though it does accept
   "--cached" and searches the patterns in contents that are in the
   index. This is technically correct, as the command does not
   search both in the index and in the working tree, but again,
   there is no way other than rote learning for users to tell that
   "--cached" is the correct one to use, even after they know that
   they want to search in the index (I already called it a major UI
   mistake, didn't I?).

   A new synonym "--staged" for "--cached" may be able to alleviate
   the confusion somewhat, given especially that "git diff" already
   knows "--staged" as a synonym for "--cached".  I think a better
   end result will come if we taught "git grep --index" to actually
   search the patterns both in the index and in the working tree at
   the same time.  There is no logical reason from the end user's
   point of view that "git grep --index" (aka "git grep
   --staged-and-working-tree") needs to fail; if we make the
   "--mode2" to mean to work on both the index and the working tree
   for any Git command when it makes sense, things will be more
   consistent, and it certainly makes sense to ask "git grep" to
   work on both the index and the working tree.  We do allow "git
   grep -e pattern tree-ish-1 tree-ish-2" to search in multiple data
   sources already, so it can be seen as a logical extension.

 * "git diff --index [TREE-ISH]" has exactly the same issue as "git
   grep", and the same conclusion, i.e. it may be worthwhile to
   teach "git diff --index [TREE-ISH]" to give combined diff between
   the given tree-ish (defaulting to HEAD as usual), the index and
   the working tree.
