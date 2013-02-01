From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools: Enable tortoisemerge to handle filenames
 with
Date: Fri, 01 Feb 2013 12:15:43 -0800
Message-ID: <7va9rnaiz4.fsf@alter.siamese.dyndns.org>
References: <50FBD4AD.2060208@tu-clausthal.de>
 <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de>
 <7vfw1qbbr4.fsf@alter.siamese.dyndns.org> <5101B0A5.1020308@tu-clausthal.de>
 <51024B02.9020400@tu-clausthal.de>
 <CAJDDKr7eNyJp1ffBYEJaZkmnVWqd0AMpnm1kdjnrrhPtuGNL_w@mail.gmail.com>
 <5102837C.9000608@tu-clausthal.de> <7v622l5d87.fsf@alter.siamese.dyndns.org>
 <51032E96.2040209@tu-clausthal.de>
 <CAJDDKr6OhZOitTdDkHWnhVhdAis0U+95xUtaNn6nwkQ-k+bA+w@mail.gmail.com>
 <5104F009.5020606@tu-clausthal.de> <7vzjzuwm7s.fsf@alter.siamese.dyndns.org>
 <510C1872.3090304@tu-clausthal.de>
 <CAHGBnuNpHtfnD6D+sji6e1yp2x6iLxjAbawwO6USF2iWW17nuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Jeff King <peff@peff.net>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 21:16:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1N1s-0007QI-NU
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 21:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283Ab3BAUPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 15:15:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40266 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757125Ab3BAUPq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 15:15:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D309B8C1;
	Fri,  1 Feb 2013 15:15:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rB+ZLAp0JSSefWtIQUWEBJ9PzFU=; b=bNHEZi
	R0b8P1DlFF7p97+DnbKwMvqDrc6cdXsVpGRt9IH5YbLjfvBztGfZy6g8LMxneQ8t
	Qqc4nTWDowZBLg3RU6UP+gQxu3Cb9OLL51EhNjOsV2LQh90iRt5AI/0EqpLaPbay
	Pap9n7YmlJX3dqu99lI3tJNvhuIxzDc7zUbnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QSUsJggwKXoAxSQ7q0Oqjqvw9NhyQrMC
	4Zr3wjgEExx0USmsE8p9YrOlEdXqLh5QGFCjhB/VKotieS3ZWz/bePyRtDYyU9SM
	I3t8nRZdZjFcAC923BCC91RB7BQ4SAIQfUu5Aeuf1TZNgPHZHiiUtSLhx+7nRzbu
	d+qeqn47864=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31957B8BF;
	Fri,  1 Feb 2013 15:15:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2BF7B8BD; Fri,  1 Feb 2013
 15:15:44 -0500 (EST)
In-Reply-To: <CAHGBnuNpHtfnD6D+sji6e1yp2x6iLxjAbawwO6USF2iWW17nuQ@mail.gmail.com>
 (Sebastian Schuberth's message of "Fri, 1 Feb 2013 21:07:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 28A718E8-6CAC-11E2-831D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215265>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> The commit message still does not mention MSYS path mangling at all,
> which probably is why the reasoning of this patch was not yet fully
> understood.

Ahh, you are very right.  I didn't realize that was what this funny
"with colon, with SP" business was about.

> I'd recommend something like the following:
>
> mergetools: Teach tortoisemerge about TortoiseGitMerge
>
> TortoiseGitMerge is an improved version of TortoiseMerge specifically
> for use with Git on Windows. Due to MSYS path mangling [1], the ":"
> after the "base" etc. arguments to TortoiseMerge caused to whole
> argument instead of just the file name to be quoted in case of file
> names with spaces. So TortoiseMerge was passed
>
>     "-base:new file.txt"
>
> instead of
>
>     -base:"new file.txt"
>
> (including the quotes). To work around this, TortoiseGitMerge does not
> require the ":" after the arguments anymore which fixes handling file
> names with spaces.
>
> [1] http://www.mingw.org/wiki/Posix_path_conversion

Sven?
