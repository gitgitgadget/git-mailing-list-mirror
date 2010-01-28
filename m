From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: expose "status-only" feature via -q
Date: Thu, 28 Jan 2010 12:27:58 -0800
Message-ID: <7viqamkm9d.fsf@alter.siamese.dyndns.org>
References: <7vk4v53gek.fsf@alter.siamese.dyndns.org>
 <4B61BC02.3070408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 21:28:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Naayl-0003pS-Cg
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 21:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291Ab0A1U2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 15:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755004Ab0A1U2J
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 15:28:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754649Ab0A1U2G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 15:28:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E349C9581F;
	Thu, 28 Jan 2010 15:28:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9V66t1lggeUS48OgJ/JGuwl2QkU=; b=SKRBVa
	lJrBeFoZz66ltyJZe5bzpvmaJkWGGU4so1dulwU1TspBG926ssFjv9SnD67FuYQD
	oub3Dn+55uod4y50ncUUSo9J8LqR9hBM1LlTNIgYj8RHZJJbKLbbcSrV0jDuCWmU
	JX/TUrN1uNMhQkzBeBR/uu/h5dKWqXDRwn+ic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LsTPMl/cZzI3ogusJRnInsY5d//WUNvk
	nWwFbkmw69+9CDSsgjRN51YADGjPr56oG82G767KZAEJQ1q69x7MrHv3uz+C3VyD
	I25dOwa/CBL3q1v6/+jTRMO5mEf6dd4WRs9t+S88QTqcXDD4DkheeLJQw7FjZsH4
	fhjS1vE5OR0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D90C69581E;
	Thu, 28 Jan 2010 15:28:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 402299581C; Thu, 28 Jan
 2010 15:28:00 -0500 (EST)
In-Reply-To: <4B61BC02.3070408@gmail.com> (Stephen Boyd's message of "Thu\,
 28 Jan 2010 08\:32\:02 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A2402CA4-0C4B-11DF-8C31-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138268>

Stephen Boyd <bebarino@gmail.com> writes:

> On 01/25/2010 03:37 PM, Junio C Hamano wrote:
>> @@ -505,6 +512,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>>   		{ OPTION_CALLBACK, ')', NULL,&opt, NULL, "",
>>   		  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH,
>>   		  close_callback },
>> +		OPT_BOOLEAN('q', "quick",&opt.status_only,
>> +			    "indicate hit with exit status without output"),
>>
>
> Why isn't this --quiet just like grep?

Because I wasn't careful enough.  Thanks; will fix.
