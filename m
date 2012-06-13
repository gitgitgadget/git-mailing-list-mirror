From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5] rebase [-i --exec | -ix] <CMD>...
Date: Wed, 13 Jun 2012 11:22:10 -0700
Message-ID: <7vipevgjhp.fsf@alter.siamese.dyndns.org>
References: <1339325076-474-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339488312-6349-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <4FD70A8E.7050502@in.waw.pl> <7vk3zc4mgz.fsf@alter.siamese.dyndns.org>
 <4FD89DD6.1070705@in.waw.pl>
 <20120613200552.Horde.JHFYfHwdC4BP2NaA39-wrmA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Wed Jun 13 20:22:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SesCw-0006XP-T8
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 20:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539Ab2FMSWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 14:22:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65079 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754234Ab2FMSWN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 14:22:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 040A880C9;
	Wed, 13 Jun 2012 14:22:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sfXAi47dHUzhdo1QuGHYPT/mDvc=; b=JlHn/1
	mWBKYWq9iYM3QrQVFGBYiFF8W5ExgxFGC+zqo2717rsfvfcqwQol3WNOpwymHcSr
	0KF8he+JwO/x8xE4WAaxUwIyqtr/5aodTRvhxwwAL990S/WcWPpBVz1zH7aOQKvN
	Pp2C9Nbm4Alla89eZ3eK8QtWiwTlxNCW5OV6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CNmz94EXHPfd+em7wziesl32/Q4JFS3o
	wYOPlfPoYrxMVLq07TEwGmmn75nwT+36F4iL5qiu+vwo2bSRRMZExB4Rl5Q5JyoU
	690IxFrDLrvrFdJSO3uLmF0EQOuVnsMnUf3c3ipF1LtGOLSF8EkFRY5iiEXsMrRx
	mKZKyEalszI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE2EE80C8;
	Wed, 13 Jun 2012 14:22:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7695480C6; Wed, 13 Jun 2012
 14:22:11 -0400 (EDT)
In-Reply-To: <20120613200552.Horde.JHFYfHwdC4BP2NaA39-wrmA@webmail.minatec.grenoble-inp.fr> (konglu@minatec.inpg.fr's message of "Wed, 13 Jun 2012 20:05:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1743208-B584-11E1-9D35-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199916>

konglu@minatec.inpg.fr writes:

>> +You may execute several commands by either using one instance of `--exec`
>> +with several commands:
>>  +
>> -You can also insert several instances of `--exec`, if you wish to only
>> -have one command per line. For example:
>> +	git rebase -i --exec "cmd1 && cmd2 && ..."
>>  +
>> -	git rebase -i --exec "cmd1" --exec "cmd2" ...
>> +or equivalently by giving more than one `--exec`:
>
> ...I'm against using "equivalently" as in the first case, all the commands
> are on one line, and in the second case, each commands have its line, thus
> easier for the user to manipulate them independently.

It looks that editing

    pick foo            pick foo
    exec cmd1           exec cmd1 && cmd2
    exec cmd2
    pick bar            pick bar
    exec cmd1           exec cmd1 && cmd2
    exec cmd2

to

    pick foo            pick foo
                        exec         cmd2
    exec cmd2
    pick bar            pick bar
    exec cmd1           exec cmd1

would take exactly the same effort, at least to me.  And more
importantly, without editing don't they do *exactly* the same thing?
If cmd1 fails, the sequencing stops at that step without running cmd2.
