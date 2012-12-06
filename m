From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clean: Display more accurate delete messages
Date: Thu, 06 Dec 2012 09:37:31 -0800
Message-ID: <7v8v9bjd44.fsf@alter.siamese.dyndns.org>
References: <1354788938-26804-1-git-send-email-zoltan.klinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 18:37:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgfOT-0001E0-Kc
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 18:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946395Ab2LFRhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2012 12:37:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38444 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945918Ab2LFRhe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2012 12:37:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52D7B8EF0;
	Thu,  6 Dec 2012 12:37:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ekZOmYJO5SX5k498+fSVBTgQpx8=; b=dL/m1v
	8OoKvCjp0TTeWzBx3hXu5auQcrP+I5NDVf1akr0PGTFsGx4SW+mMxFJt6/uKhFLN
	IWq2J81UC5WhKCjP6ilrl+3zSb5jqyQ0iJDXHQ0tRxUYNwtqsIurk+segqk2OcQI
	B9Lu/u/LOFgGeBqvHoQ9BRlwxFCfp7lRiBgnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eLUuEXaWaoYxwhJIzSkoltu7I7HrhrTt
	SVv45pbH4jodfjR/9uuUyIosC/1AklibtmWHM3QPFAiDPKpDzFwwTjOxTw2Xwmxe
	1CIpeWe/+4SoTd8R4B6xpGKDxyFKRSdrT6iVH0p0dAlKTwBuw8yvQfBh/0Squqlf
	bd2k9oqoDrE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EF928EEF;
	Thu,  6 Dec 2012 12:37:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A62E48EEB; Thu,  6 Dec 2012
 12:37:32 -0500 (EST)
In-Reply-To: <1354788938-26804-1-git-send-email-zoltan.klinger@gmail.com>
 (Zoltan Klinger's message of "Thu, 6 Dec 2012 21:15:38 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9D712118-3FCB-11E2-9289-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211167>

Zoltan Klinger <zoltan.klinger@gmail.com> writes:

> Only print out the names of the files and directories that got actually
> deleted.
>
> Consider the following repo layout:
>   |-- test.git/
>         |-- foo/
>              |-- bar/
>                   |-- bar.txt
>              |-- frotz.git/
>                   |-- frotz.txt
>         |-- tracked_file1
>         |-- untracked_file1
> ...
> Consider the output of the improved version:
>
>   $ git clean -fd
>   Removed foo/bar/bar.txt
>   Removed foo/bar
>   Removed untracked_file1

Hrm, following your discussion (ellided above), I would have
expected that you would show

    Removing directory foo/bar
    Removing untracked_file1
