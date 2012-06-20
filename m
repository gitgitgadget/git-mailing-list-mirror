From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is the textconv filter called for each line ? or once for the
 file ?
Date: Wed, 20 Jun 2012 11:35:40 -0700
Message-ID: <7vtxy5vnk3.fsf@alter.siamese.dyndns.org>
References: <loom.20120620T125636-763@post.gmane.org>
 <vpqy5nidvnx.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Laurent Alebarde <l.alebarde@free.fr>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 20 20:35:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShPku-00057a-B2
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 20:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275Ab2FTSfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 14:35:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33995 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932266Ab2FTSfq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 14:35:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14A948D42;
	Wed, 20 Jun 2012 14:35:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IcitgC3fbZEXeQ9Le/+bIQY+Z5w=; b=g6O9wJ
	zeQnayVEJj14FCeQzRdOo/0I+/m0Rg810UOV9OFx8wmUrS3SdGqlei9FswRUbjEi
	vVbnix9Leh3W9CSFF/95w3qXj5KquxJtJf3mJ0umKyV6VvuwALdYZY5atI/pJIDC
	A3CB3kWYEdBjrEZ2UxVJ/wXNH4q03h5akZGj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G16eon/D1TiKMEB+P7Y1p/xtU3H8nOCv
	Dis7Isa3tvEWEpAM/b+e3Zhs1xcwzudm2/qPWBHL4jvVRMWgTJayUD7zsIgvbeMM
	/XDzWKMqq4VW6zsc3iFOakCRPsd4XuxXq4lBSPfHOaqM7OHOsJBbLBMmCG6QaCyu
	kETiuZoDLhM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C3408D41;
	Wed, 20 Jun 2012 14:35:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41CC28D3F; Wed, 20 Jun 2012
 14:35:42 -0400 (EDT)
In-Reply-To: <vpqy5nidvnx.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed, 20 Jun 2012 14:17:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD96CE2E-BB06-11E1-8897-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200328>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Laurent Alebarde <l.alebarde@free.fr> writes:
>
>> Hi all,
>>
>> Something I need clarification please :
>>
>> In the documentation on gitattributes, it is said :
>>
>> "A textconv, by comparison, is much more limiting. You provide a transformation
>> of the data into a line-oriented text format, and git uses its regular diff 
>> tools to generate the output."
>>
>> Does it mean that the textconv filter is called for each line ?
>
> No. What would "for each line" mean, since textconv is essentially meant
> to be called on binary files?

I think the key phrase Laurent has missed is "*into* a line-oriented
text format".  The input may or may not be line-oriented.  The
output is expected to be.
