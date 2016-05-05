From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] submodule deinit: require '--all' instead of '.' for all submodules
Date: Thu, 05 May 2016 11:03:28 -0700
Message-ID: <xmqqmvo4bcwf.fsf@gitster.mtv.corp.google.com>
References: <1462401603-2067-1-git-send-email-sbeller@google.com>
	<20160504232642.GC395@google.com>
	<CAGZ79kbeCCcmGh57zUdQ=BzFOWUiwj8-3nM4dbK9yONbrmLaPw@mail.gmail.com>
	<20160504235914.GD395@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 20:03:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayNce-00049W-7q
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 20:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbcEESDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 14:03:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751890AbcEESDb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 14:03:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F7C9172CC;
	Thu,  5 May 2016 14:03:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rqsg0yNjYJk1+HizqmHPEZhQ/xc=; b=SRC9J0
	XKYlvvyVc4hrYOMsoEbdx9pohNL1M2DT4YwDKDRPkm2IqA83kTiwsX/J0iW4OVn7
	ImjZjfsAvt0pfAhfFIIdTMEemhiiJH/li+idecRhzIoqWYuWMCEviFh+WG5anJ2P
	6/Z9YH2ehuVkX5f3nz+bBV2f4W2Ye6jEk/ie8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tMkUKsMppy1Tt0sVnkeJmr7Me6pEvbhS
	tkcVNoWFbS5SSxtFbywaSTD544kwOE2YxvqSMvAIYK+lTqc7TBsKlIy3nssCcHoS
	Avotsj3hgoZl1wdXHwF/NQa51HfR5Rz8PKDEkGrhdU3qyrxYGzzhQf0ThvUbd0NL
	vR91XI/4N4A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 478E3172CA;
	Thu,  5 May 2016 14:03:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD5B6172C9;
	Thu,  5 May 2016 14:03:29 -0400 (EDT)
In-Reply-To: <20160504235914.GD395@google.com> (Jonathan Nieder's message of
	"Wed, 4 May 2016 16:59:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AC3F829C-12EB-11E6-89AC-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293659>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I mean low level as in implementation detail.  The human user would
> wonder "what is incompatible about them?  Why are you stopping me from
> what I am trying to do?"

Maybe s/incompatible/inconsistent/ is what you are after?  Why are
you stopping me from what I am trying to do?  Because you are asking
to do two contradicting things.  Do you want to nuke everything, or
do you want to keep everything outside what you specified?

After being saved countless times from a stupid mistake

    $ git commit -a -s foo.c

that was caused by habitually typing "-a", when I do want to limit
the changes to record to a specific path (or two) with similar
safety, I do not think "what is incompatible about them" is a valid
question.


    
