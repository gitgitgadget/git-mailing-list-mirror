From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Get rid of the non portable shell export VAR=VALUE costruct
Date: Thu, 22 May 2014 15:19:42 +0200
Message-ID: <87a9aa7xxt.fsf@fencepost.gnu.org>
References: <1400762896-24324-1-git-send-email-gitter.spiros@gmail.com>
	<537DF7F2.8000401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu May 22 15:19:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnSuT-0004TO-1w
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 15:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbaEVNTp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 May 2014 09:19:45 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:36186 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbaEVNTo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 May 2014 09:19:44 -0400
Received: from localhost ([127.0.0.1]:35227 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WnSuN-000377-9w; Thu, 22 May 2014 09:19:43 -0400
Received: by lola (Postfix, from userid 1000)
	id DC2D5E0601; Thu, 22 May 2014 15:19:42 +0200 (CEST)
In-Reply-To: <537DF7F2.8000401@web.de> ("Torsten =?iso-8859-1?Q?B=F6gersha?=
 =?iso-8859-1?Q?usen=22's?= message of
	"Thu, 22 May 2014 15:13:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249901>

Torsten B=F6gershausen <tboegi@web.de> writes:

> On 2014-05-22 14.48, Elia Pinto wrote:
>> Found by check-non-portable-shell.pl
>
> Thanks for picking this up
>> -export TEST_DIRECTORY=3D$(pwd)/../../../t
>> +TEST_DIRECTORY=3D$(pwd)/../../../t && export TEST_DIRECTORY
> Minor remark:
> Both commands should go on their own line, like this:
>
> TEST_DIRECTORY=3D$(pwd)/../../../t &&
> export TEST_DIRECTORY
>
>
> And, unrelated to this patch,=20
> there seem to be a lot of && missing in git-remote-testgit.sh.

I have a hard time taking the above && seriously.  pwd is a shell
builtin (when we are not talking about Version 3 UNIX or something) tha=
t
can hardly fail.  And when your shell does not support assignment to a
shell variable, you'll have a hard time getting the shell script to run=
=2E

That's stuff of the

    if (1+1 !=3D 2) { fputs("Warning: your CPU may be broken", stderr);=
 }

variety.  If you have to check for that, you have bigger problems...

--=20
David Kastrup
