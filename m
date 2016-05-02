From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 10/10] submodule deinit: complain when given a file
 instead of a submodule
Date: Mon, 2 May 2016 10:00:32 -0700
Message-ID: <CAGZ79kY2hyRgn+oS436Hdr73ajW+Aeg+X-i5BSB41xqyfkz1Mw@mail.gmail.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
	<1461976845-18228-11-git-send-email-sbeller@google.com>
	<CAP=KgsStNm7eUWRfzDPje8mAQ2hFCMJ6MpCeF_OgPvir244vgQ@mail.gmail.com>
	<CAGZ79kZbb=PuTwfagDZETkFEaq-3Fp4Bd7ex03TMixUDLtZtiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Mon May 02 19:00:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axHD8-0005gV-7K
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 19:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420AbcEBRAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 13:00:36 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:32942 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474AbcEBRAd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 13:00:33 -0400
Received: by mail-io0-f180.google.com with SMTP id f89so173533604ioi.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=g/xN1kCe7cDB2QSWlvK1OcADzGFH/TdZFL2F6VT6GR0=;
        b=kAvj4o16jKk9RJW9nygFRpOzCX318Sp4ynnqBHwFnFJR/IkuExv/dcbCQbTvFBpAqi
         +Y/VBwAmlP+AUh4BZ4tOsFhbY7E07KW04+w0efscTlJnCct/uzl/AaGt39WxXBfhFFsX
         UdaMK7ETJaZq9bIlNE4uIswKlo21B5EYKINfyvH8mNpd7txkqJnDZIALlGeHSdCeWeTR
         PijJ+3Vw5o1Hokew1hfQsCdkASxkGkAXyS61lmhqwyVFk6RysvwH7A2sfYbpbBWuZr7K
         QDcX42eZAuE+s6k7wo5eoY6EwLlw/1okoutIg6WtVwVhfu4jdjJ0u64IJxP5Yz1mnh6j
         LvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=g/xN1kCe7cDB2QSWlvK1OcADzGFH/TdZFL2F6VT6GR0=;
        b=fcqFhzi52Q0g1INp5NgQ11npf8dZmOh0EcCpT6/+ZW1myCoH5W06bGkOA6JMVqaV10
         n2TxXeJQorgf+hEPri3oQ/pEIPg9sQ4j9JQwSdeq5SiR1gLBFZ9DsRtF6w7Nybt4o/Ft
         AlhuBxQZNxU1j5OpaLI/xdnynm+R4byq4bajRXf+s3q95y2EUPG+A9ID5lsZPCJgmXHa
         p1nWuGrIbbDsKPJ4fKwjxkTKPlGKW+Yd/2EMF1NKBguwMyHlvc28uiVqeiOVJrRpu1WV
         VStmDBRchRYCPt7J4Xjh1cCdjnQSzenDwFn1P86kUOpNCmmMJ6RGQcO9PXKyax1priKD
         /pnQ==
X-Gm-Message-State: AOPr4FX4EQwMDG/P6lyz+vkKrmx+cXNPdPPa/A8kW2PXTE1+wj4nA6sd98C1vsAZNBONqWKj8SIjqZJq1QK81Tl9
X-Received: by 10.107.174.205 with SMTP id n74mr40675255ioo.96.1462208432710;
 Mon, 02 May 2016 10:00:32 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 2 May 2016 10:00:32 -0700 (PDT)
In-Reply-To: <CAGZ79kZbb=PuTwfagDZETkFEaq-3Fp4Bd7ex03TMixUDLtZtiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293241>

On Mon, May 2, 2016 at 9:21 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, May 2, 2016 at 1:26 AM, Per Cederqvist <cederp@opera.com> wrote:
>> After this change, what is the simplest way to programmatically
>> deinit any submodule that may exist, without failing if there are
>> none?
>>
>> "git commit" by default refuses to make an empty commit, but
>> it has the --allow-empty option.
>>
>> "git rm -r ." by default fails if there are no files in the repository,
>> but it has the --ignore-unmatch option.
>>
>> It makes sense that "git submodule deinit ." should fail if there
>> are no submodules, but please add support for --ignore-unmatch
>> at the same time.

With this patch series, you can omit the trailing dot, i.e.
"git submodule deinit" works. I just tested that and it works in
repositories with no submodules as well as in empty repositories,
but I'll add a test for that as well.

>
> Oh right. I'll add the --ignore-unmatch option when rerolling this series.
>
> Thanks,
> Stefan
>
>>
>>     /ceder
>>
>>
>> On Sat, Apr 30, 2016 at 2:40 AM, Stefan Beller <sbeller@google.com> wrote:
>>> This also improves performance for listing submodules, because
>>> S_ISGITLINK is both faster as match_pathspec as well as expected to
>>> be true in fewer cases, so putting it first in the condition will speed
>>> up the loop to compute all submodules.
>>>
>>> As this partially reverts 84ba959bbdf0 (submodule: fix regression for
>>> deinit without submodules, 2016-03-22), this also disallows the use
>>> of `git submodule deinit .` to deinit all submodules, when no
>>> submodules are present. `deinit .` continues to work on repositories,
>>> which have at least one submodule.
>>>
>>> CC: Per Cederqvist <cederp@opera.com>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>>
>>>
>>>> Patch 10 is a controversial thing I'd assume as it breaks existing users.
>>>> We should take it for the next major release (i.e. 3.0)
>>>> I just want to put it out here now.
>>>
>>>  builtin/submodule--helper.c |  6 +++---
>>>  t/t7400-submodule-basic.sh  | 15 ++++++++++++++-
>>>  2 files changed, 17 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>>> index 7f0941d..e41de3e 100644
>>> --- a/builtin/submodule--helper.c
>>> +++ b/builtin/submodule--helper.c
>>> @@ -242,9 +242,9 @@ static int module_list_compute(int argc, const char **argv,
>>>         for (i = 0; i < active_nr; i++) {
>>>                 const struct cache_entry *ce = active_cache[i];
>>>
>>> -               if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
>>> -                                   0, ps_matched, 1) ||
>>> -                   !S_ISGITLINK(ce->ce_mode))
>>> +               if (!S_ISGITLINK(ce->ce_mode) ||
>>> +                   !match_pathspec(pathspec, ce->name, ce_namelen(ce),
>>> +                                   0, ps_matched, 1))
>>>                         continue;
>>>
>>>                 ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
>>> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
>>> index 53644da..361e6f6 100755
>>> --- a/t/t7400-submodule-basic.sh
>>> +++ b/t/t7400-submodule-basic.sh
>>> @@ -915,7 +915,20 @@ test_expect_success 'submodule deinit works on repository without submodules' '
>>>                 >file &&
>>>                 git add file &&
>>>                 git commit -m "repo should not be empty" &&
>>> -               git submodule deinit .
>>> +               git submodule deinit
>>> +       )
>>> +'
>>> +
>>> +test_expect_success 'submodule deinit refuses to deinit a file' '
>>> +       test_when_finished "rm -rf newdirectory" &&
>>> +       mkdir newdirectory &&
>>> +       (
>>> +               cd newdirectory &&
>>> +               git init &&
>>> +               >file &&
>>> +               git add file &&
>>> +               git commit -m "repo should not be empty" &&
>>> +               test_must_fail git submodule deinit file
>>>         )
>>>  '
>>>
>>> --
>>> 2.8.0.32.g71f8beb.dirty
>>>
