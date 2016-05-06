From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v8 10/10] ce_compare_data() did not respect conversion
Date: Fri, 6 May 2016 10:54:55 +0200
Message-ID: <e33e0b87-caa1-84a3-7c5c-8938e0c78a77@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
 <1461942126-16296-1-git-send-email-tboegi@web.de>
 <xmqqvb30w29z.fsf@gitster.mtv.corp.google.com>
 <a571e222-68db-3dc1-1a94-d6b47feaf84d@web.de>
 <xmqqtwigtjfg.fsf@gitster.mtv.corp.google.com>
 <xmqqpot4s1ap.fsf@gitster.mtv.corp.google.com>
 <55d60bb1-8626-4c97-630c-1a9f114c46b4@web.de>
 <xmqqbn4nngci.fsf@gitster.mtv.corp.google.com> <57297579.6060805@web.de>
 <xmqqfutyjnhh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri May 06 10:55:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aybXZ-0008Lm-9T
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 10:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758140AbcEFIzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 04:55:09 -0400
Received: from mout.web.de ([212.227.15.14]:64977 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757785AbcEFIzD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 04:55:03 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MUnaG-1b8Roa1cnE-00YDRE; Fri, 06 May 2016 10:54:56
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <xmqqfutyjnhh.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:qYQj+v3+AwdmAE0ByIpXx/a4XQAQjZYvXDvDaw+t0bphQk0lVNW
 XwMa4HDZvhLcQmCmFl31PZ7Itd205DB1Arc+3KvAnw+BxB4gi3W9roUUrQnnOwDyZtIEKDL
 pjKrcA5xji0WM8Vs/EMJ+nDhBFl1kwVmzTs+yxQ1OvJ79jVtH6f52GjkRdif+6RLU2Qi2yw
 jSGreOB4KxBaRe1d+vuDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vv8utxdSszg=:LIsn5yOP4xR+wYsgitufUk
 bwqvG8857dzVqRT8npy0VlUSS4DbjxKhhkJ5SUgan9AfStgu8/2fYrtDHvTlTY1xUGLyi1XOi
 Go36CuYH49izGB9+PVAB5uJ8hTcWRjAu8epSLBtcY/cCb29yhfIcGmD/QAyYQE17U+4TxmDBu
 y9DY6maiTULG0SR03kgU7R/1VHobPZxt2/809/f2/qtHz03gLmMWugxdyMKg0WE8C7zgeZzR9
 fjiY2oVtMTi/4ITsDNl8cTeyIvOetXmVnmXWZHIXPme6cB2vyHhngo4xoe3wfdNigDDq6bK8E
 z/qA1ovliN7TAlRdt3x2dD9jhHfCCGWoY4MPWezhZ0jCLtNWXrdBs4fWWhAIDMcZsOCUqZtm4
 Ams5CMwOBGRubDWBrMY3cZTUqLIZAJ9+Ah6BcWNleLgkXnom0nJUbX4W+4OMh/DB44WciQ7Uz
 NpQsXgOPuYDr/QO3xKyYsxjO7MEZ4Vq/M2n0ITK10W6E3+ve72VhCwUv1wPrJrfDeBgOQjMYo
 zhXBq4OKcrKernC0e12VzF0jqfkMwNdn18Wi/3SEI95AqtwunzUe+bidCdvGJCfRXhRwaXDqd
 QRZhznR4gu5jTHIpcQEX83uLq5lCWLsCyQ1o3UEA/Pa4/+mtwqCx3mZ/edj7PkSZitzsZa2j/
 0aX7uV1cKMeu+qecV/bE0xpMOAsIQpIwRj9mUxW22uZgSCro93LEpy+2PyVGXKQAYCEBrPIzB
 hZjdosIt62AlYdJTJuRkeUfMzM8Rfn3sE03BQqcTEAZo9JaaM+7p4U+QM0qwF7X3cJR8mLsH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293754>


> Let's separate 01-04/10 into a different topic and give it its own
> name; tb/convert-eol-autocrlf was the name I picked primarily for
> 07/10 but 01-04/10 are not about that fix.  Both 02 and 04 are about
> autocrlf (the former is "core.eol is irrelevant when core.autocrlf
> is there", the latter is "fix core.autocrlf used in conjunction with
> ident conversion"), so how about tb/autocrlf-fix or something?
tb/core-eol-fix would be my suggestion, or core-eol-t0027-fix.

> And then we can merge that to 'next' and to 'master' while we find
> solution to 07/10 which is really the more important bit.
>
> As to (the inverse of) 10/10, I am starting to suspect that the
> correct solution (which may not be the "right" one, though) would
> involve teaching write_entry() that not everything it writes out can
> be marked up-to-date in the index.  A naive implemention would be to
> pass what it writes out to the filesystem through convert_to_git()
> and see if the result matches the blob in the index, and if it does
> not match, make sure ce_mark_uptodate() is not called, perhaps by
> not calling fill_stat_cache_info(), or manually dropping CE_UPTODATE
> bit at the end of the function.
>
> A naive implementation however may turn out to be way too expensive
> to use as-is, I am afraid.  Possible ways to speed up would be to
> skip this "refrain from marking up-to-date" hackery when conversion
> is known to be well behaved.  For example, with the EOL handling
> updated with your series, we may be able to say that the stock
> to-git and to-working-tree pair is guaranteed to roundtrip even with
> EOL conversion, ident conversion as long as there is no end-user
> defined clean/smudge filters.  With such an optimization, the result
> might perform with acceptable performance penalty in common cases.
>
That makes sense and will remove the shakiness, right ?
We only need to pay extra attention when there is an
external clean/smudge filter defined - otherwise we should be able to skip it -
after 10/10.
