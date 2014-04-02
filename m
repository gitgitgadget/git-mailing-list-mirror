From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git feature request: Option to force Git to abort a checkout if working directory is dirty (i.e. disregarding the check for conflicts)
Date: Wed, 02 Apr 2014 10:55:59 -0700
Message-ID: <xmqq7g77vcnk.fsf@gitster.dls.corp.google.com>
References: <004d01cf49d7$c8b9cd90$5a2d68b0$@jonasbang.dk>
	<xmqqk3bfedqi.fsf@gitster.dls.corp.google.com>
	<002001cf4b44$fe3550c0$fa9ff240$@jonasbang.dk>
	<xmqqha6e8f67.fsf@gitster.dls.corp.google.com>
	<002a01cf4dd3$d88c8640$89a592c0$@jonasbang.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Jonas Bang" <email@jonasbang.dk>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:04:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeTY-0000xS-Nf
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932816AbaDBR4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 13:56:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50211 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932810AbaDBR4D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 13:56:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D207C77195;
	Wed,  2 Apr 2014 13:56:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/H4BvkMJIiPmDqtAO1uZ3u7AqTA=; b=Azp5Rq
	iPQ3ZQdNYsx6ZCeM2jCOKk+pAL1AZACFBl7bhafCkzpr5bySWLFkf+p+NWxLTCKM
	p61UkwaWW5dvd1l81Z13dU+NBCzhn3yylFLWD87slLVySNDksJ6DODo8+n3+gubR
	YuBa7SIixhAkBApHQuwrqOsfgjCcM6yYFfSIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VQpRINn2JfVIrtnpscrMUqcgXpHBlLc0
	Z3/x5CAiLaZ43VqLH00PcoXm7hw6CcmkXVQic5x+zEMlh5zkyaqMXgNcfLf5oVwB
	M9Oha5j3ayEEvn29JYk2jIHO/KLU7f9CFH4K4fdwmIVa6O/fam6kdt4OtrvOVQMm
	eVSyzr90q74=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDC8277193;
	Wed,  2 Apr 2014 13:56:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBD4B7718E;
	Wed,  2 Apr 2014 13:56:00 -0400 (EDT)
In-Reply-To: <002a01cf4dd3$d88c8640$89a592c0$@jonasbang.dk> (Jonas Bang's
	message of "Tue, 1 Apr 2014 19:57:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0D100CBA-BA90-11E3-9E3F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245703>

"Jonas Bang" <email@jonasbang.dk> writes:

>> >> ...  The default behaviour would cover their
>> >> use case so your proposal would not hurt them, but I wonder if there
>> >> are things you could do to help them as well, perhaps by allowing
>> >> this new configuration to express something like "local changes in
>> >> these paths are excempt from this new check".
>> >
>> > Yes, those people would probably use the default 'false' behavior as
>> > it is already. If they however would like to use e.g. the 'true' or
>> > 'include-untracked' setting as a configuration variable, then they can
>> > use the command line option 'false' if they wish to do a 'git
>> > checkout' even with modified files in the working tree.
>> 
>> So in short, you are saying that "The added code necessary to implement
>> this feature will not help them in any way, it is just that we
>> will make sure it does not hurt them".
>
> I didn't realize they needed help.

If so, then you could have just stated that way, instead of saying
they have an escape hatch ;-)

It is perfectly fine to answer to "I wonder if there are things you
could do?" with "No, I am not going to help them with this series; I
only make sure I do not hurt them."  and that is perfectly fine, as
long as:

 - you do not directly hurt them with your series; and

 - you do not make it harder for those who are interested in helping
   them to build on top of your work in the future.

> How and who to decide if this is a reasonable feature request to accept?

As this project primarily works on "scratch your own itch" basis,
somebody who (1) thinks that the proposed feature is worth having in
our system and (2) is interested in working on it will pick it up.

If nobody is interested, then usually nothing happens.
