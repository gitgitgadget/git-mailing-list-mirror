From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v17 16/48] refs.c: add an err argument to delete_ref_loose
Date: Tue, 17 Jun 2014 10:23:05 -0700
Message-ID: <xmqqoaxrmow6.fsf@gitster.dls.corp.google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
	<1402941859-29354-17-git-send-email-sahlberg@google.com>
	<xmqqd2e8o05p.fsf@gitster.dls.corp.google.com>
	<CAL=YDWmHg8b0qGqWjSy+0mT20mGgbADnteNKzd5A6OC-VUrsUA@mail.gmail.com>
	<CAL=YDWmGkPMYT8vFYxGa7z3wAwEPMqDy7S8cx4s=9c1DhV9VqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 19:23:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwx6e-0006lS-Uc
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 19:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460AbaFQRXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 13:23:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64989 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755436AbaFQRXM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 13:23:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B02161F1D6;
	Tue, 17 Jun 2014 13:23:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yJBU6+u9bVc1agRiIAIcI3sEe50=; b=TwowTB
	BjywM4C0gEHaLqmzNegng7ZIkpiAZN46SfSwEI8Cght5D2U+Yufv0V4iInsTFZUH
	9MGkOz1gCiQjzOz1iZRJhcQs5iHdME1u7Pt1+ItFExbMU01I273CAYQWskqijVvc
	OeuCfI6OPO/83uWo2Nh/eNOnNaZXcqzaLPYXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=li3SaXqGuKOWiZbfGlgj+c3A6kC54OY3
	cGs02Stbh7OlskbIYkts0Ee+fYFI86Bx7y1Q4JCTW/bKyNL8VLelwnXi9nwh/TO/
	pjY1Pw0J8Cjlo7jq/PmbamdfHwfHcIoQYQX+3oNC1XEf8/b79VzmnikGCe+iAQ34
	s/MDXWfqG20=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A31591F1D5;
	Tue, 17 Jun 2014 13:23:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C5D31F1D3;
	Tue, 17 Jun 2014 13:23:05 -0400 (EDT)
In-Reply-To: <CAL=YDWmGkPMYT8vFYxGa7z3wAwEPMqDy7S8cx4s=9c1DhV9VqQ@mail.gmail.com>
	(Ronnie Sahlberg's message of "Tue, 17 Jun 2014 08:55:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0AFF26E6-F644-11E3-9D18-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251925>

Ronnie Sahlberg <sahlberg@google.com> writes:

> Thanks.
>
> I have rebased it on current master and re-sent it as v18
>
> I passes all tests, except t0008 which is unrelated to this series.

I think You need to either have 97c1364b (t0008: do not depend on
'echo' handling backslashes specially, 2014-06-13), or avoid using
bash (e.g. "make SHELL_PATH=/bin/dash") to make t0008 pass
(cf. $gmane/251634).

Thanks.
