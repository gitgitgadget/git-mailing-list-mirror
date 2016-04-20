From: Ben Woosley <ben.woosley@gmail.com>
Subject: Re: [PATCH] Update git-p4 to be compatible with git-lfs 1.2
Date: Wed, 20 Apr 2016 14:10:03 -0700
Message-ID: <CAC5gnOx9W3S3f=92T_LNWBfFm71xe9uNY3O_exxetcf2Xjp+Ew@mail.gmail.com>
References: <0102015434ee502d-d91a9a46-299f-47b0-a583-104b540200bc-000000@eu-west-1.amazonses.com>
 <CAE5ih79A2D8xTi9MuOYJ=dU12P5hOsLbw+XXptcnhAATwZvBCQ@mail.gmail.com>
 <CAC5gnOx1ZbNnYzMYYfD5TkXkgHAz7qgOTVCEiu2D0PA-MZLrvQ@mail.gmail.com> <E90E5734-C130-42A4-9230-9C95A466C919@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 23:10:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aszOR-0004KI-Dk
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 23:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbcDTVKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 17:10:35 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35056 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbcDTVKe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 17:10:34 -0400
Received: by mail-oi0-f47.google.com with SMTP id p188so62835226oih.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 14:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iyVrAPEERLXtMsmb7mPuFOiLU0I40lnVvvqheAEM37k=;
        b=KR1E339GKPsw289LfhDd/j3tfTKsgeUXqoAPNyka6PxfIiMKY9jjjXKdfLIP9/+Icz
         ryvOJ9/5QESOWXQ7bcA0gtZcSwr0ZLF1m4xww6HdWHQpHFz/eqbezFILxOUAe0MGvVKf
         tN62BUzQs2OSmjXb97Ngg9qC/kwMgyiKKR5qWsoG+1Xh/AYsTaAvS8G4uG2oanJK6dsI
         a1jWdrOchF8U52eHam0ZO3QIgSL0i1VuBHXvhetVpP6ugtOKPNh0OrpjiWT196mp+ZcI
         2rty1sOU//y5uD16NQBybJvuhy6wGRg8/9XI1ZQnXZgbrL4d/TAzYNJ/+IgbzsFgaGLu
         05vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iyVrAPEERLXtMsmb7mPuFOiLU0I40lnVvvqheAEM37k=;
        b=JDAOfe4eZEt+EXN+nThHpL1Atx90eqlFgclLS91nvFyUqzYP2amu8A7ne0eGHXjoYE
         pNmT2fHwirrt/guM9PG25RYdwtGGz9o3dck/9gU+JfZzUAl1eny/zKwE3VfRHuJ15Oji
         JPL47sMCSKxrvkI3l6pxgrjoMrNNqfRi2rvzY6938xnIYzCbc69W+2QcdxfeENFYm6X3
         cyaSIox9NEXHXH8bnGshhgTJd3lTMGkdsKw6osZemnAmnvIZuIUf4QeVhIuK61aFx9DJ
         4A0B177HBE+1hwlIZXQPmFeZBBLOD7MHQJrTM+eub2QtGD7/sz+MPA7S/gRKSs8MF96Y
         Q9jg==
X-Gm-Message-State: AOPr4FVd8P6s6gT543qyTAHZxNTEyNSitjTjE9n+XtjNbaLugsqM9bJQ0AdMTpjAp6Z7pa+0j5FwCDJgKF29Ww==
X-Received: by 10.157.46.82 with SMTP id c18mr4354888otd.24.1461186633455;
 Wed, 20 Apr 2016 14:10:33 -0700 (PDT)
Received: by 10.202.201.82 with HTTP; Wed, 20 Apr 2016 14:10:03 -0700 (PDT)
In-Reply-To: <E90E5734-C130-42A4-9230-9C95A466C919@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292079>

Thanks! Some thoughts:

* One option on the Travis front would be to just test one combination
of the 1.1 build - e.g. linux + clang + 1.1, so you'll stay within the
5 parallel builds while also having some coverage on lfs 1.1.
* It might be risky to match on contentFile when looking for the
prefix - there could be expansions or other modifications applied by
git-lfs between input and output. I would think it a bit safer to just
match on the beginning of the line.
* Have you guys thought about splitting out git-p4? It seems like a
good candidate for an extension / add-on, and would remove the soft
git-lfs dependency.

Best,
Ben

On Wed, Apr 20, 2016 at 12:36 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On Wed, Apr 20, 2016 at 12:00 PM, Luke Diamand <luke@diamand.org> wrote:
>>> On 20 April 2016 at 19:28, Ben Woosley <Ben.Woosley@gmail.com> wrote:
>>>> From: Ben Woosley <ben.woosley@gmail.com>
>>>>
>>>> The git lfs pointer output was changed in:
>>>> https://github.com/github/git-lfs/pull/1105
>>>>
>>>> This was causing Mac Travis runs to fail, as homebrew had updated to 1.2
>>>> while Linux was pinned at 1.1 via GIT_LFS_VERSION.
>>>>
>>>> The travis builds against 1.1 and 1.2 both on linux. Mac can't do the same as
>>>> it takes the latest homebrew version regardless.
>>>
>>> Is this related to the very similar thread going on here:
>>>
>>> http://thread.gmane.org/gmane.comp.version-control.git/291917/focus=291926
>>>
>>> Thanks
>>> Luke
>
>
> On 20 Apr 2016, at 21:13, Ben Woosley <ben.woosley@gmail.com> wrote:
>
>> Yep it's addressing the same problem - I developed this independently
>> after having only viewed the github repo:
>> https://github.com/git/git/pull/231
>>
>> Things I like about my patch:
>> 1) it maintains ongoing support for git-lfs 1.1 by retaining it in the travis CI
>> 2) it's a fairly minimal intervention into the existing behavior
>>
>> Lars how about adding my Travis changes to your patch?
>> Here's a look at the CI output: https://travis-ci.org/git/git/builds/124105972
>>
>> Best,
>> Ben
>
>
> Thanks a lot for your fix! It's great to see other people than
> me actually using this feature :)
>
> I already sent a v2 with LFS 1.x support, too:
> http://article.gmane.org/gmane.comp.version-control.git/291993
> Would you mind reviewing it, too?
> Sorry for the duplicated work :-(
>
> Your Travis changes are 100% correct and a very nice way to ensure we
> support Git LFS 1.1 and Git LFS 1.2. Unfortunately we run all other Git
> tests twice which increases the overall build time a lot (because we
> can only run 5 build jobs in parallel with the free Travis CI plan).
> I am not sure if testing an outdated LFS version justifies the increased
> build times...
>
> Best,
> Lars
>
> PS: Please see Junio's comment regarding top posting:
> http://article.gmane.org/gmane.comp.version-control.git/291932
>
>>>
>>>
>>>
>>>> ---
>>>> .travis.yml | 9 ++++++++-
>>>> git-p4.py   | 7 ++++++-
>>>> 2 files changed, 14 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/.travis.yml b/.travis.yml
>>>> index 78e433b..71510ee 100644
>>>> --- a/.travis.yml
>>>> +++ b/.travis.yml
>>>> @@ -23,7 +23,6 @@ env:
>>>>   global:
>>>>     - DEVELOPER=1
>>>>     - P4_VERSION="15.2"
>>>> -    - GIT_LFS_VERSION="1.1.0"
>>>>     - DEFAULT_TEST_TARGET=prove
>>>>     - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>>>>     - GIT_TEST_OPTS="--verbose --tee"
>>>> @@ -31,6 +30,14 @@ env:
>>>>     # t9810 occasionally fails on Travis CI OS X
>>>>     # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
>>>>     - GIT_SKIP_TESTS="t9810 t9816"
>>>> +  matrix:
>>>> +    - GIT_LFS_VERSION="1.2.0"
>>>> +    - GIT_LFS_VERSION="1.1.0"
>>>> +
>>>> +matrix:
>>>> +  exclude:
>>>> +    - os: osx
>>>> +      env: GIT_LFS_VERSION="1.1.0"
>>>>
>>>> before_install:
>>>>   - >
>>>> diff --git a/git-p4.py b/git-p4.py
>>>> index 527d44b..6c06d17 100755
>>>> --- a/git-p4.py
>>>> +++ b/git-p4.py
>>>> @@ -1064,7 +1064,12 @@ def generatePointer(self, contentFile):
>>>>         if pointerProcess.wait():
>>>>             os.remove(contentFile)
>>>>             die('git-lfs pointer command failed. Did you install the extension?')
>>>> -        pointerContents = [i+'\n' for i in pointerFile.split('\n')[2:][:-1]]
>>>> +        pointerLines = pointerFile.split('\n')
>>>> +        # In git-lfs < 1.2, the pointer output included some extraneous information
>>>> +        # this was removed in https://github.com/github/git-lfs/pull/1105
>>>> +        if pointerLines[0].startswith('Git LFS pointer for'):
>>>> +            pointerLines = pointerLines[2:]
>>>> +        pointerContents = [i+'\n' for i in pointerLines[:-1]]
>>>>         oid = pointerContents[1].split(' ')[1].split(':')[1][:-1]
>>>>         localLargeFile = os.path.join(
>>>>             os.getcwd(),
>>>>
>>>> --
>>>> https://github.com/git/git/pull/231
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
