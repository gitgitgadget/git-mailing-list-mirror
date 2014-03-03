From: Conley Owens <cco3@android.com>
Subject: Re: [BUG] Halt during fetch on MacOS
Date: Mon, 3 Mar 2014 14:50:46 -0800
Message-ID: <CAFFUb6XE-5+VoZRs=-YSCBJMYoEi8C+KG7Lrr1B9NmmeOJOzEA@mail.gmail.com>
References: <CAFFUb6X455R4OD5FKnVFHFmvTyRqtV300bc=a8Xs03agM+=uLQ@mail.gmail.com>
	<3DC821FE-7330-4163-9E73-D3313B74E001@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Mon Mar 03 23:50:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbhE-0006JT-54
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418AbaCCWur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:50:47 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33776 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009AbaCCWuq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:50:46 -0500
Received: by mail-ie0-f177.google.com with SMTP id rl12so6757102iec.22
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 14:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20120917;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ndSlBEY4Ick5FJJMyHMe3FBG97vPWxbOC7nbYKE0A0E=;
        b=I66baNt1ExyJiWx95qPizOH1cF2r9qlwfmfiL0LQHKW9pSu0DtcnONXUhGg6jmlgQi
         pBqNVXHiYr6gLtSlcgB9cm3XwCxJF98uerLmjpbB9qvXrULZW0hw0yc3mXRG71V4ukt3
         65HtcZeVPalB3peGz9bWwGWWMHu2PzkdJi2671b/5Me8KCrCT7X4YfffjWvj3jBMb8Ox
         9BheOCHZI4hyDpktjpoNQavn+sc40Q5AWPLkVg7LrFqH5GSOT6mtD+BTcOZjKUEBk09p
         w1R2GH1ej+jTyCEpVQe9M7QL1mqxuPEzCNJmKapQ7ei8joUEOkmU7GIC4FjUDBQGEcMV
         nGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ndSlBEY4Ick5FJJMyHMe3FBG97vPWxbOC7nbYKE0A0E=;
        b=TJeDte7dnoYOKPEzqKWdiU7/NREjpRFiGQLGXfdF9eDdn3hZ1l7I/CirOhQRNGtMMy
         4qXhBxlZnEkFRuVRX9d+aPlR7eipc613zxYGKK+0Dp9fxtMiEKovceMTULq2U6fuCDRe
         7NPo1t+yr4PDCOnmPyED7dV4Lv9hRozpLRYc5/2/jVXKqhDBzx/1IQrPQyG4oBJl6suP
         hDA/j3Z++XOR34t9BCc82HUTMdYwnkDkmU29CU86jw2s7OMmrqsNJEDKXWAiadWzNsz/
         fcWnSdlkrn3kTrfaBV2ccicNRGiSAIX76mFFC1CatKGNCNpRvzguoM56nOzRV5p7i/pt
         N98A==
X-Gm-Message-State: ALoCoQnt/2c+OyENGW0n3umg0S7mTkzYUDDRMrGWfPQ9U2J8G2umO59NiB7vrv9SBXORlqSnuQVO
X-Received: by 10.51.17.40 with SMTP id gb8mr25428673igd.18.1393887046136;
 Mon, 03 Mar 2014 14:50:46 -0800 (PST)
Received: by 10.64.145.101 with HTTP; Mon, 3 Mar 2014 14:50:46 -0800 (PST)
In-Reply-To: <3DC821FE-7330-4163-9E73-D3313B74E001@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243297>

On Sun, Mar 2, 2014 at 6:36 AM, Max Horn <max@quendi.de> wrote:
>
> On 01.03.2014, at 00:26, Conley Owens <cco3@android.com> wrote:
>
>> $ git --version  # This is just the git from MacPorts
>> git version 1.8.5.5
>> $ sw_vers
>> ProductName:    Mac OS X
>> ProductVersion: 10.8.5
>> BuildVersion:   12F45
>
> I cannot reproduce this, neither with 1.8.5.5 nor with 1.9.0. I am also running Mac OS X 10.8.5.
>
> Note: I tried this both with you original test.sh, and also with a version were I replaced the ">" by ">>", as per Jeff's suggestion. It (as predicted) didn't make any difference).
>
> If this is a race condition, it might be easier to trigger it on slower hardware. I am running this on a 2012 MBP with 2.3 Ghz i7 and an SSD. What is your test machine?

Mac mini i7 with 1TB fusion drive and 16GB ram.

It also seemed to trigger more when grabbing larger repositories.
Replace"external/tinyxml2" with "docs/source.android.com" and you
might be more likely to trigger the issue.  You can also try
increasing the number of processes to spawn from 100 to 150.

>
>
> Cheers,
> Max
>
>>
>> test.sh
>> """""""""""""""""""""""""""""""""""""
>> #!/bin/bash
>> rungit() {
>>    mkdir $1
>>    GIT_DIR=$1 git init --bare
>>    echo '[remote "aosp"]' > $1/config
>>    echo '    url =
>> https://android.googlesource.com/platform/external/tinyxml2' >>
>> $1/config
>>    GIT_DIR=$1 git fetch aosp +refs/heads/master:refs/remotes/aosp/master
>>    rm -rf $1
>> }
>>
>> for i in $(seq 1 100)
>> do
>>    rungit testdir$i &
>> done
>> """""""""""""""""""""""""""""""""""""""
>> $ ./test.sh  # Warning! This script fetches ~40MB of data
>>
>> When everything cools, you can see that there are some fetches hanging
>> (typically).
>> $ ps | grep 'git fetch'
>> ...
>> 63310 ttys004    0:00.01 git fetch aosp
>> +refs/heads/master:refs/remotes/aosp/master
>> 63314 ttys004    0:00.01 git fetch aosp
>> +refs/heads/master:refs/remotes/aosp/master
>> 63319 ttys004    0:00.01 git fetch aosp
>> +refs/heads/master:refs/remotes/aosp/master
>> 63407 ttys004    0:00.00 git fetch aosp
>> +refs/heads/master:refs/remotes/aosp/master
>> 63414 ttys004    0:00.00 git fetch aosp
>> +refs/heads/master:refs/remotes/aosp/master
>> 63420 ttys004    0:00.00 git fetch aosp
>> +refs/heads/master:refs/remotes/aosp/master
>> ...
>>
>> You can look at the parent process of each and see that one half
>> spawned the other half, or you can look at the environment variables
>> for each to see that there are two processes operating in the same
>> directory for each directory where there's an issue.
>> $ echo "$(for pid in $(ps | grep 'git fetch' | grep -o '^[0-9]*'); do
>> ps -p $pid -wwwE | grep 'GIT_DIR=[^ ]*' -o; done)" | sort
>> GIT_DIR=testdir14
>> GIT_DIR=testdir14
>> GIT_DIR=testdir32
>> GIT_DIR=testdir32
>> GIT_DIR=testdir47
>> GIT_DIR=testdir47
>>
>> I've searched through the mailing list, but this doesn't seem to be a
>> known issue.  I've only seen this occur on macs (and with a good deal
>> of regularity).  It doesn't occur on my Ubuntu box.
>>
>> ~cco3
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
