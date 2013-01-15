From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] config: Introduce diff.algorithm variable
Date: Tue, 15 Jan 2013 09:09:28 -0800
Message-ID: <7va9sa4blj.fsf@alter.siamese.dyndns.org>
References: <cover.1358193364.git.mprivozn@redhat.com>
 <f76708fc2a1dc33f3f9c67688ef5709302b56cbb.1358193364.git.mprivozn@redhat.com>
 <7v38y3a31k.fsf@alter.siamese.dyndns.org>
 <20130115165822.GB29301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Privoznik <mprivozn@redhat.com>, git@vger.kernel.org,
	trast@student.ethz.ch
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 15 18:09:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvA1I-0000o3-OM
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 18:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756697Ab3AORJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 12:09:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47479 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756494Ab3AORJb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 12:09:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B23D0AAE3;
	Tue, 15 Jan 2013 12:09:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+aw4lm5XHJo7wps+K25e9ABHPCM=; b=oWVQZK
	lPuItBHfh2MvV0u48a+JCjZBmdgKqy2q8CXo102TZx8V64a53+Q5bvIoZmr9dX7W
	XxXQV3q+7eqF2B/546acez0PvGz2NiiElniozILOfexD1prOLhpgEyvO27kEjIzP
	4Gvn6MRgzMtZETxKIGbLe0YySJIs2eO+tPw1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XGYvgIHF9nlcTwbkGdER3Lvx57h/PAdH
	Yhcp0bS9oJbse+h1azidQrXOuSwgLWfmkdQg8HsuhbclaogxUjo/edRrOt9qBqhu
	bJKhnas4aHRR7WWuONdxC9DXE2ZOKmL+ekDfhhWRNhWwa6oGQzxe19XIADnMZdDx
	sX5EdXH3Qyk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A567AAAE2;
	Tue, 15 Jan 2013 12:09:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A84BAAE1; Tue, 15 Jan 2013
 12:09:30 -0500 (EST)
In-Reply-To: <20130115165822.GB29301@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 15 Jan 2013 08:58:23 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 531300A2-5F36-11E2-9C00-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213652>

Jeff King <peff@peff.net> writes:

>> Also it is rather unusual to parse the keyword values case insensitively.
>
> Is it? "git grep strcasecmp" shows that we already do so in many cases
> (e.g., any bool option, core.autocrlf, receive.deny*, etc).

Yeah, I did the same grep after I wrote the message.  Thanks for
saving me the trouble of reporting the findings ;-)
