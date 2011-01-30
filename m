From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Add --create-cache to repack
Date: Sun, 30 Jan 2011 12:02:58 -0800
Message-ID: <7vaaiib1n1.fsf@alter.siamese.dyndns.org>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net>
 <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <alpine.LFD.2.00.1101281304270.8580@xanadu.home>
 <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com>
 <alpine.LFD.2.00.1101281502170.8580@xanadu.home>
 <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
 <AANLkTimuW-7D4YA2jeF+y4DPE=CdqtL713MQK+1Gtp-d@mail.gmail.com>
 <7vk4hmbyuo.fsf@alter.siamese.dyndns.org>
 <AANLkTi=mbeBsR5tr4J7kQCL6YqiGfttK01VUN016aapC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 30 21:03:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjdUX-00082g-DM
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 21:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529Ab1A3UDO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jan 2011 15:03:14 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253Ab1A3UDN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jan 2011 15:03:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 220413950;
	Sun, 30 Jan 2011 15:04:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OFUMZljHUsBd
	GwjRiQLQsqzl6f8=; b=N+EkjQId0wbRw5i/ziATYuI6m6WcaJB8bWIr2abS+yQC
	TtIm2ESpctXS4gp5cmXUDnyjyEGdPyzAwgWRl+qn7uzT9cTtGEyov0Acv10jHhSr
	OGxx+RA2kAHgdu/Yaz3F/BBg+dcXSHrf0ZDaL8xw1L2IYt+1J/bQT8iAaQCce0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Dhvedi
	cK6z5GJKjo20TKCHkxq+wdGGzVmx5sUKLieJ/SEVzFAB772nzIgOBRFA5HJ1ViYF
	Gu6YpR09et3lQxsN+19Hm4TrQ+Qxum3/nMHxYH0Ty63lJ1PIkct/LV8gzQ5dO3n8
	p7lD4uIyCqG41FPIAyv2d3gkWZ9ndjBnzdEMI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BDBDA394F;
	Sun, 30 Jan 2011 15:03:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 280B7394B; Sun, 30 Jan 2011
 15:03:50 -0500 (EST)
In-Reply-To: <AANLkTi=mbeBsR5tr4J7kQCL6YqiGfttK01VUN016aapC@mail.gmail.com>
 (Shawn Pearce's message of "Sun\, 30 Jan 2011 11\:43\:22 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 127E2698-2CAC-11E0-9E75-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165697>

Shawn Pearce <spearce@spearce.org> writes:

>> The amount of transfer being that small was something I didn't quite
>> expect, though. =C2=A0Doesn't it indicate that our pathname based ob=
ject
>> clustering heuristics is not as effective as we hoped?
>
> I'm not sure I follow your question.

I didn't see path information in your cachefile that contains C commits=
, T
trees, etc. that sped up the object enumeration, but you didn't observe
much transfer inflation over the stock git.

> Ooooh.
>
> I think my test was flawed.  I injected the cached pack's tip as the
> edge for the new stuff to delta compress against.

That is one of the things I was wondering.  I manually created a thin p=
ack
with only the 1-month-old tip as boundary, and another with all the
boundaries that can be found by rev-list.  I didn't find much differenc=
e
in the result, though, as "rev-list --boundary --all --not $onemonthold=
tip"
had only a few boundary entries in my test.
