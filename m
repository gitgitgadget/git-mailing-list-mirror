Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3EDB2035A
	for <e@80x24.org>; Tue, 11 Jul 2017 22:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933769AbdGKWfw (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 18:35:52 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35242 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932740AbdGKWfv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 18:35:51 -0400
Received: by mail-qk0-f169.google.com with SMTP id 16so5403617qkg.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 15:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pej9+myZHi2e+iJ69BZAnGc8cRYE6UtTMMrYQzA0qLI=;
        b=BdEzLmXSlEzRCZzxQOoL+DwpXVXbEO4V64ZtqAK3mKJm3z8xZetRLAbC8vdK2SNIGM
         3yoFTpPi2w/llVi2YQQODk1saISMvUE8hJEGYIg/2wW3SPgQ6uI2USFrJSp7QMC/Oaw6
         3NOh2zgvQiH3oHPUeFDUimGbKJQsp80JVbuJtUiJpOXFn47QqroyPNSuH+MZcStu+8gI
         fcX6DaHv5Io02brwtQX77sgqqf9UjoWOo/VaXbtgO4LHfOh7m4S5YOtN1pgdRBRno6LV
         41kBiHoXzcbb0W/nuInFG3M8JrTt4z6nB4PPXoDHngY4IRiQ2aPTfOwR+xUJK0QQUHGB
         zzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pej9+myZHi2e+iJ69BZAnGc8cRYE6UtTMMrYQzA0qLI=;
        b=e37bPAdHFjoYhtgVgasYnvxxQFq52fAqv8wcsO2hnf541WZ1ApHz/U04ncgSNyvea4
         B8v9EraZWrqABFLW9VA4FIS3F2yD2Jz2F15AxnUuYPwOID+UvJadubpeioR6PFMRYfyL
         2jSSOtORNxO9dyx0fobDJV/XmhNNimqZNrZY0/cQ38MSvmRoDziWQ+3PsTZCYUMuFW3O
         96z/q8kjYEYCFyu6sFBq6dzQ31dzHeRfzs+ccruGDmSxJy2FC70pZsRZLPj0uvtMOgQx
         jAzOTwb4qDYp5AYrpHxA1u+RB5Y/t/UUqTiFMAjxgYfUL5Mxl25s9nwbtmr/VFo201Ku
         OMoQ==
X-Gm-Message-State: AIVw111QFlFh13zs+/eH4KttwiT5gnsBip1Hcy34ye36WLH+1P/1t4DF
        1Vt9LQjZA9m+9LRKFjUcrjtWcOaVFw==
X-Received: by 10.55.19.152 with SMTP id 24mr2769212qkt.78.1499812550218; Tue,
 11 Jul 2017 15:35:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.63.198 with HTTP; Tue, 11 Jul 2017 15:35:49 -0700 (PDT)
In-Reply-To: <CAE5ih7-Sy9YmGbLs=wzfxXCSFLkEotqLRuu_xNz9x=7BhvrvnA@mail.gmail.com>
References: <94F87EDC-4F34-455E-88D5-F99C606EF628@gmail.com>
 <20170703225731.21212-1-miguel.torroja@gmail.com> <CAE5ih7-Sy9YmGbLs=wzfxXCSFLkEotqLRuu_xNz9x=7BhvrvnA@mail.gmail.com>
From:   Miguel Torroja <miguel.torroja@gmail.com>
Date:   Wed, 12 Jul 2017 00:35:49 +0200
X-Google-Sender-Auth: kWEf7XpECL5p-g_aPYGkrI5uknA
Message-ID: <CAKYtbVbNMzPe17rBUihm5Q+mgsJUhWMs3LKDp5jEJFdL+ieafg@mail.gmail.com>
Subject: Re: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
To:     Luke Diamand <luke@diamand.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke,


My bad as I didn't check that case.
It was p4CmdList as you said. the default value of the new field
skip_info (set to True) ignores any info messages. and the script is
waiting for a valid message.
If I set it to False, then it does return an info entry and it accepts
the submit change

I'm sending another patch update

On Tue, Jul 11, 2017 at 10:35 AM, Luke Diamand <luke@diamand.org> wrote:
> On 3 July 2017 at 23:57, Miguel Torroja <miguel.torroja@gmail.com> wrote:
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
>> the function p4CmdList accepts a new argument: skip_info. When set to
>> True it ignores any 'code':'info' entry (skip_info=True by default).
>>
>> A new test has been created to t9807-git-p4-submit.sh adding a p4 trigger
>> that outputs extra lines with "p4 change -o" and "p4 changes"
>
> The latest version of mt/p4-parse-G-output (09521c7a0) seems to break
> t9813-git-p4-preserve-users.sh.
>
> I don't quite know why, but I wonder if it's the change to p4CmdList() ?
>
> Luke
>
>>
>> Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
>> ---
>>  git-p4.py                | 90 ++++++++++++++++++++++++++++++++----------------
>>  t/t9807-git-p4-submit.sh | 30 ++++++++++++++++
>>  2 files changed, 91 insertions(+), 29 deletions(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index 8d151da91..a262e3253 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -509,7 +509,7 @@ def isModeExec(mode):
>>  def isModeExecChanged(src_mode, dst_mode):
>>      return isModeExec(src_mode) != isModeExec(dst_mode)
>>
>> -def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None):
>> +def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=True):
>>
>>      if isinstance(cmd,basestring):
>>          cmd = "-G " + cmd
>> @@ -545,6 +545,9 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None):
>>      try:
>>          while True:
>>              entry = marshal.load(p4.stdout)
>> +            if skip_info:
>> +                if 'code' in entry and entry['code'] == 'info':
>> +                    continue
>>              if cb is not None:
>>                  cb(entry)
>>              else:
>> @@ -879,8 +882,12 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
>>              cmd += ["%s...@%s" % (p, revisionRange)]
>>
>>          # Insert changes in chronological order
>> -        for line in reversed(p4_read_pipe_lines(cmd)):
>> -            changes.add(int(line.split(" ")[1]))
>> +        for entry in reversed(p4CmdList(cmd)):
>> +            if entry.has_key('p4ExitCode'):
>> +                die('Error retrieving changes descriptions ({})'.format(entry['p4ExitCode']))
>> +            if not entry.has_key('change'):
>> +                continue
>> +            changes.add(int(entry['change']))
>>
>>          if not block_size:
>>              break
>> @@ -1526,37 +1533,62 @@ class P4Submit(Command, P4UserMap):
>>
>>          [upstream, settings] = findUpstreamBranchPoint()
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
>>          inFilesSection = False
>> +        change_entry = None
>>          args = ['change', '-o']
>>          if changelist:
>>              args.append(str(changelist))
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
>>                  else:
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
>>          return template
>>
>>      def edit_template(self, template_file):
>> diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
>> index 3457d5db6..b630895a7 100755
>> --- a/t/t9807-git-p4-submit.sh
>> +++ b/t/t9807-git-p4-submit.sh
>> @@ -409,6 +409,36 @@ test_expect_success 'description with Jobs section and bogus following text' '
>>         )
>>  '
>>
>> +test_expect_success 'description with extra lines from verbose p4 trigger' '
>> +       test_when_finished cleanup_git &&
>> +       git p4 clone --dest="$git" //depot &&
>> +       (
>> +               p4 triggers -i <<-EOF
>> +               Triggers: p4triggertest-command command pre-user-change "echo verbose trigger"
>> +               EOF
>> +       ) &&
>> +       (
>> +               p4 change -o |  grep -s "verbose trigger"
>> +       ) &&
>> +       (
>> +               cd "$git" &&
>> +               git config git-p4.skipSubmitEdit true &&
>> +               echo file20 >file20 &&
>> +               git add file20 &&
>> +               git commit -m file20 &&
>> +               git p4 submit
>> +       ) &&
>> +       (
>> +               p4 triggers -i <<-EOF
>> +               Triggers:
>> +               EOF
>> +       ) &&
>> +       (
>> +               cd "$cli" &&
>> +               test_path_is_file file20
>> +       )
>> +'
>> +
>>  test_expect_success 'submit --prepare-p4-only' '
>>         test_when_finished cleanup_git &&
>>         git p4 clone --dest="$git" //depot &&
>> --
>> 2.11.0
>>
