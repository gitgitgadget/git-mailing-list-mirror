From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/1] refs.c: use a stringlist for repack_without_refs
Date: Thu, 20 Nov 2014 11:01:33 -0800
Message-ID: <xmqqppch3dde.fsf@gitster.dls.corp.google.com>
References: <20141120021540.GF6527@google.com>
	<1416506666-5989-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sahlberg@google.com, git@vger.kernel.org, jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 20:02:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrX0B-0006JU-0o
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 20:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757268AbaKTTCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 14:02:43 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65255 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755664AbaKTTCm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 14:02:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 943FF1FAA2;
	Thu, 20 Nov 2014 14:02:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HE/dOm62H1GekwwpLw4M5LSA5EY=; b=jOaGsD
	g7VGnSnWmZoQlx8abKBCOVa73ZXgdvevnm/7ygqWCDSMNthuLm68gTejgxiCne2Z
	VYU1ePLmLgpo8SFxvFLv2Hn7MRfDs0ZhKQ6UFNiEhOqebdHBbQVG434Z9NuQXMIg
	psXahfDn9c0a+C0GAM+pi9k8BxJRQDpojkkBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WRUPo0i52ytyIJzz5rjFiM6Ux7GZDFlp
	0RWS4pXAvHr3qGZx5/Flb/QOSAoggttC0oiSpwLXDMBzCCS0XQUXZIGnHMdtqTe4
	rX0DJGch1IhsmP1pIM/wAdREZEyMT4hjJFC/885yrm3hQCPo2FeCL5EimoBfurz5
	hwFWbWRTIWI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A2EA1FAA0;
	Thu, 20 Nov 2014 14:02:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D42DE1FA43;
	Thu, 20 Nov 2014 14:01:34 -0500 (EST)
In-Reply-To: <1416506666-5989-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 20 Nov 2014 10:04:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A5C3F698-70E7-11E4-AE41-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>  Junio, I'll address your proposed changes in a different patch. 
>  If err is passed in as NULL, we'll just skip all the error string 
>  formatting and return silent and fast.

Huh, I lost track, but I never meant to say "the functions should
return silently with error code when err == NULL".  I said that it
is another plausible expectation, hence justifies the comment to
clarify, but wished that there were no need to clarify in the first
place.

If everybody required err != NULL, there would be no need to clarify
which functions require err != NULL.  If everybody accepted err ==
NULL as a more efficient way to do "--quiet", that is another way to
remove the need to clarify.

Either way is fine and I did not "propose" anything ;-).

I think this matches more-or-less what I've locally tweaked after
following the discussion between you and Jonathan.  Thanks.
