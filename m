From: Ben Woosley <ben.woosley@gmail.com>
Subject: Re: [PATCH] Update git-p4 to be compatible with git-lfs 1.2
Date: Wed, 20 Apr 2016 12:13:21 -0700
Message-ID: <CAC5gnOx1ZbNnYzMYYfD5TkXkgHAz7qgOTVCEiu2D0PA-MZLrvQ@mail.gmail.com>
References: <0102015434ee502d-d91a9a46-299f-47b0-a583-104b540200bc-000000@eu-west-1.amazonses.com>
 <CAE5ih79A2D8xTi9MuOYJ=dU12P5hOsLbw+XXptcnhAATwZvBCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>, larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 20 21:14:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asxZb-0004d0-30
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 21:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbcDTTNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 15:13:54 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33167 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbcDTTNw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 15:13:52 -0400
Received: by mail-oi0-f53.google.com with SMTP id r78so51110139oie.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 12:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HvQq0SXaZ4RZaeeUWWlGpshJRmTNZZrjgaKdcBmbxpA=;
        b=ymACinT8bIjRdNmcvU/qo76aarD4dvhcu8DHUdHA5H9nD+NB/RWwjrLYjkECUgwXBZ
         tQjzfUU0TNsYgYRef6ayos1AEFtHbAIAvMb8CQnUdOgZv48TQJmgPJOpW5mnfps4Wqo9
         1QWRnjB9DECceCRiHDaQVWJwBPitpJM44HTRstND+SdSC3cZf6Amaluvxaim8T1UhlR7
         fBxkZnV4Yz61aZs03j/epdTsvzOHjsY5hchbtgYOrx9onG40CDTnKZ8c4OXGbaCEEQ0y
         msUtAfjIxjsSUJBlFkCo2Biw1PoR/hTzFMkyUSWQDR31fsQYnNH2fBORPqilRhFsUqOj
         we7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HvQq0SXaZ4RZaeeUWWlGpshJRmTNZZrjgaKdcBmbxpA=;
        b=b1tudq/54yMDz90NHXZmvzMQR1gbcr+8hozUiKcs9TxB51GPFxAIpSUAG/Cu7PJn2Y
         cXHQge6A6jj2RytHhpSZoOeL+scxftKNywHgVsg0nwf77KD88ON9/67hlEGUIdjFy0Ht
         WEGr3jag2Wqk3AVSHJrZxjn0ifOhxF4l8hL2+XseGVB4HxWsNkcNHpxpCCNX3nX8YRob
         6KN7lJahpE0vfkJk/HtWwV3M+FhiBHJpsLULcKm4JwGVrlW68umE4Ha3uuHx64L5OEfz
         DGuof/cGy+jY3uSRhHKBdJWKxRNX/zBVGgvzzKZmQEsnds4pDVJZb1o8ql01mjbGzRRe
         fLTQ==
X-Gm-Message-State: AOPr4FVTnqbXwZ67qDIQHwdBg9AuWx/+Uy7tXPv9hLXBIWnGoS3DhhKKN+ELCUD4O6utDNLLNGd0mkTGS64r0w==
X-Received: by 10.60.103.132 with SMTP id fw4mr4743996oeb.26.1461179631481;
 Wed, 20 Apr 2016 12:13:51 -0700 (PDT)
Received: by 10.202.201.82 with HTTP; Wed, 20 Apr 2016 12:13:21 -0700 (PDT)
In-Reply-To: <CAE5ih79A2D8xTi9MuOYJ=dU12P5hOsLbw+XXptcnhAATwZvBCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292059>

Yep it's addressing the same problem - I developed this independently
after having only viewed the github repo:
https://github.com/git/git/pull/231

Things I like about my patch:
1) it maintains ongoing support for git-lfs 1.1 by retaining it in the travis CI
2) it's a fairly minimal intervention into the existing behavior

Lars how about adding my Travis changes to your patch?
Here's a look at the CI output: https://travis-ci.org/git/git/builds/124105972

Best,
Ben

On Wed, Apr 20, 2016 at 12:00 PM, Luke Diamand <luke@diamand.org> wrote:
> On 20 April 2016 at 19:28, Ben Woosley <Ben.Woosley@gmail.com> wrote:
>> From: Ben Woosley <ben.woosley@gmail.com>
>>
>> The git lfs pointer output was changed in:
>> https://github.com/github/git-lfs/pull/1105
>>
>> This was causing Mac Travis runs to fail, as homebrew had updated to 1.2
>> while Linux was pinned at 1.1 via GIT_LFS_VERSION.
>>
>> The travis builds against 1.1 and 1.2 both on linux. Mac can't do the same as
>> it takes the latest homebrew version regardless.
>
> Is this related to the very similar thread going on here:
>
> http://thread.gmane.org/gmane.comp.version-control.git/291917/focus=291926
>
> Thanks
> Luke
>
>
>
>> ---
>>  .travis.yml | 9 ++++++++-
>>  git-p4.py   | 7 ++++++-
>>  2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 78e433b..71510ee 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -23,7 +23,6 @@ env:
>>    global:
>>      - DEVELOPER=1
>>      - P4_VERSION="15.2"
>> -    - GIT_LFS_VERSION="1.1.0"
>>      - DEFAULT_TEST_TARGET=prove
>>      - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>>      - GIT_TEST_OPTS="--verbose --tee"
>> @@ -31,6 +30,14 @@ env:
>>      # t9810 occasionally fails on Travis CI OS X
>>      # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
>>      - GIT_SKIP_TESTS="t9810 t9816"
>> +  matrix:
>> +    - GIT_LFS_VERSION="1.2.0"
>> +    - GIT_LFS_VERSION="1.1.0"
>> +
>> +matrix:
>> +  exclude:
>> +    - os: osx
>> +      env: GIT_LFS_VERSION="1.1.0"
>>
>>  before_install:
>>    - >
>> diff --git a/git-p4.py b/git-p4.py
>> index 527d44b..6c06d17 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -1064,7 +1064,12 @@ def generatePointer(self, contentFile):
>>          if pointerProcess.wait():
>>              os.remove(contentFile)
>>              die('git-lfs pointer command failed. Did you install the extension?')
>> -        pointerContents = [i+'\n' for i in pointerFile.split('\n')[2:][:-1]]
>> +        pointerLines = pointerFile.split('\n')
>> +        # In git-lfs < 1.2, the pointer output included some extraneous information
>> +        # this was removed in https://github.com/github/git-lfs/pull/1105
>> +        if pointerLines[0].startswith('Git LFS pointer for'):
>> +            pointerLines = pointerLines[2:]
>> +        pointerContents = [i+'\n' for i in pointerLines[:-1]]
>>          oid = pointerContents[1].split(' ')[1].split(':')[1][:-1]
>>          localLargeFile = os.path.join(
>>              os.getcwd(),
>>
>> --
>> https://github.com/git/git/pull/231
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
