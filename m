From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Wed, 14 Mar 2012 13:44:29 -0700
Message-ID: <7vwr6moqtu.fsf@alter.siamese.dyndns.org>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 <1331288715.21444.38.camel@beez.lab.cmartin.tk>
 <4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
 <4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr>
 <20120312183725.GA2187@sigill.intra.peff.net>
 <vpqy5r44zg7.fsf@bauges.imag.fr>
 <CAHkcotg1FKxfMR4Fe9Xfo_i4nuxzXdfVWe80HZu0wQEkiXhhmA@mail.gmail.com>
 <7vbonzssap.fsf@alter.siamese.dyndns.org>
 <CAHkcotgsU6XZCTB+YKKeVMsUC2Yr5pVoc7eJpxdyH-GcxzeTVw@mail.gmail.com>
 <7vpqcfqefy.fsf@alter.siamese.dyndns.org>
 <CAHkcotimwxg3aRxYzHx-3a1THsc=oX83qrmGswZVJnKa3R86ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 21:44:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7v3m-0001rX-4j
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 21:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761439Ab2CNUod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 16:44:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64840 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761435Ab2CNUoc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 16:44:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3DA87DC3;
	Wed, 14 Mar 2012 16:44:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=11cTbUDCk931y6MShhyhq5Xf+I0=; b=aLpS+C
	kAtQfg8FfsljdL9f3jvYT1uECzZdyu+IVIvL0gUUklwkYj54KJdr5ESjHfppVBdi
	woPLL7sgHQU9KA7daYJeu92YGWF2kPJKXDb3p/EUvvtVCMJNmO9CcHxU9pakxl95
	yIylofRL86KbnSDfZqW4Z2gOBPgMhfkkH+vWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bCELX4bS31r3oPs4F1Frt4MQYKnknyjZ
	aNFtcUytiDx6xxpEw5J5hPQZXNDP6LLsf639agTHtb79KCwX9mPs1QtNw0/zr+Xm
	DK/TMeA24PrmXERK8aFssgSl7TF/Xb04if3TuIq1qdpsqPtnwzKQrLCzN5SvRtcQ
	ggNV2VIBEPs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB4E07DC2;
	Wed, 14 Mar 2012 16:44:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BAEC7DBE; Wed, 14 Mar 2012
 16:44:30 -0400 (EDT)
In-Reply-To: <CAHkcotimwxg3aRxYzHx-3a1THsc=oX83qrmGswZVJnKa3R86ww@mail.gmail.com> (Dmitry
 Potapov's message of "Wed, 14 Mar 2012 20:49:15 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F96C364-6E16-11E1-95D6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193161>

Dmitry Potapov <dpotapov@gmail.com> writes:

>> It only shows that lack of "push --prune A" is a problem to be solved.
>>
>> And hasn't it been solved already?
>
> Has it? Somehow I cannot find the corresponding option in the manual.
> What did I miss?

What you are missing is that you are not running 1.7.10-rc to help shaking
out last minute regressions.

Please be a good resident on this list and help us out ;-)
