From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Thu, 28 Mar 2013 09:10:59 -0700
Message-ID: <7vy5d7v71o.fsf@alter.siamese.dyndns.org>
References: <20130327122216.5de0c336@hoelz.ro>
 <20130327182345.GD28148@google.com> <20130327211554.GH28148@google.com>
 <7vsj3gjy3t.fsf@alter.siamese.dyndns.org> <20130327174845.5e3081d1@hoelz.ro>
 <20130327230943.GA5204@jtriplet-mobl1> <20130327231819.GL28148@google.com>
 <20130328160104.GC16034@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Rob Hoelz <rob@hoelz.ro>,
	git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:11:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULFQK-0001Dw-BO
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756504Ab3C1QLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 12:11:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38713 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756355Ab3C1QLB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 12:11:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88D1FA54A;
	Thu, 28 Mar 2013 12:11:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XjcpEV0i5rhknGg7T/qVfb/kGMQ=; b=UFYEQ1
	N8Y6x552jvAdmCFWRMKROuw3CoZ4B/4jxRCSiOTu+Pnw3tNedd5t63SYUGTRHZq4
	mrjnN+5MX/lgo6flRD0H/vX+T0/KhCOt/X7xqfYBCt5Osi/QPGHwIBDiQPl1AbmR
	IFWdH8ytZ9WokVN6O5IVV0VOl055vsu77TD4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U3Db7Px8DRpAMqrwnAY3xlvMXji6c2uN
	wLK+hHw/M1UKFnjzmZUjWlImupwoK91r1RuW7VSlWMZbDzZ9E5K6C9PoEBqSmBr9
	CDmMY/hRyDLBMh522i8cZb9hzxHfv+Na0EEy/f15Ejk1bZDZBSwCB7VO7CQYZaV7
	oAFMSO4uWz0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F005A549;
	Thu, 28 Mar 2013 12:11:01 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04721A546; Thu, 28 Mar 2013
 12:11:00 -0400 (EDT)
In-Reply-To: <20130328160104.GC16034@leaf> (Josh Triplett's message of "Thu,
 28 Mar 2013 09:01:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 153C6D9E-97C2-11E2-9AA8-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219420>

Josh Triplett <josh@joshtriplett.org> writes:

> OK, I take it back.  I *can* imagine configurations that this change
> would break, since it does change intentional and documented behavior,
> but I don't have any such configuration.  The only such configuration I
> can imagine involves directly counting on the non-rewriting of pushUrl,
> by using pushInsteadOf to rewrite urls and then sometimes using pushUrl
> to override that and point back at the un-rewritten URL.  And while
> supported, that does seem *odd*.
>
> Objection withdrawn; if nobody can come up with a sensible configuration
> that relies on the documented behavior, I don't particularly care if it
> changes.

I actually do.

Given the popularity of the system, "people involved in this thread
cannot imagine a case that existing people may get hurt" is very
different from "this is not a regression".  After merging this
change when people start complaining, you and Rob can hide and
ignore them, but we collectively as the Git project have to have a
way to help them when it happens.
