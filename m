From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add push --set-upstream
Date: Fri, 15 Jan 2010 13:01:46 -0800
Message-ID: <7vvdf3ulol.fsf@alter.siamese.dyndns.org>
References: <1263573407-13642-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <vpqy6jzuwpv.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jan 15 22:02:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVtIy-0001uD-DQ
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 22:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab0AOVB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 16:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755447Ab0AOVB5
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 16:01:57 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab0AOVB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 16:01:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 54581912DB;
	Fri, 15 Jan 2010 16:01:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R9443/Mqiv3xXeOdfQJzTuYk2YU=; b=am7FCp
	nINGdEAcCV1NDX4jtsTJcuVOmILSDZ+JUSR79Da/CEJm/bdLaEHew0DZhtAWAhTD
	QpdzESgfll9oLOLffo/DA3QeYgLHWpjKhFknXGmkYyLHFPIA8pKz2bT8e8auSz+1
	TlmYvaoe+TNWRvaVQ87LiiLTHJmbnMaRvRvV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dj63z/Oj243ecRtKgAe1ufKAlBwg8NtN
	705nEwtStk0vRKMR5eiCismV4mJjhsaAf/J0WhgS1j/0uV0+yCmzNrtpxvzwxlJv
	Vt1WTnGXBz/QoVT0RcfFM1HOUTSI2nQLuhhhrTD5C0kcqzrtvTpKAN2tlznlbwbu
	Mg1PEHXp4VQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EE8B912D7;
	Fri, 15 Jan 2010 16:01:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A5F4912D0; Fri, 15 Jan
 2010 16:01:47 -0500 (EST)
In-Reply-To: <vpqy6jzuwpv.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri\, 15 Jan 2010 18\:03\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3459E950-0219-11DF-B1C8-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137117>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
>
>> +
>> +-u::
>> +--set-upstream::
>> +	For every branch that is up to date or successfully pushed, add
>> +	upstream (tracking) reference for argument-less git pull.
>
> Not just argument-less git pull. git status is also impacted for
> example. Actually, we already have documentation for it in git-branch
> (--track option), and git-config (branch.<name>.merge configuration
> variable), so you should add a pointer to one of them.
>
> How about
>
> --set-upstream::
> 	For every branch that is up to date or successfully pushed, add
> 	upstream (tracking) reference, used by argument-less
> 	linkgit:git-pull[1] and other commands. For more information,
> 	see 'branch.<name>.merge' in linkgit:git-config[1].

Yeah, if we talked only about the configuration variable it wouldn't help
users, but this description is reayy good.

> Or the --track option of branch and checkout should be renamed as
> --set-upstream, but that seems a lot of trouble for little benefit.

It might make sense to do so in the longer term UI clean-up, but I think
that is largely an independent topic.  By not introducing new places the
confusing --track is used, we are at least not making things worse.
