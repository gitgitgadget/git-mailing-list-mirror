From: Junio C Hamano <gitster@pobox.com>
Subject: Re: FEATURE REQUEST: Allow SSH style URLS (with extra colon)
Date: Sat, 30 Jan 2010 14:30:04 -0800
Message-ID: <7v4om3jker.fsf@alter.siamese.dyndns.org>
References: <87tyu3cyy3.fsf@jondo.cante.net>
 <20100130222157.GI9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jan 30 23:30:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbLpd-0007wz-TJ
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 23:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748Ab0A3WaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 17:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753533Ab0A3WaO
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 17:30:14 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40362 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab0A3WaM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 17:30:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9536995478;
	Sat, 30 Jan 2010 17:30:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1f4kCahCys2yExd+LEQdtb1eMfk=; b=k2PPvN
	kVnV2U8A28lehXSTKxsa+7xMeB+ElYwDl9rBLefPXwRmtkiyJjsyBt8Twhu78wao
	uPk3gW9ABkYbqpMQpsd1irwmgd6n3sVJ2DqZOVU0u1N3Mg7P0Mjh9RTYknz4C89X
	nIFyXQ8OUg1NTf2EVGuaTD0scXM8aAek8w6MI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fe7cZTVHiG+03js2/yxBRC0yfzrzND5d
	RetGKhLQvv+Ktrs1Oet06+0UgMXxzjJDFzppuio4xyV4F0pIQr0ng83w5C/yeyIV
	SNHFldrNLHkksYup3mhE14Onx7ADwwINmyO2LEpTs82oWb1hVoGeM9Nqr5+1NGRe
	OsMG/fC8m5g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6058F95473;
	Sat, 30 Jan 2010 17:30:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A026B9546D; Sat, 30 Jan
 2010 17:30:05 -0500 (EST)
In-Reply-To: <20100130222157.GI9553@machine.or.cz> (Petr Baudis's message of
 "Sat\, 30 Jan 2010 23\:21\:57 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0603CF08-0DEF-11DF-A2F4-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138504>

Petr Baudis <pasky@suse.cz> writes:

> On Sat, Jan 30, 2010 at 06:57:56PM +0200, Jari Aalto wrote:
>> 
>> An example:
>> 
>>     ssh://foo@examplecom:/path
>>                         |
>>                         Allowed
>
> But that's not an URL anymore. If you want to use ssh pathspec, write it
> as a pathspec, not an URL. Just foo@example.com:/path works fine. ;-)

The way URLs are defined is:

	<scheme>:<scheme-specific-part>

so if somebody defines his "ssh" scheme to allow any random garbage, its
their URL and you cannot say "that is not an URL", unless you qualify your
statement with "I want to keep ssh scheme consistent with the common
internet scheme syntax".

As I think "ssh://..." is simply moronic, I don't even care to "keep" the
scheme specific part consistent with the common internet scheme syntax to
begin with.  I agree with your conclusion, though ;-)

scp syntax works just fine.
