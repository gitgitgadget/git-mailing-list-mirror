From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: file named - on git commit
Date: Mon, 28 Jan 2013 12:51:53 -0800
Message-ID: <7vy5fduj2u.fsf@alter.siamese.dyndns.org>
References: <51065540.1090007@renemoser.net>
 <87txq11sbk.fsf@pctrast.inf.ethz.ch> <20130128204140.GA7759@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Rene Moser <mail@renemoser.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 21:52:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzvgg-0000a9-FM
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 21:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab3A1Uv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 15:51:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42514 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181Ab3A1Uv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 15:51:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5F9ACC04;
	Mon, 28 Jan 2013 15:51:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TxpoqVXfozP4O95UIhSR8LFrclA=; b=C5HSuw
	VKic5o2IjT64mt4J8O0eHGB/mlmdZzGg5gwHzvUYwNg1ThD9Qqoaq0+O+Ctwj+jz
	hQcAccktIAG2eKTi0Jsjf5/x2ZAoaaCkZWlYN2oFfPDmib5PwouVosw4IUuFAzDn
	kyQk/iGC129laTPGX7tqBzUNccQktM41zk8Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dhmZPHGSTbmvZ5SI0TarAXPSENUIsIJP
	XXAdLi8zG9YgLsUXUexkzbrzVP9tvr6+28Ox82Mvr0f5+wveJnvQg/esRle/7WnW
	Lf9Zc1oT86GB6LT/x6PszooISb5ZxsVftywkh/44jj7vmBnuTaYmmQwT/V1cbP3Z
	vaSdYmExJxQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB4B3CC03;
	Mon, 28 Jan 2013 15:51:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FA78CBFC; Mon, 28 Jan 2013
 15:51:54 -0500 (EST)
In-Reply-To: <20130128204140.GA7759@google.com> (Jonathan Nieder's message of
 "Mon, 28 Jan 2013 12:41:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8CA88A02-698C-11E2-AB8E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214870>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thomas Rast wrote:
>> Rene Moser <mail@renemoser.net> writes:
>
>>> Found a little issue in git version 1.7.9.5 if a file named "-", causing
>>> "git commit" to read from stdin.
>>>
>>> (So you must hit ctrl-d or ctrl-c to finish the commit.)
> [...]
>> This was fixed by Junio around 4682d85 (diff-index.c: "git diff" has no
>> need to read blob from the standard input, 2012-06-27), which is
>> included starting with v1.7.12 and the v1.7.11.3 maint release.  Please
>> upgrade.
>
> Should upgrade-averse folks stuck on 1.7.10.y (like Debian 7.0, which
> is currently in the release candidate stage) take this fix?  Do you
> happen to know of any other fixes such people would want?

FYI, the fix referred to in this thread are three-patch series that
forked from 1.7.6.6, so it should be trivial to merge it even to
such an old version.

The topic-branch workflow shines ;-)
