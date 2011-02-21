From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Mon, 21 Feb 2011 15:33:21 -0800
Message-ID: <7vtyfxgdz2.fsf@alter.siamese.dyndns.org>
References: <4D0ED5EC.9020402@burntmail.com>
 <20101220213654.GA24628@burratino> <4D112586.2060904@Freescale.com>
 <4D119015.6020207@burntmail.com> <4D2AB63D.7040803@burntmail.com>
 <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com>
 <4D2FEF49.8070205@burntmail.com> <20110114074449.GA11175@burratino>
 <7v8vynnokt.fsf@alter.siamese.dyndns.org> <4D450655.5090501@burntmail.com>
 <AANLkTik0Mp=Ww_+ZN_jw6t4gsFwLo1UTw5JOpho8bCd=@mail.gmail.com>
 <7vhbcb35xk.fsf@alter.siamese.dyndns.org> <4D5E1116.7040501@burntmail.com>
 <7voc69p4xu.fsf@alter.siamese.dyndns.org> <4D5F6E97.4000402@burntmail.com>
 <7vy65bkw72.fsf@alter.siamese.dyndns.org> <4D61EA4B.3020708@burntmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@laptop.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Guy Rouillier <guyr@burntmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 00:33:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrfGD-0002gO-6A
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 00:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580Ab1BUXdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 18:33:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab1BUXdk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 18:33:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D15123FD0;
	Mon, 21 Feb 2011 18:34:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Mau6lNcQNvMGnRDHGCDGMgEAy6k=; b=JjrRufWJhVUAq00zHJe+HGs
	bmzLgwxmbbouwudQxyoK1bBaGpZU0r+C94bM0FAiPWlnt9tt3aY+hgYOPbAwRNUU
	uq9riGvb1PxxjzYqUpXbn/Q8ZcRUkJQ9tFbIUAjBSQJSjgUQLRk8Az6pmVzvi46d
	be5w9IciRaLDzmsbPKqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=GFCy90Y6KKNikV6kjNSKjEUCVY3vh08jc/9HDdjmOF6NePXX8
	WNoI3JhEqOquZBacBcdoM65R5bpax6YVLyH7lE8y51WtODoYjawQYDQ0m61vQXIu
	M1S52CyKf9EBloZsdpQne7TYl185dNkLRXVNnw4w3yo4xl2B+o7/jFnyzA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6372B3FCA;
	Mon, 21 Feb 2011 18:34:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1013D3FC5; Mon, 21 Feb 2011
 18:34:33 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 28F5E6B8-3E13-11E0-BDDF-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167513>

Guy Rouillier <guyr@burntmail.com> writes:

> On 2/20/2011 2:21 AM, Junio C Hamano wrote:
> ...
>> In practice, I would imagine that the cvsroot part wouldn't contain an
>> equal sign, so this looser regexp would not hurt in the real life, but it
>> does feel yucky.
>
> Well, this is the important point. I did think of these aspects when
> writing the code.  Sure, writing more precise code is possible, but the
> results are the same in either case.

It is probably unlikely to see a SP in the pathname, but I do not think it
is reasonable to introduce a regression to forbid '=' in the pathname to
the repository, which we have been supporting since August 2009, when we
know the patch as-is will regress the use case, and especially when we
already know a way to code not to regress is not too complex.

The "substitute with 'A' when missing" comes from e481b1d (cvs: initialize
empty password, 2009-09-17); it makes me worried that the patch is
removing the support, _unless_ that commit by Clemens was addressing a
problem that does not exist (and if so, I'd like to see a sentence or two in
the commit log to explain why it is a sane thing to do to remove it).

Thanks.
