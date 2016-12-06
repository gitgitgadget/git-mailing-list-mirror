Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FDA91FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 16:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753620AbcLFQD3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 11:03:29 -0500
Received: from mail-wj0-f169.google.com ([209.85.210.169]:33434 "EHLO
        mail-wj0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752800AbcLFQD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 11:03:28 -0500
Received: by mail-wj0-f169.google.com with SMTP id xy5so326990641wjc.0
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 08:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IdpoEVJssljyfrmpEuUESS3uiEqWe3FiaDgYqR6rW8U=;
        b=1AESNNofYfuzmoAfpBaLgVe4OiAX1vK1WxDgQZN3kcenr2XslSpT4rcmVGYqvtv7zU
         /GiIMcH4SO5t4fvBr0Q8qNnLJG1Q05LsdBEPfhtMh6wdU4zxUuuPvsFT4mt81OTLiQQH
         rC4X9JzYPsBCZTBUHdm1AQ9UsFY4ziJmyeU27+1L2bG1k6tEL2Sic5DJE0vjQ46bBiG+
         tL92kddvUOS+fGSuJblizHa4xIQlVn+hqzJKKArWPYSLtaoF8MVlxzFworrPJYyPrp1I
         zIkNHukrKIQFg/BSTfFq6LajD1JYXGZo7FLqcTQE8SNWCAVHzlV6zabeKvG6Y8HDqPML
         iVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IdpoEVJssljyfrmpEuUESS3uiEqWe3FiaDgYqR6rW8U=;
        b=k1cOYOasekgtUN7gvZPP5+XSvujiIoB4UTRG69OWtWUXyRKC/6U+jla8f+X6gtRW6z
         u+WbjvbR5nTevn9hykeKoq4dqXPSZn6kiUSLHzDbgW8Ji7AQkZCvb5eW4bOsz/fbZvdE
         FnLKJEqTB/RQxwiQ5hV8FwpkgOo1F0nb+jvxsYOzFNhIdenkXnEy9Oei7yzWv7n3u44t
         OTIH2pkIj/3oGwVNqIRdNg6Phx/CYM0gudnnm1GcVOXfCo6VH/lz+K2tL+tyDUtmPNK4
         TxfK82OKyPVvsV8MT92/kPA37VQujitL6UGbNAsvIKaraandM2Fb9yY0jySpfHQvNgIx
         fXOA==
X-Gm-Message-State: AKaTC00IdVraWjINzyByP8M0UOiC55XMk/1D59S497qSWlZz3Gc7nSZWO826eJbIIphyqZ3FmdtqpTMngqYRtQ==
X-Received: by 10.25.43.69 with SMTP id r66mr20621789lfr.158.1481040206672;
 Tue, 06 Dec 2016 08:03:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.114.186.165 with HTTP; Tue, 6 Dec 2016 08:03:26 -0800 (PST)
In-Reply-To: <CAE5ih79S+SFt-fsQ_2c4eXMankoXvoSE3zhxw39Y4XeQqQ9nMg@mail.gmail.com>
References: <01020158d1de0e71-ac079bb9-bc7d-4fb7-9ff7-60fd6955116b-000000@eu-west-1.amazonses.com>
 <CAE5ih79S+SFt-fsQ_2c4eXMankoXvoSE3zhxw39Y4XeQqQ9nMg@mail.gmail.com>
From:   Vinicius Kursancew <viniciusalexandre@gmail.com>
Date:   Tue, 6 Dec 2016 16:03:26 +0000
Message-ID: <CAE-KjjE7UE19CfGQb=5BzJrz3Ji6mOXTT46_3v2056b_U8A+qw@mail.gmail.com>
Subject: Re: [PATCH] git-p4: add p4 shelf support
To:     Luke Diamand <luke@diamand.org>
Cc:     Nuno Subtil <subtil@gmail.com>, Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems if you do shelve and then later submit the p4 workspace is
left dirty (just like --prepare-p4-only would've done).
Vinicius Alexandre Kursancew <viniciusalexandre@gmail.com>



On Tue, Dec 6, 2016 at 8:36 AM, Luke Diamand <luke@diamand.org> wrote:
> On 6 December 2016 at 02:02, Nuno Subtil <subtil@gmail.com> wrote:
>> Extends the submit command to support shelving a commit instead of
>> submitting it to p4 (similar to --prepare-p4-only).
>
> Is this just the same as these two changes?
>
> http://www.spinics.net/lists/git/msg290755.html
> http://www.spinics.net/lists/git/msg291103.html
>
> Thanks,
> Luke
>
>>
>> Signed-off-by: Nuno Subtil <subtil@gmail.com>
>> ---
>>  git-p4.py | 36 ++++++++++++++++++++++++++++++------
>>  1 file changed, 30 insertions(+), 6 deletions(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index fd5ca52..3c4be22 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -1286,6 +1286,8 @@ def __init__(self):
>>                  optparse.make_option("--export-labels", dest="exportLabels", action="store_true"),
>>                  optparse.make_option("--dry-run", "-n", dest="dry_run", action="store_true"),
>>                  optparse.make_option("--prepare-p4-only", dest="prepare_p4_only", action="store_true"),
>> +                optparse.make_option("--shelve-only", dest="shelve_only", action="store_true", help="Create P4 shelf for first change that would be submitted (using a new CL)"),
>> +                optparse.make_option("--shelve-cl", dest="shelve_cl", help="Replace shelf under existing CL number (previously shelved files will be deleted)"),
>>                  optparse.make_option("--conflict", dest="conflict_behavior",
>>                                       choices=self.conflict_behavior_choices),
>>                  optparse.make_option("--branch", dest="branch"),
>> @@ -1297,6 +1299,8 @@ def __init__(self):
>>          self.preserveUser = gitConfigBool("git-p4.preserveUser")
>>          self.dry_run = False
>>          self.prepare_p4_only = False
>> +        self.shelve_only = False
>> +        self.shelve_cl = None
>>          self.conflict_behavior = None
>>          self.isWindows = (platform.system() == "Windows")
>>          self.exportLabels = False
>> @@ -1496,6 +1500,12 @@ def prepareSubmitTemplate(self):
>>                  else:
>>                      inFilesSection = False
>>              else:
>> +                if self.shelve_only and self.shelve_cl:
>> +                    if line.startswith("Change:"):
>> +                        line = "Change: %s\n" % self.shelve_cl
>> +                    if line.startswith("Status:"):
>> +                        line = "Status: pending\n"
>> +
>>                  if line.startswith("Files:"):
>>                      inFilesSection = True
>>
>> @@ -1785,7 +1795,11 @@ def applyCommit(self, id):
>>                  if self.isWindows:
>>                      message = message.replace("\r\n", "\n")
>>                  submitTemplate = message[:message.index(separatorLine)]
>> -                p4_write_pipe(['submit', '-i'], submitTemplate)
>> +
>> +                if self.shelve_only:
>> +                    p4_write_pipe(['shelve', '-i', '-r'], submitTemplate)
>> +                else:
>> +                    p4_write_pipe(['submit', '-i'], submitTemplate)
>>
>>                  if self.preserveUser:
>>                      if p4User:
>> @@ -1799,12 +1813,17 @@ def applyCommit(self, id):
>>                  # new file.  This leaves it writable, which confuses p4.
>>                  for f in pureRenameCopy:
>>                      p4_sync(f, "-f")
>> -                submitted = True
>> +
>> +                if not self.shelve_only:
>> +                    submitted = True
>>
>>          finally:
>>              # skip this patch
>>              if not submitted:
>> -                print "Submission cancelled, undoing p4 changes."
>> +                if not self.shelve_only:
>> +                    print "Submission cancelled, undoing p4 changes."
>> +                else:
>> +                    print "Change shelved, undoing p4 changes."
>>                  for f in editedFiles:
>>                      p4_revert(f)
>>                  for f in filesToAdd:
>> @@ -2034,9 +2053,13 @@ def run(self, args):
>>              if ok:
>>                  applied.append(commit)
>>              else:
>> -                if self.prepare_p4_only and i < last:
>> -                    print "Processing only the first commit due to option" \
>> -                          " --prepare-p4-only"
>> +                if (self.prepare_p4_only or self.shelve_only) and i < last:
>> +                    if self.prepare_p4_only:
>> +                        print "Processing only the first commit due to option" \
>> +                              " --prepare-p4-only"
>> +                    else:
>> +                        print "Processing only the first commit due to option" \
>> +                              " --shelve-only"
>>                      break
>>                  if i < last:
>>                      quit = False
>> @@ -3638,6 +3661,7 @@ def printUsage(commands):
>>      "debug" : P4Debug,
>>      "submit" : P4Submit,
>>      "commit" : P4Submit,
>> +    "shelve" : P4Submit,
>>      "sync" : P4Sync,
>>      "rebase" : P4Rebase,
>>      "clone" : P4Clone,
>>
>> --
>> https://github.com/git/git/pull/309
