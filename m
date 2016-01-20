From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Wed, 20 Jan 2016 10:04:44 +0100
Message-ID: <711209F5-E034-459E-8E85-BF8BC32B2E86@gmail.com>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com> <xmqqmvs19w5n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 10:05:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLohL-00035M-Ua
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 10:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933861AbcATJE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 04:04:59 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38111 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283AbcATJEs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2016 04:04:48 -0500
Received: by mail-wm0-f51.google.com with SMTP id b14so17886572wmb.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 01:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Z6e8nsNUlrP77G6tx7XK1rpcBDCIVRtYL0T1xmS2x+Y=;
        b=jb+bqQay/Zd+w4EOgLfmjFeYE72lwvTUGLguD/Ivy7D2QNAJYn1FoVKHCGlVcyz4dJ
         cuCNziXcvnptZhslU0ixYHH3sxXyX4D7L6dS2xwEwJaXVGctmduwv3OXLtLH+3PhZx55
         YZnJ7NTSlWSG/aBT5VSuk/iqCJj2OFVFoGY99vOrEVz4EiVtDu7Z5Cf9H4nHBZNyQSol
         LOVWYx0r8P3fCMXBF0T5QcVfocg+KeLfSJEN9RXKfqthooqDlLjB5Ek8iSKA363xN+kN
         MdxAZZBY09xERJJLTyq++ui0aaAtEiu3v7d3nesInrKtl88wlwOj+jvZb8D+LXVL+eTP
         zihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=Z6e8nsNUlrP77G6tx7XK1rpcBDCIVRtYL0T1xmS2x+Y=;
        b=ktGfzyfdeL2rRbc5uSS5TfdOwY4l5udqWGGVnGsXIwao5AaFFsIGDahEiTNtNUSAY/
         kKyLwfG+9Teug57u9EZOBlOmleU79EwoEMsfVYxSaK0PNf1uPKAbDm+tuF+k/nizos/v
         kYMAblIeqnfJC6mlLpMd5eP1g6pmvBcwJOoSOcJJkS00waZsbMjAqfMH21yjqJH5hy+v
         UN9ZXXiGKS7ax1+I5O+Jn/f/9CyK4sExRbnqlU5cP6wDPPdiqaKc+xYwnJyorizCDPSU
         TkcUjwoLcmNL7V35q+Cytc1gEb4BOLcYO4q6nSeRdXOMyzjzT5xTMui2TYm6xNSEe/sv
         qrxg==
X-Gm-Message-State: AG10YOS8Juv7pDf/dxpcGz9VrKk6aWJ49dEFaNeAr2/XAveXHivwSlM1DEo+xwDRywLlsQ==
X-Received: by 10.28.224.134 with SMTP id x128mr2857702wmg.62.1453280686519;
        Wed, 20 Jan 2016 01:04:46 -0800 (PST)
Received: from slxbook3.fritz.box (p508BA58E.dip0.t-ipconnect.de. [80.139.165.142])
        by smtp.gmail.com with ESMTPSA id 73sm24080555wmm.7.2016.01.20.01.04.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 01:04:45 -0800 (PST)
In-Reply-To: <xmqqmvs19w5n.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284431>


On 19 Jan 2016, at 21:00, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Use the Travis-CI cache feature to store prove test results and make them
>> available in subsequent builds. This allows to run previously failed tests
>> first and run remaining tests in slowest to fastest order. As a result it
>> is less likely that Travis-CI needs to wait for a single test at the end
>> which speeds up the test suite execution by ~2 min.
>> 
>> Unfortunately the cache feature is only available (for free) on the
>> Travis-CI Linux environment.
>> 
>> Suggested-by: Jeff King <peff@peff.net>
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> .travis.yml | 8 +++++++-
>> 1 file changed, 7 insertions(+), 1 deletion(-)
> 
> This is cute, but isn't it useful even outside Travis's context?  I
> am not suggesting to touch anything other than .travis.yml file in
> this patch, but if I wanted to get the benefit from the idea in this
> patch when I run my tests manually, I can just tell prove to use the
> cached states, no?
> 
> IOW, I am confused by the beginning of the log message that says
> this is taking advantage of "the Travis-CI cache feature".  This
> improvement looks to me like using the feature of "prove" that
> allows us to run slower tests first, and does not have much to do
> with Travis.
> 
> You are relying on the assumption that things under $HOME/ is stable
> while things under t/ (or in our source tree in general) are not,
> and I think that is a sensible thing to take advantage of, but are
> we sure that they are running in an environment where "ln -s" would
> work?  Otherwise, it may be more robust to copy $HOME/.prove to
> t/.prove before starting to test and then copy it back once the
> tests are done.

OK, looks like my wording was not ideal. One important thing to know is that 
$HOME is *not* stable. These TravisCI machines start *always* in a completely 
clean state. That's why prove cannot store and use it's cache. With the following 
statement I instruct Travis to cache my ".prove-cache" directory. As a consequence
Travis CI will automatically restore this directory whenever it starts a new instance
for the git job. It will also save the content of this directory when the job is done.

>> +cache:
>> +  directories:
>> +    - $HOME/.prove-cache

The Travis CI cache works only on a directory basis. Since I don't want to cache
the entire /t directory I came up with the $HOME/.prove-cache directory. I also used
a file link to leverage the automated save/restore feature for the $HOME/.prove-cache
directory. If I would not use a link then I would need to copy the updated .prove file 
from t/ to .prove-cache after the test run.

Would the following first sentence for the commit message be less ambiguous?

"Use the Travis-CI cache feature to make the prove test results cache persistent 
across subsequent build jobs. This allows to run previously..."

Thanks,
Lars


>> 
>> diff --git a/.travis.yml b/.travis.yml
>> index c3bf9c6..f34726b 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -1,5 +1,9 @@
>> language: c
>> 
>> +cache:
>> +  directories:
>> +    - $HOME/.prove-cache
>> +
>> os:
>>   - linux
>>   - osx
>> @@ -18,7 +22,7 @@ env:
>>     - P4_VERSION="15.2"
>>     - GIT_LFS_VERSION="1.1.0"
>>     - DEFAULT_TEST_TARGET=prove
>> -    - GIT_PROVE_OPTS="--timer --jobs 3"
>> +    - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>>     - GIT_TEST_OPTS="--verbose --tee"
>>     - CFLAGS="-g -O2 -Wall -Werror"
>>     - GIT_TEST_CLONE_2GB=YesPlease
>> @@ -67,6 +71,8 @@ before_install:
>>     p4 -V | grep Rev.;
>>     echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)";
>>     git-lfs version;
>> +    mkdir -p $HOME/.prove-cache;
>> +    ln -s $HOME/.prove-cache/.prove t/.prove;
>> 
>> before_script: make --jobs=2
>> 
>> --
>> 2.5.1
