From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v9 2/3] t7507-commit-verbose: make test suite use write_script
Date: Fri, 25 Mar 2016 11:36:10 +0530
Message-ID: <CAFZEwPNMB2Ti2d=qdZKyoYzneHxUPATiFWd_fSPxktZuF3Q+pw@mail.gmail.com>
References: <01020153a7ba4eae-9b88e119-0505-418f-a137-595250edaa9d-000000@eu-west-1.amazonses.com>
	<1458817259-11675-1-git-send-email-szeder@ira.uka.de>
	<CAPig+cQJ1yK8WhXE0sxSmDenMt1DMZCoJypTu_wkDsDyuBsAWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 07:06:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajKt5-0007A8-Cs
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 07:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbcCYGGN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 02:06:13 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35027 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbcCYGGM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2016 02:06:12 -0400
Received: by mail-yw0-f195.google.com with SMTP id u8so427787ywa.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 23:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=Ma/y7Qex4KWBcW7VNypMUF1mtRw4UTT1sKLIwbn53dY=;
        b=mfZ+AnOHWWEVX2epmIScrcWKGp/oNAUzUvW/x3Thw8imVexVBk+Jxpc4dXk7bQqQLs
         ExhxoLzJzgi7oYGiQI/6xxQK7Im7X2EXEqZQsFeng1eK3REU8cXRu78uLEL9PONNzXey
         wb9gXT0BcBz2HNHyl1V4telWWnc18eZx51n+m9BL7sxGbkDb/DPclMPsAL5VzJktONpM
         aun8nxBgeLFPkRbpjCp9nTtTXCyuyuNpO0mqMlMxxtthOCDxShNvRojnYBBlQruEU0j/
         dvsYicoaWxGu6Etn9ObqSFffQCjviM8MmT3m1wzNRiysWHv1KOb/LD3UTnTCqXTTJXV4
         77ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=Ma/y7Qex4KWBcW7VNypMUF1mtRw4UTT1sKLIwbn53dY=;
        b=QnxPgEK2apNPgtZEX76m5W+C6zlzXWgeLVRP9heyfRTf650U/njN+DzHh08Ju7qesT
         w+FriqOl6UIQiVWOdLAO+ezRCQU6BoCW8Z4VF0jD17pibO2un95Fc8KYUZ9bV0rK3sBD
         rbmkobNKZivHmHH9h4D1wNEyc1tfKW+DIphuwbp5LLCmOCl/MjkYjkxahVGvfYhgsD8S
         5XhntqvyuL7luwHNF5sN9uvSPzeSIUlZAJ4sflKLS2CC0kDsyTof/2yIdLit80mmrLlJ
         aNJITzd9LbPSPdRPIlEQWgEcEGbYgC6hoVRHxN3C5n7VUANh6lCzvE4zrNfCLk7XFLTQ
         4OKA==
X-Gm-Message-State: AD7BkJIcoN0m81rPZkJ+vmTQUcScLwCX9HhvB0TepAJdVZfdZsf0S/LYdhcfzQxdTWnYS/C/BQb9PdS27dX7Aw==
X-Received: by 10.129.9.214 with SMTP id 205mr6306201ywj.53.1458885971002;
 Thu, 24 Mar 2016 23:06:11 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Thu, 24 Mar 2016 23:06:10 -0700 (PDT)
In-Reply-To: <CAPig+cQJ1yK8WhXE0sxSmDenMt1DMZCoJypTu_wkDsDyuBsAWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289849>

On Fri, Mar 25, 2016 at 5:27 AM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Thu, Mar 24, 2016 at 7:00 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de=
> wrote:
>>> Also remove test_set_editor from global scope and use it in whichev=
er
>>> test it is required.
>>
>> Why?
>>
>> test_set_editor sets and exports shell variables.  Since you don't
>> invoke test_set_editor in a subshell, after the first invocation the
>> editor will be part of the global scope anyway.
>
> Agreed that this needs proper justification in the commit message.
> And, the justification is to make each test more self-contained,
> particularly because a subsequent patch will introduce a second fake
> "editor", and by making tests responsible for setting the editor they
> need, they don't have to worry about bad interactions from "editors"
> set by earlier tests[1][2].

This shou  cadve  mbe ave be ave be ave be ave be ave be ave be ave
> Another issue is that the commit message is backward. The subject
> ("t7507-commit-verbose: make test suite use write_script") tries to
> sell this as primarily being about write_script(), but the real gist
> of the patch is that it is making each test more self-contained, and
> the subject should say so. The write_script() bit is just a minor
> aside which can be introduced with a "While here let's use
> write_script to..." at the end of the commit message.
>
>>> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
>>> index 2ddf28c..cf95efb 100755
>>> --- a/t/t7507-commit-verbose.sh
>>> +++ b/t/t7507-commit-verbose.sh
>>> @@ -3,12 +3,11 @@
>>>  test_description=3D'verbose commit template'
>>>  . ./test-lib.sh
>>>
>>> -cat >check-for-diff <<EOF
>>> -#!$SHELL_PATH
>>> -exec grep '^diff --git' "\$1"
>>> +write_script "check-for-diff" <<-\EOF &&
>>> +grep '^diff --git' "$1" >out &&
>>> +test $(wc -l <out) =3D 1
>>
>> Our test lib offers the test_line_count helper function, which
>> outputs a helpful error message in case the number of lines do not
>> match.
>
> test_line_count() was mentioned in [2], however, this line counting i=
s
> done in the fake "editor" script, not in the test script proper, so
> the spelled-out form $(wc ...) was proposed[2].

I have a slight doubt regarding this. Can the functions from test-lib
work in such scripts flawlessly? If yes, then its probably better to
use them.

>> The original didn't check the number of lines.  This change is not
>> mentioned at all in the commit message.
>
> Right, and this particular change really belongs in patch 3/3 where
> it's needed[2], and should be properly explained by the 3/3 commit
> message.

Sure! It should have been mentioned.

>>>  EOF
>>>  chmod +x check-for-diff
>
> Drop the 'chmod' line; write_script() does this for you.

I was unaware about this. I will drop it off.

>>> -test_set_editor "$PWD/check-for-diff"
>>>
>>>  cat >message <<'EOF'
>>>  subject
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/289329
> [2]: http://article.gmane.org/gmane.comp.version-control.git/289370
