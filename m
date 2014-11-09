From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-imap-send: use libcurl for implementation
Date: Sun, 09 Nov 2014 09:45:04 -0800
Message-ID: <xmqqy4rkb74v.fsf@gitster.dls.corp.google.com>
References: <53FD0CD1.7030801@raz.or.at> <545F6586.109@web.de>
	<545F8079.7010806@raz.or.at> <545FA3FA.10308@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bernhard Reiter <ockham@raz.or.at>,
	Torsten =?utf-8?Q?B=C3=B6gershaus?= =?utf-8?Q?en?= 
	<tboegi@web.de>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Nov 09 18:46:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnWZY-0007HV-Di
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 18:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbaKIRqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 12:46:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60061 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751274AbaKIRqc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 12:46:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA2941ADB3;
	Sun,  9 Nov 2014 12:46:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9ipsbbokFK1rJiHtAb4OUQzHQKQ=; b=Vy38JF
	ePi2n+/LQz9g/i7KAtBW0yXlz90th425QDnxs4Tds+Bvyj4lIEfsaaJulwLSZ8vf
	DhK4Xub1trYB0cas0zjASW+q5kuIHgK+gkWAdry3gvYtU9xy17Iyg9o2ICtKLxoi
	X0YR9Y5DjLEJyy5gEWtXygfumh5zNTqj+CAWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=POXLbz6uA1aQqKDzl99NFEzQ99D8R66C
	x6zQAALREnaYB6XWe4tLcrAhVvJP9FFJPVYkUF4ROYV1HBDqhnLWeQCIhhR4Yh2c
	8yKymA9YeNKEuSfp2OCq4qh3sBvAughQWOkGMdQtTFvGYMlUptPNdvP3hpASvG50
	yW3EKmKt9SY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F0861ADB2;
	Sun,  9 Nov 2014 12:46:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C1621AD69;
	Sun,  9 Nov 2014 12:45:06 -0500 (EST)
In-Reply-To: <545FA3FA.10308@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Sun, 09 Nov 2014 17:27:22 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2462278A-6838-11E4-A06B-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

>> In order to suppress a sparse warning about "using sizeof on a
>> function", we use the same solution used in commit 9371322a6
>> ("sparse: suppress some "using sizeof on a function" warnings",
>> 06-10-2013) which solved exactly this problem for the other commands
>> using libcurl.
>
> Although it doesn't hurt, I don't think this 'problem' deserves
> so many (or any) inches in the commit message. ;-)

Use smaller line pitch, then? ;-) I am sure myself 6 months down the
road as a "git show" reader of this patch would appreciate these
five lines when I scratch my head looking at the Makefile changes.

>> Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>
> Since I didn't actually review this patch, or make any significant
> contribution to the code (it's not even enough to be copyright-able!),
> then this 'Signed-off-by:' should not be included. At *most* you might
> want to put a 'Helped-by:' _prior_ to your sign-off.

Yes, that is the appropriate thing to do, I would think.

Thanks.
