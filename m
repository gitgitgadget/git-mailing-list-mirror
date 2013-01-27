From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote-testpy: fix patch hashing on Python 3
Date: Sun, 27 Jan 2013 12:11:20 -0800
Message-ID: <7vr4l6v11z.fsf@alter.siamese.dyndns.org>
References: <cover.1358686905.git.john@keeping.me.uk>
 <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk>
 <20130126175158.GK7498@serenity.lan>
 <7vwquzzkiw.fsf@alter.siamese.dyndns.org> <5104B0B5.1030501@alum.mit.edu>
 <20130127141329.GN7498@serenity.lan> <20130127145056.GP7498@serenity.lan>
 <7vzjzuv224.fsf@alter.siamese.dyndns.org>
 <20130127200401.GT7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 27 21:11:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzYZs-0006DT-Ub
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 21:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755915Ab3A0ULY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 15:11:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39362 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755866Ab3A0ULX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 15:11:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1890C5BB;
	Sun, 27 Jan 2013 15:11:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hbqnnbKVx6tb+/iD39XXiF5H9Xw=; b=xr4CGS
	lZusorB3iGzPtS5GYGl1HzVBFi+Tspy6lb2uNqerJyj0sqcP3A5R8K87j4V42WGH
	gVG6aiSMKbvg1dm50XBgB3fPpLuw4RLTId6e5Ty9Hu9oKbQGGZgI94aoRAjwHYVo
	L0TsqBRPBURqUTqp45R7YnDhas3wqiU8eZvdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U6pHt5y0kGsRSeXO9OyHZlVY00piqWbf
	C9mAlXQgLBju8TMQoIplvT8qJLgcBB/V8u6Swh+cUlVeNNSnrixnPNTCJycNbNLa
	T4hTIMuuCS9GWuDA1/v19heQvjyeuSShuPZJZO0h3nL641mtvkJ8VPfPaykF/Ak9
	lSBeSKQgPVE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A123AC5B9;
	Sun, 27 Jan 2013 15:11:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3718BC5B8; Sun, 27 Jan 2013
 15:11:22 -0500 (EST)
In-Reply-To: <20130127200401.GT7498@serenity.lan> (John Keeping's message of
 "Sun, 27 Jan 2013 20:04:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B82932F0-68BD-11E2-8088-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214725>

John Keeping <john@keeping.me.uk> writes:

>> Thanks; will queue and wait for an Ack from Michael.
>> 
>> Does the helper function need to be named with leading underscore,
>> though?
>
> ...  Since this is a script
> not a library module I don't feel strongly about it in this case.

That is exactly why I asked.
