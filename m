From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] pre-push hook support
Date: Mon, 14 Jan 2013 14:54:00 -0800
Message-ID: <7va9sb8jg7.fsf@alter.siamese.dyndns.org>
References: <1356735452-21667-1-git-send-email-aaron@schrab.com>
 <1358054224-7710-1-git-send-email-aaron@schrab.com>
 <7vk3rfek51.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 23:54:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TusvB-0001PA-8n
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 23:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757309Ab3ANWyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 17:54:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37937 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756300Ab3ANWyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 17:54:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58CF2BD52;
	Mon, 14 Jan 2013 17:54:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mXBtmB3zyLYdaokq5Ce5oo9bRmA=; b=tM0BcO
	HrP1Msi1qUGrPCkFjfqYQL+QWASfgNTFrKSvKUTR/y9BSL877zOb8hqhVbNtt7WU
	gHbMh6/ymluAsPEPvnoUO0IfoTAkeWYloyAR0NJn2+oo7Pmd0ugWyqdZlvnbCZso
	w0k6dPyQMXbbVXt3NS/aH0wdHTAikoXrhh1JQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cBLIVc9Wd5I2o2S7E+I7O44RawTyk5OJ
	ZaIZm1VfvTy/nkJPxwLGnrsnywvKtk3OLnXGZuLIhmaKSIid4yYvnUuQoXeNWNaB
	cNwnTctGVOLnnSbPyrdavt63gcOcIXYvnglMeEpMI4/nOxejny3A1u/Ck9PdjCKG
	hVzmWQGK3Sk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BB3FBD51;
	Mon, 14 Jan 2013 17:54:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAC9ABD50; Mon, 14 Jan 2013
 17:54:01 -0500 (EST)
In-Reply-To: <7vk3rfek51.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 14 Jan 2013 09:42:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49E3BCCC-5E9D-11E2-8EDE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213540>

Junio C Hamano <gitster@pobox.com> writes:

> Aaron Schrab <aaron@schrab.com> writes:
>
>> Main changes since the initial version:
>>
>>  * The first patch converts the existing hook callers to use the new
>>    find_hook() function.
>>  * Information about what is to be pushed is now sent over a pipe rather
>>    than passed as command-line parameters.
>>
>> Aaron Schrab (3):
>>   hooks: Add function to check if a hook exists
>>   push: Add support for pre-push hooks
>>   Add sample pre-push hook script
>
> Getting much nicer.  Thanks.

Hmph, t5571 seems to be flaky in that it sometimes fails but passes
when run again.  Something timing dependent is going on???
