From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Q: rebasing (moving) a whole tree (not just one branch)
Date: Fri, 18 Mar 2011 14:14:20 -0700
Message-ID: <7vaagsw2qb.fsf@alter.siamese.dyndns.org>
References: <4D83BB0A.8070307@dirk.my1.cc> <20110318202637.GA23255@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 22:14:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0h0I-0007oe-Mo
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 22:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757489Ab1CRVOd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 17:14:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757366Ab1CRVOb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 17:14:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8AA594330;
	Fri, 18 Mar 2011 17:16:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6h3vCnOeQiiJ
	e3/JLi1+tbTsasE=; b=JfbY96V2XfjeiKn1m9q1kp+u0v78mbMzqTcHf8i/0WaG
	eSjZqWglKFtsnwNBhCu47be5JBkxY6/4hAZDjnQ/nzB+BY7NbxK3iMpl10PrqDXU
	O6NMUaEFFVPxUoH+CCyJL6NKZ24qVX9gCKBdymuY6KB5kWoUfsKLwwyiwWHYMH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=o7HXbk
	KPAgPQsOA/aJJ3BqqRtMUU919V7hoGOcOd9r0Df80bzPbGggl2bHVi/K6ivkBYaB
	lBg0sd3nuSIEGpMAB8rMzwyCj0tsgpGqlK9cd4OljK1MGux2P8K7l+ZsiD9GYy8t
	OhxoBXco9pkWCT4/zar6MLX2t7ShNky0DvoyY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3CFFE432A;
	Fri, 18 Mar 2011 17:16:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E8E204327; Fri, 18 Mar 2011
 17:15:56 -0400 (EDT)
In-Reply-To: <20110318202637.GA23255@elie> (Jonathan Nieder's message of
 "Fri, 18 Mar 2011 15:26:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ECDDC722-51A4-11E0-87DC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169362>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Dirk S=C3=BCsserott wrote:
>
>> I'd like to rebase a whole tree from A to B. Not just a single
>> branch, but a whole tree. Let's say I have the following history:
>>
>> --- A --- B
>>     |
>>     + -- C -- D
>>          |
>>          + E -- F
>>=20
>> I'd like to rebase C and its descendants from A to B
>
> I'd suggest cheating by making a merge of D and F and "rebase -p"-ing
> that. :)
>
> To say something more sensible would probably require more informatio=
n
> about the particular application, though.

I am not a huge fan of filter-branch, but shouldn't you be able to
filter-branch D and F (and no other branch) on top of B?
