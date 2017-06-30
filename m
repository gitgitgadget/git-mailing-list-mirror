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
	by dcvr.yhbt.net (Postfix) with ESMTP id AB9CF202AB
	for <e@80x24.org>; Fri, 30 Jun 2017 09:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751743AbdF3Jl6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 05:41:58 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34531 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbdF3Jl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 05:41:57 -0400
Received: by mail-qt0-f180.google.com with SMTP id 32so94466063qtv.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ljFXtQ2oUIhsaW4NwQ93Uu2V600tna9ZxfXT+vb4/Kc=;
        b=TeFxDm8sAZnru6DZ1cpaRQFLcc3iCtMqw6slmn7ISVlz7x9gBeNDWn/PPf70tIMDql
         x+xOxCYzrampUuvn9mwm2lp7pKDS6B5j+IUaVJlgIIkZCYjQAGuMcUK+p2otHwH6H6DN
         EpAJ1ZwWWOCZ50DAiis8sk8xdaH/+7uQVWHf5Nl4Vc3Jwejlr05NdAlVdR1zpbMHOZ84
         lZ7wTsI4apJHmaW759G4PCBfeFoHlTAy8t3rAfr4FaBjr7TYRlJMCqj3ZoOHNZI12j9M
         o0kZgvy1pfYaTPSxrpStjf0s7igK65Dy63oYEA7hGbsX9hOR2+Suhi9uMS2ML+tmVubV
         c7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ljFXtQ2oUIhsaW4NwQ93Uu2V600tna9ZxfXT+vb4/Kc=;
        b=sT/QxZJM5aGOMw3coLabAV/gr6Izp853MhjXcptTrjw8RpWCu7hTpzrVhqBO7PKWSw
         ZfDN7mYLhUhi35qT4JS6sIEINRgNMWFNaix+gwwwE1bu8O2TGeenPoT9lMe8py5UieAk
         i8r7oDtn3fko5iz7NVOJUDyfdXflZM2n8Pjo7tGwXOAf34qpVisv4tCvH4L17EGNkQHP
         ioHIRNg9B1X01RNvzxOWNLKt+9eKJ7Hbltz8EtQ41uxx1fnv3SoNf4zvbRCGr4yvKStA
         ILUb2KZbbtVO8G+mX2IfrTkrAsZ+eJm7V+P4tsvIz9kus8ppyGBBTeGFQEjKYgWwQOpl
         kcZg==
X-Gm-Message-State: AKS2vOxod02lAlf6kcDm0PJlPpnGM0gg0pfVXl5PPUJ1oq3z3SNLNlXq
        mHCwlS1+uUtOUi0L/eKQR/CAgsyDfuZu
X-Received: by 10.200.45.182 with SMTP id p51mr24682005qta.208.1498815716621;
 Fri, 30 Jun 2017 02:41:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.63.198 with HTTP; Fri, 30 Jun 2017 02:41:55 -0700 (PDT)
In-Reply-To: <41BF267D-5F4D-4031-B9D4-15DB263D35D9@gmail.com>
References: <CAE5ih7-x45MD1H6Ahr5oCVtTjgbBkeP4GbKCGB-Cwk6BSQwTcw@mail.gmail.com>
 <20170629224659.25677-1-miguel.torroja@gmail.com> <41BF267D-5F4D-4031-B9D4-15DB263D35D9@gmail.com>
From:   Miguel Torroja <miguel.torroja@gmail.com>
Date:   Fri, 30 Jun 2017 11:41:55 +0200
X-Google-Sender-Auth: hGwOQThUSsmNcAH9AxJBqYRlS4g
Message-ID: <CAKYtbVbOXZiZrsFGOKu=sFroSL-FBQo2wMaA9GmJvc-Uh7QZEA@mail.gmail.com>
Subject: Re: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 30, 2017 at 10:26 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 30 Jun 2017, at 00:46, miguel torroja <miguel.torroja@gmail.com> wrote:
>>
>> The option -G of p4 (python marshal output) gives more context about the
>> data being output. That's useful when using the command "change -o" as
>> we can distinguish between warning/error line and real change description.
>>
>> Some p4 triggers in the server side generate some warnings when
>> executed. Unfortunately those messages are mixed with the output of
>> "p4 change -o". Those extra warning lines are reported as {'code':'info'}
>> in python marshal output (-G). The real change output is reported as
>> {'code':'stat'}
>>
>> A new test has been created to t9807-git-p4-submit.sh adding a p4 trigger
>> that outputs extra lines with "p4 change -o" and "p4 changes"
>>
>> Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> git-p4.py                | 85 ++++++++++++++++++++++++++++++++----------------
>> t/t9807-git-p4-submit.sh | 27 +++++++++++++++
>> 2 files changed, 84 insertions(+), 28 deletions(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index 8d151da91..61dc045f3 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -879,8 +879,12 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
>>             cmd += ["%s...@%s" % (p, revisionRange)]
>>
>>         # Insert changes in chronological order
>> -        for line in reversed(p4_read_pipe_lines(cmd)):
>> -            changes.add(int(line.split(" ")[1]))
>> +        for entry in reversed(p4CmdList(cmd)):
>> +            if entry.has_key('p4ExitCode'):
>> +                die('Error retrieving changes descriptions ({})'.format(entry['p4ExitCode']))
>> +            if not entry.has_key('change'):
>> +                continue
>> +            changes.add(int(entry['change']))
>>
>>         if not block_size:
>>             break
>> @@ -1526,37 +1530,62 @@ class P4Submit(Command, P4UserMap):
>>
>>         [upstream, settings] = findUpstreamBranchPoint()
>>
>> -        template = ""
>> +        template = """\
>> +# A Perforce Change Specification.
>> +#
>> +#  Change:      The change number. 'new' on a new changelist.
>> +#  Date:        The date this specification was last modified.
>> +#  Client:      The client on which the changelist was created.  Read-only.
>> +#  User:        The user who created the changelist.
>> +#  Status:      Either 'pending' or 'submitted'. Read-only.
>> +#  Type:        Either 'public' or 'restricted'. Default is 'public'.
>> +#  Description: Comments about the changelist.  Required.
>> +#  Jobs:        What opened jobs are to be closed by this changelist.
>> +#               You may delete jobs from this list.  (New changelists only.)
>> +#  Files:       What opened files from the default changelist are to be added
>> +#               to this changelist.  You may delete files from this list.
>> +#               (New changelists only.)
>> +"""
>> +        files_list = []
>>         inFilesSection = False
>> +        change_entry = None
>>         args = ['change', '-o']
>>         if changelist:
>>             args.append(str(changelist))
>> -
>> -        for line in p4_read_pipe_lines(args):
>> -            if line.endswith("\r\n"):
>> -                line = line[:-2] + "\n"
>> -            if inFilesSection:
>> -                if line.startswith("\t"):
>> -                    # path starts and ends with a tab
>> -                    path = line[1:]
>> -                    lastTab = path.rfind("\t")
>> -                    if lastTab != -1:
>> -                        path = path[:lastTab]
>> -                        if settings.has_key('depot-paths'):
>> -                            if not [p for p in settings['depot-paths']
>> -                                    if p4PathStartsWith(path, p)]:
>> -                                continue
>> -                        else:
>> -                            if not p4PathStartsWith(path, self.depotPath):
>> -                                continue
>> +        for entry in p4CmdList(args):
>> +            if not entry.has_key('code'):
>> +                continue
>> +            if entry['code'] == 'stat':
>> +                change_entry = entry
>> +                break
>> +        if not change_entry:
>> +            die('Failed to decode output of p4 change -o')
>> +        for key, value in change_entry.iteritems():
>> +            if key.startswith('File'):
>> +                if settings.has_key('depot-paths'):
>> +                    if not [p for p in settings['depot-paths']
>> +                            if p4PathStartsWith(value, p)]:
>> +                        continue
>>                 else:
>> -                    inFilesSection = False
>> -            else:
>> -                if line.startswith("Files:"):
>> -                    inFilesSection = True
>> -
>> -            template += line
>> -
>> +                    if not p4PathStartsWith(value, self.depotPath):
>> +                        continue
>> +                files_list.append(value)
>> +                continue
>> +        # Output in the order expected by prepareLogMessage
>> +        for key in ['Change','Client','User','Status','Description','Jobs']:
>> +            if not change_entry.has_key(key):
>> +                continue
>> +            template += '\n'
>> +            template += key + ':'
>> +            if key == 'Description':
>> +                template += '\n'
>> +            for field_line in change_entry[key].splitlines():
>> +                template += '\t'+field_line+'\n'
>> +        if len(files_list) > 0:
>> +            template += '\n'
>> +            template += 'Files:\n'
>> +        for path in files_list:
>> +            template += '\t'+path+'\n'
>>         return template
>>
>>     def edit_template(self, template_file):
>> diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
>> index 3457d5db6..4962b6862 100755
>> --- a/t/t9807-git-p4-submit.sh
>> +++ b/t/t9807-git-p4-submit.sh
>> @@ -409,6 +409,33 @@ test_expect_success 'description with Jobs section and bogus following text' '
>>       )
>> '
>>
>
> I have never worked with p4 triggers and that might be
> the reason why I don't understand your test case.
> Maybe you can help me?
>
>> +test_expect_success 'description with extra lines from verbose p4 trigger' '
>> +     test_when_finished cleanup_git &&
>> +     git p4 clone --dest="$git" //depot &&
>> +     (
>> +             p4 triggers -i <<-EOF
>> +             Triggers: p4triggertest-command command pre-user-change "echo verbose trigger"
>> +             EOF
>> +     ) &&
>
> You clone the test repo and install a trigger.
>
>> +     (
>> +             cd "$git" &&
>> +             git config git-p4.skipSubmitEdit true &&
>> +             echo file20 >file20 &&
>> +             git add file20 &&
>> +             git commit -m file20 &&
>> +             git p4 submit
>> +     ) &&
>
> You make a new commit. This should run the "echo verbose trigger", right?

Yes, that's correct. In this case the trigger is run with p4 change
and p4 changes

>
>> +     (
>> +             p4 triggers -i <<-EOF
>> +             Triggers:
>> +             EOF
>> +     ) &&
>
> You delete the trigger.
>
>> +     (
>> +             cd "$cli" &&
>> +             test_path_is_file file20
>> +     )
>
> You check that the file20 is available in P4.
>
>
> What would happen if I run this test case without your patch?
> Wouldn't it pass just fine?

If you run it without the patch for git-p4.py, the test doesn't pass

> Wouldn't we need to check that no warning/error is in the
> real change description?
>

that can also be added, something like this: 'p4 change -o | grep
"verbose trigger"' after setting the trigger?

> Thanks,
> Lars
