From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Restrict ref-like names immediately below $GIT_DIR
Date: Tue, 18 Oct 2011 23:19:51 -0700
Message-ID: <7vty75ec54.fsf@alter.siamese.dyndns.org>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
 <20111011230749.GA29785@sigill.intra.peff.net>
 <7vehyjcckp.fsf@alter.siamese.dyndns.org>
 <20111012021128.GA32149@sigill.intra.peff.net>
 <7v39eyddoc.fsf@alter.siamese.dyndns.org>
 <20111012045004.GA22413@sigill.intra.peff.net>
 <7vvcru9k22.fsf_-_@alter.siamese.dyndns.org> <4E95D60B.5030904@alum.mit.edu>
 <7vr52i9j8g.fsf@alter.siamese.dyndns.org> <4E9609E3.1000300@alum.mit.edu>
 <7v39epft32.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 19 08:20:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGPVR-0005wZ-3L
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 08:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab1JSGTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 02:19:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50822 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469Ab1JSGTy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 02:19:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 868892CEC;
	Wed, 19 Oct 2011 02:19:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B+hDIQIdPDfuMEaq76Cwrs7PNDw=; b=KUZ8Eg
	uZpLmtIFcEp6QvWYxAlnPJuSWW40s3rHd34HIP7wTkqB6Zhh9h60gAj7qO7coZai
	yyvl7zun/Qi44mDv766LLztEQ6hvBOqZIi2O02BFzKCKZTKrNM56RU4FFdY+e7HQ
	0DM+kbYkILolHCLPtYlWJrzYBz9AA17s8VH8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RMPhSpZXIjBlDcAbxE2jSQr+0NeCDwqh
	fDENr4DUerGHhw7KrA6F5DSkciJXIRJFNqEZjuElfBRetmBWsKbUrwqN+A68hv83
	tsYXmtHF7tBjlgM16JE/LtdXga+8ulMzQ/Y9wnJ/HZNT3DKZQFedmYsvK3ccP7ca
	m4KiZD2u1TQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EE152CEB;
	Wed, 19 Oct 2011 02:19:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB2922CEA; Wed, 19 Oct 2011
 02:19:52 -0400 (EDT)
In-Reply-To: <7v39epft32.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 18 Oct 2011 22:28:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B540D88-FA1A-11E0-B11E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183917>

Junio C Hamano <gitster@pobox.com> writes:

> I was trying to summarize this topic for Release Notes.
>
>   Possibly incompatible changes
>   -----------------------------
>
>    * Special refs such as "HEAD", "MERGE_HEAD", and "FETCH_HEAD" are now
>      restricted to names with only uppercase letters and underscore. All
>      other refs must live under refs/ namespace. Earlier, you could
>      confuse git by storing an object name in $GIT_DIR/tmp/junk and say
>      "git show tmp/junk", but this will no longer work.
>
> But noticed that "git update-ref tmp/junk HEAD" does create such a ref
> that won't be recognized, and "git check-ref-format tmp/junk" is happy.
>
> I think we would need to restrict check_ref_format() so that these
> commands (and possibly others, but I think that single function will cover
> pretty much everything) also reject "tmp/junk" immediately below $GIT_DIR
> as a bad string. Otherwise we cannot merge these fixups, which would mean
> we would have to revert the "Clean up refname checks and normalization"
> series, at least the part that started emitting the "warning", which is a
> mess I would rather want to avoid.
>
> Opinions on how to get us out of this mess?

Addendum.

I was digging this further and see fairly large conflicts between the bulk
of "clean up refname checks and normalization" topic and the logic to
avoid the additional warning by tightening the dwimmery.

check_refname_format() has always assumed that it is OK to be called at
any level of substring, and there are many code like this one (example is
from remote.c::get_fetch_map()):

        for (rmp = &ref_map; *rmp; ) {
                if ((*rmp)->peer_ref) {
                        if (check_refname_format((*rmp)->peer_ref->name + 5,
                                REFNAME_ALLOW_ONELEVEL)) {
                                struct ref *ignore = *rmp;
                                error("* Ignoring funny ref '%s' locally",
                                      (*rmp)->peer_ref->name);

This code somehow _knows_ that peer_ref->name begins with "refs/" and that
is the reason it adds 5 to skip that known part. In this particular case,
I think we can simply drop the +5 and allow-onelevel, but there are other
instances of the calls to the function that feeds the rest of the refname
string, skipping leading substring (not necessarily "refs/"), assuming
that any component string is either valid or invalid no matter where it
appears in the full refname. I wouldn't be surprised if some callers do
not even have enough information to tell what the leading substring would
be in the full refname context (e.g. parsing of "master:master" refspec,
relying on the later dwimmery to add refs/heads/ in front, could just
verify that "master" is in good format with allow-onelevel).

The new restriction bolted on to that logic in jc/check-ref-format-fixup
series to work around the new warning in 629cd3a (resolve_ref(): emit
warnings for improperly-formatted references, 2011-09-15) is incompatible
with the assumption, as we would need to check full refname, and treat the
first refname component very differently from other components. It has to
be either "refs" in multi-component refname, or all caps in a one-level
one, but the callers of check_refname_format() are not designed to feed
the full refname to begin with.

I am tempted to revert 629cd3a (resolve_ref(): emit warnings for
improperly-formatted references, 2011-09-15) that started giving the
warnings, and drop the jc/check-ref-format-fixup topic [*1*] altogether,
but that is a short-sighted workaround I would rather want to avoid. It
essentially declares that the "Clean up refname checks" topic was a
failure and did not manage to really clean things up.

A possible alternative might be to leave check_refname_format() and its
callers as they are, introduce check_full_refname() function that knows
the new restriction on top of check-ref-format-fixup, and use that in
lock_ref_sha1(), lock_any_ref_for_update() and is_refname_available()
[*2*]. That way, we can keep the potentially useful "ill-formed contents
in the ref" warning and avoid possible confusion caused by random files
that are directly under $GIT_DIR, which would be far more preferable in
the longer term.

Anybody wants to give it a try?


[Footnote]

*1* The topic is misnamed; it is about fixing dwimmery, not checking.

*2* This currently does not seem to check the well-formedness of the ref
it is creating at all; it should check the "ref", but not "oldref" to
allow renaming a malformed ref to correct earlier mistakes.
