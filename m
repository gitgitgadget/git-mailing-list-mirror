From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git.pm
Date: Thu, 10 May 2012 09:20:29 -0700
Message-ID: <7vr4usnh2q.fsf@alter.siamese.dyndns.org>
References: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
 <CAFouetgwRpB1GFJOC8PTVryVY-94S3xa5ZiSaWQWoz070qQ-6g@mail.gmail.com>
 <CAB3zAY0NeXuH-wXyYkbim5U74eANY4hq5D6SsVLu3KeUqHFqzQ@mail.gmail.com>
 <20120426203136.GA15432@burratino>
 <CAB3zAY3VHtUobJfJ7=nSKb_6uJOXLGVHzR18qV6txPkzf54cDw@mail.gmail.com>
 <CANgJU+W-FJZRtu_4si7nr96KfNe2rzaiUaDC0GiK_WixudvcxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Subho Banerjee <subs.zero@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>, git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 18:20:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSW6Y-0002bR-C9
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 18:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774Ab2EJQUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 12:20:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752906Ab2EJQUd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 12:20:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C5A6729D;
	Thu, 10 May 2012 12:20:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j9k+YY5iYXQvglpwZx4pBQse/Lo=; b=ZqFkXH
	wpDQYkEZaBa1aQL2gKJicyqgoFov3sHj9/jdyyQ4+j+2XEyFx/urxkX0XUQVjsEo
	kSDWXSJD/NWrW5qBcmmb+a/TG8mWTqHjZ2g1eztuNh8kxeOXJr24KYgsDcwwyONf
	yACzoXxr+TfoAPxhggwcwvVeOR7kFZ6MDeucs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aSBeYS5n+aTHYkv0olPL5IrHCxmKg3La
	IWSXuqYoTYpe4X4nLn5231uv/UUVih0qFnxqy9hVREfl0KrcgTkVAM28lhhYXkAd
	PSl1v4J+gNx4PZRv0k+zx39qLF4PadnWpZWIXp6f4JhNd46yp67TWgZi7D4wimmf
	C2iztkkQ5Fg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 128C8729C;
	Thu, 10 May 2012 12:20:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71969729B; Thu, 10 May 2012
 12:20:31 -0400 (EDT)
In-Reply-To: <CANgJU+W-FJZRtu_4si7nr96KfNe2rzaiUaDC0GiK_WixudvcxA@mail.gmail.com>
 (demerphq@gmail.com's message of "Thu, 10 May 2012 17:54:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 103CCB9E-9ABC-11E1-8200-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197591>

demerphq <demerphq@gmail.com> writes:

> Similar logic for Try::Tiny. Why bother with it? It is pretty close to
> a fancy way to write eval { ...; 1 } or do { .... };  It is just one
> more module for people to misunderstand, and then make bugs with.

I personally like the approach to stick to bare "eval {}; if ($@) { ... }"
sequence, as it is much more explicit and easier to understand what is
happening underneath.  IOW, I like what I read in demerphq's message.

But it could be that these many people who wrote these different
catch/throw things did so for a reason that I am missing, and if that is
the case, I am interested to hear what benefit we will get from using
them.

"It looks more familiar to people with (your favorite language)" could be
it, but then I would not regret missing such a reason ;-)

Thanks.
