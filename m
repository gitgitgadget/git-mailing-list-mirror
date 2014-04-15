From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 0/6] transport-helper: fixes
Date: Tue, 15 Apr 2014 14:25:28 -0700
Message-ID: <xmqqfvlejnef.fsf@gitster.dls.corp.google.com>
References: <1397333575-11614-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq61mbod8y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Richard Hansen <rhansen@bbn.com>,
	Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 23:28:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaAu1-0002A8-2Z
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 23:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbaDOVZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 17:25:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43009 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbaDOVZb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 17:25:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 587E47C4F2;
	Tue, 15 Apr 2014 17:25:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ucqJyQKMub4V7lz334NMMQzof3M=; b=FJhYrR
	g0GqGQKd5EbCjU5DuxHN2NOwIRHDe/43pjPASbEM6+KSTFDaPEymFnQtao1+xDLC
	b0IUVp3fnyQxMYqi6Qsgn2nyfpGIMZA7XvHqb1UOLKKWw0JAuPNTUV0jNYut9swa
	rxDkLYdnNaMVveFeS6baC4b9Vd1ZwzcsYqHts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EoFCHGW6VPUAekV8EQKyVAKvsVwMHMiQ
	pYIhbq2KHiaRIHCt96x+t+VvGxYLp71OrV+nFJoS7JtnPVDCzt2D4RWgDBcQVp7H
	F7X2/Ih+QSxpAdlNad2ZuK0GFCBm/LhVbzhlBYpxIc/9MCW0pGhk7dA7aLqPNfl+
	X8TJ/TndS1c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 359897C4EF;
	Tue, 15 Apr 2014 17:25:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C55F27C4E1;
	Tue, 15 Apr 2014 17:25:29 -0400 (EDT)
In-Reply-To: <xmqq61mbod8y.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 14 Apr 2014 13:41:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7823D8C0-C4E4-11E3-8482-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246303>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> These patches add support for remote helpers --force, --dry-run, and reporting
>> forced update.
>>
>> Changes since v8:
>>
>> --- a/transport-helper.c
>> +++ b/transport-helper.c
>> @@ -734,7 +734,7 @@ static int push_update_ref_status(struct strbuf *buf,
>>         }
>>  
>>         (*ref)->status = status;
>> -       (*ref)->forced_update = forced;
>> +       (*ref)->forced_update |= forced;
>>         (*ref)->remote_status = msg;
>>         return !(status == REF_STATUS_OK);
>>  }
>
> Hmph, isn't v8 already in 'master' as of 90e6255a (Merge branch
> 'fc/transport-helper-fixes', 2014-03-18)?

I checked and it seems to be that way.  If there are new development
that are missing in my tree, please send in incrementals.

Thanks.
