From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] Submodules: Add the new config option "ignore"
Date: Mon, 09 Aug 2010 09:57:00 -0700
Message-ID: <7v7hjz7mhv.fsf@alter.siamese.dyndns.org>
References: <4C4DD33F.4020104@web.de> <4C4DD3CF.9070906@web.de>
 <7vhbjjware.fsf@alter.siamese.dyndns.org> <4C5B3D36.1060902@web.de>
 <7vvd7obpy5.fsf@alter.siamese.dyndns.org> <4C5B4E80.1070102@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 09 18:57:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiVf9-0000Kl-5w
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 18:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068Ab0HIQ5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 12:57:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58374 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757124Ab0HIQ5R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 12:57:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 861C31BBC;
	Mon,  9 Aug 2010 12:57:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=z12EXdmkodjAJSfZMHn0lVoQhkQ=; b=V8dQMnU9shpWxB/IZ4R9Gz4
	MYYQscx0PgAPHnWJ1o1LZ/A+mXIINLpMsGUjV84DoLsHw3ChN722ioiwZzZzz8nA
	B/JelxiAg5E7PFuz+kY4M6DugbuM1RfU0cMW2KiXnhIROrH1woJ910bxfIAddpNV
	8vYOxxl98eEyY6prbseQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=wbHklwhHA4yCseC0FMR0dlBxFYyPGaJ0yyOLeBoL28enMu06K
	HMxXRilnZm6cUMWRklYFgkVUSthHhhmTOb05MK+HC9Jyq8RbqULJpt245QM6hRe6
	icp+PSqA0z0VdkEhjiMS3FLQi7+5KyQC8FM8gMv8+n5fCZ0hygFqtMb2/I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 804CC1BB7;
	Mon,  9 Aug 2010 12:57:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.126]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5FDE1BB4; Mon,  9 Aug
 2010 12:57:01 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 272231BA-A3D7-11DF-BEE9-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152986>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 06.08.2010 01:27, schrieb Junio C Hamano:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> 
>>> Am 28.07.2010 23:35, schrieb Junio C Hamano:
>>>> The value of "submodule.<name>.path" does not have to be "<name>".  There
>>>> seems to be a bit of confusion here.
>>>
>>> Thanks for clearing up my confusion, this is v2 of this patch using the
>>> path configured for the submodule instead of its name.
>> 
>> Hmph, I thought that it would make more sense to use <name> so that once
>> the user configures ignore in .git/config, it will persist across moving
>> of the submodule in the superproject tree.  I wonder what others would
>> think.
>
> I think that is just what this patch does, it uses the ...

Yeah, what you said is all correct.  I just misread "... this patch using
the path ... instead of its name" to mean that the user-level interface is
now keying off of a path, but that is not what you meant.  You instead
meant that the name is used as the key and it used as if it is a path in
the previous round, but now it goes through name-to-path mapping.

Thanks.
