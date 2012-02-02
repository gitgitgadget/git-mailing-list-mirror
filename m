From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Finding all commits which modify a file
Date: Thu, 02 Feb 2012 11:13:32 -0800
Message-ID: <7vk445vyjn.fsf@alter.siamese.dyndns.org>
References: <5456.38.96.167.131.1328194547.squirrel@mail.lo-cal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Groothuis" <ngroot@lo-cal.org>
X-From: git-owner@vger.kernel.org Thu Feb 02 20:13:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt26G-0005Rx-N5
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 20:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580Ab2BBTNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 14:13:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61054 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754290Ab2BBTNe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 14:13:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 372F46660;
	Thu,  2 Feb 2012 14:13:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sFnNVhqJHsDwKR8Zjvnvfi4TwGs=; b=ruYxJ3
	H2NtY5lLYLstwZaENGYwg5iWNmbwHR+ZeI+X38RNEP6p7WD8uygD2l4ZIFtKN/jH
	4Q59+AC87z/5y/l3vxFZaNG7YnUst7L1mXt4o4MQvTqmrlKB2hT1NzK3k+/4Wj8p
	JuJLNDDnBzLtEfqzeP4MQcfSolfP5yAu7UC4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t94bbCjjWplyDEG1nP6ocKpDLn5JXpl7
	6XST6eTctBLNZlhUD1DnAglgRDiJsaStckBGVePOToY+antzewmSrPAZdsJVKQ0p
	qbrWxXTGgwdBNu4mDJWX+EHQOwxUTWFd5PW0w/QZnD8HzwgKy6GDhLueacwK1d00
	zCe2oXArVLk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EFBE665F;
	Thu,  2 Feb 2012 14:13:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC295665E; Thu,  2 Feb 2012
 14:13:33 -0500 (EST)
In-Reply-To: <5456.38.96.167.131.1328194547.squirrel@mail.lo-cal.org> (Neal
 Groothuis's message of "Thu, 2 Feb 2012 09:55:47 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0017234A-4DD2-11E1-81DC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189676>

"Neal Groothuis" <ngroot@lo-cal.org> writes:

>> "Neal Groothuis" <ngroot@lo-cal.org> writes:
>>
>>> Is there a situation where checking for TREESAMEness before
>>> simplification
>>> is desirable and checking after would not be?
>>
>> When you do not want to see a side branch that does not contribute to
> the end result at all, obviously ;-). Outside that situation, before or
> after should not make a difference, I would think.
>
> In that case, you wouldn't be using the --full-history flag at all, yeah?

Yes. In case my tongue-in-cheek comment was too obscure, I was saying that
I do not think the change to TREESAME-ness check you were alluding to would
break any use case I would think of off the top of my head.

We of course might discover undesired consequences in unexpected corners
after we try your change, but I do not think we can discuss such corner
cases further without seeing a patch.
