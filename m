From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 0 bot for Git
Date: Wed, 13 Apr 2016 09:15:18 -0700
Message-ID: <xmqqfuuplc2x.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
	<CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
	<vpq60vnl28b.fsf@anie.imag.fr>
	<CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com>
	<vpqoa9ea7vx.fsf@anie.imag.fr>
	<xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com>
	<vpqegaa9i89.fsf@anie.imag.fr>
	<BF053934-BA62-4621-AAAA-11F821B274EA@gmail.com>
	<vpq1t69669d.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Apr 13 18:15:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqNRw-0003QO-Vc
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 18:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbcDMQPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 12:15:23 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754343AbcDMQPW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 12:15:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C2D5526DC;
	Wed, 13 Apr 2016 12:15:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U6tLikjryB6v8vyaUUsRSSbn0fk=; b=vKnwcs
	NMvsiVMEvzBNEn5abMAcMlC8hXSOI0kB3ptaWOjlnSCPn16lq68uR2jVZ0itJoHh
	LIaa5CMQozeZ8uAJ8noeTLb6WO+scb2gfdrcjeNqOQbTklF/aQ7d1hnJgNcNULH+
	Tz1o86gDQjvakgXQujS+2yGMZ43a4bauM9Vmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MdaCD6PlT6C5ldM/jOes6PwTBXQEGykg
	a3my+UHKKh1E9sscEaYSPOZrpFeyh/rpTHoUopPjgHnuA5G800Xm/9RSR4wRUypE
	FyjLoEe6VG4MVoEARvlrXJ4g/yAHENK0bVqq3/I6qQ49tQ156EsJFdSwfLUXFm3/
	KL05w+Gr+Io=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 926AC526DA;
	Wed, 13 Apr 2016 12:15:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F13F5526D9;
	Wed, 13 Apr 2016 12:15:19 -0400 (EDT)
In-Reply-To: <vpq1t69669d.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	13 Apr 2016 14:30:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EAF34F92-0192-11E6-BCD7-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291457>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>>>> True, presumably the Travis integration already solves that part, so
>>>> I suspect it is just the matter of setting up:
>>>> 
>>>> - a fork of git.git and have Travis monitor any and all new
>>>>   branches;
>>>> 
>>>> - a bot that scans the list traffic, applies each series it sees to
>>>>   a branch dedicated for that series and pushes to the above fork.
>>> 
>>> ... and to make it really useful: a way to get a notification email sent
>>> on-list or at least to the submitter as a reply to the patch series.
>> Travis CI could do this ...
> The missing part would be "as a reply to the patch series". When I start
> reviewing a series, if the patch is broken and the CI system already
> knows, I'd rather have the information attached in the same thread right
> inside my mailer.

Yeah, such a message thrown randomly at the list would be too noisy
to be useful, but if it is sent to a specific thread as a response,
it would grab attention of those who are interested in the series,
which is exactly what we want.

So with what you added, the list of what is needed is now:

 - a fork of git.git and have Travis monitor any and all new
   branches;
 
 - a bot that scans the list traffic, applies each series it sees to
   a branch dedicated for that series and pushes to the above fork;

 - a bot (which can be the same as the above or a different one, as
   long as the former and the latter has a way to associate a topic
   branch and the original message) that receives success/failure
   notice from Travis, relays it as a response to the original patch
   on the list.
