From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 2/3] t7507-commit-verbose: store output of grep in a file
Date: Sun, 27 Mar 2016 13:05:20 -0400
Message-ID: <CAPig+cQoRW3_0HPv7aUZFgAu41vkR73Z7Z+hpfrXZymEAvDFMg@mail.gmail.com>
References: <01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
	<01020153b478cf9b-1417ac08-005c-4d72-91f1-0b07f00a24d5-000000@eu-west-1.amazonses.com>
	<CAPig+cRQ5hOLi3539Emq=YexHRXqdesf+Yo2cY+NkiPO_9Vhyg@mail.gmail.com>
	<CAFZEwPMaZkUi+DvohhVrc_dW_8cdfJsZX-YA_SRWDp021UvDLQ@mail.gmail.com>
	<CAPig+cTFK=HPAtk7MeMQSTccmiaai++3sVn6J_pRcSi+w_4Lng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 19:05:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akE7y-0005KZ-Ae
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 19:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbcC0RFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 13:05:22 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35513 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbcC0RFV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 13:05:21 -0400
Received: by mail-vk0-f66.google.com with SMTP id e185so12534005vkb.2
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Yl8yXSTF3lBD5ToHlUhtA2nQAXwO5kVY/AhHERdJBzk=;
        b=J3joQ5bEdc5K+aVvU0+2cfs/nd5lLaCUHybjS1gRDF0OFzNM/YklR892Gq+R+Pc0fQ
         +u4eRsrDb29efFhUky84a3TK+AcKoVTIIScGJrGjUuYRRw8clKcr4Nk5grGe6o5QUrgc
         ID4zGYbCnp6MXjzJQ8PZO9FbJXNzLhrPWMfvLrUoEFETDxDz934x7UqKklSoMVUmAgeU
         SBLtuCWvc/pjSmUOqOu30+8q3zUaU24u45ZNomgmNdCYYGBK8QEvPSB+9TKQChk/lOCO
         4V+y4zjceZdWli+8qW8BIkCiRldS/juvc0zUPM4NGvKyoB1U8JA8gruxlfoxxakpsblY
         ljkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Yl8yXSTF3lBD5ToHlUhtA2nQAXwO5kVY/AhHERdJBzk=;
        b=dUZmViiKC3pdf18WwLW28zNBTdN9BJ3Z5Hy+vk5VO99uFIUM9ZwLX87Wid3nyF27x8
         Mqo8QQLW7zDDbdn1fQ5QRak0tDa0nyRl7bBnzd7++c0hcISyELi8RPhKEKK1l2o0EVkQ
         MYBZUIVqlZ97AJW0T+VSK4InLxTKM0M8HT1ZKdqQpdD+YfUKIlEud7MqvMdj6GtddWPS
         L4cDZ/3QuIVoYWi3Q/WoLCxSBjBqljcDQ5jvxEsl01PUy1tcr4wfmuxgiHTvy6F1Cl/V
         P6ie2RbFFjWj73dtovBCyqosIRVI7F/+eaORgv+drs6hSjZ9zdrGfBVyznbAd9GpswNj
         b3EA==
X-Gm-Message-State: AD7BkJJhrfLuAGZ8RP/Os4OZE2VUTqwRk8LG9jgkDlfqatWSDTMts39NWEU1xGkGhBTGlJ1iqaSZ4oUCTSeOgg==
X-Received: by 10.31.150.76 with SMTP id y73mr12180597vkd.84.1459098320279;
 Sun, 27 Mar 2016 10:05:20 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Sun, 27 Mar 2016 10:05:20 -0700 (PDT)
In-Reply-To: <CAPig+cTFK=HPAtk7MeMQSTccmiaai++3sVn6J_pRcSi+w_4Lng@mail.gmail.com>
X-Google-Sender-Auth: GzVCXIpgBiwCheLN69DJXTQVgfQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290016>

[also forwarding this to the list since it's relevant to the ongoing
discussion, and I hadn't noticed when replying that Pranit had
(presumably) accidentally dropped the git list as a recipient]

On Sun, Mar 27, 2016 at 3:10 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Mar 27, 2016 at 1:42 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Sun, Mar 27, 2016 at 8:37 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Sat, Mar 26, 2016 at 3:48 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> It is important to explain *why* you want to be able to count how many
>>> diffs were in the editor message. In particular, you will be adding
>>> new tests in a subsequent patch which will expect a specific number of
>>> diffs (rather than any number of diffs)
>>>
>>> Also, you need to explain why you're changing the existing tests to
>>> count the number of diffs. Is it simply "because you can" or is it
>>> because you suspect that a change you're making in a subsequent patch
>>> might accidentally cause too many diffs to show up in the existing
>>> test cases?
>>
>> Sorry for not writing commit messages properly. It is a part I am working on.
>> How does this paragraph sound to you in addition to the previous commit message?
>> "A subsequent commit will introduce a scenario where it is important
>> to be able to exactly determine how many diffs were present."
>
> That's fine for explaining why 'check-for-diff' is being updated to
> store the output, but you still need to explain why you're changing
> the existing tests.
>
>>>> -cat >check-for-diff <<EOF
>>>> -#!$SHELL_PATH
>>>> -exec grep '^diff --git' "\$1"
>>>> +write_script "check-for-diff" <<'EOF' &&
>>>> +! test -s out ||
>>>> +rm out &&
>>>
>>> Why not just "rm -f out"? But, more importantly, why do you need to
>>> remove the file at all? The '>' redirection operator (used below) will
>>> overwrite the file, so no need to remove it beforehand.
>>
>> I wasn't aware about '-f' option. It is important to remove the file.
>> I initially tried without removing the file and it caused problems.
>> This is because let's say the previous test had 1 diff which was
>> stored in out. Now, if in the next test, it is expected to have 0
>> diffs then grep would fail to execute and nothing will be re-written
>> to out and out will contain the 1 diff from previous test. An
>> explanation for this should be mentioned in the commit message?
>
> No. Rather than trying to explain all this in the commit message, it
> would be better to retain a simple implementation of 'check-for-diff'
> rather than adding several levels of complication. More about this
> below...
>
>>>> +! grep '^diff --git' "$1" ||
>>>> +grep '^diff --git' "$1" >out
>>>
>>> Um, what? Why two greps? I would have expected you to simply re-use
>>> the existing grep (minus the backslash) while adding the redirection:
>>>
>>>     -exec grep '^diff --git' "\$1"
>>>     +exec grep '^diff --git' "$1" >out
>>
>> The reason of two greps in that if in some test it fails to find any
>> diffs, the editor will return an error. Of course we could test this
>> scenario by using test_must_fail as in previous patches, but I think
>> it would be more clearer if we could test for the existence of out
>> which is done in patch 3/3. I will explanation for this in commit
>> message.
>
> This sounds unnecessarily complicated. It's not too difficult to
> reason about a script named 'check-for-diff' actually "checking for
> presence of diffs" and failing if no diff is present, from which it
> follows naturally that new tests which don't expect any diffs would
> use test_must_fail. Keeping it simple like this also makes this patch
> much less noisy since it doesn't require changing existing tests.
>
> Likewise, it keeps most of the new tests in 3/3 small because the bulk
> of them only want to know that a diff was present, but don't care
> about the number of diffs. However, it's not necessarily a bad thing
> to ensure that you got the number of diffs you expected (for instance,
> that a single -v really behaved as -v, and not as -v -v), so that can
> be used as an argument for overhauling the old tests, as well as using
> counting in all new tests.
>
> However, even if you take the approach of making 'check-for-diff'
> succeed unconditionally and always count diffs, the current
> implementation is still overly complicated. It would be much simpler
> to let 'check-for-diff' always create the output file, and then use
> "test_line_count = 0 out" when expecting no diffs than to sometimes
> create the output file and sometimes not. The shell '>' operator will
> truncate the file to zero size even before grep is invoked, so you
> don't need to worry that results from an earlier test will pollute
> 'out' for a subsequent test, even if grep finds no matches. Thus,
> 'check-for-diff' collapses to this tiny implementation:
>
>     grep '^diff --git' "$1" >out
>     exit 0
>
> Or, if you want to be terse:
>
>     grep '^diff --git' "$1" || exit 0 >out
>
> A couple notes: First, "out" isn't a great name for this file; perhaps
> come up with a better name. Second, under this scenario,
> "check-for-diff" isn't the most accurate name; it's now simply
> collecting diffs rather than checking for presence.
>
> An alternative would be for the output file to contain the actual
> count of diffs, rather than the diff lines themselves. For instance:
>
>     write_script count-diffs <<\EOF &&
>     grep -c '^diff --git' "$1" >out
>     exit 0
>     EOF
>
> Whether that's actually better is subjective.
>
> So, what's my final word? I quite like the idea of keeping everything
> as simple as possible, thus not altering existing tests and only doing
> line count in the two or three new tests which actually care about the
> number of diffs. However, I can also be sold on retrofitting existing
> tests and having new tests do line counting as a way to improve test
> coverage by catching cases where "-v" incorrectly behaves as "-v -v".
> If you go that route, then the commit message of this patch needs to
> sell it as such (an improvement in test coverage).
