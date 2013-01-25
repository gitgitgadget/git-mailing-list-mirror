From: Junio C Hamano <gitster@pobox.com>
Subject: Re: segmentation fault (nullpointer) with git log --submodule -p
Date: Fri, 25 Jan 2013 07:36:18 -0800
Message-ID: <7vip6l5l71.fsf@alter.siamese.dyndns.org>
References: <20130123143816.GA579@krypton.darkbyte.org>
 <20130123200222.GB19832@sigill.intra.peff.net>
 <510124F5.9090505@atlas-elektronik.com>
 <CACsJy8B9O=A26_=sv1JEYdtazsWa4khZkqpTgFSSTs_RGGPZqQ@mail.gmail.com>
 <51013FDD.5030004@atlas-elektronik.com>
 <CACsJy8CEofqi9S8-SDx_O+Ko0i56aRZ4KEJrVnbFum6zzsJrJg@mail.gmail.com>
 <20130124232721.GA16036@sigill.intra.peff.net>
 <7va9ry87a0.fsf@alter.siamese.dyndns.org>
 <7vzjzx7w01.fsf@alter.siamese.dyndns.org>
 <20130125055331.GC26524@elie.Belkin>
 <FE6CC927-1915-4486-BBB8-4C109F7B5295@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>,
	Armin <netzverweigerer@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jonathon Mah <jmah@me.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 16:36:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TylKi-0007OW-JM
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 16:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756815Ab3AYPgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 10:36:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54631 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754841Ab3AYPgV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 10:36:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC51EC9DD;
	Fri, 25 Jan 2013 10:36:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NJeWi3MXhraBPDiSQwkfT8O0Zeo=; b=VaZgYw
	CMG6gE2fEXlx+EzhLB1ZAL3PS7WVj/pfL4Wl1NfonUHJt60qeeNx0ET66Q5xU44F
	0+KFrJsqVf8f7nC4GFbGtbTKiZAsQu/c6dOHpLPqLZYJoW+eTYYKV3161q2B96xC
	lp8hKwuvtob33WvzzRPY8tUbJ8jQs1pGHmYb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qKCP3GFVxKTq+hmjb5gyqbEGeqjjenpy
	l/AkwzJgyRk+Rt9hr5kSjjAwAQTMGjaeQPHZGyG7JtJpmLlTdDDRHiOVfSRIVT5f
	kPSzY93D5fi9/lRl3JyT/EXsnp+OJe6K7wdjhzO/MRTjocPRA1tB4HclXvDSav0F
	xuTmQk4hDiI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF894C9DB;
	Fri, 25 Jan 2013 10:36:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49BF3C9D7; Fri, 25 Jan 2013
 10:36:20 -0500 (EST)
In-Reply-To: <FE6CC927-1915-4486-BBB8-4C109F7B5295@me.com> (Jonathon Mah's
 message of "Thu, 24 Jan 2013 23:32:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F76E831C-6704-11E2-8610-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214560>

Jonathon Mah <jmah@me.com> writes:

> Just to note, the proposals so far don't prevent a "smart-ass"
> function from freeing the buffer when it's called underneath the
> use/release scope, as in:
>
> with_commit_buffer(commit); {
> 	fn1_needing_buffer(commit);
> 	walk_rev_tree_or_something();
> 	fn2_needing_buffer(commit);
> } done_with_commit_buffer(commit);

I think the goal of everybody discussing these ideas is to make sure
that all code follows the simple ownership policy proposed at the
beginning of this subthread: commit->buffer belongs to the revision
traversal machinery, and other users could borrow it when available.

Even though your sample code will break, from that point of view, I
do not think it is something worth worrying about.  If the function
"walk_rev_tree_or_something()" discards commit->buffer, it by
definition must be a part of the revision traversal machinery, and
any code that calls it inside with_commit_buffer() or uses the field
after such a call without revalidating commit->buffer, is already in
violation.  With or without such a macro, we would need to be
careful about enforcing the ownership rule, and I think a code
structure like the above example is easier to spot problems in
during the review than the current code.

Because retaining commit->buffer is done for the benefit of the
next/future users of the data, and not for the users that _are_
using them right now, I do not think the usual refcounting that
discards when nobody references the data is a good match to the
problem we are discussing.
