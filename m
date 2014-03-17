From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] gc --aggressive: three phase repacking
Date: Mon, 17 Mar 2014 16:07:23 -0700
Message-ID: <xmqq8us8a0gk.fsf@gitster.dls.corp.google.com>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
	<1394976904-15395-6-git-send-email-pclouds@gmail.com>
	<xmqqfvmgbhlb.fsf@gitster.dls.corp.google.com>
	<CACsJy8BgHp=w3RU==9tiebnOPxzCnwurpZbNjxtS5O=q_kDcOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 00:07:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPgd1-0003y4-GC
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 00:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbaCQXH1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2014 19:07:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55510 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343AbaCQXH0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2014 19:07:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A986375836;
	Mon, 17 Mar 2014 19:07:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MwXCXP869Opl
	3HUZJ/JVqnaW/IA=; b=vP8nrUcia3oC/wnaIZf7CuxQT2E6Ln2XBNIqX5zFqWnS
	qeFOd8FG2N1pOqXBwt5nBok0/8FDRm53C6T4mO5dvSA4sgZH6ZSkY5f81Of21BLF
	JUqmdM1N8DqbZiC9ldpuaDU4JGnEQFIbZTOVEw30UjROf9io3wQfw1VggMPsCl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=t63Szi
	lRONz3pZq2I29teDUFTkoXgXqPEGrG/H7JEGFlBIN6WPgJbvx847q7r2fZ5FYg/o
	rVszDYHH1VE2PwUD1nDu9s/qOg/njiSruFoyO/Yef5wHRq8I/T8fXPmNcrL8jhBu
	BVfE+Su4FgEOTUqBU5QIyo49b51kjIA53Twc0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9791575835;
	Mon, 17 Mar 2014 19:07:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA0C975834;
	Mon, 17 Mar 2014 19:07:24 -0400 (EDT)
In-Reply-To: <CACsJy8BgHp=w3RU==9tiebnOPxzCnwurpZbNjxtS5O=q_kDcOA@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 18 Mar 2014 05:59:32 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E70E9A22-AE28-11E3-9C34-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244311>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Mar 18, 2014 at 5:12 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> As explained in the previous commit,...
>>
>> [PATCH 3/4] becomes a commit with an empty log message for some
>> reason.  Have you tried running "am -s" on it?
>
> "am -s" worked fine. "am -s --scissors" did not (because of my use of
> scissors in the commit message). Not sure what happened on your side.=
=2E

Yeah, I meant "am -c".
