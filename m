From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Porcelain scripts: Rewrite cryptic "needs update"
 error message
Date: Fri, 05 Nov 2010 15:38:26 -0700
Message-ID: <7v39rfs8f1.fsf@alter.siamese.dyndns.org>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <1287499168-26569-1-git-send-email-artagnon@gmail.com>
 <20101027145548.GA1136@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 05 23:39:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEUvz-0004Vl-TT
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 23:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014Ab0KEWiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 18:38:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000Ab0KEWiv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 18:38:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 92A1D3533;
	Fri,  5 Nov 2010 18:38:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=UadEBIXnWz5yNyg92e6mLLREAzw=; b=QeLedJN0Hr79st0vn/wXwk7
	xtUHFEaHywh2zJ5z9Zo2eEHUnIL/6IHBiXdTTOPwzd/DvBioM5LzqHVBItMrwSKq
	a7YKUyDhcRqR2UNoMVVxggv5yUiK3q9zthIaT5ejSr26QKO1Ecvc5VXLoNYZWtoE
	7N+OzTO6ztRV5HS+2QkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=vj/YHF7E+EjMnxTa4IUbrnJWWpPp9vbFgRdySIH2omlKPNAJF
	jAPgzvwXlUErARKC9HfMIH7sDRB/ycqRuMJLqKWZ7eIpu7/+lvhs6lo0qcYorK0I
	C99GMzUKzWeTipJRDtQB2KD5YOS+ldzIi6AM7QuB/szjN3R2hT0CtaF5pU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0E00E352E;
	Fri,  5 Nov 2010 18:38:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 34E9C3529; Fri,  5 Nov 2010
 18:38:29 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6E72370E-E92D-11DF-881D-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160826>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Ramkumar Ramachandra writes:
>> Although Git interally has the facility to differentiate between
>> porcelain and plubmbing commands and appropriately print errors,
>> several shell scripts invoke plubming commands triggering cryptic
>> plumbing errors to be displayed on a porcelain interface. This patch
>> replaces the "needs update" message in git-pull and git-rebase, when
>> `git update-index` is run, with a more friendly message.
>> 
>> Reported-by: Joshua Jensen <jjensen@workspacewhiz.com>
>> Reported-by: Thore Husfeldt <thore.husfeldt@gmail.com>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> ---
>>  Ref: <1285877017-8060-1-git-send-email-artagnon@gmail.com> for v2.
>>  Ref: <1285514516-5112-1-git-send-email-artagnon@gmail.com> for v1.
>> 
>>  Thanks to Matthieu for reviewing v1 and Junio for reviewing v2: I've
>>  tried to attack the problem more conservatively in this patch. It
>>  doesn't list paths, and doesn't print "generic" advice.
>
> Junio: Is this patch alright?

I did not see anything glaringly wrong in the patch offhand.  The new
messages look a bit too verbose, though.

Will queue and see what people would say.
