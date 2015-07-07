From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 09/12] t4150: am with post-applypatch hook
Date: Tue, 07 Jul 2015 10:07:51 +0200
Organization: gmx
Message-ID: <4babfe85175ee5b2e2da3afdfe3a30c2@www.dscho.org>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
 <1435861000-25278-10-git-send-email-pyokagan@gmail.com>
 <17f64cb49c820eb41d0fb58435c91c40@www.dscho.org>
 <CACRoPnQ_bUtLuavFCdJGFAW08EY_LGV5Q=RR9Ey3jsoPk6-C3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 10:08:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCNvY-0006Kr-Ie
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 10:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126AbbGGIIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 04:08:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:50217 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353AbbGGIH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 04:07:58 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LmNHK-1YcV8U1qBG-00ZvFm; Tue, 07 Jul 2015 10:07:52
 +0200
In-Reply-To: <CACRoPnQ_bUtLuavFCdJGFAW08EY_LGV5Q=RR9Ey3jsoPk6-C3w@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:CA3gUic1FU37Pi/11R7AKf/91kM2Qs/oJ8mZEZXMoDH8JqrMrWS
 dFfcTguvAnZ/ltjgWoC7UvJXqbK7qE59WetU7Jr4IhA0GsaE2hjV2vATDXXLNLxja6IBYcC
 n8AlTUkIGx/BuYvPvazRVKs2ZEVmzbG1V25mI/6NQ+v5qHoorc8PSb94u3UaZ3Vz0e/qd9m
 Ol9wc1dyknpcYkWVTAkKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5Gwu7mZUZec=:TvR93kJOt9jsX9DdMQK/A4
 pDQ8TPp1onmYbFhMopO3pmLD35aCyd1cDczoaCy+u/vqPXZE7MkSY+OdOHa4A0p4jPoRcoJQK
 BqW4p96OKeuSgxp9xlDPQZO4O+Ow2cXGJudqkuj8cXv5pFaf1+qdXsIvKRgvzUeMuQlp84OL0
 Jl10ZcJx2ZaV4KuXnYaLfzK7Mo4nd0p7cqUKD885uHhFqraWoPol+Ri7ogAhT0i/BpPzYb9pf
 A1zaK2H75k/3nV2o989TXieB9b1MeYvAEbiGt+FCjkIsMPsYJggogizvAkmeP28nH5MpWUqWi
 eL/uFIuhPvGCbziH99F11NMgUg7xYcuz3oF3saXIgwfCaCUm9S7/dvOfe5L0TcN7lq/8IwlzD
 xs2dd+rd8RbItw5rQtBwj2OXVZvrl3DqtjFyczl9LdLlSGVh8KpqJq8UCNQ/JrIqq/6Q0qa3F
 XGbQx+vWOOYowV6EV8juE91YUQuM/U/PfQ/scWtMn3llaaFe+LA+xG7msr7hOJBWppBI6xfTF
 AsSCjK7SYa27F6QzktB5hU8LDZlKnCZb2U9XnPZE3kOKzghK5QXg65I2rudnl2/nrbYJIDVi6
 Wp88rb64vAg9nwwg3EXxCQEo+XegYrXbOcOSbzcKyqrUV6AcbxDW7xEWGBVEPmEA9aAPiZYlv
 RYyRYwA/7uFUQJGhbt6K37jzh2cwf4MO+Jq8tGfHu6tY2hv0f5pYuNqlER7BOJ+JMnKc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273488>

Hi Paul,

On 2015-07-07 08:47, Paul Tan wrote:
> On Sun, Jul 5, 2015 at 11:58 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> On 2015-07-02 20:16, Paul Tan wrote:
>>
>>> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
>>> index dd6fe81..62b678c 100755
>>> --- a/t/t4150-am.sh
>>> +++ b/t/t4150-am.sh
>>> @@ -275,6 +275,48 @@ test_expect_success 'am with failing pre-applypatch hook' '
>>>       test_cmp_rev first HEAD
>>>  '
>>>
>>> +test_expect_success 'am with post-applypatch hook' '
>>> +     test_when_finished "rm -f .git/hooks/post-applypatch" &&
>>> +     rm -fr .git/rebase-apply &&
>>> +     git reset --hard &&
>>> +     git checkout first &&
>>> +     mkdir -p .git/hooks &&
>>> +     cat >.git/hooks/post-applypatch <<-\EOF &&
>>> +     #!/bin/sh
>>> +     git rev-parse HEAD >head.actual
>>> +     git diff second >diff.actual
>>> +     exit 0
>>> +     EOF
>>> +     chmod +x .git/hooks/post-applypatch &&
>>> +     git am patch1 &&
>>> +     test_path_is_missing .git/rebase-apply &&
>>> +     test_cmp_rev second HEAD &&
>>> +     git rev-parse second >head.expected &&
>>> +     test_cmp head.expected head.actual &&
>>> +     git diff second >diff.expected &&
>>> +     test_cmp diff.expected diff.actual
>>> +'
>>> +
>>> +test_expect_success 'am with failing post-applypatch hook' '
>>> +     test_when_finished "rm -f .git/hooks/post-applypatch" &&
>>> +     rm -fr .git/rebase-apply &&
>>> +     git reset --hard &&
>>> +     git checkout first &&
>>> +     mkdir -p .git/hooks &&
>>> +     cat >.git/hooks/post-applypatch <<-\EOF &&
>>> +     #!/bin/sh
>>> +     git rev-parse HEAD >head.actual
>>> +     exit 1
>>> +     EOF
>>> +     chmod +x .git/hooks/post-applypatch &&
>>> +     git am patch1 &&
>>> +     test_path_is_missing .git/rebase-apply &&
>>> +     git diff --exit-code second &&
>>> +     test_cmp_rev second HEAD &&
>>> +     git rev-parse second >head.expected &&
>>> +     test_cmp head.expected head.actual
>>> +'
>>
>> These 2 tests as well as the previous patches look to me as if they could be refactored (the paradigm is the same: add a certain hook after resetting and then apply the patch, verify that the hook ran/failed)... do you think there is a chance for that?
> 
> I had a look, but I think that while it is true that the overall
> sequence of each test is the same, the details differ enough that
> there's no obvious way to refactor the tests sensibly. For example,
> the contents of the hook scripts are not the same, as we need to check
> that the hooks are run at the correct stage of git-am execution. And
> as such, the verification tests are also different as well.

Yeah, makes sense. Thanks for the clarification!

Ciao,
Dscho
