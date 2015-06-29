From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 04/11] for-each-ref: add '--points-at' option
Date: Tue, 30 Jun 2015 00:41:15 +0530
Message-ID: <CAOLa=ZRfgMtkVbYTf3NR7pXz+OmUZ3H1hiquGU2-hYy2NP87wQ@mail.gmail.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
 <1435222633-32007-1-git-send-email-karthik.188@gmail.com> <1435222633-32007-4-git-send-email-karthik.188@gmail.com>
 <xmqqk2um9x7w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 21:11:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9eT7-0004K7-ME
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 21:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbbF2TLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 15:11:45 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36423 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbbF2TLp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 15:11:45 -0400
Received: by obzt3 with SMTP id t3so20186909obz.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=D+N1+84tfVbA7knskqWV8uo+FAQ0PRoZuVdO5r1Zz/k=;
        b=J1A11RHm45AHHDmXMIxBOB4o+KsgutYnuVB/7yJRkWRLnXu+mF+LcQ7v2Phee9QGx7
         TNURZZAJYy//R37BkSkN8c20rzurYBQqPgvP8abBDJXut1mj2TYA8p4SnQvrXCpvLr/L
         F5rorUKH19ArMqhqQxSzilRKOaQvUqduC/GGHbzWteCBR+hUc93VLpbt9uiUV/99OPU/
         hwZe9mjc1axqy8LJgVkKFk7kIk3LBkZRFu+rqLpG3A5L0ikvlLOZOsaez3L7WXM5yJGp
         2C1ftyefqfLZPWsZd0SdtI8pLxAgqMuQOCphCW3Cryej8ugiEQuBS8iY3S0Qa/V3upC3
         B8pQ==
X-Received: by 10.60.35.8 with SMTP id d8mr15310910oej.37.1435605104514; Mon,
 29 Jun 2015 12:11:44 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Mon, 29 Jun 2015 12:11:15 -0700 (PDT)
In-Reply-To: <xmqqk2um9x7w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272995>

On Tue, Jun 30, 2015 at 12:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +test_expect_success 'check signed tags with --points-at' '
>> +     cat >expect <<-\EOF &&
>> +     refs/heads/side
>> +     refs/tags/four
>> +     refs/tags/signed-tag four
>> +     EOF
>> +     git for-each-ref --format="%(refname) %(*subject)" --points-at=side >actual &&
>> +     test_cmp expect actual
>> +'
>
> This piece seems to fail without a trailing whitespace in the
> expected file.  I initially suspected that they were dropped
> on my end while applying with "git am --whitespace=fix", but going
> back to my mailbox, it seems that what gmane received does not have
> them in the first place:
>
>         sed -e "s/Z$//" <<-\EOF &&
>         refs/heads/side Z
>         refs/tags/four Z
>         refs/tags/signed-tag four
>         EOF
>
> or something like that to make the EOL more visible to those who are
> reading the tests, perhaps?

Thanks, will use sed like you suggested.

-- 
Regards,
Karthik Nayak
