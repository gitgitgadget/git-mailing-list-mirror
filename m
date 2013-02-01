From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 17:15:13 -0800
Message-ID: <7vr4l0dece.fsf@alter.siamese.dyndns.org>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
 <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
 <7vvcadgss0.fsf@alter.siamese.dyndns.org> <20130131190747.GE27340@google.com>
 <7vip6dgmx2.fsf@alter.siamese.dyndns.org> <20130131200434.GI27340@google.com>
 <7v622dgl2o.fsf@alter.siamese.dyndns.org>
 <7vobg5f55t.fsf@alter.siamese.dyndns.org> <20130131210002.GK27340@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 02:15:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U15EC-0007bK-Er
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 02:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080Ab3BABPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 20:15:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49505 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641Ab3BABPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 20:15:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7E26CDFB;
	Thu, 31 Jan 2013 20:15:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aZim6Ezz9EN3MjwdIQ+Ruyy1GFk=; b=xpu4Di
	qmo1DqqxdOylE22w03EWvNuxH7HXF0pguIEf2GpH/fXurSlGsQmSh4MOt688EMxY
	2YrrEki2pNfP+rBzmj8ORdFD0m7qZCsY/9Q/tofjCOjjRuvAjaDEsECWxNlZfWFU
	UGogTgF8DWW9CCj2NAQOaGDEAiz96V5gfr7hI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vZoX3ThCHbOY/eTxRYn8EQsoOKtTXxgh
	7OhcCTuU+nMhsyYnM2u8Ihh940ZUIb2NKB3aaOnnm5dlsewRF1fRuKWVhhGQ8Wrh
	IZndR85usZpzOjdXKUN18kGzOEeJbRAZEV3zjX4ViDZpeK0tNCDLGgxlupjAY3iF
	8c/1uEJMU8A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBE7FCDFA;
	Thu, 31 Jan 2013 20:15:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2629DCDF8; Thu, 31 Jan 2013
 20:15:15 -0500 (EST)
In-Reply-To: <20130131210002.GK27340@google.com> (Jonathan Nieder's message
 of "Thu, 31 Jan 2013 13:00:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D57C9D04-6C0C-11E2-8725-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215195>

Jonathan Nieder <jrnieder@gmail.com> writes:

> [...]
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1795,7 +1795,8 @@ push.default::
>>    +
>>    This is currently the default, but Git 2.0 will change the default
>>    to `simple`.
>> -* `upstream` - push the current branch to its upstream branch.
>> +* `upstream` - push the current branch to its upstream branch
>> +  (`tracking` is a deprecated synonym for this).
>
> I have already explained that I believe this is a bad idea and why and
> proposed an alternative.  I take it that either we are
> miscommunicating or we fundamentally disagree about the role of
> documentation. :(

Whatever.

For tonight, I'll queue this version on 'pu' primarily because I do
not want to think about it anymore today and because I do not want
to see us forget that we have to fix this in some way, and this was
the only one that I can simply "git am" on this topic. It is not
because I want to say "this is the version we are going to use,
stfu!"  This topic does not even deserve such inter-developer
tension, IMHO.

    doc: mention tracking for pull.default
    
    When looking at a configuration file edited long time ago, a user
    may find 'pull.default = tracking' and wonder what it means, but
    earlier we stopped mentioning this value, even though the code still
    support it and more importantly, we have no intention to force old
    timers to update their configuration files.
    
    Instead of not mentioning it, add it to the description in a way
    that makes it clear that users have no reason to add new uses of it
    preferring over 'upstream', by not listing it as a separate item on
    the same footing as other values but as a deprecated synonym of the
    'upstream' in its description.
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
