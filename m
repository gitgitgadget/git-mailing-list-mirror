From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Git status reports untracked on tracked files
Date: Tue, 04 Jun 2013 18:39:18 +0200
Message-ID: <51AE1836.7060701@gmail.com>
References: <CAO-zUnh4018FSnsXzX4gLw-4AnWsKgEiZ5P4pktjxNokargQwA@mail.gmail.com> <20130603222618.GA26180@sigill.intra.peff.net> <CAO-zUniGNqxLJ9JrRMtfGF7O52sQsrGBoh0HJf+zh0czwt7ETQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Andrey Kiyanovsky <andrey.kiyanovsky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 18:39:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjuGZ-0000Yj-KP
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 18:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844Ab3FDQjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 12:39:20 -0400
Received: from mail-bk0-f52.google.com ([209.85.214.52]:49931 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab3FDQjS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 12:39:18 -0400
Received: by mail-bk0-f52.google.com with SMTP id e11so303345bkh.11
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KV0UuV2bLsSfO7auMGnIYjN7aIwjIg4n072FcZjhXOg=;
        b=LH+23vC1k7XBfzGuO3GTCOqLvO//5RS+PKicWxvmkMZAgdCks6/tbZHmh1EiYPhvt2
         VjDiQH9pmSWa7JJFLhXe7z1NShkKRhyv9D1mbXfyWQXv8RFX3STPNfQE2IHLDBd0YBsC
         JC2KuAyEel18WeqyMfk6WQRH06CuP1BfHghavNsM8KSlNRvSlCMvpPMfZg9nkXmYTrSR
         m7RV5TpNI78I7GgRiaOIWNWarm3iF0mldMjU3EWzQGAJIgsN2eXTA1M4AMUsfhwCwJYM
         mARIDe8QJ+iiQaZAxT9Vsvg7Ec5oMym9czC66RKYydi3TC9FLyQq2tXio9KdbN+mo6aX
         Nnsw==
X-Received: by 10.205.17.193 with SMTP id qd1mr8219406bkb.88.1370363957602;
        Tue, 04 Jun 2013 09:39:17 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id jm15sm23665865bkb.13.2013.06.04.09.39.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 09:39:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CAO-zUniGNqxLJ9JrRMtfGF7O52sQsrGBoh0HJf+zh0czwt7ETQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226376>

Am 04.06.2013 11:05, schrieb Andrey Kiyanovsky:
> I have tried Git 1.8.3 for Windows. Case is fixed. Thank you very much!
> 
> 2013/6/4 Jeff King <peff@peff.net>:
>> On Wed, May 29, 2013 at 11:40:56AM +0300, Andrey Kiyanovsky wrote:
>>
>>> Git version 1.8.1.2. for Windows
>>>
>>> Git config:
>>>
>>> [core]
>>>       repositoryformatversion = 0
>>>       filemode = false
>>>       bare = false
>>>       logallrefupdates = true
>>>       symlinks = false
>>>       ignorecase = true
>>>       hideDotFiles = dotGitOnly
>>>       compression = 1
>>
>> In the past there have been some problems with status listings of
>> untracked files when core.ignorecase is in use. I fixed some cases with
>> a commit that went into v1.7.8, but some problems remained. Karsten
>> Blees (cc'd) did some work that went into git v1.8.1.6, but I do not
>> know off-hand if it would fix your case or not.
>>

Yep, the hash collision bug can definitely cause this with ignorecase=true, glad it helped.

Another case in which Git for Windows will report tracked files as untracked is if you upgrade from < 1.7.10 with non-ASCII file names in the repository. Particularly annoying are hyphens (\u00ad), which look just like ASCII minus (\u002d). See [1] for details.

[1] https://github.com/msysgit/msysgit/wiki/Git-for-Windows-Unicode-Support
