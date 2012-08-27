From: Junio C Hamano <gitster@pobox.com>
Subject: Re: libgit2 status
Date: Mon, 27 Aug 2012 12:44:07 -0700
Message-ID: <7v6284qfw8.fsf@alter.siamese.dyndns.org>
References: <87a9xkqtfg.fsf@waller.obbligato.org> <5038A148.4020003@op5.se>
 <7vharpv77n.fsf@alter.siamese.dyndns.org>
 <nnglih0jotj.fsf@transit.us.cray.com>
 <7vfw78s1kd.fsf@alter.siamese.dyndns.org>
 <nngsjb8i30w.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, <greened@obbligato.org>,
	<git@vger.kernel.org>
To: <dag@cray.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 21:44:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T65EP-0003IP-UH
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 21:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186Ab2H0ToL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 15:44:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51505 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753602Ab2H0ToL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 15:44:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E85339883;
	Mon, 27 Aug 2012 15:44:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K6zV6R/ZHCoVG7DED75WLDb6xo0=; b=cwvZ6y
	SlB0BTQuuZxr/W6+ecpUohmLqFlAjLqf+F0mdGlIDbLIV218RrReIwLI+BtO8I/B
	YzwpQLpLAK102rL1y3wWvshayUrv6ddbw5cUdj9qvlbBjuUzrj4F2jd7ph0WQ+Z1
	iXVWoS4NQ+8BQDgaKtXZD/aONMVzZjSRkphMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wyzkU/+XYIXCM+CgT8M6/cMsulfJIQvo
	Ad7AxJnXGIWgCYn+n9pXkAjvtojcxScKqGArhaVacBUwehXwkj1tsQ54NU3gfNol
	9eUgqrbSsEEVQ+Yk80oazAKaJYYg1zMc9oty0J1miNtzpDEkotT5OOKeZMoTteUp
	CypvmaKPW5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5F0E9882;
	Mon, 27 Aug 2012 15:44:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 534589881; Mon, 27 Aug 2012
 15:44:09 -0400 (EDT)
In-Reply-To: <nngsjb8i30w.fsf@transit.us.cray.com> (dag@cray.com's message of
 "Mon, 27 Aug 2012 13:49:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91AED820-F07F-11E1-AA60-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204369>

<dag@cray.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> I would be happy to be a guinea pig for libgit2 in order to improve it,
>>> but I don't want to significantly impact git-subtree's move to core.
>>> I'll have to figure out the right balance there given feedback.
>>
>> I expect it will take some time for libgit2 to allow our Makefile to
>> start saying "LDFLAGS += -libgit2"; it will need to become as stable
>> and widespread as other libraries we depend on, e.g. -lz and -lcurl.
>
> Well that's a chicken-and-egg problem, isn't it.  How will a library
> become widespread unless something uses it?

That something will not be the git core itself.  Otherwise we will
lose a stable reference implementation to catch its bugs.
