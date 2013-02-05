From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Tue, 05 Feb 2013 09:38:52 -0800
Message-ID: <7vy5f2slsj.fsf@alter.siamese.dyndns.org>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu> <20130205083327.GA4931@elie.Belkin>
 <5110DF1D.8010505@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 05 18:39:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2mUL-0006Gf-EB
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 18:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383Ab3BERi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 12:38:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878Ab3BERi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 12:38:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B543CCDF;
	Tue,  5 Feb 2013 12:38:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pt+LmF6QiSGQ5fzFPzRviGRyL8U=; b=nw5QYC
	sIJLJbNpRnm9w/J73top8Wqavs3+WpAWQ+/fjaJayYLA2GAYTWkQyJdaP/vellaO
	hzB50hsiAkitcQ1wQIQNPAI8Ra3zZxPHmun7c5CjUM9jPgYpI3I7/6M4doYxSvuR
	owBvQkGEFoiBY7rUwpYT3Tm5V1UG/RSf+r8AM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xgFtThoBCn3Bo5RxEOZdtrtSUyGN1sKL
	pQ72pwf80rx8VfwDzoLQRHFBaLMSfq3kU6ajawDMFiv655Y1oAeSVrexECH+tX7f
	moThwunYVxKbnWCgFwWyKqXjG6gSbuuCrG2uO88wYkUqFb9zjvT8TZbATx283drH
	7hNvIIkMHG0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80A51CCDE;
	Tue,  5 Feb 2013 12:38:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2874CCDD; Tue,  5 Feb 2013
 12:38:53 -0500 (EST)
In-Reply-To: <5110DF1D.8010505@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 05 Feb 2013 11:29:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E91B646A-6FBA-11E2-8D50-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215524>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 02/05/2013 09:33 AM, Jonathan Nieder wrote:
>> Michael Haggerty wrote:
>> 
>>> I would again like to express my discomfort about this feature, which is
>>> already listed as "will merge to next".  Frankly, I have the feeling
>>> that this feature is being steamrolled in before a community consensus
>>> has been reached and indeed before many valid points raised by other
>>> members of the community have even been addressed.  For example:
>> 
>> In $dayjob I work with Gerrit, so I think I can start to answer some
>> of these questions.
>> 
>>> * I didn't see a response to Peff's convincing arguments that this
>>> should be a client-side feature rather than a server-side feature [1].
>> 
>> The client can't control the size of the ref advertisement.  That is
>> the main motivation if I understood correctly.
>
> Not according to Junio [4]:
>
>   Look at this as a mechanism for the repository owner to control the
>   clutter in what is shown to the intended audience of what s/he
>   publishes in the repository.  Network bandwidth reduction of
>   advertisement is a side effect of clutter reduction, and not
>   necessarily the primary goal.

See my response to Jonathan.

> Hiderefs creates a "dark" corner of a remote git repo that can hold
> arbitrary content that is impossible for anybody to discover but
> nevertheless possible for anybody to download (if they know the name of
> a hidden reference).

That is why allow-tip-sha1-in-want is a separate opt-in feature only
the server side controls.
