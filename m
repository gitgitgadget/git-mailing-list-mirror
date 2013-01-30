From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Files excluded but not ignored
Date: Wed, 30 Jan 2013 08:17:21 -0800
Message-ID: <7v38ximyr2.fsf@alter.siamese.dyndns.org>
References: <loom.20130130T161911-66@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jason Wenger <jcwenger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 17:17:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0aM6-0008KT-Ph
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 17:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193Ab3A3QRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 11:17:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55509 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753845Ab3A3QRY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 11:17:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB1C2C205;
	Wed, 30 Jan 2013 11:17:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MM/+/CO8ElsOK5hzrfLj4IDTAbc=; b=Kzg1lG
	0IueBfFotOEZFbEXyYGtNh0YegryTh1U0d/AQcRNeJ8c8ezXjtG7x1s16OfJvTm7
	r5iI9enivNzhPdO2hA3MqrDXa7aYJBblYiVRZk0T2gsv+WhzbnYuqgbMPJOO9jxe
	M4RcAX0TERMSudoTBYXMzX/RNwrqi3+C52Ra8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dqDNQ6XVsE+3t1anOJHv8MBYpNMC2TgY
	RI0nopuL7IhRofmXJWQ56o3QQcOCeinnQxgcuA53nV1kx2DLGQXV2imDpU0/vnRI
	LRNoeLEhXi5SbbBtZpoE8hmx49Dvn1FODTM1cye6HrjpT3+SIYg6N7l5i0DfE4IQ
	QqwkIIcyHeE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D03F4C204;
	Wed, 30 Jan 2013 11:17:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57838C202; Wed, 30 Jan 2013
 11:17:23 -0500 (EST)
In-Reply-To: <loom.20130130T161911-66@post.gmane.org> (Jason Wenger's message
 of "Wed, 30 Jan 2013 15:34:42 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8794F736-6AF8-11E2-8883-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215029>

Jason Wenger <jcwenger@gmail.com> writes:

> I prefer to not add core.* files to my ignore listings because I find it helpful 
> to see them in git status -- It helps me notice and clean them up periodically.  
> Not having them ignored is also good ,because it allows git clean to care of 
> core.*  files.
>
> The problem is that git add -A, git stash -u, etc, remain interested in the core 
> files.
>
> Trying to start up discussion of whether there would be merit to a "half-
> ignored" state -- Files which are excluded from tracking, but which still 
> show in git status, and which are removed by git clean.
>
> Not trying to propose yet how .git/exclude or .gitignore would be formatted 
> or anything like that.  Just looking for opinions on whether such a state 
> would be considered by the community as a good thing and merit the added 
> complexity in the code.

I see no merit for "ignored and never to be tracked, but are still
shown loudly in the untracked list" myself.  Use cases for "ignored
and never to be tracked, but not expendable" class were mentioned
often in the past, though.
