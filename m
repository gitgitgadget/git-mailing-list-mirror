From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 10/10] submodule deinit: complain when given a file
 instead of a submodule
Date: Mon, 2 May 2016 09:21:56 -0700
Message-ID: <CAGZ79kZbb=PuTwfagDZETkFEaq-3Fp4Bd7ex03TMixUDLtZtiA@mail.gmail.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
	<1461976845-18228-11-git-send-email-sbeller@google.com>
	<CAP=KgsStNm7eUWRfzDPje8mAQ2hFCMJ6MpCeF_OgPvir244vgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Mon May 02 18:22:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axGbk-0002ue-Aj
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 18:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbcEBQV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 12:21:59 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:35824 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbcEBQV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 12:21:57 -0400
Received: by mail-io0-f177.google.com with SMTP id d62so172748232iof.2
        for <git@vger.kernel.org>; Mon, 02 May 2016 09:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=J+UTbAqdG5Y69Z4+z34g23f0Ogccm8SZaQujwEs43Hw=;
        b=Ek8+CFiePdt1D+O9FSHuL+4k9K3O6Kbqaxjjwcr/qur8PHA9b4v6NzhinTEKEJuCXn
         M6vz2zRl9/SKUPZDo0TV/+onRI3PvnTCvQeuRk3+8sitpSTFMll6MSTmJaefqDutCtlI
         YABwQvJ7WHWEl7Uf+MQu0yKgvIi9q5XMjsC4Z4YIIUfy7Ixlxn9YrLitrPPjzwQzQ9y8
         ebY9sZ3oyATrma8ONJ6fAiTppmxAS8+heeHE3h5horfatTsah11Be0BQZ0JR980x+yVD
         lCPHWc177SjPOTlv7wZ2R1GWs6YSEP7yvfxd3IShbdknB3aYzCHBMkwD9D+L9VZOQwQl
         LDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=J+UTbAqdG5Y69Z4+z34g23f0Ogccm8SZaQujwEs43Hw=;
        b=UavhY9muAyQpUNF8MhxDfTQgXlPIWbkCRFX/faAJKaNqs5dbK7wTVb/rdQFTGNIi+O
         KXBcLXr6AY5CM0fSSNaTnr8tfUtWfnua5edripAo7hc0qdn4pdc2FIRKifsB+Z4abKvH
         stavSf/NTpiJaZ9GjvxLN9sNk722y/GB0KHfxgHi7RqOzil0FBl/FeocMGkq/DM6kdkA
         o6wCvqBuqWm4cG89EpxmcNik4F+jDrJEbId+iFPwVk3ChC4r+RHBE33+JuMnc26XzAWD
         bpOElduaKNw6spm/xAE4Q5/PYBNNGU/nr2OBI9wsB2PSMX0PpZ4MHOcjD3w059wFnMET
         c2Sg==
X-Gm-Message-State: AOPr4FXnvckjgxT0KYJnQVYeedgVdyRb7+CSrMXkvGwwXGddstr+gudcddXZci5eBncSjhkGdYs0/QJIPsBykx2Q
X-Received: by 10.107.174.205 with SMTP id n74mr40480775ioo.96.1462206116473;
 Mon, 02 May 2016 09:21:56 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 2 May 2016 09:21:56 -0700 (PDT)
In-Reply-To: <CAP=KgsStNm7eUWRfzDPje8mAQ2hFCMJ6MpCeF_OgPvir244vgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293240>

On Mon, May 2, 2016 at 1:26 AM, Per Cederqvist <cederp@opera.com> wrote:
> After this change, what is the simplest way to programmatically
> deinit any submodule that may exist, without failing if there are
> none?
>
> "git commit" by default refuses to make an empty commit, but
> it has the --allow-empty option.
>
> "git rm -r ." by default fails if there are no files in the repository,
> but it has the --ignore-unmatch option.
>
> It makes sense that "git submodule deinit ." should fail if there
> are no submodules, but please add support for --ignore-unmatch
> at the same time.

Oh right. I'll add the --ignore-unmatch option when rerolling this series.

Thanks,
Stefan

>
>     /ceder
>
>
> On Sat, Apr 30, 2016 at 2:40 AM, Stefan Beller <sbeller@google.com> wrote:
>> This also improves performance for listing submodules, because
>> S_ISGITLINK is both faster as match_pathspec as well as expected to
>> be true in fewer cases, so putting it first in the condition will speed
>> up the loop to compute all submodules.
>>
>> As this partially reverts 84ba959bbdf0 (submodule: fix regression for
>> deinit without submodules, 2016-03-22), this also disallows the use
>> of `git submodule deinit .` to deinit all submodules, when no
>> submodules are present. `deinit .` continues to work on repositories,
>> which have at least one submodule.
>>
>> CC: Per Cederqvist <cederp@opera.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>>
>>> Patch 10 is a controversial thing I'd assume as it breaks existing users.
>>> We should take it for the next major release (i.e. 3.0)
>>> I just want to put it out here now.
>>
>>  builtin/submodule--helper.c |  6 +++---
>>  t/t7400-submodule-basic.sh  | 15 ++++++++++++++-
>>  2 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 7f0941d..e41de3e 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -242,9 +242,9 @@ static int module_list_compute(int argc, const char **argv,
>>         for (i = 0; i < active_nr; i++) {
>>                 const struct cache_entry *ce = active_cache[i];
>>
>> -               if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
>> -                                   0, ps_matched, 1) ||
>> -                   !S_ISGITLINK(ce->ce_mode))
>> +               if (!S_ISGITLINK(ce->ce_mode) ||
>> +                   !match_pathspec(pathspec, ce->name, ce_namelen(ce),
>> +                                   0, ps_matched, 1))
>>                         continue;
>>
>>                 ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
>> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
>> index 53644da..361e6f6 100755
>> --- a/t/t7400-submodule-basic.sh
>> +++ b/t/t7400-submodule-basic.sh
>> @@ -915,7 +915,20 @@ test_expect_success 'submodule deinit works on repository without submodules' '
>>                 >file &&
>>                 git add file &&
>>                 git commit -m "repo should not be empty" &&
>> -               git submodule deinit .
>> +               git submodule deinit
>> +       )
>> +'
>> +
>> +test_expect_success 'submodule deinit refuses to deinit a file' '
>> +       test_when_finished "rm -rf newdirectory" &&
>> +       mkdir newdirectory &&
>> +       (
>> +               cd newdirectory &&
>> +               git init &&
>> +               >file &&
>> +               git add file &&
>> +               git commit -m "repo should not be empty" &&
>> +               test_must_fail git submodule deinit file
>>         )
>>  '
>>
>> --
>> 2.8.0.32.g71f8beb.dirty
>>
