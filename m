From: Michael G Schwern <schwern@pobox.com>
Subject: Re: git-svn SVN 1.7 fix, take 2
Date: Tue, 24 Jul 2012 16:06:27 -0700
Message-ID: <500F2A73.4000502@pobox.com>
References: <500F17A3.60307@pobox.com>
 <7vipdcesk6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Robin H. Johnson" <robbat2@gentoo.org>,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 01:06:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StoBX-0005h1-1s
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 01:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968Ab2GXXGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 19:06:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34641 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754857Ab2GXXG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 19:06:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E043C85E3;
	Tue, 24 Jul 2012 19:06:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=OM8+Y5yb6pJh
	dGKPdZw67CSQtgs=; b=OtG0PLR2fYmfY3An2dKT47SgixSA2t6cV8BJt668VUKf
	RUqHQYGkoDbGRNeaAfVvEZUi2/SENmtJdFstcGNcKmZvzYyRCZAvreL0RhmlyP6c
	c8Y4AaHFdkIJObHHxUYF9WkkGTArZBD7FpV4odGWrp+iTOYL8X8lqxThgAAhdwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xQ3GTW
	vWH7+VLzLOseHZB8/GAzDAjMzLxgRFEgsZTZlxQL9vHN6nvXMpC5PTuPFyPt9AgH
	ZBWVVQox3VmrV0LTeapbF3V04x+5koAHKP5WyJan/HsyWqS7ieUzXYj+SokQcOGS
	RQgD48wWNR/Z/2TfKdRA2/SW1xQFaOtMeymzA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB30485E1;
	Tue, 24 Jul 2012 19:06:28 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC19785DE; Tue, 24 Jul
 2012 19:06:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vipdcesk6.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 331E5CFA-D5E4-11E1-B7B0-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202084>

On 2012.7.24 2:51 PM, Junio C Hamano wrote:
> Michael G Schwern <schwern@pobox.com> writes:
> 
>> A big one is "do not blast 10 emails to a mailing list" but I gather that's ok
>> here if a submission needs 10 commits to be well expressed and its done via
>> git-send-email?  And then if patch #3 needs revision I'm to do it in a rebase
>> and resend the whole 10 commits?  Am I to think of git-send-email less as a
>> means of sending patches to a mailing list and more as a git transport mechanism?
> 
> Yes, yes and whatever (even though I think send-email is just a
> better MUA/MSA when you want to send patches and isn't restricted
> for a _git_ transport, I do not think it matters how you look at it).

#3 was not intended as a dig.  If I can think about git-send-email like a
funny way to do a git-push then that fits better in my head.  I worry about
sending too many emails to a list at once.  I don't worry about sending too
many commits in one push.


>> I'm trying to bust it up into easier to digest pieces.  I came into this cold
>> without much knowledge of the problem ("something to do with
>> canonicalization") and no knowledge of the code.
> 
> Perhaps it is a good idea to lurk and see how others submit their
> topics first?

While I use git heavily I'm not invested in working on it.  I work on a lot of
projects.  I'd like to be able to do the work, submit it, work through review,
and get out without joining another mailing list and studying their culture.

Is there a document I could look at for submitting a large body of work, or
could I help improve SubmittingPatches to document the process better?


-- 
I do have a cause though. It's obscenity. I'm for it.
    - Tom Lehrer
