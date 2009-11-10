From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Define $PERL_PATH in test-lib.sh
Date: Tue, 10 Nov 2009 12:17:26 -0800
Message-ID: <7v7hty6so9.fsf@alter.siamese.dyndns.org>
References: <1257850011-7544-1-git-send-email-book@cpan.org>
 <4AF95C0D.90605@viscovery.net> <20091110133427.GC8896@plop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: "Philippe Bruhat \(BooK\)" <book@cpan.org>
X-From: git-owner@vger.kernel.org Tue Nov 10 21:17:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7x9y-0003EP-O7
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 21:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758047AbZKJURb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 15:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758036AbZKJURa
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 15:17:30 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758035AbZKJURa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 15:17:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C96109AA79;
	Tue, 10 Nov 2009 15:17:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=en5wCs7FhoYsstqShlmndpZFH3Q=; b=Q+MQTaoA6DPcnZuGn+D8wQ/
	V9YU1ACKyjGVwFwBn1dpd01NpLX4tSyHbYYooGtdKuEaWpZpWOjmO9vZPOlW+0uS
	emqg5mjKBTzqNWlWBrGxDfZ/7idLG2Kyhf5IjjONmsEc2WhRjO4rXMlFXBggFebG
	wi5UZa/v3FqsFwtE1mJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=CGXF0FKOHNUkH62x/uKMZBfdIme8NIfET/4/MA45WpmzXeb50
	cyM7q98oGUoLD+p0iEDTJ8nP3C2xOSH6l7k8nHezXbaFDp9taSTyA0EPOl2GF8ru
	RRCBNTEdABPFJ/EE01WTcER/x1o3jk22b/9t0m+r7l5IIKQlLCv2AUYmGY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9EEC49AA76;
	Tue, 10 Nov 2009 15:17:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1DEC89AA71; Tue, 10 Nov 2009
 15:17:27 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 13F50BFC-CE36-11DE-AB1A-BD45BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132593>

"Philippe Bruhat (BooK)" <book@cpan.org> writes:

> On Tue, Nov 10, 2009 at 01:26:53PM +0100, Johannes Sixt wrote:
>> >  
>> > +test -z "$NO_PERL" && test -z "$PERL_PATH" && export PERL_PATH=/usr/bin/perl
>> 
>> Wouldn't
>> 
>>    ... && export PERL_PATH=perl
>> 
>> be a safer fall-back?
>
> /usr/bin/perl is the value used in the top-level Makefile.
> I used this for consistency.

Hmm, but that means two separate definitions in ./Makefile and
t/test-lib.sh must be kept in sync forever, and there is not even a
comment next to the line that requires such care in your patch to help
people who might want to change these lines in the future.
