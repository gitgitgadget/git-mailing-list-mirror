From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes: line
Date: Wed, 30 Oct 2013 11:33:56 -0700
Message-ID: <xmqqsivibobv.fsf@gitster.dls.corp.google.com>
References: <20131024122255.GI9378@mwanda> <20131024122512.GB9534@mwanda>
	<20131026181709.GB10488@kroah.com> <20131027013402.GA7146@leaf>
	<CA+8MBbK3dicmwOJb0mhTwr59O1tqzZgEGmMfSQV61Z=aK_64oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Triplett <josh@joshtriplett.org>,
	Git Mailing List <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>
To: Tony Luck <tony.luck@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 19:34:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbaar-00078V-DV
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 19:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195Ab3J3SeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 14:34:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63523 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754144Ab3J3SeG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 14:34:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88DDD4224C;
	Wed, 30 Oct 2013 14:34:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NZB0Ju8Y2b1f5CBzLvmCqQJT6eE=; b=YQMdW5
	gCfVETfMvIyAJW5Mh3LdCybllVAH65D6Xo4le2I6D3d9TH/GkmBe4MuAokhZePJ+
	gnYba/neJweiubJugbZkCkAlvqRY8LAtK8f+NN22b0px2Lc5xGxn/PtXo10I16Zg
	zrJjsZsPVuIRSQZiPV+n1iPLBk2LG/bpavRVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gWueHMFXFzJLZvS9iv9V9Fz2m77GlKLy
	O0thw0at+YAoOIKkLUnOGGYpdfJ4KtmajxFPc9wbjI5UF//j9ey8AbgBFEnK/SNq
	84EJpMzQx+kfjNdiUr0szfBQa+q1A3Qwt1cvBt0M4Qv7Z0a06MScglfVsXZwQMSU
	i1mDYTE6R+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74ED34224B;
	Wed, 30 Oct 2013 14:34:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32FD642249;
	Wed, 30 Oct 2013 14:34:00 -0400 (EDT)
In-Reply-To: <CA+8MBbK3dicmwOJb0mhTwr59O1tqzZgEGmMfSQV61Z=aK_64oA@mail.gmail.com>
	(Tony Luck's message of "Wed, 30 Oct 2013 10:28:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D80F5D94-4191-11E3-8E58-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237052>

Tony Luck <tony.luck@gmail.com> writes:

> On Sat, Oct 26, 2013 at 6:34 PM, Josh Triplett <josh@joshtriplett.org> wrote:
>
>> +               format_commit_message(commit, "Fixes: %h ('%s')\n", sb, &ctx);
>
> What is the value of double wrapping the commit message inside '...'
> and then ('...')?

Good point ;-)
