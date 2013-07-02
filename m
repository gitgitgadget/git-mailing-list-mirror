From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: get description from repo.git/config
Date: Tue, 02 Jul 2013 11:51:50 -0700
Message-ID: <7vbo6k94mx.fsf@alter.siamese.dyndns.org>
References: <15tsj20cizd.fsf@tux.uio.no>
	<7vtxmgruhc.fsf@alter.siamese.dyndns.org>
	<vpq1u9kunba.fsf@grenoble-inp.fr>
	<7vwqrbmh4d.fsf@alter.siamese.dyndns.org>
	<5188B165.3050709@alum.mit.edu>
	<7v1u7iapzw.fsf@alter.siamese.dyndns.org>
	<51D2996B.8070503@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>,
	git@vger.kernel.org, Marc Branchaud <mbranchaud@xiplink.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Chris Hiestand <chiestand@salk.edu>, Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 02 20:51:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu5gE-0008Qh-0w
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 20:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579Ab3GBSvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 14:51:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47398 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754523Ab3GBSvx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 14:51:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE4F52AC86;
	Tue,  2 Jul 2013 18:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0/Ly7TKguOA+tfItnpZbSTTh6k4=; b=cyfuOl
	RO4SKzs6A2NzhRso7EJZxczDuIPO/os0PHMsBVXbEenqQLX7Tdz92kCCDwddBzxs
	rzPohoVK6E/Iun92YFroVkBT3D5q2rpn2mJkfLUFSFZ3lcHcaah0JkTZ29M0sX3S
	tJsQv+qGB3OPSW4GEnUJC9dEbWGLd2Lcb2QtI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ATPH9AJVxlwAwYRntMbXwjJLGFD6nIpG
	UBH46e3ZkuKv9oRPBYDW043gU4vtO1zu5yvGKOJ/h+UbbQpjR6zuS4YPjrWAWYNZ
	GJNHoajagmVEhijKX0u6uQx+RpbaHlMyDjMD9txKaNX24peqZLjVokdLlGirzFbQ
	zTtVSnK+GmA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B03B62AC83;
	Tue,  2 Jul 2013 18:51:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14F162AC7B;
	Tue,  2 Jul 2013 18:51:52 +0000 (UTC)
In-Reply-To: <51D2996B.8070503@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 02 Jul 2013 11:12:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 756D5940-E348-11E2-8F6F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229416>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I have a logistical question: git-multimail doesn't have its own mailing
> list, and GitHub doesn't offer one.  I was thinking about setting up a
> Google group, but a few people at GitMerge suggested that I instead
> direct discussion of git-multimail to the main Git mailing list.  I
> would slightly prefer that, but I would first like to make sure that the
> extra traffic (probably not much) would be welcome on the Git mailing list.

I think we shouldn't be worried about the "cluttering" too much
before we start.  If the volume is too small, the messages relating
to multimail may be drawfed by other traffic, but that is the same
for messages relating to any other parts of the system.

It only becomes a problem if the volume on multimail is too large
but most of the list readers are not interested in them. I somehow
find it hard to imagine that will happen soon.
