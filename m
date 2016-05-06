From: Junio C Hamano <gitster@pobox.com>
Subject: Re: /* compiler workaround */ - what was the issue?
Date: Fri, 06 May 2016 12:57:58 -0700
Message-ID: <xmqqinyr2c3d.fsf@gitster.mtv.corp.google.com>
References: <AA5B2B1715BAF7438221293187A417A7BDE9D11D@desmdswms002.des.grplnk.net>
	<17E04501C9474282B87758C7998A1F5B@PhilipOakley>
	<xmqqtwic9o88.fsf@gitster.mtv.corp.google.com>
	<CACsJy8CBuU8H8r_f4KsnLkhLtfRv0nDo4hGS31LVn0e1Y_3OAQ@mail.gmail.com>
	<51C902B1F7464CF2B58EB0E495F86BB5@PhilipOakley>
	<572CDCFF.9050607@ramsayjones.plus.com>
	<xmqq60ur3tlu.fsf@gitster.mtv.corp.google.com>
	<572CF0D5.6010305@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri May 06 21:58:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aylt3-0001m2-P6
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 21:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758782AbcEFT6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 15:58:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758779AbcEFT6C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 15:58:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DD3A17A7F;
	Fri,  6 May 2016 15:58:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dkmIpKm/i36gHhnwYQX8ibztZz8=; b=UnR6+m
	NLrgwO/QM6PTHikKan4AO0o9NeqtFGUjmM2PhKazvv9vB+q4sYR3t6yn0Pm9zAhl
	JBDlBC/URiVtImyUwJa9qrRDDOopMrpEM5bSFosaCWHv6BuALz1pzhF1Mm0rrPRO
	/IogQ5uj6YDHKvOzEfLP8d+lMoF1FDQNaLVFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xOx0gimjevCj6MQFO3ZFgrh3pIdgtJTN
	cJK6CxS0ekmyR+cHbVGwVzNhSWMAZ+nJZOUOXziDu8+65tnGg73AmebMKsDlrSHE
	iUVmgMHs4MkGbKdAg0L3DNGCYWCfrOMs8Wtcew1rPOgIFNtl5PF5MPyoGmcnZGDv
	FwTZA7yxrvQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CFC8017A7E;
	Fri,  6 May 2016 15:58:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EEE5C17A7D;
	Fri,  6 May 2016 15:57:59 -0400 (EDT)
In-Reply-To: <572CF0D5.6010305@xiplink.com> (Marc Branchaud's message of "Fri,
	6 May 2016 15:30:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D5A9F9E4-13C4-11E6-8D0B-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293854>

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 2016-05-06 02:54 PM, Junio C Hamano wrote:
>>
>> I wonder if can we come up with a short and sweet notation to remind
>> futhre readers that this "initialization" is not initializing but
>> merely squelching warnings from stupid compilers, and agree to use
>> it consistently?
>
> Perhaps
>
> 	#define COMPILER_UNINITIALIZED_WARNING_INITIALIZER 0
>
> or, for short-and-sweet
>
> 	#define CUWI 0
>
> ?
>
> :)

I get that smiley.

I was hinting to keep the /* compiler workaround */ comment, but
in a bit shorter form.
