From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] Update git-p4 to be compatible with git-lfs 1.2
Date: Wed, 20 Apr 2016 21:36:16 +0200
Message-ID: <E90E5734-C130-42A4-9230-9C95A466C919@gmail.com>
References: <0102015434ee502d-d91a9a46-299f-47b0-a583-104b540200bc-000000@eu-west-1.amazonses.com> <CAE5ih79A2D8xTi9MuOYJ=dU12P5hOsLbw+XXptcnhAATwZvBCQ@mail.gmail.com> <CAC5gnOx1ZbNnYzMYYfD5TkXkgHAz7qgOTVCEiu2D0PA-MZLrvQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
To: Ben Woosley <ben.woosley@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 21:36:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asxvJ-0003f9-Ny
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 21:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbcDTTgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 15:36:24 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37778 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbcDTTgV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2016 15:36:21 -0400
Received: by mail-wm0-f49.google.com with SMTP id n3so98604571wmn.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9UShlLFLjvE54Z9+Tx34PmwEUnhx3e4Osk/IKVJttLI=;
        b=f2OjxGwgoudT6LdYx7KTTyNucLa9wdbF5ELZQke5CZZNQ8qzaWF8qtq0WP07qadwCf
         2s6ka7OvISlHda63JeX7vOCphMxYFN7gf4EK534kaOnJl0Swh9Y9feHRDJP+nvUnmMfx
         syjdVE87H/0v615o7OjOXVsCrPCSrSvD920kx0tf3RuaxSXCFBIuBo61tmUJuKqHuv8H
         SCuvA+tUDglrGKMX7Q8Th7L7Hr2I1bw+9yXXR7LZMASB7t1K1qIIQ1HkFZqWJXsLiTTj
         G0sRYJPClh8yp3KZvbCxm7UOWRyDwQ0BLpjmyBXfEpSh7EjU38prv4RSfyUg93Cud/NQ
         GXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9UShlLFLjvE54Z9+Tx34PmwEUnhx3e4Osk/IKVJttLI=;
        b=Xkcufw2VDLEnvGEbqiVWpqcESHTlyeW6vxzgpiwLqf+t6sSe9AHys4pfntMBdCkrC5
         BcIFjzFmCCiw/g5ZfYm9LUNGNq9NgM4ZwYjy0xM0MoA1oQ6OwxJIBsi+EqpJ2O4WApwJ
         29CdHGEjRtzi/DHUCgBRL//Lhlc0CI7CNBABgCAYrmO+QXQkkE6uIHuo6SpM+0tQv5nx
         5KK88yfbEd6skz/xgbs8DOCI94IqpqjMnkjBwlVzjsepovAdc49MLzpKWTVCSHmmIIKT
         zz5gLKsidkTwd+ogMJtNoCULMms+knMsrnTi0u7nbJfLmGeSZEzkX4SxE3StivKCYs5S
         Us/g==
X-Gm-Message-State: AOPr4FXQDSCpZxjJPi4pSy1G2IMV7743f08+af7dQJqVfMP7FUwyCNtvUJEsaGm/iIWs0g==
X-Received: by 10.28.167.13 with SMTP id q13mr11755402wme.55.1461180980142;
        Wed, 20 Apr 2016 12:36:20 -0700 (PDT)
Received: from slxbook3.fritz.box (p508BAD5D.dip0.t-ipconnect.de. [80.139.173.93])
        by smtp.gmail.com with ESMTPSA id l124sm11101352wmf.11.2016.04.20.12.36.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Apr 2016 12:36:19 -0700 (PDT)
In-Reply-To: <CAC5gnOx1ZbNnYzMYYfD5TkXkgHAz7qgOTVCEiu2D0PA-MZLrvQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292060>


> On Wed, Apr 20, 2016 at 12:00 PM, Luke Diamand <luke@diamand.org> wrote:
>> On 20 April 2016 at 19:28, Ben Woosley <Ben.Woosley@gmail.com> wrote:
>>> From: Ben Woosley <ben.woosley@gmail.com>
>>> 
>>> The git lfs pointer output was changed in:
>>> https://github.com/github/git-lfs/pull/1105
>>> 
>>> This was causing Mac Travis runs to fail, as homebrew had updated to 1.2
>>> while Linux was pinned at 1.1 via GIT_LFS_VERSION.
>>> 
>>> The travis builds against 1.1 and 1.2 both on linux. Mac can't do the same as
>>> it takes the latest homebrew version regardless.
>> 
>> Is this related to the very similar thread going on here:
>> 
>> http://thread.gmane.org/gmane.comp.version-control.git/291917/focus=291926
>> 
>> Thanks
>> Luke


On 20 Apr 2016, at 21:13, Ben Woosley <ben.woosley@gmail.com> wrote:

> Yep it's addressing the same problem - I developed this independently
> after having only viewed the github repo:
> https://github.com/git/git/pull/231
> 
> Things I like about my patch:
> 1) it maintains ongoing support for git-lfs 1.1 by retaining it in the travis CI
> 2) it's a fairly minimal intervention into the existing behavior
> 
> Lars how about adding my Travis changes to your patch?
> Here's a look at the CI output: https://travis-ci.org/git/git/builds/124105972
> 
> Best,
> Ben


Thanks a lot for your fix! It's great to see other people than
me actually using this feature :)

I already sent a v2 with LFS 1.x support, too:
http://article.gmane.org/gmane.comp.version-control.git/291993
Would you mind reviewing it, too?
Sorry for the duplicated work :-(

Your Travis changes are 100% correct and a very nice way to ensure we 
support Git LFS 1.1 and Git LFS 1.2. Unfortunately we run all other Git
tests twice which increases the overall build time a lot (because we
can only run 5 build jobs in parallel with the free Travis CI plan).
I am not sure if testing an outdated LFS version justifies the increased
build times...

Best,
Lars

PS: Please see Junio's comment regarding top posting:
http://article.gmane.org/gmane.comp.version-control.git/291932

>> 
>> 
>> 
>>> ---
>>> .travis.yml | 9 ++++++++-
>>> git-p4.py   | 7 ++++++-
>>> 2 files changed, 14 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 78e433b..71510ee 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -23,7 +23,6 @@ env:
>>>   global:
>>>     - DEVELOPER=1
>>>     - P4_VERSION="15.2"
>>> -    - GIT_LFS_VERSION="1.1.0"
>>>     - DEFAULT_TEST_TARGET=prove
>>>     - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>>>     - GIT_TEST_OPTS="--verbose --tee"
>>> @@ -31,6 +30,14 @@ env:
>>>     # t9810 occasionally fails on Travis CI OS X
>>>     # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
>>>     - GIT_SKIP_TESTS="t9810 t9816"
>>> +  matrix:
>>> +    - GIT_LFS_VERSION="1.2.0"
>>> +    - GIT_LFS_VERSION="1.1.0"
>>> +
>>> +matrix:
>>> +  exclude:
>>> +    - os: osx
>>> +      env: GIT_LFS_VERSION="1.1.0"
>>> 
>>> before_install:
>>>   - >
>>> diff --git a/git-p4.py b/git-p4.py
>>> index 527d44b..6c06d17 100755
>>> --- a/git-p4.py
>>> +++ b/git-p4.py
>>> @@ -1064,7 +1064,12 @@ def generatePointer(self, contentFile):
>>>         if pointerProcess.wait():
>>>             os.remove(contentFile)
>>>             die('git-lfs pointer command failed. Did you install the extension?')
>>> -        pointerContents = [i+'\n' for i in pointerFile.split('\n')[2:][:-1]]
>>> +        pointerLines = pointerFile.split('\n')
>>> +        # In git-lfs < 1.2, the pointer output included some extraneous information
>>> +        # this was removed in https://github.com/github/git-lfs/pull/1105
>>> +        if pointerLines[0].startswith('Git LFS pointer for'):
>>> +            pointerLines = pointerLines[2:]
>>> +        pointerContents = [i+'\n' for i in pointerLines[:-1]]
>>>         oid = pointerContents[1].split(' ')[1].split(':')[1][:-1]
>>>         localLargeFile = os.path.join(
>>>             os.getcwd(),
>>> 
>>> --
>>> https://github.com/git/git/pull/231
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
