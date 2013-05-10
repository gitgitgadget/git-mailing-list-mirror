From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] t4300 (rebase): don't unnecessarily set GIT_TRACE
Date: Fri, 10 May 2013 08:42:16 -0700
Message-ID: <7vr4he3kpz.fsf@alter.siamese.dyndns.org>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
	<1368196178-5807-5-git-send-email-artagnon@gmail.com>
	<7vmws2529j.fsf@alter.siamese.dyndns.org>
	<CALkWK0k_ArM9EpY0S7=mbgFpHsoauZCr9e=ESX_CEA5-vRHrHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 17:42:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UapSl-0005k7-00
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 17:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801Ab3EJPmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 11:42:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753719Ab3EJPmS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 11:42:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 740711D14A;
	Fri, 10 May 2013 15:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AW/arSZIjHacxeMDCCTcD/JOV60=; b=pNwmGt
	d9NL3z1mlrDS+7WnKm0ustrOb3DJXVlxNlaG02v5egwuHwsAaboc+xJSa23yUrYC
	ERPu86SHNeDwng+O2I1kTLFFDdD0OqJFfn3DDplVGVnEBXxm6DU/U29Akh0snXpa
	7XGKMEA+P9A+7PEonsP9NbSACrcvsotinnLRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RDxAL6bJpEHv5a5vqBQSJhudCnryIlYp
	XXHjtncfUanR3GIzuajGi7+86wB+oRGjDaPNuchl7JlXGPumM6OSWkm6gBqoM5ZC
	y/1jqn/u+h4JpDjN39jsHYAiyB4Ybb/E3rqa222/VO1MiQLjTX8iUnjO2ut7oe8b
	OIJRtSLo17s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BE5C1D149;
	Fri, 10 May 2013 15:42:18 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0EC31D148;
	Fri, 10 May 2013 15:42:17 +0000 (UTC)
In-Reply-To: <CALkWK0k_ArM9EpY0S7=mbgFpHsoauZCr9e=ESX_CEA5-vRHrHQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 10 May 2013 20:16:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31F443B6-B988-11E2-9998-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223874>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>
>>> A couple of tests execute 'git rebase' with GIT_TRACE set to 1, but
>>> this trace output is not used anywhere.
>>
>> Isn't it shown in "t4300-*.sh -v" output to help the debugger?
>
> Um, but why the GIT_TRACE in just these two places?  Can't I set
> GIT_TRACE=1 when executing the shell script if I really wanted that?

Perhaps because this is a test about "rebase" and a typical debugger
does not want to trace other "git" things while debugging this?
