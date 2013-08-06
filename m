From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase -i error message interprets \t in commit message
Date: Tue, 06 Aug 2013 10:47:55 -0700
Message-ID: <7v1u66hfsk.fsf@alter.siamese.dyndns.org>
References: <87k3jy6cyc.fsf@fencepost.gnu.org>
	<CALkWK0mg4FTONDieaaW+OV0cbUpzb46gj39NcNmBMXSyey_JKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 19:48:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6lMb-0001SS-9L
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 19:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756496Ab3HFRsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 13:48:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50879 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756464Ab3HFRr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 13:47:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37E3D36350;
	Tue,  6 Aug 2013 17:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k/1xwHMOQPnymcAZZZ6oDjkBr+c=; b=G6DLTo
	HBEBla8wLcXJgUoQXhowJxYGe4HhmaNECrgZoWd6oYU6RiiLjPf8UTcR/8WEwDcx
	nSbxTHOP3vdlQOq5AbawUxb4fIB7gqEfMjy4QsvvDB7C6n0ra5ZsroNNMwBvi67j
	+CAp+zjxp3Cr+JHS7X4zCXwM3kM0lStsdfC6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c+Itr6tbluMKySK3rq97IgCpAynIwg/q
	eug7W/116DB1A6zavEUgEiCXDZxIWYnHfMFikAYLWGhxN2e0v4yLTzow9DYqxe+q
	IDfh3w+F4GI2YFahhinRB25HdKUtzGmPwNerMFZnoDSyCU8Fp/KLSGYeUUnvj85X
	79dUAiC9hFE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C2B83634F;
	Tue,  6 Aug 2013 17:47:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B51883634D;
	Tue,  6 Aug 2013 17:47:57 +0000 (UTC)
In-Reply-To: <CALkWK0mg4FTONDieaaW+OV0cbUpzb46gj39NcNmBMXSyey_JKQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 6 Aug 2013 21:31:04 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5464BF66-FEC0-11E2-8234-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231768>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> So, it's the shell script.  Now, read about shell escaping [1] and
> submit a patch.

This is not about shell escaping at all.  I think the message is fed
to echo as-is, or to printf as its first parameter.
