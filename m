From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can I change Git binary file's name when deploying Git-based product?
Date: Tue, 19 Jan 2016 10:57:05 -0800
Message-ID: <xmqqwpr59z3y.fsf@gitster.mtv.corp.google.com>
References: <CACaY5-uUqFxsRdwPzxAjphc=wNQhM76YJFmCZu86SpGeG1fOrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?7J2A6rWQ?= <eunqyo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 19:57:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLbSr-0007Fj-Ui
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 19:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757168AbcASS5K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jan 2016 13:57:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756737AbcASS5I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jan 2016 13:57:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DFD9E3C8FB;
	Tue, 19 Jan 2016 13:57:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Q+Z0Ux3kle7D
	z+oV961/V/OgOtc=; b=pywQ+HfokwZn3IXSkI7tnUFO4qeljAZDbHR4n1sysQoy
	piLkOqS9OPWH0/WtSRseTXwQGl6+MznJ5mzmO2rcmUTc4YZ2OdYuIGrLarDtYC+C
	HtdOS047GCZ6T28TeBnjLn2AulvI3TELtqIH30pxNbdkC1tOWyt8KWMqMMLrYkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=A37Xwp
	+17HMCl5BdVrCweE54ho3QjUOnsCn2Dlea0dzHeHEtkTK6Wp9bHKQy6hqLwIZ1zw
	oiPawad7CDYmiiJK+xXWftG7sf5d/Cpwz3qQzqoZ6/lRJe22NtNYYcjwSXGOI3+i
	dJ8EDroccPHZmV+PPfBgwfM5PYW8Z/vsGEWMA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D85203C8FA;
	Tue, 19 Jan 2016 13:57:06 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5E7E43C8F9;
	Tue, 19 Jan 2016 13:57:06 -0500 (EST)
In-Reply-To: <CACaY5-uUqFxsRdwPzxAjphc=wNQhM76YJFmCZu86SpGeG1fOrw@mail.gmail.com>
	(=?utf-8?B?IuydgOq1kCIncw==?= message of "Tue, 19 Jan 2016 17:07:16 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6F4CBF6E-BEDE-11E5-88A7-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284372>

=EC=9D=80=EA=B5=90 <eunqyo@gmail.com> writes:

> Problem is that whenever git command is executed, 'The Git command
> requires the command line developer tools. Would you like to install
> the tools now?' message comes out.

As far as I know, that is not a message Git produces, but likely to
come from some magic wrapper (or "missing command handler") the
distro gives its users.

> I found out that when i change Git binary file's name that my product
> is executing, problem is solved. Since then i tried to read every
> licenses regarding Git but can't find a clear answer.
>
> Can i change Git binary file's name to for example 'Git-indegs',
> 'Indegs' when deploying my product?

The Git source code is licensed under GPLv2, and IIUC, there is
nothing that forbids you from naming the resulting binary other than
"git".

It is completely a separate issue if merely renaming the binary from
"git" to another name is sufficient to keep things working.  Many
subcommands of Git are built into a single binary and I suspect that
they would work regardless of what the name of that single binary
is, but others invoke other Git subcommands while they are running,
and when the do so they expect to find the other subcommand they are
invoking are "git foo", not "hju foo", even if they were invoked as
"hju".  That too is something you can modify under the licensing
terms of GPLv2, i.e. if you make such a modification and ship the
binaries based on that modified source, you must make the
modification available to the recipients of the binaries in the
source form under the same GPLv2 license.
