From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: Re: is it possible filter the revision history of a single file into another repository?
Date: Thu, 18 Dec 2008 14:51:38 -0500
Message-ID: <8ec76080812181151y4a5a6f5cna57785c935032e77@mail.gmail.com>
References: <8ec76080812180551p8c97a0dqa2025e67792946c7@mail.gmail.com>
	 <200812181504.02105.thomas.jarosch@intra2net.com>
	 <8ec76080812180619k78a28e30t591b514148202869@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Thomas Jarosch" <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 20:58:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDP15-00035R-Pb
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 20:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbYLRT5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 14:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbYLRT5V
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 14:57:21 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:13995 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbYLRT5U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 14:57:20 -0500
Received: by yw-out-2324.google.com with SMTP id 9so238725ywe.1
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 11:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tjslZPfHa0t7hffScacs5WtdXn+qh1PSA0vEvsooyRc=;
        b=i5MQz4oUSMX4P6o3jZ9/MbH5s0eeodKncgQEYef3m4G666rC4/ZV1zujWjsHrzXwhf
         WoGcikUce8Y4pvQYCxWIOCse5KjQZGR3A+WxAz5vSXQE+FRLe44D30NjWsDFt03ok68L
         nqNFWmN6YBmTkYGDmmtWaIKCDA8x0bwXuquJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mIHXa5uZaikvbPziVyqEqCMgHvg0Tnq2ii/VuZb7SPfuM1TsVIAF+CwcZaWs9DJUb3
         mRzBRZxA8SDmHM2LOGqdDY2KCSssBvd1fEWP9CObVG/ZW8Wh1kTjHvDaSywEwAsOq2JZ
         fyHJehFC4GY7gwqg2MwOuc7YjVW13OUAFo1iU=
Received: by 10.151.109.11 with SMTP id l11mr2606021ybm.71.1229629898598;
        Thu, 18 Dec 2008 11:51:38 -0800 (PST)
Received: by 10.151.136.2 with HTTP; Thu, 18 Dec 2008 11:51:38 -0800 (PST)
In-Reply-To: <8ec76080812180619k78a28e30t591b514148202869@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103486>

Sorry, seem to be getting this error:
`/home/whit/dvl/risk.metrics.utils/RiskMetrics/.git-rewrite/t/../index.new':
No such file or directory

do I need to set up the index file first?

Is there a good site that documents this procedure?

[whit@linuxsvr RiskMetrics]$ git filter-branch --tag-name-filter cat
--index-filter \
>    'git ls-files -s |grep -P "riskmetrics.rb" \
>    |GIT_INDEX_FILE=$GIT_INDEX_FILE.new git update-index --index-info &&
>    mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' -- --all
Rewrite 8f1a0eaae033d109f4a3a4b410bd8e04dd9997db (1/481)mv: cannot
stat `/home/whit/dvl/risk.metrics.utils/RiskMetrics/.git-rewrite/t/../index.new':
No such file or directory
index filter failed: git ls-files -s |grep -P "riskmetrics.rb" \
   |GIT_INDEX_FILE=$GIT_INDEX_FILE.new git update-index --index-info &&
   mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE
[whit@linuxsvr RiskMetrics]$



On Thu, Dec 18, 2008 at 9:19 AM, Whit Armstrong
<armstrong.whit@gmail.com> wrote:
> thanks, I will give this a try.
>
> On Thu, Dec 18, 2008 at 9:04 AM, Thomas Jarosch
> <thomas.jarosch@intra2net.com> wrote:
>> On Thursday, 18. December 2008 14:51:12 Whit Armstrong wrote:
>>> For instance, if my repository contains foo.c, and 100 other files.
>>>
>>> I would like to create a new and separate repository containing only
>>> the revision history of foo.c.
>>>
>>> Would someone mind pointing me at some documentation for this
>>> procedure if it exists?
>>
>> This worked for me:
>>
>> git filter-branch --tag-name-filter cat --index-filter \
>>    'git ls-files -s |grep -P "\t(DIR1|DIR2)" \
>>    |GIT_INDEX_FILE=$GIT_INDEX_FILE.new git update-index --index-info &&
>>    mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' -- --all
>>
>> Run "git ls-files -s" to see the output format.
>> Replace the "DIR1|DIR2" with "foo.c".
>>
>> Later on you might want to remove empty commits from the history:
>> git filter-branch --tag-name-filter cat --commit-filter 'if [ z$1 = z`git rev-parse $3^{tree}` ]; then skip_commit "$@"; else git commit-tree "$@"; fi' "$@" -- --all
>>
>> If you want to run two filter-branch commands in a row
>> or you want to free up the space in .git afterwards:
>>
>> - git for-each-ref --format='%(refname)' refs/original | xargs -i git update-ref -d {}
>> - git reflog expire --expire=0 --all
>> - git repack -a -d
>> - git prune
>>
>> Cheers,
>> Thomas
>>
>>
>
