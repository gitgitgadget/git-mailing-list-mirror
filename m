From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Tue, 01 Nov 2011 12:47:12 -0700
Message-ID: <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Tue Nov 01 20:47:25 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RLKIu-00068s-N0
	for glk-linux-kernel-3@lo.gmane.org; Tue, 01 Nov 2011 20:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587Ab1KATrR (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 1 Nov 2011 15:47:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57590 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010Ab1KATrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2011 15:47:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A57169BE;
	Tue,  1 Nov 2011 15:47:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EEWBWU93Qgj1kW8bu/16bvfm+Cc=; b=akG07V
	A4eZgnEQEbvZesAvqksn+osmNU/8yqcqjSGG/fBIQ9F03ZXAP1i5EexwBBN9YTcd
	wsWZrlctxy05FvKR4HfyIgrTWjTQL1adbK+c7yuiUOGQ0NRnYkqpcq/hE7ZVQ2sA
	t7wHGGTvurCremh1URVjRw+DZbHaX25VfaF3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HK52vSMzFzYcy/RoueElG68h+r9Qgget
	mm1rulXL3vy6n0TzrU3k+/Vm1Z0F2OYTy2M49DmQjtVPWt2/Es2gWTeXyZbW/WiC
	BFKCMaq27gvP6mM8uoIA3aca9zz41VKMb8msKVVwXcMIo6m66b0eKn19MV98z3m4
	hWj5nokM7Qk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 514AF69BD;
	Tue,  1 Nov 2011 15:47:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC1C069BB; Tue,  1 Nov 2011
 15:47:13 -0400 (EDT)
In-Reply-To: <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com> (Linus
 Torvalds's message of "Mon, 31 Oct 2011 15:18:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BAA93FE-04C2-11E1-9782-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184582>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> But what would be nice is that "git pull" would fetch the tag (based on
> name) *automatically*, and not actually create a tag in my repository at
> all. Instead, if would use the tag to check the signature, and - if we
> do this right - also use the tag contents to populate the merge commit
> message.
>
> In other words, no actual tag would ever be left around as a turd, it
> would simply be used as an automatic communication channel between the
> "git push -s" of the submitter and my subsequent "git pull". Neither
> side would have to do anything special, and the tag would never show
> up in any relevant tree (it could even be in a totally separate
> namespace like "refs/pullmarker/<branchname>" or something).

While I like the "an ephemeral tag is used only for hop-to-hop
communication to carry information to be recorded in the resulting
history" approach, I see a few downsides.

 * The ephemeral tag needs to stay somewhere under refs/ hierarchy of the
   lieutenant's tree until you pick it up, even if they are out of the way
   in refs/pullmarker/$branchname. The next time the same lieutenant makes
   a pull request, either it will be overwritten or multiple versions of
   them refs/pullmarker/$branchname/$serial need to be kept.

   - If the former, this makes forking of the project harder. Suppose a
     pull request is made, you fetch and reject it. The lieutenant reworks
     and makes another pull request. At this point the earlier signature
     is gone. If somebody disagreed with your rejection and wanted to run
     his tree with the initial version you rejected, his tree will not
     carry the signature from the lieutenant.

   - If the latter, then there needs to be a way to expire these pull
     markers when they no longer are useful (i.e. the signature in it is
     transcribed to a merge commit you create) [*1*]. But the party who
     has power to clean them (i.e. the lieutenant who owns the repository)
     is different from the party whose action determines when they no
     longer are necessary (i.e. you). In practice this would lead to these
     pull markers not cleaned at all [*2*].

 * To verify the commit C that was taken from the tip of lieutenant's tree
   some time ago, one has to find the merge commit that has C as a parent,
   and look at the merge commit.  For example "git log --show-signature"
   would either show or not show the authenticity of C depending on where
   the traversal comes from. You certainly can implement it that way, but
   "some child describes an aspect of its parent, but not necessarily all
   children do so" feels philosophically less correct than "the commit has
   data to describe itself".

In your "ephemeral tag", the workflow for a developer (D) and his
integrator (U) would look like this, I think.

 D$ until have something worth sending; do work; done
 D$ git push -s
 Enter passphrase: ...
	- "push" internally creates a pull marker that signs the commit
          object name this is pushing, among other things, and sends it
          along the primary payload
 D$ git pull-request; mail linus

 U$ git pull
 	- "pull" notices the pull marker and fetches it as well;
        - "pull" GPG validates the pull marker;
        - When preparing a merge commit message, the contents of the
          pull marker is included in .git/MERGE_MSG

The "in-commit signature" would give you 100% and your contributors 98% of
that, I think.

 D$ until have something worth sending; do work; done
        - The final round of reworking is concluded with "commit -S",
          which would GPG sign the tip commit itself
 D$ git push
	- Nothing needs to change in the protocol nor "push" itself
 D$ git pull-request; mail linus

 U$ git pull
 	- "pull" GPG validates the tip commit
	- Nothing unusual needs to happen to the resulting "merge" commit

And as a bonus, the code is already there ;-).


[Footnote]

*1* The common ancestor discovery in fetch uses as many refs as it can to
reduce the amount of data that needs to be transferred, and it is known to
hurt performance of the initial advertisement exchange when there are too
many useless refs.

*2* Do casual git users even know how to remove refs in a
remote/publishing repository?
