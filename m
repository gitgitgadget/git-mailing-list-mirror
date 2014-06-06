From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] userdiff: support C# async methods and correct C# keywords
Date: Fri, 06 Jun 2014 10:34:11 -0700
Message-ID: <xmqq61keq6wc.fsf@gitster.dls.corp.google.com>
References: <1401682405-3319-1-git-send-email-ch3cooli@gmail.com>
	<xmqqy4xbq7xo.fsf@gitster.dls.corp.google.com>
	<CACbrTHcVNmffTHPPnPYDXXwYQacmiS77573Y+GpyjSv-yHQM7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sup Yut Sum <ch3cooli@gmail.com>, git <git@vger.kernel.org>
To: Steve Hoelzer <shoelzer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 19:34:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsy22-000383-58
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 19:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbaFFReS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 13:34:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65386 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbaFFReR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 13:34:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C5B691C233;
	Fri,  6 Jun 2014 13:34:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6IIUS1ylnQuUGa6kJSoy8z8+/5U=; b=HJ16jG
	K26rr/UR8DgBciBzwkvZilLYFSLnYgPxeNqVhRsnS8uoCs/MUbzdT0K2wWLonhfF
	mlMu853s0xyb4SVf4NAZ62ZIiYeDQGwWMupIQVC8k9PJJ7k50hvp25ZJmnFSSes8
	j38mIEg5veGSBSoBCXqzYMDceJ5usGCpRFO2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BbzhHzMbieo93o7SgEfsD63ndSerMA3b
	L0tKA4gmB3O9RCMGZuzk3Fq1uJgLyk5SZcrayJ59Krk8znp4nAhHI9wZYU5cK/i+
	MI/d6knfX2Zhzca7W2SUwY+3hiDoydR6FBKCIUHrV+UDp6LrdwFZQ+EW/Si6lP8r
	olWQGMdBBZs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BC2C41C232;
	Fri,  6 Jun 2014 13:34:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0F1301C22E;
	Fri,  6 Jun 2014 13:34:12 -0400 (EDT)
In-Reply-To: <CACbrTHcVNmffTHPPnPYDXXwYQacmiS77573Y+GpyjSv-yHQM7g@mail.gmail.com>
	(Steve Hoelzer's message of "Fri, 6 Jun 2014 08:27:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C66B4FB0-EDA0-11E3-AF81-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250952>

Steve Hoelzer <shoelzer@gmail.com> writes:

> On Thu, Jun 5, 2014 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Sup Yut Sum <ch3cooli@gmail.com> writes:
>>
>>> async is in C# 5.0
>>> foreach is in C# 1.0
>>
>>> instanceof is in Java. The similar keywords are typeof, is, as in C# 1.0
>>
>> This one made me read it twice, until I realized you meant
>>
>>     instanceof() is listed as keywords, but there is no such thing
>>     (it is in Java, though); in C# we use typeof() for similar
>>     purposes
>
> The original email was a bit hard to parse. Junio's clarification left
> out the C# keywords 'is' and 'as'. I suggest phrasing it like this:
>
> instanceof() is listed as keywords, but there is no such thing (it is
> in Java, though); in C# we use typeof(), 'is', and 'as for similar
> purposes

You would need to balance the quotes around "as" ;-)

But reading the patch again after noticing that you have () after
typeof but not after is/as, I am not sure if the change proposed
here is even correct for the latter two.  I do not speal c-sharp, so
I asked http://msdn.microsoft.com/en-us/library/cscsdfbt.aspx for
some examples and here are what I found:

    Type t = typeof(ExampleClass)
    Base b = derived as Base;
    if (obj is MyObject) ...

Unlike the control-flow keywords (e.g. do/while/for/...), do they
typically appear at the beginning of lines?  

Isn't the purpose of these !^[ \t]* patterns to reject lines that
begin with the language keywords that do not start functions, so
listing a keyword that does not usually appear at the beginning of
line looks like a churn that is not useful.

> diff --git a/userdiff.c b/userdiff.c
> index fad52d6..96eda6c 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -134,9 +134,9 @@ PATTERNS("cpp",
>  	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
>  PATTERNS("csharp",
>  	 /* Keywords */
> -	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
> +	 "!^[ \t]*(do|while|for|foreach|if|else|typeof|is|as|new|return|switch|case|default|throw|try|catch|using)\n"
>  	 /* Methods and constructors */
> -	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
> +	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe|async)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
>  	 /* Properties */
>  	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
>  	 /* Type definitions */
