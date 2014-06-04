From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 9/9] fetch: allow explicit --refmap to override configuration
Date: Wed, 04 Jun 2014 15:28:22 -0700
Message-ID: <xmqqbnu8tim1.fsf@gitster.dls.corp.google.com>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com>
	<1401833792-2486-10-git-send-email-gitster@pobox.com>
	<538F34E1.6010704@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Thu Jun 05 00:28:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsJfp-0008Qd-29
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 00:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbaFDW23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 18:28:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55517 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685AbaFDW22 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 18:28:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B847F1CAD1;
	Wed,  4 Jun 2014 18:28:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UGvKMQn5xuvDCfI8qnW9bpXwG1I=; b=DcP4kP
	mqm1Sw5soSv/jtyZm+7JbWP/B61eqBDt0rEeRqhxSHQsTnWvFNZTBBirmKn5a1lh
	0KdHrEAuJ2Rctp6IBA/+y9N6q9KmR6sRquGj3mMj+yU21Ls5D1bmRTj6xi91jwvA
	kmllv5gp+vLITP3ZWNZAMiGfy+l+ZWcVJraBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gsJTz43FNEPl7vNGD1zNxhoQcxaervHc
	fvh+N4/IafRzTuNQENxQvJLq9AUCosKLPZopiapjRQBVNK0f4/6bSKjNYUhJmNRs
	mBVLWy993/JMCuwybZwAOU7Ziy8XJ8dgc/ihGl0PUwsYKy1kmLCpq8j/sgQ7C004
	WT/2aDZ0qic=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD7E11CACF;
	Wed,  4 Jun 2014 18:28:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EF8B61CACD;
	Wed,  4 Jun 2014 18:28:23 -0400 (EDT)
In-Reply-To: <538F34E1.6010704@xiplink.com> (Marc Branchaud's message of "Wed,
	04 Jun 2014 11:01:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8A5C3E7C-EC37-11E3-9974-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250798>

Marc Branchaud <mbranchaud@xiplink.com> writes:

>> Teach the command to pay attention to the --refmap=<lhs>:<rhs>
>> command-line options that can be used to override the use of
>> configured remote.*.fetch as the refmap.
>
> (Your 0/9 message merely said "The new patches at the
> end clarifies how remote.*.fetch configuration variables are used in
> two conceptually different ways." so I was not expecting fetch to get a new
> option.)

This is more about conceptual consistency & completeness than new
and useful addition, in that configured values and the feature they
enable ought to be expressible and overridable from the command line
options but we so far lacked a way to trigger the "do not affect
what gets fetched, only affect where they go locally" feature, which
is offered by the second way to use remote.*.fetch variable.  I do
not think we absolutely need it and that is why it is at the end as
an optional addition.

[jc: again, good suggestions I'll use when amending snipped]

Thanks.
