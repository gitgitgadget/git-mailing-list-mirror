From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] gc: remove unused #include "sigchain.h"
Date: Thu, 22 Oct 2015 13:14:29 -0700
Message-ID: <xmqqk2qer78a.fsf@gitster.mtv.corp.google.com>
References: <1445517810-13998-1-git-send-email-tklauser@distanz.ch>
	<1445517810-13998-2-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Thu Oct 22 22:14:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpMFw-0001ul-QZ
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 22:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758137AbbJVUOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 16:14:32 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757964AbbJVUOb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 16:14:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2885624A71;
	Thu, 22 Oct 2015 16:14:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BrVJpYQ8uFD1+EVLqKB+pwrnKDQ=; b=JdRCv1
	mnkQKNa6fsbcm7z62FaKBTitc8lcvsHe8th5Am0QUzpjiGGUmiSYp5yv8Zvjblfl
	qOH0QXHyBvXiITKL68eatUu5v1tuyzenuOMJdSGI5logbEZSjsxnGMQmGlEf39yN
	0p+MIZUMoIMsa9NUN0FDbsYJnMwW5HTNh5yfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uayxFq8onG8+q2V/YG+I131elE+2JwuB
	8887tyQ9AFxpLGFNqD+V9UkbB+CXz3BWgtNmbHDw0OsmbXaSMg8XCKE5Siv6YR1W
	rOjkcO6yRJgEFGPBms/fMYQ2ZNMgN36V5KAMH/9fV+/gpWIKsWg5EqcEB3QC/XUL
	fCY5lgLALNE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1FEFE24A70;
	Thu, 22 Oct 2015 16:14:31 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 97DDE24A6E;
	Thu, 22 Oct 2015 16:14:30 -0400 (EDT)
In-Reply-To: <1445517810-13998-2-git-send-email-tklauser@distanz.ch> (Tobias
	Klauser's message of "Thu, 22 Oct 2015 14:43:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 80B6F006-78F9-11E5-B1AD-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280073>

Tobias Klauser <tklauser@distanz.ch> writes:

> After switching to use the tempfile module in commit ebebeaea (gc: use
> tempfile module to handle gc.pid file), no declarations from sigchain.h
> are used in builtin/gc.c anymore. Thus, remove the #include.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---

I'll drop this one as we seem to have gained another user of the API
in this file in the nd/gc-auto-background-fix topic.

>  builtin/gc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 9ff0204..dc8a242 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -15,7 +15,6 @@
>  #include "lockfile.h"
>  #include "parse-options.h"
>  #include "run-command.h"
> -#include "sigchain.h"
>  #include "argv-array.h"
>  #include "commit.h"
