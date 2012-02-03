From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH, RFC] Fix build problems related to profile-directed
 optimization
Date: Fri, 03 Feb 2012 11:58:52 -0800
Message-ID: <7vaa4zpu2r.fsf@alter.siamese.dyndns.org>
References: <1328209417-8206-1-git-send-email-tytso@mit.edu>
 <7vvcnpuhpo.fsf@alter.siamese.dyndns.org> <20120202201226.GA1032@thunk.org>
 <7vvcnou40u.fsf@alter.siamese.dyndns.org> <20120203020743.GE1032@thunk.org>
 <7vr4ycsbga.fsf@alter.siamese.dyndns.org>
 <BEE56B27-1C86-4C26-A584-3FF179B7A3D6@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Clemens Buchacher <drizzd@aon.at>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Feb 03 20:59:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtPHg-0004xt-Kb
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 20:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319Ab2BCT64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 14:58:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64240 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309Ab2BCT6y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 14:58:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EBF267CA;
	Fri,  3 Feb 2012 14:58:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6BwBaMGGknAv6Do9+E+wWS31GKU=; b=X56w18
	kqZVUjDWMRITsS7VV0F5GhQ7+GC080h4mV6K+yFax5nhzLfkOXB9U1ju2Gc0Yyn5
	Hdn7lUhGDNUs5LL8UW3A479k+VMlDK/HPI8mtbD7csa3KHcCOZ15y1rt4QqD7uS1
	bs89Tlg3d0Oh5++Vh3CqLDBhZ41ci9U7Ggfpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AF1ytiIYll8151VI0j/BuUD7CD8qQi/W
	UoI0Q4FCDpQJh3EJT5a9m/o6fzLIc38ceZa2XBVY6Lxu7bgV60zMx3xeTS8w9Z8a
	Rt2S7L1FDy6YVHPM8H/3EBwxAkzT8euVvbwqgyjHRBC6sHDUgM5SgTl4HIpDNjMf
	nBlbczoGxyM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55EA967C8;
	Fri,  3 Feb 2012 14:58:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E268C67C7; Fri,  3 Feb 2012
 14:58:53 -0500 (EST)
In-Reply-To: <BEE56B27-1C86-4C26-A584-3FF179B7A3D6@mit.edu> (Theodore Tso's
 message of "Fri, 3 Feb 2012 13:19:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7FD7F954-4EA1-11E1-8EA8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189795>

Theodore Tso <tytso@MIT.EDU> writes:

> On Feb 3, 2012, at 1:00 AM, Junio C Hamano wrote:
>
>> 
>> * I am happy that this version handles this well:
>> 
>>   $ make PROFILE=BUILD install
>> 
>>   even though you did not advertise as such in INSTALL ;-).
>
> I can mention it, although it will mean adding more verbiage about
> profile-directed optimization into the INSTALL.

Oh, sorry, I didn't mean it that way.  Please read it as: "Something that
is a natural thing for people to expect after reading what is in INSTALL
works correctly. Yay! Thanks."
