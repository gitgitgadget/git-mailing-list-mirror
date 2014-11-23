From: Junio C Hamano <gitster@pobox.com>
Subject: Re: recent cygwin breakage
Date: Sun, 23 Nov 2014 10:13:25 -0800
Message-ID: <xmqqr3wtyed6.fsf@gitster.dls.corp.google.com>
References: <5470B9F9.2060008@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Nov 23 19:13:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsbfB-0004e5-W4
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 19:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbaKWSN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 13:13:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751273AbaKWSN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 13:13:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D636C1859A;
	Sun, 23 Nov 2014 13:13:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vJjO9CevZrZtPNAR0IY+7eYONTQ=; b=Xx96Kb
	SDHqQIGluN6QtFN5iBSsICRjz0Jxp3C1FNDCMS/ObhHAdglbLfDSkKxQ3NhBqc4q
	e6d6JSi51ExyD6M+lYZ6yNaeWamTkvVKP4+xQDjbPwKQH5/Kn0PJMI6xL8fzGFa5
	yQEZJvmhbkocCK3KmSCl8Z3MVkKaGBxSutL08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nB/7F09as3YBjHSEcUuvVnyhihHKjWVp
	zGYXiBGVDrkh+0qbo0i+JhNQKK3NAXbD4ipv6XRbVmBk2Zg2aC10tTdW7a5lcbQr
	vnoOIWnj3C7ZfTVZ62FJ4G2srlgLGGfq6NuXP8tORzWnow3E3AqnlBVzOLAZfyrs
	0pzQtK8IZko=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CC77518595;
	Sun, 23 Nov 2014 13:13:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 546B918593;
	Sun, 23 Nov 2014 13:13:26 -0500 (EST)
In-Reply-To: <5470B9F9.2060008@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Sat, 22 Nov 2014 16:29:45 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6B4F5898-733C-11E4-B0A0-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260093>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Just a quick heads-up on a recent cygwin breakage.
> 
> I updated my (64-bit) cygwin installation yesterday and (along
> with many other packages) I noticed a new version of gcc (and
> presumably libc) was installed (gcc v4.8.3-5 x86-64).
> ...
> However, I haven't run any tests yet. Also, I would need to check
> this out on 32-bit cygwin (I haven't booted that laptop into Win XP
> for quite some time!).
>
> Hmm, I don't really know if this is an unintended side-effect of a
> recent change to cygwin (or a bug), but I couldn't see any mention
> of this on the cygwin mailing list. (I don't intend to report this
> to that mailing list; I don't want to subscribe to (yet another)
> busy list). :(

Thanks.

I wonder if it is safe to unconditionally drop XOPEN_SOURCE; would
it cause problems for older Cygwin to those who have not updated to
the recent one yet?  The proposed change looks trivially correct
otherwise.
