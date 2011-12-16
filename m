From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Adding hooks.directory config option; wiring into
 run_hook
Date: Fri, 16 Dec 2011 10:06:43 -0800
Message-ID: <7vmxasie6k.fsf@alter.siamese.dyndns.org>
References: <CADQnX_e76LzuRUDOKFOsRHU=e8Cw+qh5x1BdW5HMEdMmP5PaHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christopher Dale <chrelad@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 19:06:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbcBI-0002IM-4d
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 19:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760331Ab1LPSGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 13:06:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46218 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760292Ab1LPSGq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 13:06:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B98405AFE;
	Fri, 16 Dec 2011 13:06:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tdF3AUcIS+nt3WLZ8fwPcbFReZs=; b=lnRxBs
	FAe0bLtzUw5Zx5gVjDTZIMJJJkJmGUa5ywuCSgye+JSUl42rSNed+bHKsXsRkmZI
	fKAfTHCRi99d2Iu60506YXGI4s/UTRwEu3p5RR5M+E6dUE8fXPI5SNpqn2K1zoWn
	QPsBqg4763KgLUFHa1Zpp0zGVLc7CHbYCjym4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CunC90VsVwheQjk5+iw5J+IjxduOl7Oj
	8GGTHtm5O0TnitEeV00ASFGSGafhlmjVhNsdW1+pL6vZ3KVXt1bTIoE3eCFdbKOt
	FDLybA5ocqInGYwWx6cOL7d4xXdyHlA7KfdPTwwMpUfSsD4oMAeq+DB7NM4Yyv9Q
	WFQVWGMxS8M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B15725AFD;
	Fri, 16 Dec 2011 13:06:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A4BE5AFC; Fri, 16 Dec 2011
 13:06:45 -0500 (EST)
In-Reply-To: <CADQnX_e76LzuRUDOKFOsRHU=e8Cw+qh5x1BdW5HMEdMmP5PaHg@mail.gmail.com>
 (Christopher Dale's message of "Fri, 16 Dec 2011 12:00:58 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6FD9446-2810-11E1-B788-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187294>

Christopher Dale <chrelad@gmail.com> writes:

> ...
> trusted path execution policies. These systems require that any file
> that can be executed exhibit at least the following characteristics:
>
>   * The executable, it's directory, and each directory above it are
>     not writable.
> 
> Since the hooks directory is within a directory that by it's very nature
> requires write permissions,...

Sorry, but I am not interested at all. If you can write into $GIT_DIR/config
then you can point at any directory with hooks.directory and that would mean
it would defeat your "trusted path execution policies".
