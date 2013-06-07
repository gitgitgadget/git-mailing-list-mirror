From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Fri, 07 Jun 2013 14:53:02 -0700
Message-ID: <7vk3m5si4h.fsf@alter.siamese.dyndns.org>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
	<20130607000006.GA25731@goldbirke>
	<CALkWK0=D7sHLgptWkFHma1FoS-zdifHqXnuuBKhkyuszgEJ0Xw@mail.gmail.com>
	<7v8v2lu5ks.fsf@alter.siamese.dyndns.org>
	<20130607191643.GA31625@goldbirke>
	<7vwqq5snzi.fsf@alter.siamese.dyndns.org>
	<20130607204430.GD31625@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jun 07 23:53:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4at-00084v-MT
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 23:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756423Ab3FGVxH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 17:53:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49373 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756046Ab3FGVxF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 17:53:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3389826D60;
	Fri,  7 Jun 2013 21:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mobM1YyEar+w
	pZqC1HJxOd0b29Y=; b=fQ37Gnz3JtI7igbLJOgbSN5Kk6Rzp4wYrdoyytRLB0mS
	GqYAey2fLoroUW+G1prd6dM5g0tlk/7tpBxv6YUB808G/xVII+DObYcukQM1AgRI
	K2BJgLLQs2NG6rzaGKqEROMWCz0Iq5AYJHEeGqn+P54n4eg5k8XnhSh5goxFORI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ti1qU1
	7+rZAp4L++Q60aXqCkvD3hO/6Jbv+tYCWGbfgrqVCU3bPh5+zXsvaQOb7PBK1RA0
	wYYgvam1h9SoiRo7rrq252US32vyPfE4icEb/mLqZG9QMKQlQtbs4YuOXfneBXdJ
	O+DU/rWOyE4Ir63C0PNCildzj6yI5IKKWt6mk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28E8A26D5F;
	Fri,  7 Jun 2013 21:53:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B34226D5E;
	Fri,  7 Jun 2013 21:53:03 +0000 (UTC)
In-Reply-To: <20130607204430.GD31625@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
	"Fri, 7 Jun 2013 22:44:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0F5846A-CFBC-11E2-ABD7-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226741>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Fri, Jun 07, 2013 at 12:46:25PM -0700, Junio C Hamano wrote:
>> Thanks for a pointer.  I think what I was suggesting was slightly
>> different in that I was hoping to see a single helper that knows to
>> complete to object names (possibly including trees/blobs with the
>> treeish:path notation), ranges, and pathnames (not treeish:path
>> notation) until it sees a "--" and then complete only to pathnames.
>
> We already got that except the completion of pathnames before "--",
> and I don't know how that could be done properly for commands taking
> both refs and paths.
> ...
>   git diff git.c
>   git diff master git.c
>   git diff master next git.c

It is somewhat annoying that "git diff gi<TAB>" stops at expanding
it to "git diff git" and then upon another "git diff git<TAB>"
offers tags whose names begin with "git" (e.g. gitgui-0.10.0) but
the pathname git.c is not included in the choices.  My wish was to
take the union in such a fairly limited case.  I tend to agree with
you that "git diff <TAB>" that expands to all refs and pathnames
would be useless, but so is expansion to all pathnames (or refnames
for that matter).

In any case, I wouldn't insist on AI perfection in the first place
;-).  As long as it works reasonably well, I am happy (and I think
the current completion code already works better than reasonably
well, at least for me).

Thanks.
