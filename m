From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Wed, 22 May 2013 15:53:25 -0700
Message-ID: <7v8v36iq3e.fsf@alter.siamese.dyndns.org>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 00:53:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfHuX-0004mF-Fu
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 00:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757029Ab3EVWx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 18:53:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60234 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756843Ab3EVWx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 18:53:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 135552100B;
	Wed, 22 May 2013 22:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qOilZ41nx1v4b6nfk+0GTmbCLTo=; b=RuXJ0l
	iktCYI2JQBDjF6wNOBijRsCJvoSQPMtu9n77Y6/2kBKkhp74kKXProZVFzXs+bBz
	g40dAnl1w9EXD1xhRV3WbHA7Od2m2bHtWf8ow5HN4Vijh/E8O6WcLi/rkyGsvXwY
	qtsBG/u8ZIifQw0YmkHKYrXhNVgywY88LERUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lSrfY6uV0dLoW2yBc+cPwHBiV/DNefiu
	3/obFgmaoRGMtyYqbrOh2Vo8umt9ei6Gdrg4wYioFjSrO2wnNzeHwTn9SuT+QMEX
	lbcJZFeaIKN3EY3TCV5MrapAn84kq/mB1WFgLLUD9F8t3NdJoLY8p+H1p3tJBEJo
	K7JjkjoKfh8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0658421006;
	Wed, 22 May 2013 22:53:28 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D47121005;
	Wed, 22 May 2013 22:53:27 +0000 (UTC)
In-Reply-To: <CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 22 May 2013 17:43:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A59AA58-C332-11E2-A95A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225202>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, May 22, 2013 at 5:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> As I already said in the above, the answer is no, when you are
>> trying to find who moved the code from the original place.
>
> But I'm not trying to find who moved the code, I'm trying to find
> related commits; hence the name 'git related'.
>
> The person who moved the code will be on the list regardless,

That is exactly the point I have been trying to raise.  Does the
person appear in the list when you run blame with -CCC?  You ask for
the body of the function, and the -C mode of blame sees through the
block-of-line movement across file boundaries, and goes straight to
the last commit that touched the body of the function in its original
file, no?
