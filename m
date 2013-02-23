From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-index: allow "-h" to also display options
Date: Sat, 23 Feb 2013 13:25:08 -0800
Message-ID: <7vfw0m7mff.fsf@alter.siamese.dyndns.org>
References: <1361643041-19036-1-git-send-email-apelisse@gmail.com>
 <CALWbr2x4En9qof7hFL+Onh1M1080=-OaJtAsNYY01qRj5R1a1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 22:25:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9MbC-0006g4-FB
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 22:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086Ab3BWVZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 16:25:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758697Ab3BWVZK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 16:25:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31A52BC0D;
	Sat, 23 Feb 2013 16:25:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QHblHS602xj4Eh1NdJR1/pIARDA=; b=RBan/g
	FRduZasLofjFWO6Y77/B1lHxrgTq2+3p5mKZS2/15/AxvtWc6lciThrx97SowrBp
	kHnFH2JSvPLrNLKGuqAj2BMU2P+XLi9lf7bv6acFZ7wGuQYBsdrxDYTdTtsfOkEX
	cdYfYDqMEDHm5D39WejHzFSIkb8I9OlEvOV6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ckkWfOuyLFbJ3j8DbHrJzVPavK3ifrNP
	8HFyed+pB2QE4YDtsHRCN8w9FVZ8RG57CdbOUZF8FqogZJ5zhu5nOakbzqy8dFHf
	OLqWlvMHNouGqPJe0Uo+IfLS0vHYC6jR4oGcuevnprIkU/TSpNxlzWcH9qqm8hQ6
	YDzPA0P2zGQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26826BC0C;
	Sat, 23 Feb 2013 16:25:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2BCDBC0A; Sat, 23 Feb 2013
 16:25:09 -0500 (EST)
In-Reply-To: <CALWbr2x4En9qof7hFL+Onh1M1080=-OaJtAsNYY01qRj5R1a1w@mail.gmail.com> (Antoine
 Pelisse's message of "Sat, 23 Feb 2013 19:13:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 804FFD6C-7DFF-11E2-BF85-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216917>

Antoine Pelisse <apelisse@gmail.com> writes:

>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> index ada1dff..3071ee6 100644
>> --- a/builtin/update-index.c
>> +++ b/builtin/update-index.c
>> @@ -796,7 +796,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>>         };
>>
>>         if (argc == 2 && !strcmp(argv[1], "-h"))
>> -               usage(update_index_usage[0]);
>> +               usage_with_options(&update_index_usage[0], options);
>>
>>         git_config(git_default_config, NULL);
>>
>
> Ok I just realized that
>
>     usage_with_options(update_index_usage, options);
>
> would be better...

Yeah, that probably is easier on the eyes, even though they are
equivalent.

Thanks, will queue.
