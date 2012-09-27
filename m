From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A generalization of git blame
Date: Wed, 26 Sep 2012 23:38:06 -0700
Message-ID: <7vobksrmwh.fsf@alter.siamese.dyndns.org>
References: <89ccf5dd776edc648d488c20214e1105.squirrel@webmail.cs.wisc.edu>
 <CC2642CD25C542A18FB55E7BD58F95E5@PhilipOakley>
 <7vsja5vh2z.fsf@alter.siamese.dyndns.org>
 <72fc15c78ddb6b5c9e95f6b0cd925a26.squirrel@webmail.cs.wisc.edu>
 <7vfw64txa1.fsf@alter.siamese.dyndns.org>
 <a71b0f99366188f023e5bc8a5f704184.squirrel@webmail.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Philip Oakley" <philipoakley@iee.org>, git@vger.kernel.org
To: xmeng@cs.wisc.edu
X-From: git-owner@vger.kernel.org Thu Sep 27 08:38:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TH7jn-00044H-G9
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 08:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617Ab2I0GiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 02:38:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65313 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754124Ab2I0GiI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 02:38:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4208E70B3;
	Thu, 27 Sep 2012 02:38:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UnE42obNKM/7OTMj4MFbFvGdHbk=; b=wpXoXD
	91m8cwkwwyqqRj2/jc+yq6R3jtC4acbyi/SfAAvFHxPeCevfrKrX0JJfX6hxW0ox
	Fjvh/M5ARWH4LJM5ESGdpaDV238B/KH9zPShNEzj9luIw/FwnfcmK1JVGqVwyMHw
	DqQVFQ8+7ZVUBgzx65aEMurQXgmvkC1ZbfnZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H2mJBIWZbllPKW0qfIW0pNJprsmIYq6E
	4g+/DKYfo1ieZQmwJiyHKwuADvSZTZOSJ6n2OWKE2m3JkBShULaZBOVpfDVlLE4z
	35wN/QCGgJl+YNiRP/CMjH544GljBzFgHtmbXZRpr9L7awbiKAPw1BseoOQJrzWc
	I7Hxd4HawO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F66670B2;
	Thu, 27 Sep 2012 02:38:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 853CA70B1; Thu, 27 Sep 2012
 02:38:07 -0400 (EDT)
In-Reply-To: <a71b0f99366188f023e5bc8a5f704184.squirrel@webmail.cs.wisc.edu>
 (xmeng@cs.wisc.edu's message of "Wed, 26 Sep 2012 23:18:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5DE2972-086D-11E2-BD50-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206463>

xmeng@cs.wisc.edu writes:

>> It largely depends on how the user would interact with your program,
>> which is totally unclear as we haven't seen any part of it.  I do
>> not think we have enough information to answer the question at this
>> point.
>
> Do you mean it largely depends on the diversity of options on input and
> output formats? ...
> ... I know this is not enough for a tool. So this is case, does "how the user
> would interact with your program" mean that I should add ...

I am not saying anything about what you should or should not do. It
is your program, and we haven't seen anything about it, other than
handwaving, what good it will do to its users, so I am not qualified
to make such a comment on it yet.  What I meant by "how the users
would interact with..." are things like this:

 - Why users would want to use it in the first place?  What are
   missing from existing tool set?

 - What kind of questions do users ask to the program and how do
   they ask them?

 - How are the answers to these questions presented by the program
   to the users?

 - How do users interpret and use these answers in what way?

Notice that I didn't include "How do you compute the answers?"  When
we are initially evaluating a feature at "how do they interact" level,
we are not interested in the implementation at all.
