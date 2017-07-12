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
	by dcvr.yhbt.net (Postfix) with ESMTP id 39A0B202AC
	for <e@80x24.org>; Wed, 12 Jul 2017 10:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755634AbdGLKQs (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 06:16:48 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35118 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdGLKQq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 06:16:46 -0400
Received: by mail-qk0-f169.google.com with SMTP id 16so15552082qkg.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZM5UMIJ36lokhPvVhIrzc5BjX60Kl6GEbWkdJujwLbs=;
        b=bjwMFb+QcfgOmh8SpmgL9f1JC96AWv0jTOsKmJS2GftyAespZQQNsC3WAdsVLWH63f
         rqCqM8Z2ACrqH+Lmw5yMHIfd4aEja5IogDKNSJrQRXGbnw+E10oZzZPVwNTnEi63AgCE
         QFHaNpBvFW1J5+PpbSJzpJxw2qxUsaXwYsZos5ycwCZdob2UqsjuKtomgF4o/weBEtIL
         KAKDD1FuvQszQvy5w5F82wEj9qr2Zl4yLd4hyh9iTfH5ESiduo2gqtrtPnVvgtvXWjHh
         33N3DuMa0nKJGA+2pzaHn7s6nT7j24gg8c37pnht6waHUQrXSyHhfXvFTGbdKIZhYhA5
         GyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZM5UMIJ36lokhPvVhIrzc5BjX60Kl6GEbWkdJujwLbs=;
        b=pNbFmogD/WljOR9P6yFGJ/96ku4uSB8vuDapWdK6jjiLHzr7jwNEC1qSFPxQVntlxG
         uwe2uPiZ9EPETzaC4v+WxLKbs9HjV9b7Rl2SlpQIkS2okVWi/010iBO9c3RMCO+UH1/+
         OPflMf901gPqmZ2qwr7z6PVUFViRImj81R2sZseKOpaoP69C/V/p5ZaoP/Q++IKYv9Oa
         QYldKXKHcKPasAJBi+5P9ePMeiWRI/rC6BHs9IgaW0qF3NC2EYm4nRfVdZqvuSeoQPCO
         5He40HslI7uU/bLkYkCY8VhzpsT3XGvJnhcGrHdkvDjoSPossjOt+GRJPooTuXzABiOZ
         HoHA==
X-Gm-Message-State: AIVw110gbOpH5t6RN4DWIg0Y/MLrKkODBv7cec7YJ/ATOJiqs/OVfc4j
        hZVGk5bjytx/D1NBGUTc0+oNgOKOmA==
X-Received: by 10.55.19.152 with SMTP id 24mr5022018qkt.78.1499854605882; Wed,
 12 Jul 2017 03:16:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.63.198 with HTTP; Wed, 12 Jul 2017 03:16:44 -0700 (PDT)
In-Reply-To: <CAE5ih78mrTz1sfJbRSuPTNojxWyH_1JFDY2pe7GMAZdPhzcvpA@mail.gmail.com>
References: <CAE5ih7-Sy9YmGbLs=wzfxXCSFLkEotqLRuu_xNz9x=7BhvrvnA@mail.gmail.com>
 <20170711225316.10608-1-miguel.torroja@gmail.com> <CAE5ih78mrTz1sfJbRSuPTNojxWyH_1JFDY2pe7GMAZdPhzcvpA@mail.gmail.com>
From:   Miguel Torroja <miguel.torroja@gmail.com>
Date:   Wed, 12 Jul 2017 12:16:44 +0200
X-Google-Sender-Auth: 0RxITV2eqJ2yIngNDMups8Iw-9k
Message-ID: <CAKYtbVb8T=edPG5539=uwDjHnCerLO2Oejy8bWK+giSS8nNGig@mail.gmail.com>
Subject: Re: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The motivation for setting skip_info default to True is because any
extra message  output by a p4 trigger to stdout, seems to be reported
as {'code':'info'} when the p4 command output is marshalled.

I though it was the less intrusive way to filter out the verbose
server trigger scripts, as some commands are waiting for a specific
order and size of the list returned e.g:

 def p4_last_change():
     results = p4CmdList(["changes", "-m", "1"])
     return int(results[0]['change'])
 .
 def p4_describe(change):
    ds = p4CmdList(["describe", "-s", str(change)])
    if len(ds) != 1:
        die("p4 describe -s %d did not return 1 result: %s" % (change, str(ds)))

Previous examples would be broken if we allow extra "info" marshalled
messages to be exposed.

In the case of the command that was broken with the new default
behaviour , when calling modfyChangelistUser, it is waiting for any
message with 'data' that is not an error to consider command was
succesful


Thanks,


On Wed, Jul 12, 2017 at 10:25 AM, Luke Diamand <luke@diamand.org> wrote:
> On 11 July 2017 at 23:53, Miguel Torroja <miguel.torroja@gmail.com> wrote:
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
>> A new test has been created in t9807-git-p4-submit.sh adding a p4 trigger
>> that outputs extra lines with "p4 change -o" and "p4 changes"
>>
>> Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
>> ---
>>  git-p4.py                | 92 ++++++++++++++++++++++++++++++++----------------
>>  t/t9807-git-p4-submit.sh | 30 ++++++++++++++++
>>  2 files changed, 92 insertions(+), 30 deletions(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index 8d151da91..1facf32db 100755
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
>> @@ -1494,7 +1501,7 @@ class P4Submit(Command, P4UserMap):
>>          c['User'] = newUser
>>          input = marshal.dumps(c)
>>
>> -        result = p4CmdList("change -f -i", stdin=input)
>> +        result = p4CmdList("change -f -i", stdin=input,skip_info=False)
>
> Is there any reason this change sets skip_info to False in this one
> place, rather than defaulting to False (the original behavior) and
> setting it to True where it's needed?
>
> I worry that there might be other unexpected side effects in places
> not covered by the tests.
>
> Thanks
> Luke
