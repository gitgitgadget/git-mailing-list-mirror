From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git issues with submodules
Date: Tue, 26 Nov 2013 14:19:33 -0800
Message-ID: <xmqqbo16vma2.fsf@gitster.dls.corp.google.com>
References: <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
	<528FC638.5060403@web.de> <20131122215454.GA4952@sandbox-ub>
	<20131122220953.GI4212@google.com> <52910BC4.1030800@web.de>
	<20131124005256.GA3500@sandbox-ub> <52922962.3090407@web.de>
	<xmqq1u24xkjq.fsf@gitster.dls.corp.google.com>
	<5294EC11.2010405@web.de>
	<xmqq1u23vty1.fsf@gitster.dls.corp.google.com>
	<20131126195126.GC4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 23:19:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlQys-0001a1-2i
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 23:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758568Ab3KZWTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Nov 2013 17:19:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59437 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753613Ab3KZWTh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 17:19:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D48D56ECC;
	Tue, 26 Nov 2013 17:19:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8EXtA/sY7zUOHVyIjrM7LXajtzE=; b=bm0PcY
	NHULyow7Rju1l9RzJlEA9r6FWK+otaMjNDb3EfDo/BnbOqPsqoVcF9lgYQ/eU/04
	vtbUupjurWBo1jzsKv+R+YNnNRdT6yKcrmFdB99xfLVjdYGucLsQzLrwi9xj8hR+
	fj25EmcFNMhTIyWTKpr16zh9shgp/L8K6RjaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BHhaH4r9q6LSiSp5BIq0rIz41UM1UEAV
	iMjE1CkVi5fJTB8k9oIUft5VMk/Q0jXLXVVPC1OPTPky8cJObsoQpvhqhhxA5OOR
	q+MNrBLIjTtOimPZ3xKGufyCFPpe+PPhrlg830VSbcGZejN4VJoYuQ3SMrnX0wVy
	VLp0Jb1hrE0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB2E656ECB;
	Tue, 26 Nov 2013 17:19:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21DCC56ECA;
	Tue, 26 Nov 2013 17:19:36 -0500 (EST)
In-Reply-To: <20131126195126.GC4212@google.com> (Jonathan Nieder's message of
	"Tue, 26 Nov 2013 11:51:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D54C3D4A-56E8-11E3-809C-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238398>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>>                                          I have a feeling that the
>> current "not copy to fix it to a stable value, but look into
>> .gitmodules as a fallback" was not a designed behaviour for the
>> other properties, but was done by accident and/or laziness.
>
> It was designed.  See for example the thread surrounding [1]:

OK, thanks.

>
> | And when you are on a superproject branch actively developing inside a
> | submodule, you may want to increase fetch-activity to fetch all new
> | commits in the submodule even if they aren't referenced in the
> | superproject (yet), as that might be just what your fellow developers
> | are about to do. And the person setting up that branch could do that
> | once for all users so they don't have to repeat it in every clone. And
> | when switching away from that branch all those developers cannot forget
> | to reconfigure to fetch-on-demand, so not having that in .git/config is
> | a plus here too.
>
> Thanks,
> Jonathan
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/161193/focus=161357
