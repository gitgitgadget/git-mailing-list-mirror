Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EECB202AB
	for <e@80x24.org>; Fri, 30 Jun 2017 16:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbdF3QCP (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 12:02:15 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33657 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbdF3QCP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 12:02:15 -0400
Received: by mail-qt0-f176.google.com with SMTP id r30so102462489qtc.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AAvCJ5yE2vi8DMWuSG31hc9KOJbCqYd7+t6gQSZ8sok=;
        b=W1jD0KH6rfyCW+eVQ4rdXmBlgOWUQg/3hdPAZV0J3dA58JFWz7B5nUwTn8tWR3Gw2E
         H+don2mrdfBLzi42BVwh2W47gux9dLGVQCeAHLfLroLH+L0pffsEaZFhitsSksEy0vbt
         PfJUQCXLV7klRzB6ISuSSnIYHVlNhPpIBsdsz4vb613Z3gcp0kSCNv2zzlCIYb5sJBXN
         uCdz49N7GTV94pr7aw1EvrepO9ZLPQ9P6ucrN1h1U0QkpMVncijkt2CYPA2lV9zG0o6D
         en1k4JmYEUHbZZQ6++DNcwmHkDQmT6GBA09i8Ha4KSnqTolkzaunAoBn+5FlGH5GOil8
         eJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AAvCJ5yE2vi8DMWuSG31hc9KOJbCqYd7+t6gQSZ8sok=;
        b=mEvJyFp7Pi/wF3aXlVHIyp1IKdKla69EzwhqUCcmOIzmFD9UVp8r+mtFD8s40c/yF1
         3vfkvj5Uz3N1YhLqpf/EQPLo6X0APV/J84O1b8TQp4Or4jNcPK7E1BbovTe2UhMGsac2
         B3T3eqAQQ5FQN1FiB3rtqld6zjWFd7Gdt0rw7+LtSHJ0rK9waNJp+P5JHV5gtE/taonF
         2QmcWxVkxJPc/sYgWkY6zSI/YDxy6n8Xq60mxmu1ac3SXBkC9vjWzoXEZlU0Ovk3cfqe
         VO1rVP7/iZqGYSKpAnfCcCSL7OLf5W/1Vcqal09Hmq21jvnPZrAGqQLuFDCxGS7abSD1
         FLXQ==
X-Gm-Message-State: AKS2vOzHz4atnoi13SifgSQTc/aMf5XAD1DbO4HHphp3OLwjM3O7RS2i
        lyVIEerrGquwz0d12c8LDeDDT4VutA==
X-Received: by 10.237.37.116 with SMTP id w49mr28440728qtc.14.1498838533574;
 Fri, 30 Jun 2017 09:02:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.63.198 with HTTP; Fri, 30 Jun 2017 09:02:12 -0700 (PDT)
In-Reply-To: <94F87EDC-4F34-455E-88D5-F99C606EF628@gmail.com>
References: <CAE5ih7-x45MD1H6Ahr5oCVtTjgbBkeP4GbKCGB-Cwk6BSQwTcw@mail.gmail.com>
 <20170629224659.25677-1-miguel.torroja@gmail.com> <41BF267D-5F4D-4031-B9D4-15DB263D35D9@gmail.com>
 <CAKYtbVbOXZiZrsFGOKu=sFroSL-FBQo2wMaA9GmJvc-Uh7QZEA@mail.gmail.com> <94F87EDC-4F34-455E-88D5-F99C606EF628@gmail.com>
From:   Miguel Torroja <miguel.torroja@gmail.com>
Date:   Fri, 30 Jun 2017 18:02:12 +0200
X-Google-Sender-Auth: sInKkKJjXain2YsoYN6oeR2o1jY
Message-ID: <CAKYtbVYCK_8jjW_B-Mmd3heUabTiTq0Lakf1Znz2ptipQwhEJQ@mail.gmail.com>
Subject: Re: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 30, 2017 at 12:13 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 30 Jun 2017, at 11:41, Miguel Torroja <miguel.torroja@gmail.com> wrote:
>>
>> On Fri, Jun 30, 2017 at 10:26 AM, Lars Schneider
>> <larsxschneider@gmail.com> wrote:
>>>
>>>> On 30 Jun 2017, at 00:46, miguel torroja <miguel.torroja@gmail.com> wrote:
>>>>
>>>> The option -G of p4 (python marshal output) gives more context about the
>>>> data being output. That's useful when using the command "change -o" as
>>>> we can distinguish between warning/error line and real change description.
>>>>
>>>> Some p4 triggers in the server side generate some warnings when
>>>> executed. Unfortunately those messages are mixed with the output of
>>>> "p4 change -o". Those extra warning lines are reported as {'code':'info'}
>>>> in python marshal output (-G). The real change output is reported as
>>>> {'code':'stat'}
>>>>
>>>> A new test has been created to t9807-git-p4-submit.sh adding a p4 trigger
>>>> that outputs extra lines with "p4 change -o" and "p4 changes"
>>>>
>>>> Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
>>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>>> ---
>>>> ...
>>>
>>> I have never worked with p4 triggers and that might be
>>> the reason why I don't understand your test case.
>>> Maybe you can help me?
>>>
>>>> +test_expect_success 'description with extra lines from verbose p4 trigger' '
>>>> +     test_when_finished cleanup_git &&
>>>> +     git p4 clone --dest="$git" //depot &&
>>>> +     (
>>>> +             p4 triggers -i <<-EOF
>>>> +             Triggers: p4triggertest-command command pre-user-change "echo verbose trigger"
>>>> +             EOF
>>>> +     ) &&
>>>
>>> You clone the test repo and install a trigger.
>>>
>>>> +     (
>>>> +             cd "$git" &&
>>>> +             git config git-p4.skipSubmitEdit true &&
>>>> +             echo file20 >file20 &&
>>>> +             git add file20 &&
>>>> +             git commit -m file20 &&
>>>> +             git p4 submit
>>>> +     ) &&
>>>
>>> You make a new commit. This should run the "echo verbose trigger", right?
>>
>> Yes, that's correct. In this case the trigger is run with p4 change
>> and p4 changes
>>
>>>
>>>> +     (
>>>> +             p4 triggers -i <<-EOF
>>>> +             Triggers:
>>>> +             EOF
>>>> +     ) &&
>>>
>>> You delete the trigger.
>>>
>>>> +     (
>>>> +             cd "$cli" &&
>>>> +             test_path_is_file file20
>>>> +     )
>>>
>>> You check that the file20 is available in P4.
>>>
>>>
>>> What would happen if I run this test case without your patch?
>>> Wouldn't it pass just fine?
>>
>> If you run it without the patch for git-p4.py, the test doesn't pass
>
> You are right. I did not run "make" properly before running the test :)
>
>
>>> Wouldn't we need to check that no warning/error is in the
>>> real change description?
>>>
>>
>> that can also be added, something like this: 'p4 change -o | grep
>> "verbose trigger"' after setting the trigger?
>
> Yeah, maybe. I hope this is no stupid question, but: If you clone the
> repo with git-p4 *again* ... would you see the "verbose trigger" output
> in the Git commit message?
>

The commands that are affected are the ones that don't use the -G
option, as everything is sent to the standard output without being
able to filter out what is the real contents or just info messages.
That's not the case with the python output (-G). Having said that... I
tried what you just said (just to be sure) and the function
p4_last_change fails... as it expects the first dictionary returned by
p4CmdList is the one that contains the change:
"int(results[0]['change'])" and that's not the case as it's an info
entry (no 'change' key, that's in the next entry...)  I'll update with
new patches

I didn't notice that before because the P4 server we have in our
office only outputs extra info messages with the command "p4 change".


> - Lars
