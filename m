From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: inform the user they can re-order commits
Date: Fri, 16 Mar 2012 07:46:19 -0700
Message-ID: <7vhaxoioxw.fsf@alter.siamese.dyndns.org>
References: <4F63205A.6000202@seap.minhap.es>
 <vpqlin0n8w5.fsf@bauges.imag.fr> <7vty1oivub.fsf@alter.siamese.dyndns.org>
 <4F63571D.4070405@seap.minhap.es> <vpqaa3geiso.fsf@bauges.imag.fr>
 <7vpqccipuv.fsf@alter.siamese.dyndns.org> <vpq3998ehp3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 16 15:46:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8YQS-00082w-JB
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 15:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965421Ab2CPOqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 10:46:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47906 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964906Ab2CPOqd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 10:46:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D1E04767;
	Fri, 16 Mar 2012 10:46:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yQadXNH/3XlZGscFhPHKP9Dd3zk=; b=FQqIvG
	CaNk4iuYmOe6MCM6PTN4psQeKUwmyedkv+t4XFO2Mo5oAk4/7EYPREuiSC5kJ83V
	n2VkpWt4NbIp/fFKnFLZkUp/+LolRT0F7teuSYGg9WW3WvyFdJ9DLApp03qnXbUi
	anZIupSjTat4snms++4sL3KM2aDegEoCSL7YA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z4LccnsStJA7CxGGgeMAOQgvXuqZ7Ven
	puSCK8wLuumU9MEoFPo8SB9pBdQgRjY680bATt1y86KQSKYm/z0Uc+M5J53UjN8e
	a71aPfsJXPUcPD2sRrvn98GU6NHhgkjxaCw70a4adhXAjHu4OVA+udPtrQx0i5Qg
	yv5YZZZJzdY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA2154766;
	Fri, 16 Mar 2012 10:46:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C3424765; Fri, 16 Mar 2012
 10:46:21 -0400 (EDT)
In-Reply-To: <vpq3998ehp3.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri, 16 Mar 2012 15:36:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBCDF78C-6F76-11E1-90CF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193270>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> But if the user sees the help message of "rebase -i", then I don't think
>>> we will stop him from breaking anything by not mentionning that
>>> reordering commits can work. We already give other commands that rewrite
>>> history with more or less danger, so the additional messages isn't
>>> really harmful.
>>
>> I was not questioning that "You can also reorder" is dangerous in any way.
>>
>> What is dangerous is to give an illusion that it is safe to use "rebase
>> -i" without reading a decent documentation that does not even say that
>> reordering is one of the primary purpose of the command, and the mindset
>> that it is OK to give such an illusion with these reminder lines.
>
> Yes, but my point is that you can already do that. Nelson just gave an
> example when explaining how he came out with this patch.

Yes, I know that.

And a patch like this will _encourage_ the users to follow that path even
more. Is it a good thing?  That is what I was questioning.
