From: Sergei Organov <osv@javad.com>
Subject: Re: git-blame.el: what is format-spec?
Date: Fri, 04 Dec 2009 23:54:10 +0300
Message-ID: <87einafojx.fsf@osv.gnss.ru>
References: <87vdgm3e1k.fsf@osv.gnss.ru> <m2fx7qae49.fsf@igel.home>
	<87ljhi3cao.fsf@osv.gnss.ru> <87fx7q4p6h.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri Dec 04 21:54:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGfAS-00033x-5r
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 21:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbZLDUyH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Dec 2009 15:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757218AbZLDUyH
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 15:54:07 -0500
Received: from javad.com ([205.178.136.214]:46533 "EHLO 02aef2d.netsolvps.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757170AbZLDUyG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 15:54:06 -0500
Received: (qmail 9968 invoked from network); 4 Dec 2009 20:54:12 +0000
Received: from unknown (HELO osv.gnss.ru) (89.175.180.246)
  by javad.com with (AES256-SHA encrypted) SMTP; 4 Dec 2009 20:54:12 +0000
Received: from osv by osv.gnss.ru with local (Exim 4.69)
	(envelope-from <osv@osv.gnss.ru>)
	id 1NGfAI-0005bq-Mr; Fri, 04 Dec 2009 23:54:10 +0300
In-Reply-To: <87fx7q4p6h.fsf@lysator.liu.se> ("David =?utf-8?Q?K=C3=A5geda?=
 =?utf-8?Q?l=22's?= message of "Fri\, 04 Dec 2009 18\:36\:06 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134576>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Sergei Organov <osv@javad.com> writes:
>
>> Andreas Schwab <schwab@linux-m68k.org> writes:
>>> Sergei Organov <osv@javad.com> writes:
>>>
>>>> What is format-spec function in current git-blame.el? Neither my G=
NU
>>>> Emacs 22.2.1 nor Google knows anything about it.
>>>
>>> It's part of Emacs since more than 9 years, imported from Gnus.
>>>
>>
>> Thanks, I now see it in Gnus on my own computer, in
>> lisp/gnus/format-spec.el.gz.
>>
>> GNU Emacs 22.2.1 (i486-pc-linux-gnu, GTK+ Version 2.12.11) of 2008-1=
1-10
>> on raven, modified by Debian=20
>>
>> However, isn't it a bad idea to require Gnus(!) for git-blame to run=
? Gnus
>> is not installed on our server where I've encountered the problem. W=
as
>> format-spec actually moved to core emacs recently?
>
> That was not my intention when I posted the patch. I seem to recall t=
hat
> I asked for testing, in particular from users with older Emacsen than
> 23. But I got no response, and only recently discovered that the patc=
h
> hade been accepted.
>
> format-spec is included in Emacs 23, and is a useful function.

Then there should be (require 'format-spec) in git-blame.el, right? Due
to:

$ emacs --version
GNU Emacs 23.1.1
[...]
$ emacs --batch -Q -f format-spec
Symbol's function definition is void: format-spec
$

Now, I've evaluated (require 'format-spec) in my Emacs 22 (yes, 22, not
23), and now git-blame almost works there. The problem I see is that it
doesn't output anything in the echo area. It color-codes the buffer, it
does show correct pop-up when mouse is over a region, but it doesn't
print anything in the echo area when I move cursor through the regions.
Any idea how to debug/fix this?

-- Sergei.
