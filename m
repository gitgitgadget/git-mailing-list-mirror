From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 11/11] Documentation: add documentation for 'git interpret-trailers'
Date: Fri, 04 Apr 2014 15:42:41 -0700
Message-ID: <xmqqk3b4ogwu.fsf@gitster.dls.corp.google.com>
References: <20140401191831.353.99271.chriscool@tuxfamily.org>
	<20140401192023.353.34477.chriscool@tuxfamily.org>
	<20140402003938.GE6851@google.com>
	<CAP8UFD1hrXDdwKokLH_j=vwWoViC9sSJHf0gTFubh-oFQao4MA@mail.gmail.com>
	<xmqqob0gohc2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 05 00:43:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWCpH-0006c9-Ao
	for gcvg-git-2@plane.gmane.org; Sat, 05 Apr 2014 00:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbaDDWmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2014 18:42:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46657 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752341AbaDDWmo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2014 18:42:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 281027949A;
	Fri,  4 Apr 2014 18:42:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dKByd1XiBmnosfpJzxJw2ch7bFY=; b=xcUbYt
	ELOwfI/ayLPCslduoW5V5cBj+hvQeaJ0saxyuh42/2UtfSd6cAEENjuhvN3/QzE2
	PCP2VaU4lGQMpG9vcyjfEd9cqt5T24vVV5gCMk7SUoMHT8UklvEyKLTojVEDkAA/
	HI3K8glQ5kq1R1vrxE+XyAYIMl46Z/zoiGt34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VY0FFrObeAdfCgMKGzlEYwNsrU/xnnva
	mCf2Cy6+19Xc7RuF2cnKZ9kQlM54b3ji8UPLawaqsSdFV3S8FONHTJjADcMxw680
	fzMNwu+YES6ICKuEm0c4e6ije6ILm37psd9cf6jVKTmdTk+8l90yM6fSwyq4EHuh
	MtQMVXg26KI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11A5A79494;
	Fri,  4 Apr 2014 18:42:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DC8A7948F;
	Fri,  4 Apr 2014 18:42:43 -0400 (EDT)
In-Reply-To: <xmqqob0gohc2.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 04 Apr 2014 15:33:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6F4B6DD2-BC4A-11E3-B25B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245776>

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
> ...
>>> Why support both '=' and ':'?  Using just one would make it easier to
>>> grep through scripts to see who is adding signoffs.
>>
>> That was already discussed previously.
>
> I do recall it was discussed previously, but given that a new reader
> posed the same question, I am not sure if the end result in this
> patch under discussion sufficiently answers the question in a
> satisfactory way.
>
> Thanks.

Sorry, I sent out only a half-response before finishing.

>> The reason is that people are used to "token=value" for command line
>> arguments, but trailers appears in the result as "token: value", so it
>> is better for the user if we support both.

While I do understand the part before ", so" on the second line, I
do not see why that leads to the conclusion at all.

Yes, because it is a well-established convention to separate option
name with its parameter with '=', accepting "--option=parameter"
makes sense.  That may result in a string "Option: parameter" added
to the output from the command.  I am not sure why that output has
anything to do with how the command line should be specified.
