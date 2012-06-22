From: Junio C Hamano <gitster@pobox.com>
Subject: Re: security flaw with smart http
Date: Fri, 22 Jun 2012 12:34:47 -0700
Message-ID: <7vmx3vp2co.fsf@alter.siamese.dyndns.org>
References: <87fw9ns0cp.fsf@kanis.fr>
 <CAJo=hJvCC8_oFFMyc5Fkweg6A6cSV6z+UxeCkvnU34KQfYx91w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ivan Kanis <ivan.kanis@googlemail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 22 21:35:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si9dC-00055V-QD
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 21:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756339Ab2FVTey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 15:34:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55994 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756203Ab2FVTex (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 15:34:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 131366F09;
	Fri, 22 Jun 2012 15:34:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+kg+FLN43ay27H8thYe5xxG4O+4=; b=WYQ8Cq
	pZ26QLY+VlwMWVsUEYx+uvXAGER4e4gM9jkPaNMsJNcOAwMShww8TYSOqAxZThb8
	axJvz4ylWfUGaz/ldw3XjuxlTHS8B3/v0OnaS4LyAkJ+AmdWZmLu24xT8NX8xd55
	sgPUZFhnQHQbdtuTs8xMDEkQdqL/cGwK7fIuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FhwJG2esAWIOfjcR0VbawNH0wef33R70
	Sy0AZ1rMIDIh/KGPU2hlEggdw/77DgXhfGPCUjfHurvyoUbKlLqnClxsUTo/X0LX
	HZvnN5eFZVvi2X/B5taug5rjSPM5rUJKXiHxXQspjrAziDrQked2jO+fSZ+TWAWU
	+awjG5zuWp4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05B7A6F08;
	Fri, 22 Jun 2012 15:34:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F75C6F05; Fri, 22 Jun 2012
 15:34:52 -0400 (EDT)
In-Reply-To: <CAJo=hJvCC8_oFFMyc5Fkweg6A6cSV6z+UxeCkvnU34KQfYx91w@mail.gmail.com> (Shawn
 Pearce's message of "Fri, 22 Jun 2012 10:54:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56920378-BCA1-11E1-A5BA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200460>

Shawn Pearce <spearce@spearce.org> writes:

> On Fri, Jun 22, 2012 at 3:12 AM, Ivan Kanis <ivan.kanis@googlemail.com> wrote:
>> I think we found a security flaw with git http smart backend. We are
>> running git version 1.0.7.4 on our server. Adding random words after the
>> password and the authentication still succeeds.
>
> git http-backend does not handle authentication or authorization. This
> is handled in your web server. You should consult your web server's
> documentation, and maybe its configuration files.

Very good advice.

> Git is freely available under the GPLv2 license. I believe it is
> possible for you to attempt experiments yourself with more up-to-date
> versions if you wish.

And the result is very unlikely to change, if the only change
between the earlier experiment and the next one is the vintage of
Git used, as the part that makes authentication decision is Ivan's
webserver and its configuration, which is not going to change
between the two experiments.

I do not recall ever releasing 1.0.7.4, nor having smart http
support before v1.6.6, by the way.
