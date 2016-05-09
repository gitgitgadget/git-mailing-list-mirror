From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 00/19] index-helper/watchman
Date: Mon, 09 May 2016 15:22:00 -0700
Message-ID: <xmqqy47iswhj.fsf@gitster.mtv.corp.google.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
	<xmqqa8jyuczj.fsf@gitster.mtv.corp.google.com>
	<1462832134.24478.49.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 10 00:22:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aztZ4-0006K5-Hu
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 00:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbcEIWWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 18:22:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751248AbcEIWWE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 18:22:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CCC961A1AF;
	Mon,  9 May 2016 18:22:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sR65JG3PRhrUrNt/TpA4kOQmcOI=; b=d5MCO+
	b51O64XWw2AN4Ha4c+bzdgolrrfRRVWPhR9LRyZZmVRi105zijOOiD2LNCjWWOkc
	fGK0tQcQFoNcZJPybCvYkcbhgQeZpS9wwuTXAmEUceVrGYYDIeRoM6E3lOXuCRck
	NiNvkZVoprgFvhtlOIIUTXRZYOQBRIC5vlHK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WHjOT8G/d7Is6lS31u1CtCx6w4hzpoKj
	vqj37dQ0bKy5Eq/GS0IjoO3CA6iYtMlkJYGulwir9wGBcNh4FzL9y5GbVQhNVe9q
	5GzJkvANNMHUNz8fnmPGpAojam2dKXHbkYZQ2jKguRo7/DzrIbDPeQ35YIAsZNbv
	kDVbs10fbKw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C5C391A1AE;
	Mon,  9 May 2016 18:22:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 480A91A1AD;
	Mon,  9 May 2016 18:22:02 -0400 (EDT)
In-Reply-To: <1462832134.24478.49.camel@twopensource.com> (David Turner's
	message of "Mon, 09 May 2016 18:15:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7415E34C-1634-11E6-BA51-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294079>

David Turner <dturner@twopensource.com> writes:

> On Mon, 2016-05-09 at 14:40 -0700, Junio C Hamano wrote:
>> Hmmm, I seem to be getting
>> 
>>     $ cat t/trash*7900*/err
>>     fatal: Already running
>> 
>> after running t7900 and it fails at #5, after applying
>> "index-helper: optionally automatically run"
>
> It still passes for me (with or without USE_WATCHMAN set).  I'm testing
> on Ubuntu 15.10 with "Linux ubuntu 4.2.0-35-generic", on an ext4
> filesystem.

It passes on one box and fails on another.  They both run the same
Ubuntu 14.04 derivative, with same ext3 filesystem.  The failing one
is on a VM.

> Does it fail before or after git status 2>err ?  (If before, then those
> "err" contents are from the previous test).

I didn't dig and I do not know (yet).

> Is index-helper in fact running after the test fails? 

"ps ax | grep index-helper" showed a process, which I had to "kill"
manually.
