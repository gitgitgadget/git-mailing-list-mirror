From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Corruption of branch?
Date: Mon, 14 Dec 2015 12:42:05 -0800
Message-ID: <xmqqr3ioiwyq.fsf@gitster.mtv.corp.google.com>
References: <566EFF11.6010600@gmail.com>
	<CAGZ79kaUw8Hb_7hdAUbvmnmXvm3a-77j5t3zeyQ-7BqwPCSp+A@mail.gmail.com>
	<566F05B2.8080403@gmail.com>
	<1450120801.1678.13.camel@twopensource.com>
	<566F1F96.4060806@gmail.com>
	<1450124302.16044.1.camel@kaarsemaker.net>
	<566F277F.4070101@gmail.com>
	<1450125640.16044.4.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Nyberg <tomnyberg@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 21:42:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Zwj-0007Bz-9i
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 21:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbbLNUmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 15:42:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752975AbbLNUmH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 15:42:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B53E33AD1;
	Mon, 14 Dec 2015 15:42:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QEoGCew3hyGTn3MrDwaRAWpVEbc=; b=TgUDox
	jggwJk3cV5Aac2d5Ly7FfZqa296NOySj9iHQAl+zlRncyjXMJqbiuCt53Pz0JmTI
	glsrh7Wp+VTBRhkdTK35Mb4pUcilA+hOTUzNwToZpwFw5q7qwEPgl4/Z9j0upUWK
	1KJfD6EsOaVz+TVS2HHnBxfUYJHLrQ1yhtofI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CeFlTI0cHH6oEU6oIZyc5A/Ya9QSrJkV
	+AkLPJp9PNOl7lD3/cdaOB9tU5B/OmmR4XX+A3fGnsQIAxEh2UDYIyLJBs61kzIR
	PRvgwqnV7wapLXw6OQ+sPLtEuBt3Edgq8ku0B+zdWJDGVAayngxo0bXdl0H1TNO4
	Qib5u4iO5yo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 12B3033AD0;
	Mon, 14 Dec 2015 15:42:07 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6B14D33ACD;
	Mon, 14 Dec 2015 15:42:06 -0500 (EST)
In-Reply-To: <1450125640.16044.4.camel@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Mon, 14 Dec 2015 21:40:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 23983398-A2A3-11E5-A954-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282406>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> That leaves only one option: you also have a file or directory named
> 'frus' in the root of your repository. In this case 'git checkout frus'
> does the same as 'git checkout -- frus' instead of DWIM'ing 'git
> checkout frus' to 'git checkout -b frus origin/frus'

;-)  That would be my guess.
