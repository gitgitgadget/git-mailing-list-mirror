From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/9] t5520: fixup file contents comparisons
Date: Sat, 16 May 2015 11:57:14 -0700
Message-ID: <xmqq617sfj05.fsf@gitster.dls.corp.google.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
	<1431508136-15313-2-git-send-email-pyokagan@gmail.com>
	<xmqqk2wcbmq5.fsf@gitster.dls.corp.google.com>
	<xmqqa8x8bkuc.fsf@gitster.dls.corp.google.com>
	<CAO2U3QgD0-tAwGnMeeMR5aqbUuqDsdWy0Sw8dQBPUpUNwJZpHg@mail.gmail.com>
	<xmqq4mnf8358.fsf@gitster.dls.corp.google.com>
	<CACRoPnSbekLANNiGOyxN70TCUd1c=wcrU_6Gfew5pp5EBpSEsA@mail.gmail.com>
	<xmqq7fs9hekc.fsf@gitster.dls.corp.google.com>
	<CACRoPnSP9xfyW47ZqU7QO5o4tyzROh4hGRPqG9g9OB5cquS+uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 16 20:57:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YthHB-0000SE-SN
	for gcvg-git-2@plane.gmane.org; Sat, 16 May 2015 20:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbbEPS5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2015 14:57:19 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33299 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbbEPS5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2015 14:57:16 -0400
Received: by iebgx4 with SMTP id gx4so144850771ieb.0
        for <git@vger.kernel.org>; Sat, 16 May 2015 11:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=szfPiQw5ZZR0mcPR4roXpUMth62CmHkvHpyM9+AfdsU=;
        b=PGhL2ePosGz5CwF93d+KL/UdnlHn8JChqSxv2GsotuEb6gTaIhyIA7pDcyUcgefAZz
         +JQE9+VmCU6CyAQNkCfaNDUrDL6d9GopW6+qluIlfPUonh7dVO5s/nTBjnUitbyxs9ss
         H9oRHKV5/jpdBE49TP09ftcd9G4Dsvh7JLEb/uLL11QbT4z+HgfL7N3Up10+7WohzIZ6
         +hry/Y7bhdwmIGj3CIth0z5XsyvrtrVSzuPN6JLFPZlAIAZCackSEMeYnawYFNAHbQOQ
         9GA+2hdgdIJM6G9PmmoG+AeTRIQt8a8jQaktKQcWBpQKvDsS1Rz7Efak2uar3GCWZlvQ
         pmxw==
X-Received: by 10.42.90.138 with SMTP id k10mr26816015icm.50.1431802635801;
        Sat, 16 May 2015 11:57:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c15a:d232:e950:b701])
        by mx.google.com with ESMTPSA id 16sm3984679ion.20.2015.05.16.11.57.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 16 May 2015 11:57:15 -0700 (PDT)
In-Reply-To: <CACRoPnSP9xfyW47ZqU7QO5o4tyzROh4hGRPqG9g9OB5cquS+uw@mail.gmail.com>
	(Paul Tan's message of "Sat, 16 May 2015 21:49:52 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269199>

Paul Tan <pyokagan@gmail.com> writes:

> Hi Junio,
>
> On Sat, May 16, 2015 at 2:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Just to avoid misunderstanding, please do not remove 'verbose '
>> blindly without thinking while doing so, as you already did 1/3 of
>> the necessary job to make things better.
>
> Eh? I thought we established that using "verbose" does not provide
> anything more than what "set -x" already provides. So at the very
> least, its use should be removed completely.

I did not mean "do not remove and keep them".  I meant "do not
remove without thinking; instead, take mental notes on patterns
these silent ones may have while removing them".

>> You might have noticed, while adding them, there were something
>> common that we currently do with a bare 'test' only because we
>> haven't identified common needs.  As I already said,...
>> ...
>> That would be an improvement (and that is the remaining 2/3 ;-).
>
> Yeah, this kind of comparison with file contents is something that is
> done often in t5520, so I agree with adding it.
>
> However, what about these kind of tests:
>
>      test new = "$(git show HEAD:file2)"
>
> or these:
>
>      test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
>
> So, perhaps we could introduce a generic function like:

It all depends on how common they are.

> So the first example would be:
>
>     test_output "git show HEAD:file2" new

Simple things like that look fine, but when a variable is involved,
use of eval combined with the fact that the test body is inside sq,
makes the callers unnecessarily ugly.

	test_expect_success 'some title' '
		var=$(...) &&
		test_output "git show \$var:file2 | sed -e \"s/$old/$new/\"" new
	'

Which is the concern this shares with the other one I sent about
counting the number of lines in the output from a command that made
me hesitate to suggest it.

So I dunno.
