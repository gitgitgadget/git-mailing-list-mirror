From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
 transports.
Date: Wed, 02 Dec 2009 10:41:40 -0800
Message-ID: <7vk4x5fcbf.fsf@alter.siamese.dyndns.org>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <fabb9a1e0912010812t4de8027dj1faf828051d1adc2@mail.gmail.com>
 <20091201165245.GF21299@spearce.org> <20091201171908.GA15436@Knoppix>
 <20091201193009.GM21299@spearce.org>
 <7vskbuwhmy.fsf@alter.siamese.dyndns.org> <20091202055632.GD31244@Knoppix>
 <7vy6llnar5.fsf@alter.siamese.dyndns.org> <20091202160446.GA32667@Knoppix>
 <alpine.DEB.1.00.0912021832480.4985@pacific.mpi-cbg.de>
 <fabb9a1e0912021006x2905578bo16dbcaedc0d97bc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 19:42:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFu9I-0006iq-Hb
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 19:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405AbZLBSls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 13:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755252AbZLBSls
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 13:41:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160AbZLBSlr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 13:41:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 612E0A339C;
	Wed,  2 Dec 2009 13:41:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1k4ulJ/hXn0WiFoYbuWgUOdsUPg=; b=nTk/Us
	T+mKma1LhkEudJTvieTA6IdlNr2wJnP/wCbZKppvqb83EsC8+aD8eIPAO34//+nG
	lVIBLHOLKEZxcExyYAi23p8nSYb9EGIE2yA5nki0fRRS1b14yrr+iUgewm6Yhy8i
	/3aABr2pk2xqDGRc21XO9x2scJ0G13pvreQIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KqrLz/DJwy5+cXt7L+p9EtwHFwRnI725
	9djAvuWoJXHdtlkf6lX8o8Abd+48vfdRmIgZsZNuPG5FPzGx7sIYS7wNeXCYu93I
	dL7zh76yfC+8vNSJTNRU0A2WIj1HHUrF3fg/7kR8P8FPjneBnIsWqvGxTh8Fd+ya
	DQmvjM57ex8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2496AA3396;
	Wed,  2 Dec 2009 13:41:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EC496A3391; Wed,  2 Dec 2009
 13:41:41 -0500 (EST)
In-Reply-To: <fabb9a1e0912021006x2905578bo16dbcaedc0d97bc6@mail.gmail.com>
 (Sverre Rabbelier's message of "Wed\, 2 Dec 2009 19\:06\:34 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 59A6218E-DF72-11DE-80F3-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134367>

Sverre Rabbelier <srabbelier@gmail.com> writes:

>> Of course, I never understood why the backend should know the
>> implementation detail that it is based on cURL, so it would be even more
>> modular (at least by my definition) if there was no hard-coded mapping.
>
> Agreed.

I don't get this point at all.

Backend is _very_ aware of how it is implemented itself.  Naming one
implementation git-remote-http is to declare that "I am the one and only
implementation of http handler" and forces another implementation of http
handler, perhaps based on different toolkit than libcurl, to forever be a
second class citizen that need to use name other than 'http'.

The "mapping" you two are calling "hard-coded" may be "hard-coded" but is
a better kind of hard-coding than hard-coding "http" to "this particular
implementation" implicitly like you two seem to be advocating.  Think of
it as having one extra layer of indirection.

When the second implementation of http handler proves to be better than
the current one, we can flip the mapping, and anybody who were using
"http://" to access some repository will automatically updated to use the
new backend instead of the old one.  With your scheme, you probably could
change the name of the old "http" backend to "http-deprecated" and the new
one from "second-class-citizen-http" to "http" to achieve a similar
effect, but I do not think it is as nice as having one extra level of
indirection.

> However, I am not convinced that we should do any magic to map
> "foo://" to git-remote-foo. On the other hand, I do think it makes
> sense to have something modular that allows "git-remote-http" to be
> implemented as a separate package that can be installed.

As I said, I do think modular is good, but I think what Dscho is
advocating does not have much to achieve that goal.
