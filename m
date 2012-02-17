From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3]
Date: Fri, 17 Feb 2012 09:03:22 -0800
Message-ID: <7v62f5v1d1.fsf@alter.siamese.dyndns.org>
References: <7v7gzmxw78.fsf@alter.siamese.dyndns.org>
 <cover.1329472405.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Feb 17 18:03:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyRDW-0001g0-0Q
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 18:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462Ab2BQRDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 12:03:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37767 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038Ab2BQRDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 12:03:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D645789A;
	Fri, 17 Feb 2012 12:03:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VSMAdqsG+mo9VpHbqYh5DswyC/k=; b=YOHJKq
	ZL9Rt2W3+uf0EV8g82UMQQsXqCOIhGtk/HxRWDGwT3ToV7Hyrd9DKjM6qcgqeOjQ
	v6wh2sc1WBgVU5Ebt1jldq5kzI77+tC7LVs5GKFpbewo8kr7XNa0QU0O/NktDUJU
	8ChyHBwWvK4agURJlH4d9cX65kiwGvwv4gMkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W/8/cqUsCMhTmyaDoftL/Lol8fv1TT5h
	VBzL21ErwK7QYexlTouGPF2ynj9S4YkD0Do1nsEbak6f2nI8tASezl8lDotVZzzW
	nUWLltz3sjT0pLAGtefh/8UWpbwD7V/BJfmxTMONG39LU60dc/vgdMzt+hdwN0Wj
	/M49WWkPObY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24F667899;
	Fri, 17 Feb 2012 12:03:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0D8D7898; Fri, 17 Feb 2012
 12:03:23 -0500 (EST)
In-Reply-To: <cover.1329472405.git.trast@student.ethz.ch> (Thomas Rast's
 message of "Fri, 17 Feb 2012 11:25:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D22E418-5989-11E1-BE2E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190963>

Thomas Rast <trast@student.ethz.ch> writes:

> There were actually more mistakes lurking :-( so I am resending the
> whole series.

Ok, will requeue.  The diff you attached to this cover letter looked at
least halfway sane, compared to the previous round ;-), though it is not
exactly clear what goes to lib-test-functions and what goes to lib-test
(for example, you moved test_expect_success to 'test-functions', but it
calls test_ok_ that is in 'test-lib', and test_ok_ is directly used by
test_perf in the new 't/perf/perf-lib.sh'), making it harder for people to
decide where to put their additions to the test infrastructure from now
on.  There needs a bit of description in the first patch to guide them.

I seem to be getting intermittent test failures, and every time the
failing tests are different, when these three are queued to 'pu'. I didn't
look for what goes wrong and how.

Thanks.
