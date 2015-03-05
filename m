From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git merge driver / attributes bug in 2.3.1?
Date: Thu, 05 Mar 2015 10:55:44 -0800
Message-ID: <xmqqa8zr46kv.fsf@gitster.dls.corp.google.com>
References: <D8780C527EB1E642B3150E6D705B46D448E7E48C@DWPWHMS531.dwpbank.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Gondek\, Andreas" <Andreas.Gondek@dwpbank.de>
X-From: git-owner@vger.kernel.org Thu Mar 05 19:55:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTaw3-00035V-Qg
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 19:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758561AbbCESzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 13:55:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756164AbbCESzr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 13:55:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A5233DC8E;
	Thu,  5 Mar 2015 13:55:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4wZnytzBu+mKsPWoYW+Pl5HnybY=; b=FqAjXV
	iLptfKSc7PCPeQKE9WootRGpF/gekINJnfkPzmv2jy7LknmZ5NXynrek/Jx1B0V/
	BR4vNgV97UGNxdNe/3dwVtAXYDeg+Fv/mqRSpkosWjkAtuUX7QuRZ8TJfmiMWWJJ
	4Hs9Lrwk/fgB+OzLIhZzSxb4zPx6K3xQOW9d0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KWxPlsrIUj69ndtUsrNUbePFNgGPuISg
	0l9LFnPxotnjDZjZtKOvWSKmLG/+RSQlKfo7SWwUWgHX3ZJDvJh/HLk2JA8twQDr
	PTEIkxTSsnusgTS9KqXwxfEyrdd4JKXG0tfVTS5hzSCHBnxHAHHQ/mjguDE3WVd4
	DjKuKNnz6M0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 289BF3DC8D;
	Thu,  5 Mar 2015 13:55:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7AA5F3DC8C;
	Thu,  5 Mar 2015 13:55:45 -0500 (EST)
In-Reply-To: <D8780C527EB1E642B3150E6D705B46D448E7E48C@DWPWHMS531.dwpbank.local>
	(Andreas Gondek's message of "Thu, 5 Mar 2015 13:30:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3AEA1EA4-C369-11E4-89B5-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264858>

"Gondek, Andreas" <Andreas.Gondek@dwpbank.de> writes:

> after upgrading the Git installation on one of our development servers
> from 1.9.0-rc3 to 2.3.1 we are experiencing strange behavior of merge
> drivers.

Do you see the same with something slightly older, like say v2.2.0?

The only change that I can think of offhand that may be related is
6ea358f7 (ll-merge.c: refactor `read_merge_config()` to use
`git_config_string()`, 2014-08-13) that went into v2.2.0, but I
don't immediately see how that would be related X-<.
