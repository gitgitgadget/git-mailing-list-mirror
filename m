From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] Auto-generate mergetool lists
Date: Mon, 28 Jan 2013 13:50:19 -0800
Message-ID: <7vk3qxugdg.fsf@alter.siamese.dyndns.org>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <7v38xm12kk.fsf@alter.siamese.dyndns.org>
 <CAJDDKr7sQKDNPpaFJi+en479TF=aLXL2pvXODeo6CC3xD1KMGw@mail.gmail.com>
 <7vr4l6yrd3.fsf@alter.siamese.dyndns.org>
 <CAJDDKr75K3RGgU79nrznbpjQMLQGkDs=W8XEofURNsS1X1bvjg@mail.gmail.com>
 <20130128210136.GC7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jan 28 22:50:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzwbH-00030O-S6
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 22:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420Ab3A1Vu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 16:50:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47984 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753085Ab3A1VuY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 16:50:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDC51CCB6;
	Mon, 28 Jan 2013 16:50:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QRRCd2q8tUARziQ52Ydom+Xwm+w=; b=qJ0yIW
	eGVAE28YZB59Bkupu7kISQMZJeDg/eEEsPe3EKB2F9xj6+3k7P/6scsYw8zwWTZ2
	aoSTRhtpIxsXoiRu47h/CeHyZMHlTQ54KSn4NsFZ4fz4gnk7wEPlnEs4EA9B/TB2
	ciz434IxOvuZxIw2zeZq8Hvy1QuoW7yfcaQmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HdfMRszwEIjnbmIg2eiUwEj0jhu/RRcE
	gXIVVkAIYdx4kM/e5lfXFZI2T91gIJitetTZl/FSg6DiptSIIAnPZ8T4DuDaH9aI
	+cXgEBPcRrKBAgYFtkdScScjN9K99LL2x6YtPixfER66WVr4mn2mhE8QdA+f/nyi
	QoEPkHrqqe0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E26A8CCB5;
	Mon, 28 Jan 2013 16:50:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 563A3CCB3; Mon, 28 Jan 2013
 16:50:21 -0500 (EST)
In-Reply-To: <20130128210136.GC7498@serenity.lan> (John Keeping's message of
 "Mon, 28 Jan 2013 21:01:36 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B691A684-6994-11E2-A4CB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214877>

John Keeping <john@keeping.me.uk> writes:


> I've had a quick look and it's quite straightforward to build on top of
> this to get an output format like this:
>
>     'git mergetool --tool-<tool>' may be set to one of the following:
>                     araxis
>...
>                     vimdiff2
>
>             user-defined:
>                     mytool
>
>     The following tools are valid, but not currently available:
>                     bc3
>...
>                     xxdiff
>
>             user-defined:
>                     mybrokentool
>
>     Some of the tools listed above only work in a windowed
>     environment. If run in a terminal-only session, they will fail.
>
> I don't think the suffix form would be too hard either - it just
> requires moving an explicit sort into the top-level shot_tool_help
> function.

I tend to think that one-tool-per-line format like the above looks
nicer.

What are the situations where a valid user-defined tools is
unavailable, by the way?
