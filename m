From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 00/19] index-helper/watchman
Date: Tue, 10 May 2016 13:30:37 -0700
Message-ID: <xmqq37ppodua.fsf@gitster.mtv.corp.google.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
	<xmqqa8jyuczj.fsf@gitster.mtv.corp.google.com>
	<1462832134.24478.49.camel@twopensource.com>
	<xmqqy47iswhj.fsf@gitster.mtv.corp.google.com>
	<1462881130.3018.13.camel@kaarsemaker.net>
	<5731FFB7.20006@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	pclouds@gmail.com
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Tue May 10 22:30:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0EIs-0001mu-NO
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 22:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbcEJUar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 16:30:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751568AbcEJUal (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 16:30:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 566AA19917;
	Tue, 10 May 2016 16:30:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RpEW1ghmqPd7xPGKU5KOM8v1y1w=; b=ZaVTfO
	4CG01oKcYuFS8+6ufg8ltt/EXA5lJv4zTh6tk1UtpmQyaLemdpE5+xzk7u47u03Q
	lcPkYnprmX81YhsacMcZp33xWBlByE6cfQi5F3hbT+EPv8igb6I+fEo1Y3S7hf6c
	MJ86ufZRXz8TUh45LBwHUUOPLuFpI4G1To/7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gvf4XxF+TS9QvKdtfpWvf1qjQYSvu7M7
	e3890LHRHF7/kufB122/VOdUKIDuVKJoLF0j5eFcKVTK1sm30P7RzS8qsAQIarb3
	9EhD9qgkPAgcRD8duwS44e4GoUptjUna5/fhyLtquRMUmyJWqvWNekgiE63dOwLq
	gWG7X2ji4L4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B09519916;
	Tue, 10 May 2016 16:30:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 92E7E19913;
	Tue, 10 May 2016 16:30:39 -0400 (EDT)
In-Reply-To: <5731FFB7.20006@ramsayjones.plus.com> (Ramsay Jones's message of
	"Tue, 10 May 2016 16:35:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0F4DDD74-16EE-11E6-9E51-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294186>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 10/05/16 12:52, Dennis Kaarsemaker wrote:
>> On ma, 2016-05-09 at 15:22 -0700, Junio C Hamano wrote:
>>> It passes on one box and fails on another.  They both run the same
>>> Ubuntu 14.04 derivative, with same ext3 filesystem.  The failing one
>>> is on a VM.
>> 
>> Same here, except ext4 instead of ext3. Failing on a virtual machine,
>> not failing on a physical one.
>
> I can confirm the trend:
>
>     Linux Mint 17.3, ext4 - bare-metal pass, (Virtual Box) VM fail.
>
> ATB,
> Ramsay Jones

I do not think there is anything VM specific, though.  If it is
SIGPIPE, it is very much understandable it is timing dependent, and
VMness may be a cause of timing differences, nothing more.

I seem to getting the failure on my physical box today, by the way.
