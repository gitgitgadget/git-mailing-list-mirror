From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Sat, 09 Jun 2012 23:37:58 -0700
Message-ID: <7v8vfvbrjt.fsf@alter.siamese.dyndns.org>
References: <1339122742-28677-1-git-send-email-martin@laptop.org>
 <4FD31476.90104@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin@laptop.org>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Sun Jun 10 08:38:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdbmq-0007aD-Ne
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 08:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250Ab2FJGiD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jun 2012 02:38:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045Ab2FJGiC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2012 02:38:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35E8236DC;
	Sun, 10 Jun 2012 02:38:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MAC1HwYhKNCI
	acxjUPpkigyvSq0=; b=wtUqrWIjoJSyCBN9UNaJzF59lHvFacDQ9+fZfwTM65mf
	lEbUx0xnRupQtVsOXRVS3d2Wao33VC0qgEO4tt1RyZw8CuEpnCIaneaJSpZCL5gB
	IMMC6oXjPm4DHX4MrrrBlXIwBQDdCZMSi5cZu9cvFFVhtCIlyBH/BLIjFNgsGTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VdgpGX
	t7EQuMo+GQCHHp90vpVmDTq37FgPJcwYIXTS1+nI6qUZxYtlh0IwXuGeimC+M4OV
	eb5I9NQDw49O9iPTAsB5OzCDThtY6rCtKdElJA5ecTTYAOmINUucI8g+IFK/P/9+
	uHLsaXLKMQNZnIsb2dXc6BktHZbo38whiuXTM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C28536DB;
	Sun, 10 Jun 2012 02:38:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 906FD36DA; Sun, 10 Jun 2012
 02:38:00 -0400 (EDT)
In-Reply-To: <4FD31476.90104@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drzeje?=
 =?utf-8?Q?wski-Szmek=22's?= message of "Sat, 09 Jun 2012 11:16:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2B2E754-B2C6-11E1-B495-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199567>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> On 06/08/2012 04:32 AM, Martin Langhoff wrote:
>> git log -G'regex' is a very usable alternative to the classic
>> pickaxe. Minimal patch to make it usable from gitk.
>
>>      set gm [makedroplist .tf.lbar.gdttype gdttype \
>>  		[mc "containing:"] \
>>  		[mc "touching paths:"] \
>> -		[mc "adding/removing string:"]]
>> +		[mc "adding/removing string:"] \
>> +		[mc "changes match regex:"]]
>
> Hi,
>
> this feature is definitely useful. One nitpick: the string that you a=
dd
> becomes part of a sentence in the GUI: "prev/next commit changes matc=
h
> regex", which is in different grammatical form then the existing
> snippets. Should be something with '-ing'.

"prev/next commit with changes matching regex" perhaps?

In any case, Paul needs to be in the loop when we discuss gitk
changes.
