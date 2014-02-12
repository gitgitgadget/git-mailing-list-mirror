From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] gc: config option for running --auto in background
Date: Wed, 12 Feb 2014 09:36:28 -0800
Message-ID: <xmqqmwhwnsgz.fsf@gitster.dls.corp.google.com>
References: <xmqqd2j2afup.fsf@gitster.dls.corp.google.com>
	<1391843332-20583-1-git-send-email-pclouds@gmail.com>
	<1391843332-20583-2-git-send-email-pclouds@gmail.com>
	<CABPQNSb3=i8F+vPEG3RmH+snZVZ-xrPtcVY2Nx9uvyTCLXcy6g@mail.gmail.com>
	<CACsJy8BBQ3Bh6q6JM8V-QVKfzwp1w99+u4_55jjGbHLV3c62gA@mail.gmail.com>
	<xmqqob2est9c.fsf@gitster.dls.corp.google.com>
	<CAPc5daW3VwLutU8JZu9fBbGtihw5X_bE9M31ugzqN9mEnFYNNQ@mail.gmail.com>
	<CACsJy8CyAsA5VA-s_c7juaRyToRU+QzJsYZDvzD5ggaR6=9FOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	chris <jugg@hotmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 18:36:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDdjl-0004Co-9G
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 18:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475AbaBLRgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 12:36:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49477 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793AbaBLRgg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 12:36:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 974586A5E1;
	Wed, 12 Feb 2014 12:36:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c8BBkJC6ztIVd6R1B056g76dgho=; b=OWHGFZ
	74HDgKi9yPFAWkCaAz8Fp/RqJ1sosEHnYGxjPdjG2A9n7+d9WNC8oz7FYZqp3qF8
	pP+e3kH95tCKQ+Aryd103RZCUdMbk449b9PI5LSIB0tBSJ6wVWyPswADfu35RO1y
	LzvECyA1eEZewYpf5Q3Tc76TjlzbdcCjuChaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mYor9pdgZ+/BU7rCv5O6ZGdleB9N10Oq
	RBQq63e4pyplNLMMbe30WFICf4APl2W+bmcN8vK2hX85Ec7e1XO5udmJpg70tl3z
	cRjzpayU1ypk1TIlXvDh3DQabun0ayCnVRe1UFF9U7MdPLDjMzHDwcOTrrpilMuj
	8qD7y94srVc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9546C6A5DD;
	Wed, 12 Feb 2014 12:36:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AFBE6A5DB;
	Wed, 12 Feb 2014 12:36:30 -0500 (EST)
In-Reply-To: <CACsJy8CyAsA5VA-s_c7juaRyToRU+QzJsYZDvzD5ggaR6=9FOg@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 12 Feb 2014 08:53:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 351825DA-940C-11E3-AC57-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241999>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Feb 11, 2014 at 2:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Mon, Feb 10, 2014 at 10:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> If --quiet is set, we should not be printing anyway. If not, I thinkg
>>>> we could only print "auto packing in background.." when we actually
>>>> can do that, else just print the old message. It means an #ifdef
>>>> NO_POSIX_GOODIES here again though..
>>>
>>> Didn't you change it not to die but return nosys or something?
>>
>> Ah, the problem is that it is too late to take back "... will do so in
>> the background" when you noticed that daemonize() did not succeed, so
>> you would need a way to see if we can daemonize() before actually
>> doing so if you want to give different messages.
>>
>> "int can_daemonize(void)" could be an answer that is nicer than
>> NO_POSIX_GOODIES, but I am not sure if it is worth it.
>
> Or we could pass the "quiet" flag to daemonize() and let it print
> something in the #ifdef NO_POSIX_GOODIES part.

Hmph...  What would that something say?  "I was asked to gc in the
background but I can't here" is not suitable for daemonize() that is
not specific to "gc".

The flow I had in mind was something along the lines of this

	if (!quiet) {
        	if (detach_auto && can_daemonize())
                	say "auto packing in the background";
		else
                       	say "auto packing"
	}
        if (detach_auto && can_daemonize())
        	daemonize();

If we had daemonize(noisy=1) and coded it this way:

	if (!quiet)
        	say "auto packing";
	if (detach_auto)
        	daemonize(!quiet);

we could do something like:

	daemonize(int noisy) {
        	if (noisy && !defined(NO_POSIX_GOODIES))
                	say ", and doing so in the background";
		... do the actual daemonizing ...
	}

but that feels ugly.
