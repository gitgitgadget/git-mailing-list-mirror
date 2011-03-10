From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Summer of Code project ideas due this Friday
Date: Thu, 10 Mar 2011 12:54:29 -0800
Message-ID: <7vtyfa3ddm.fsf@alter.siamese.dyndns.org>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110309215841.GC4400@sigill.intra.peff.net> <20110310001017.GA24169@elie>
 <201103101815.23477.trast@student.ethz.ch>
 <20110310184653.GA17832@sigill.intra.peff.net>
 <7vpqpy4w8k.fsf@alter.siamese.dyndns.org>
 <20110310192851.GB19257@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 10 21:55:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxmsu-00027D-Dk
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 21:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100Ab1CJUyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 15:54:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab1CJUyx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 15:54:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E23F941B8;
	Thu, 10 Mar 2011 15:56:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KCfK84EKi9ZPs/lai2vycHN58NQ=; b=msnrZV
	wOYAHmitQYegT8XQzgQ97/MXycNVt7U2lq3Kwbn5Vh1aJAVgIwxfQPWIhcazCeKy
	+Zide3VYOYiJhsw7hqgQnOw8bPx56O26alxZTR7siAAD8Oa2eqIj+wgJ4gkiu3kf
	Wb2j+UDsoKmCoOJR2xKQ0+DiUAIFbPO3EI0Yk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d7w3lXgs2ZGCLlauP88dp75GwdjzIFWO
	W3aAzdMpJb+bJQFzoDLU+QeawtsvONvPDWyA0LbK/s1/enMQvFHxO73HK/lXk3yo
	H8gyzaC39/JH3lJ/cg7Y+fZrbPRoIVoUsrHxtTEPcr3WVv9wYt6aUcPWni14JVaa
	ahJCGwccdtA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 62C6F41B3;
	Thu, 10 Mar 2011 15:56:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 41E1541AA; Thu, 10 Mar 2011
 15:55:59 -0500 (EST)
In-Reply-To: <20110310192851.GB19257@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 10 Mar 2011 14:28:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3C4E97A-4B58-11E0-90E1-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168850>

Jeff King <peff@peff.net> writes:

>> I think the end-result would be a nice feature. I suspect that it would
>> not involve conversion from --cc, but more like using the difference
>> between the HEAD and the working tree, generated as if there is no
>> multi-stage index.
>
> The trouble is that I would like to see the combined diff, then say "OK"
> and have it apply the result to the index. But because we work on a
> per-hunk basis, you need to match the combined diff hunks to the regular
> diff hunks, taking into account that hunks could be split.  Which maybe
> is straightforward, but I haven't convinced myself yet that there are no
> corner cases where they don't line up.

Forgetting for now the implementation, I _think_ what you would want is
for "git add -p" to notice that you are resolving conflicts, and do not
bother you about cleanly merged parts (I take it is a given that you would
always want to add them to the index without even inspecting when running
"add -p"), and make the per-hunk selection loop ask only about the parts
that originally had conflicts.

But it is rather hard to arrange.  Neither "--cc" nor "-c" during the
merge is about showing conflicts but is about showing the result with
respect to the two originals.  If you resolved conflicts in your editor
already, there are no lines with "<<</>>>" markers that are different from
either original to cause the "conflicted parts" to appear in their output.
If your conflict resolution ended up in taking what one side did, "--cc"
will hide it as a non-event.  So at least you would be using "-c" to
implement this.

Also, you have to remember that "add -p" is about adding the state you
deem Ok incrementally to the index, that once you add a path to the index
the higher stages for the path will collapse to stage #0, and that "-c"
and "--cc" make their comparison based on what you have in higher stages.

I would imagine that a workable implementation might look like this:

 0. The solution introduces a new index extension, "PRSF" (partial
    resolution so far)".  This is a mapping from pathname to a blob object
    name.

 1. "git add -p" notices that you are in the middle of conflict
    resolution, by noticing that you have higher stages to the path.

 2. Look up the path from the PRSF extension.  If there is no entry for
    the path, recreate the content-level 3-way merge using the content of
    three stages (i.e. the state immediately after the mergy operation
    that caused the conflicts before you touched the corresponding file in
    your working tree), and register this image (with the full glory of
    "<<</>>>" conflict markers) to the extension.  If there already is an
    entry in the extension for the path, skip this step.

 3. The patch the user will see in the interactive hunk selection is the
    difference between the working tree and the PRSF image, not your
    regular index (nor the HEAD version). This allows you to see how you
    resolved the conflict incrementally so far.

 4. Choosing a hunk to "apply" would not affect the index entry for the
    path, as it would collapse its higher stages.  It instead updates the
    blob registered in the PRSF extension using the hunk you are applying.

If you are running "git add -p" incrementally (i.e. edit a little, review
with diff, then "add -p" the part you are sure about, and repeat the whole
thing), the next invocation of "git add -p" would notice that you still
have unresolved conflicts in PRSF.  It will skip the step 2 above and the
step 3 will let you review the remaining difference between the PRSF image
(which you updated in step 4 during the last round) and what you have in
the working tree.  The step 4 will update the PRSF image for the next
invocation of "git add -p".  And you continue until you are done.

At the end (we would probably need a good way to detect the user might
want to declare "end" automatically for a good user experience), use the
PRSF image to collapse the higher stages for the path down to stage 0.
