From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature "git tag -r" to show tags and commits they are pointing
 to
Date: Thu, 22 Oct 2009 14:35:46 -0700
Message-ID: <7vr5svf6x9.fsf@alter.siamese.dyndns.org>
References: <76c5b8580910221424n220449b9vda26f032174b6fa7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 23:36:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N15KB-0003cA-Gf
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 23:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277AbZJVVft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 17:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754917AbZJVVft
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 17:35:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58183 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620AbZJVVft (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 17:35:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 230AC81D71;
	Thu, 22 Oct 2009 17:35:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IMv7MW2AIplRsj670e0/qbex4yg=; b=rFkWBN
	lfytFVT0Tk4RUD7fLWNhcGKePEbz6EETLSQEPJfpFi5NG6UIJMNqP6PHbIwhKsVy
	ghC4tAUF2GJG3UntW/Dbflwh2l2OpCeWxTN1LjLwhHnAT1jIMUKZZoaKcPkJiyWf
	ngJiGolXXQ1WSp/cO23PXpX8+DhtI4gqoXHYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=upcgTEie4HuKj/MfM5Lby6XvBw1O3WA3
	wk5VUaoSZRNiSVVXC48sI8Uqaxcjqi1QUdXNX44UkhakDeea43GLoX53E4a9/vNp
	/m4UeO6aJNFSM2qe4huMQB/Nsxa/EsfPXhOj4vWP8CRpzkWCocAzBhbTws2sDpax
	oXXtddg/z5o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 057AF81D70;
	Thu, 22 Oct 2009 17:35:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EE9D881D6E; Thu, 22 Oct 2009
 17:35:47 -0400 (EDT)
In-Reply-To: <76c5b8580910221424n220449b9vda26f032174b6fa7@mail.gmail.com>
 (Eugene Sajine's message of "Thu\, 22 Oct 2009 17\:24\:20 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE8E788C-BF52-11DE-B5FF-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131067>

Eugene Sajine <euguess@gmail.com> writes:

> Hi,
>
> Currently there is no way you can get the commits your tags are
> pointing to by using git tag.
> The only way i found is to use rev-parse (which is by the way not
> supported by the bash_completion)
>
> It seems reasonable to have upper level command like:
>
> $ git tag -r
>
> to output
>
> v0.1  8794hke84f9e8h9ef9eh949793...
> v0.2  jhkd934398e9f499f47w9789o97...
>
> $ git tag -n -r
>
> v0.1 "super message"     8794hke84f9e8h9ef9eh949793...
> v0.2  "another message" jhkd934398e9f499f47w9789o9f...
>
> $ git tag -r v0.2
> v0.2  jhkd934398e9f499f47w9789o9f...
>
>
> What do you think?

Not intereseted at all, as this does not look anything more than "because
I could", not "because this is useful and sorely lacking".

The "super message" and such are actually useful to humans, but "v0.1" is
much more useful than 8794hke to humans, and these tag names are just as
usable as the hexadecimal commit object names to the tools.  You can say
"git show v0.1^0" and "git show 8794hke" and get the same thing.

Heck, "8794hke" is not even hexadecimal, and the fact that you did not
even notice it is a _S*RE_ sign that they are not useful to humans.

If you _are_ a human, that is ;-)

In other words, please do not justify such a proposal with "I want to have
'git tag' command to show the commit object name".  Rather, justify _why_
(1) you _need_ to show the commit object name to begin with, and (2) the
output _has_ to come from 'git tag' and not 'git rev-parse'.
