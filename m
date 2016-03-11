From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v4] commit: add a commit.verbose config variable
Date: Fri, 11 Mar 2016 10:18:41 -0000
Organization: OPDS
Message-ID: <83A7534D5757482089D43FFE96FCA1C9@PhilipOakley>
References: <0102015362963f6a-626ad27e-e705-4a75-93a6-55a5f75d0226-000000@eu-west-1.amazonses.com><CAPig+cT+dmD2Nxw7z+x0Q2z_aJQFMwRwnb=dn1uH-_Nt9tnk4Q@mail.gmail.com> <CAFZEwPMznAUBhgJgZ7aRvtH1W8hDYLci6khbw9EsWS9WGhSh=Q@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Pranit Bauva" <pranit.bauva@gmail.com>,
	"Eric Sunshine" <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 19:48:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeS6U-0000HR-Ej
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 19:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbcCKSr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 13:47:59 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:60779 "EHLO
	smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbcCKSr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 13:47:57 -0500
Received: from PhilipOakley ([92.22.7.88])
	by smtp.talktalk.net with SMTP
	id eS6MaI8NyjCCPeS6Ma9Omr; Fri, 11 Mar 2016 18:47:54 +0000
X-Originating-IP: [92.22.7.88]
X-Spam: 0
X-Authority: v=2.1 cv=UsDDT7EB c=1 sm=1 tr=0 a=6QMx9pIb3V9ZKGzuUMGrGw==:117
 a=6QMx9pIb3V9ZKGzuUMGrGw==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=BCjA09oAAAAA:8
 a=TSbVqHtbAAAA:8 a=g9eVMJaYNvXKNEklBNEA:9 a=QEXdDO2ut3YA:10
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfNqv3Us/5hkjmB0dX8Wtu0VhAzAwc09z6sHMgTk9e/zswB43e1alTLhhUPwZVp4aFyZ3haf7IC8BRb9DGaOlSyRFaYJ3Cw1GIHAoyTNavRygVrhB0euq
 A8gyKF/sNAt6+YLKz2X55S3fNAuV7nXEiGr6cmu5GqTU66isasJbfglZZwxdLTszMcHyRNCfZCiuvv1t0oGKCq3lhFYxP7Qf0OPv2Q8eULqudl3TakdChivx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288698>

From: "Pranit Bauva" <pranit.bauva@gmail.com>
> On Fri, Mar 11, 2016 at 4:31 AM, Eric Sunshine <sunshine@sunshineco.com> 
> wrote:
>
>>     Add commit.verbose configuration variable as a convenience
>>     for those who always prefer --verbose.
>>
>> or something.
>
> Sure!
>
>> As a convenience to reviewers, please use this area below the "---"
>> line to provide links and explain what changed since the previous
>> round rather than doing so in a separate email.
>
> Actually I am sending the patches with submitGit herokuapp because my
> institute proxy does not allow IMAP/POP3 connections.

You can still include the 'three dashes' and a commentary at the end of your 
(local) regular commit message, and then when it is sent as a patch it will 
have the right format. There are carried through rebases as well.

There is a similar feature for attaching notes (though I haven't used it).

Either should get around your institute's proxy issue.

>
>> The "permanently" bit sounds scary. A more concise way to state this 
>> might be:
>>
>>     See the `commit.verbose` configuration variable in
>>     linkgit:git-config[1].
>>
>> which doesn't bother spelling out what the intelligent reader should
>> infer from the reference.
>> Style: space before {
>
> Sure!
>
>>> +test_expect_success 'commit with commit.verbose true and no arguments' 
>>> '
>>
>> "no arguments" doesn't convey much; how about "--verbose omitted" or
>> something? Ditto for the titles of other tests.
>
> Will change the language construct.
>>> +       echo content >file &&
>>> +       git add file &&
>>> +       test_config commit.verbose true &&
>>> +       (
>>> +               GIT_EDITOR=cat &&
>>> +               export GIT_EDITOR &&
>>> +               test_must_fail git commit >output
>>> +       ) &&
>>> +       test_i18ngrep "diff --git" output
>>> +'
>>
>> Making git-commit fail unconditionally with "aborting due to empty
>> commit message" is a rather sneaky way to perform this test. I would
>> have expected to see these new tests re-use the existing machinery
>> provided by this script (the check-for-diff "editor") rather than
>> inventing an entirely new and unintuitive mechanism. Doing so would
>> also reduce the size of each new test.
>
> I agree on the fact that making git-commit fail unconditionally is not
> a good way to perform the test. "check-for-diff" is not really an
> "editor" and it checks for the commit message after it has been
> written to the history. The verbose output is stripped when it is
> written to the history so we won't be able to test whether this patch
> works. This is where purposely breaking the code is required as when
> the commit fails, it gives the output of the contents present at that
> time (which will contain the verbose output). More over the
> 'check-for-diff' uses grep which is not preferred. Many tests are now
> using test_i18ngrep (eg. f79ce8db). I had planned on using
> 'check-for-diff' before but it took me some time to figure out this
> behavior and thus I began searching for another mechanism (breaking
> code).
>
>> Some additional tests[1][2] are probably warranted.
>>
>> [1]: http://article.gmane.org/gmane.comp.version-control.git/288648
>> [2]: http://article.gmane.org/gmane.comp.version-control.git/288657
>
> I think these tests also are better included in this file as this
> patch triggers it and it would not make much of a difference between
> t7507 and t7502 but in fact improve its readability.
>>>  test_done
