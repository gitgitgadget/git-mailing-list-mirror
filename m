From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] 2.5.0 build with NO_PERL is broken
Date: Fri, 14 Aug 2015 15:22:47 -0700
Message-ID: <xmqqzj1tfr2g.fsf@gitster.dls.corp.google.com>
References: <loom.20150814T171757-901@post.gmane.org>
	<loom.20150814T184447-932@post.gmane.org>
	<xmqq7foxiqu6.fsf@gitster.dls.corp.google.com>
	<CAPig+cR77oFo6D3f8BjAB_yM-xPt+3EUGK4vZr3eYWJGTtksAQ@mail.gmail.com>
	<xmqqoai9h9co.fsf@gitster.dls.corp.google.com>
	<CAPig+cR6iT=AC8zq-vHHTkXMzRmDA-o9JLi0h8gbR1tzbqNyKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Renato Botelho <garga@freebsd.org>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 00:23:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQNNQ-0004hp-C4
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 00:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbbHNWWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 18:22:51 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34526 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbbHNWWt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 18:22:49 -0400
Received: by pdbfa8 with SMTP id fa8so35175828pdb.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 15:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Q3MXdbyyeZo7pcXcKezsYescZpidOhz0sALy9icMD4A=;
        b=PspI3QrMLREAqPqwlnd+l21nfZnLGU0XXbnKDviW0tGx7d1xY0XUGdS340YX44CzyH
         FR4SZVG12694F/DV/+YeP9zzcFh0oJR21Zn/6Jz1SBT+tf3QnqobnsYH9rDJUBBDaCxm
         hNy9LmlZB1qJ7HOr+PKDGKQjywK6VobXFHTCdvf6Ss+Jkw6mtuOQGmeZlddNrXlDju6o
         0FrYDRP9tclMXZj5HU9em3qQ7FpDGNqiLsO9cRg3uh3ahY+bpuUe+TPyIm7Y3YRUFaYv
         cnTwlxwjtIhN7LxGKN3kH8rVF2OIXgmvwJia86u8jh42CqSua1yp6PpyxXt84z2yb8Zd
         QjTQ==
X-Received: by 10.70.135.133 with SMTP id ps5mr64712581pdb.48.1439590968674;
        Fri, 14 Aug 2015 15:22:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id pd10sm7132301pdb.66.2015.08.14.15.22.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 15:22:48 -0700 (PDT)
In-Reply-To: <CAPig+cR6iT=AC8zq-vHHTkXMzRmDA-o9JLi0h8gbR1tzbqNyKA@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 14 Aug 2015 17:15:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275968>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Aug 14, 2015 at 5:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> Nevertheless, there's still the problem, due to 527ec39
>>> (generate-cmdlist: parse common group commands, 2015-05-21), that git
>>> doesn't build at all anymore when Perl is unavailable.
>>
>> I do not think that is anything new.  We always have assumed "some"
>> version of Perl available in order to run t/ scripts.
>
> True, but prior to 527ec39, without Perl available, git itself could
> at least be built and used (with some commands unavailable), even if
> it couldn't be fully tested. As of 527ec39, however, git won't even
> build because common-cmds.h can't be generated.

I wouldn't bother digging in the history myself, but I am reasonably
sure that the current genereate-common-cmds is not the sole instance
that we relied on Perl to build (not test) in the past, and that is
another reason why I do not think this is anything new.
