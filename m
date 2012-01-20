From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: Provide an empty file when no base exists
Date: Thu, 19 Jan 2012 23:39:16 -0800
Message-ID: <7vty3qg6vv.fsf@alter.siamese.dyndns.org>
References: <7vhazqhn8u.fsf@alter.siamese.dyndns.org>
 <1327043453-80965-1-git-send-email-davvid@gmail.com>
 <7v7h0mhm8g.fsf@alter.siamese.dyndns.org>
 <CAJDDKr490XFqGe+y1pa7fnNhPMRE3ZR3=A+_XNUrCA1GZv+wkw@mail.gmail.com>
 <7vy5t2g6za.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, jcwenger@gmail.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 08:39:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro94F-0002pp-C5
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 08:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107Ab2ATHjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 02:39:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743Ab2ATHjS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 02:39:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B29329C5;
	Fri, 20 Jan 2012 02:39:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VHdByy6kOAXoPFfoqvSUMQTnQa0=; b=F4bTNa
	d167IEyXciYLDmwEKceFeG6qoOWwVcs6oywQBz09wm7S6nSyHZMVQwqA8paoJM9m
	eIwRmD1s6BAHGJPFz3HlrcdWcl++28zpbf0NrJo5F/S7R8sdHk47jRSX+rDwlIoB
	fvvFKZ/DDAdrR6VbQjEXhvA9OI0BGCL8CXwiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mJDu2lrszP8ypz8VyI2izWcSZ5mJlzJN
	0lzhRZT94lvOZYFrLUNDem9oHUWbP7PIL08Uve+SyEz3FNb3fQYUW5DODODqdeWP
	pifSXP7tmrB0OlF5d8JB08t6qG8BFpj7lyWUWkLEFUzCMT3p3c73eqHM5XlA5tE6
	NxuojMbc4bc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1297629C4;
	Fri, 20 Jan 2012 02:39:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CF0529C3; Fri, 20 Jan 2012
 02:39:17 -0500 (EST)
In-Reply-To: <7vy5t2g6za.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 19 Jan 2012 23:37:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DBBBF3F6-4339-11E1-8135-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188866>

Junio C Hamano <gitster@pobox.com> writes:

Yuck, sorry for sending out a edit-in-progress copy.

> It almost makes me wonder if the obviously simplest change to make
> checkout_staged_file create an empty file when the asked-for stage does
> not exist, i.e.

It should read

It almost makes me wonder if the obviously simplest change to make
checkout_staged_file create an empty file when the asked-for stage does
not exist is good enough, i.e.
