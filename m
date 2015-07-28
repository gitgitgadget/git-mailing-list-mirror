From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git branch command is incompatible with bash
Date: Tue, 28 Jul 2015 19:27:46 +0200
Message-ID: <55B7BB92.30006@kdbg.org>
References: <20150727121253.GC17338@2vizcon.com> <55B69E68.90306@kdbg.org>
 <xmqqh9opgtjz.fsf@gitster.dls.corp.google.com> <55B72F09.3030000@kdbg.org>
 <xmqq4mkogvb7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Anatol Rudolph <a.rudolph@2vizcon.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 19:27:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK8fS-0005zN-77
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 19:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbbG1R1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 13:27:50 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:24592 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbbG1R1t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 13:27:49 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3mglM73jpZz5tl9;
	Tue, 28 Jul 2015 19:27:47 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 02F5752C2;
	Tue, 28 Jul 2015 19:27:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <xmqq4mkogvb7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274795>

Am 28.07.2015 um 17:23 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Are you trying to say that the result of 'rev-parse --abbrev-ref HEAD'
>> is suboptimal and that of 'symbolic-ref --short HEAD' is OK?
>
> My "Interesting" was primarily about that I wasn't aware of the
> "--abbrev-ref" option.
>
> Yes, I am sure some time ago I accepted a patch to add it, but I
> simply do not see the point, especially because the "--short" option
> to symbolic-ref feels much more superiour.  "What branch am I on?"
> is about symbolic refs, rev-parse is about revisions.
>
> I can see that "symbolic-ref --short" is much newer than the other
> one, so addition of "--abbrev-ref" to "rev-parse" may have been a
> mistake made while being desperate (i.e. not having a way to do so
> with plumbing, we wanted "some" way to do so and chose poorly).

Heh. Originially, I was about to suggest

    git symbolic-ref -q --short HEAD || git rev-parse --abbrev HEAD

in order to handle the detached HEAD case by printing the abbreviated 
commit name, only to learn that this doesn't do what I expected. Looking 
at the man page of rev-parse, I discovered --abbrev-ref. And learned 
that I actually should have used --short instead of --abbrev in the 
above rev-parse command.

Confusing...

-- Hannes
