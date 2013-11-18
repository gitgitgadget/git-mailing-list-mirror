From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v1.8.5-rc2
Date: Mon, 18 Nov 2013 09:01:54 -0800
Message-ID: <xmqqvbzpbq4d.fsf@gitster.dls.corp.google.com>
References: <xmqqsiuzdhov.fsf@gitster.dls.corp.google.com>
	<5284FE88.8040208@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Nov 18 18:02:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViSD7-0008GH-0F
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 18:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503Ab3KRRCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 12:02:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35109 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373Ab3KRRB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 12:01:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5478951A5C;
	Mon, 18 Nov 2013 12:01:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZISKuc3kNQfZqgJfRxJk9vTzS0A=; b=NBNmtL
	PfFbSCg/CBf/euw46keYfZBCq9yvrJD6mM44nj9IvGnoLVo7IOpPIqBAk+3NPai+
	VF6Ra4t6YxgvgzTz9NeRa6VGhu5aoIaTNnQOdg+jpDRRwbIOq0G1H7i+qTDaPZMp
	Nn0SBv/WunoBQK3GGhFruDJetfplPFY1mhPjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YXsXRtqH6rOmJ3DaeztIXJ67r1h/SN9P
	/iJC/wcHQ0lsHEfNqEgFWfEOqFNLma7CUq2BPXZguNEmbymO9lpCpPpJvqEt2ji5
	pT6EK2A6w/H81xmRCUW5y1AoV0Ao4fv/97wgS4AXRfbN3QU26jRtRmCFXZNTRpq4
	rQQB089Re6I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4835851A5B;
	Mon, 18 Nov 2013 12:01:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BF7151A56;
	Mon, 18 Nov 2013 12:01:58 -0500 (EST)
In-Reply-To: <5284FE88.8040208@xiplink.com> (Marc Branchaud's message of "Thu,
	14 Nov 2013 11:47:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 22CB8AFC-5073-11E3-8ADE-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237991>

Marc Branchaud <marcnarc@xiplink.com> writes:

>> Foreign interfaces, subsystems and ports.
>> 
>>  * "git-svn" used with SVN 1.8.0 when talking over https:// connection
>>    dumped core due to a bug in the serf library that SVN uses.  Work
>>    it around on our side, even though the SVN side is being fixed.
>>  ...
>>  * Subversion 1.8.0 that was recently released breaks older subversion
>>    clients coming over http/https in various ways.
>
> Isn't this the same as the serf fixes ([1],[2])?  If not, what git change is
> it referring to?

The latter, I think, is 8ac251b6 (git-svn: allow git-svn fetching to
work using serf, 2013-07-06).  Without it we won't even work with
newer SVN library.

The former I think refers to 73ffac3b (git-svn: fix termination
issues for remote svn connections, 2013-09-03).  Even with the serf
support, without a work-around, we won't work with serf.

The description can and should be rolled into one, but I am not sure
what the best wording would be.

Thanks.
