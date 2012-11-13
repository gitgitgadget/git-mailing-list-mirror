From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Notes in format-patch
Date: Tue, 13 Nov 2012 08:29:53 -0800
Message-ID: <7vhaotfou6.fsf@alter.siamese.dyndns.org>
References: <50A0B896.8050700@drmicha.warpmail.net>
 <a35a8f44b908bded0b475b02e7917011fb3bf90b.1352728712.git.git@drmicha.warpmail.net> <50A2213B.4060505@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 17:30:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYJNK-00030h-Rd
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 17:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540Ab2KMQ35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 11:29:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55029 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108Ab2KMQ34 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 11:29:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C027EA681;
	Tue, 13 Nov 2012 11:29:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ciQAaYfJp+Sf0Cq8bfPkEvSMR+E=; b=Nkt8a1
	T5EBJusjJsVnEmar+PRChSCbmU7zp8fdY7o5MZd56/Kel6YhzaOFvYn9hmiITCCZ
	0dCfmFCspT7PqMMghC6pzUQADgEXAIpBcukEe+fzePo7+GbOec6JcxnYkRojo+4E
	szNYkPe6llC53atkQfwXlPfE9D9gd6nOm9LwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y8DGSqqLlkLMn5IpsS1CBnQ0/bYl4chg
	gGldWwGnJQzKcnBcFauz+7yvC+zMaPAFSPGHHaum//8oHxWIIFBQnbs9DucoBRYo
	+e7oSxBPZIOObQZVvJX+Jm1dK8JKJMlu/sVVoWRoBZ2D8lVreMEbMvPdGhHRkMee
	yZEfzOmZDno=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACC61A67F;
	Tue, 13 Nov 2012 11:29:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FD46A67C; Tue, 13 Nov 2012
 11:29:54 -0500 (EST)
In-Reply-To: <50A2213B.4060505@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Tue, 13 Nov 2012 11:30:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B69EBCA-2DAF-11E2-85A8-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209629>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Michael J Gruber venit, vidit, dixit 12.11.2012 15:18:
>> 'git replace' parses the revision arguments when it creates replacements
>> (so that a sha1 can be abbreviated, e.g.) but not when deleting
>> replacements.
>> 
>> Make it parse the argument to 'replace -d' in the same way.
>> 
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> 
>> Notes:
>>     v3 safeguards the hex buffer against reuse
>>  builtin/replace.c  | 16 ++++++++++------
>>  t/t6050-replace.sh | 11 +++++++++++
>>  2 files changed, 21 insertions(+), 6 deletions(-)
>> 
>> diff --git a/builtin/replace.c b/builtin/replace.c
>
> By the way - Junio, is that the intented outcome of "format-patch
> --notes"? I would rather put the newline between the note and the
> diffstat...

I do not mind (actually I personally would prefer to see) a blank
line between the three-dash and "Notes:", but I agree that we should
have a blank line before the diffstat block.
