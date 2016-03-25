From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 2/3] t7507-commit-verbose: make test suite use write_script
Date: Fri, 25 Mar 2016 02:24:31 -0400
Message-ID: <CAPig+cRY8P2WtqR4y0zW+netCHa3=9Wnb8LmcB35SqP4OGC6Vg@mail.gmail.com>
References: <01020153a7ba4eae-9b88e119-0505-418f-a137-595250edaa9d-000000@eu-west-1.amazonses.com>
	<1458817259-11675-1-git-send-email-szeder@ira.uka.de>
	<CAPig+cQJ1yK8WhXE0sxSmDenMt1DMZCoJypTu_wkDsDyuBsAWg@mail.gmail.com>
	<CAFZEwPNMB2Ti2d=qdZKyoYzneHxUPATiFWd_fSPxktZuF3Q+pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 07:24:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajLAj-0000VX-4S
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 07:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbcCYGYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 02:24:33 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33904 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbcCYGYc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 02:24:32 -0400
Received: by mail-vk0-f67.google.com with SMTP id e6so7138152vkh.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 23:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=/IbXHUDlbHlTkwz/AU91jV3MrrsIVjpk7NbDwz+4Vvc=;
        b=BkYzjiVlXJEcj7RyvD6LpsPVoE9oQ9bzUBo7ATtDjaOGjkgs4zoI0r3F3SUbe7zpaB
         B/RCFQJhK8vg6XXkzONTICkliinjP4iNrJ1eU0BVe/M+Nh10BFLl6AZB6UY4Kp0vEXoa
         JhFzUACsVXxI+C1+M7uZpYIx5YE+fD2WAKlLrpyHckesgYh5X7RK4QjwiERpNtFpaOg1
         wv4s1bczivSrDVEJdGCxBVIWfXvtbm+nGkw3FdB+D2WlzpOvMuVuzP6sJk/acJtak7D1
         EldDVwcv5D+fTcpWY0TlLFZ9FI0mac+VhMUkuOFmjIrshtnGENVdhFqcOvdQtS8PA1qE
         nqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/IbXHUDlbHlTkwz/AU91jV3MrrsIVjpk7NbDwz+4Vvc=;
        b=SqIhejIPn1BYHOXUSsrnld9spHCGr1M3huCLhIoLvVv2pTPX23voSb9+FaYtsmFidv
         Ms0KMKkPA1+HPB4K3BI7FmongG9cvg1mTzgHISCtINoNzmoLwpny4N8/zLjwNH21Bwl1
         Ki86KtHxhoLoi2Q35PlBSVMksdxY7KecLPJn1ljGukZFpBp6kmwsqbLC/qOSxsVJztFj
         N7QoJNP/0gDok6y0Y/9AYZS+2JozFAMFNQtFVS1sok57iSZKuXFelwxZJky0+5PfmEQN
         e3NXZvBoe3HffgmD4PMxrGv5DmYN6C5kmE+If7qL+xHq7cfpva2rQAWwl6eIkD8G6xFl
         RaTg==
X-Gm-Message-State: AD7BkJLKSBETgqu+WlCFfnQLWQu00ACs2Kv/URA8FFInZOIuKKXkDxmAYXwdJqhQT5azrif0Bn1rk61YulpIvw==
X-Received: by 10.31.130.74 with SMTP id e71mr6393093vkd.117.1458887071145;
 Thu, 24 Mar 2016 23:24:31 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 24 Mar 2016 23:24:31 -0700 (PDT)
In-Reply-To: <CAFZEwPNMB2Ti2d=qdZKyoYzneHxUPATiFWd_fSPxktZuF3Q+pw@mail.gmail.com>
X-Google-Sender-Auth: 5rhrWMBOUPry1TCqOxmY4ezGbvw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289852>

On Fri, Mar 25, 2016 at 2:06 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Fri, Mar 25, 2016 at 5:27 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Agreed that this needs proper justification in the commit message.
>> And, the justification is to make each test more self-contained,
>> particularly because a subsequent patch will introduce a second fake
>> "editor", and by making tests responsible for setting the editor they
>> need, they don't have to worry about bad interactions from "editors"
>> set by earlier tests[1][2].
>
> This shou  cadve  mbe ave be ave be ave be ave be ave be ave be ave

Hmm, yes, what you say makes perfect sense... er, wait...

>>>> -cat >check-for-diff <<EOF
>>>> -#!$SHELL_PATH
>>>> -exec grep '^diff --git' "\$1"
>>>> +write_script "check-for-diff" <<-\EOF &&
>>>> +grep '^diff --git' "$1" >out &&
>>>> +test $(wc -l <out) = 1
>>>
>>> Our test lib offers the test_line_count helper function, which
>>> outputs a helpful error message in case the number of lines do not
>>> match.
>>
>> test_line_count() was mentioned in [2], however, this line counting is
>> done in the fake "editor" script, not in the test script proper, so
>> the spelled-out form $(wc ...) was proposed[2].
>
> I have a slight doubt regarding this. Can the functions from test-lib
> work in such scripts flawlessly? If yes, then its probably better to
> use them.

Probably not easily, and it's not worth complicating the "editor"
script by trying to import the test_line_count() function.

>>>>  chmod +x check-for-diff
>>
>> Drop the 'chmod' line; write_script() does this for you.
>
> I was unaware about this. I will drop it off.

I thought I had mentioned it in the review in which I had suggested
using write_script() or one of the follow-up emails, but upon looking
back at those messages, I saw it was not so. It turns out that I was
probably thinking about a different patch review in which I had
mentioned dropping 'chmod'[1].

[1]: http://article.gmane.org/gmane.comp.version-control.git/288085/
