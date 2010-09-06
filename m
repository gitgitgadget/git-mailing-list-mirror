From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] New send-email option smtpserveroption.
Date: Sun, 05 Sep 2010 23:38:01 -0700
Message-ID: <7vpqwrv0l2.fsf@alter.siamese.dyndns.org>
References: <1283708940-2172-1-git-send-email-pascal@obry.net>
 <1283708940-2172-4-git-send-email-pascal@obry.net>
 <m3lj7fn9oy.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Mon Sep 06 08:38:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsVLN-000555-9Z
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 08:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661Ab0IFGiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 02:38:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab0IFGiK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 02:38:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 50415D3BCB;
	Mon,  6 Sep 2010 02:38:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DVZZU2LHi9QXebwh32GxzmkKdC8=; b=dLGHhu
	GDJk7hdiiYXowZuaYKuag/fLAXm115z/PLjW1xySr0ChbXok+xkAIbtAFciz/oIq
	98kd7+a8NP7saJZNkGK4yx2X7ZeCNRPU9Byg2tH/MlRh7lZcdr1U7VBV1xo+9AT0
	ZHh2HrKU2wpwgIIYNFfNmle7LaisaXGY8Xq1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nz2gl+VHrJKffSmb147cTl8h1e0bRvBW
	oYuBfp8cr1rAdR/kl1AfPqhxE/IIZqJEhEnQ6TFdogAqrOKumg1ttSUnNNPqghVG
	/i1gvhEefvAaDEiF1NxsJeojwzTdht7rcgYxB5zO5AvzXxjSMwMiajf2rd2XULkX
	2Z9Cp0ILCLE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CCCED3BC9;
	Mon,  6 Sep 2010 02:38:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28EB0D3BC3; Mon,  6 Sep
 2010 02:38:03 -0400 (EDT)
In-Reply-To: <m3lj7fn9oy.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sun\, 05 Sep 2010 14\:49\:15 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4EF39A3E-B981-11DF-81BC-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155537>

Jakub Narebski <jnareb@gmail.com> writes:

> Pascal Obry <pascal@obry.net> writes:
>
>> The new command line parameter --smtp-server-option or default
>> configuration sendemail.smtpserveroption can be used to pass
>> specific options to the SMTP server. Update the documentation
>> accordingly.
>
> Sign-off?  (See Documentation/SubmittingPatches).

Thanks.

>> ---
>>  Documentation/git-send-email.txt |    8 ++++++++
>>  git-send-email.perl              |    8 +++++++-
>>  2 files changed, 15 insertions(+), 1 deletions(-)
>
> Needs update to Documentation/config.txt, adding line about
> sendemail.smtpserveroption.

And test if it is easy to arrange (otherwise I'll take a look myself, so
do not worry too much about it).

>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
>> index c283084..5af05bc 100644
>> --- a/Documentation/git-send-email.txt
>> +++ b/Documentation/git-send-email.txt
>> @@ -157,6 +157,14 @@ user is prompted for a password while the input is masked for privacy.
>>  	`/usr/lib/sendmail` if such program is available, or
>>  	`localhost` otherwise.
>>  
>> +--smtp-server-option=<option>::
>> +	If set, specifies the outgoing SMTP server option to use.
>> +	Default value can be specified by the 'sendemail.smtpserveroption'
>> +	configuration option.
>> ++
>> +The --smtp-server-option option must be repeated for each option you want
>> +to pass to the server.
>
> Just a nitpick.
>
> How do multiple options are supported with sendemail.smtpserveroption?
> This also needs to be described, I think.

That is a good and important point.

We could

	[sendemail]
        	smtpserveroption = opt1
        	smtpserveroption = opt2
                
or if we choose to split at WS

	[sendemail]
        	smtpserveroption = "opt1 opt2"

but with the second form there always is this nagging "how would you
specify an option with WS in it" issue, so the former might be easier.  

If we take the latter route, we should take a single command line option
and split it, i.e. --smtp-server-option='opt1 opt2', using the same WS
quoting mechanism, for consistency between command line and configuration.

I dunno.  Have we solved a similar issue with other parts of the system,
and how?

>> @@ -1015,6 +1019,8 @@ X-Mailer: git-send-email $gitversion
>>  		}
>>  	}
>>  
>> +	unshift (@sendmail_parameters, @smtp_server_options);
>> +
>
> I guess that you are following strange style that other 'unshift'
> invocation uses, but there should be no space between function and
> opening parentheses beginning its arguments, e.g.
>
>   join("\n", @xh)
>
> not
>
>   join ("\n", @xh)

I tend to prefer shift/unshift/push/pop written without these
parentheses.  Is it just me?
