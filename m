From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Fri, 23 Mar 2012 11:20:07 +0100
Message-ID: <87pqc3ei08.fsf@thomas.inf.ethz.ch>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
	<7vmx79zeui.fsf@alter.siamese.dyndns.org>
	<CAJsNXT=YEida53nV7kj6a3cw2GibYJab4n2PucNO6inUR3HPRQ@mail.gmail.com>
	<7v8viswdho.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: PJ Weisberg <pj@irregularexpressions.net>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 11:20:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB1c7-0001UZ-Fb
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 11:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758007Ab2CWKUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 06:20:44 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:57640 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757649Ab2CWKUK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 06:20:10 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 23 Mar
 2012 11:20:09 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 23 Mar
 2012 11:20:08 +0100
In-Reply-To: <7v8viswdho.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 22 Mar 2012 14:08:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193751>

Junio C Hamano <gitster@pobox.com> writes:

> PJ Weisberg <pj@irregularexpressions.net> writes:
>
>> On Wed, Mar 21, 2012 at 4:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> underlying system calls like open("foo") will *not* magically start
>>> returning a file descriptor opened for "FOO" if your filesystem is not
>>> case insensitive.
>>
>> No, but magic_open("foo") might, if someone had put forth the effort
>> to write a function called magic_open.
>
> Exactly.
>
> That is why we avoid describing what happens when you set it on a case
> sensitive filesystem, to leave the door open for such a cleverness.
>
> It may still be a mistake in the manual that we did not explicitly say
> that setting core.ignorecase on a case sensitive system will give you an
> undefined behaviour.

How about trying to read "HEAD" as "head" instead when core.ignorecase
is true?  That would allow us to catch such misconfiguration (which I
imagine can also happen accidentally if you mv a repository across FS
boundaries) and tell the user about it.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
