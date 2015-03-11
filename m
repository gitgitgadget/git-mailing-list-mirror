From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [JFF] "-" and "@{-1}" on various programs
Date: Wed, 11 Mar 2015 13:16:43 -0700
Message-ID: <xmqqoanz5lxw.fsf@gitster.dls.corp.google.com>
References: <xmqqy4n4zjst.fsf@gitster.dls.corp.google.com>
	<55003757.8090004@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 11 21:16:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVn3j-000575-4i
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 21:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbbCKUQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 16:16:47 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750775AbbCKUQq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 16:16:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A95F3E9DB;
	Wed, 11 Mar 2015 16:16:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y9cd/paGSZYUl+ZOR4hYHtmbHJM=; b=WlMEYz
	66F0sUACKAvTBkqUf9EyXk8D2iENSjAz0c3QpJlDkhFk3qmdMzzf0nKsyem+YvEU
	+uHm462+K2z4S8PK+YG+fsjAo8VTHNKZS0rtqVSmJO3Q/kRo5lmBX7ZEQ4vvvgCJ
	JzMj9XFpWX/xQHQOsHuITnW4MfE3BP7CHjymc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XZCLdJj91PwebG1iHdngQqBKxIp0MsDE
	Kqy9iXMP+mtRgJhQA6UCQVzKpsfZeJyHzbwHJ9vF3Rw+H2NAXQxWa9oKxZYu73Wn
	WQ+pPLiGKkzVIBW93MW+Sy7mWahuyeMGC5376Zojs3ZVUpuPGKiWBgPGh6cOShSS
	XVeY5F1XJJ4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 71B6F3E9D9;
	Wed, 11 Mar 2015 16:16:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E86773E9D6;
	Wed, 11 Mar 2015 16:16:44 -0400 (EDT)
In-Reply-To: <55003757.8090004@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Wed, 11 Mar 2015 13:38:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 89D9BE86-C82B-11E4-81DD-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265334>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 10.03.2015 21:20:
>> JFF stands for just for fun.
>> ...
>> What does not work are what needs further tweaking in revision.c
>> parser.  "git checkout master && git checkout next && git log -.."
>> should show what next has on top of master but I didn't touch the
>> range notation so it does not work, for example.
>> 
>>  builtin/checkout.c |  3 ---
>>  builtin/merge.c    |  3 +--
>>  builtin/revert.c   |  2 --
>>  revision.c         |  2 +-
>>  sha1_name.c        | 57 +++++++++++++++++++++++++++++++++---------------------
>>  5 files changed, 37 insertions(+), 30 deletions(-)
>
> Like it :)
>
> It removes the special casing and makes a shorthand available
> systematically. I'd say it's useful even without extending it to ranges.

I wouldn't have done this if I thought it will lead to an unusable
blind alley ;-) But I won't be hacking on this any further for now.

Hint hint...
