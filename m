From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC] How to pass Git config command line instructions to
 Submodule commands?
Date: Mon, 25 Apr 2016 13:59:03 -0700
Message-ID: <CA+P7+xoaqNF+uBHVnD2QR7j-=0Hyvd-scTc_vOdV+etC0VS9jA@mail.gmail.com>
References: <60724588-B06E-47E8-9302-8709C4601826@gmail.com> <CAGZ79kYmAr-O6_Jw2KO9eZEfZQ+_WBiERF=nhOYLJCZpUjSSyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 22:59:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aunbO-0007N6-8f
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 22:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbcDYU7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 16:59:25 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35265 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933466AbcDYU7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 16:59:24 -0400
Received: by mail-ob0-f174.google.com with SMTP id n10so76783444obb.2
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 13:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2Md+n+CtNxJPEW8dYE7EdGXrXQ/xeyHwPesFdZ+r8f8=;
        b=BVsVT9fRRWX/BKzRrqasX6u35DZzMqZYNIOutap7NCQ5+A/p9bQZo4Hg4XbaLtHX96
         8IxzpLuCPRkB4mFNBow+89SO0hsUwUGgseNySdGl8eQv42WvZORtxjgnfK19bzjD7sZZ
         C1KZjJC9nFUsk1BsI5seEWJkRa0+m7GgENlS/e5G4LF2zb0rkiOJXc7Rc/YG0y4CvzTF
         O4uQCSbNlpIr1FYThAqZkZ+T645whdgWmf8RjmviH0LdJOTF3YVY0OZwjsqxiy03z2rW
         qZs1/GMIIcjOtZ8taH4lXv/RvdfFp+sWr8nz20o1s2GB+jm/kDu4Dkk7qtjIx2Shz7XC
         uMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2Md+n+CtNxJPEW8dYE7EdGXrXQ/xeyHwPesFdZ+r8f8=;
        b=LbhDy/A1nxawrQW87ijA7rzaJ7n+IhSFbVgpVyu8sgITydaV4SHkV42eGhr8migSRT
         pIO0CDOuPOgXfcXkgYleJagH7tiPoxDYbmFLEfQo6L7TeO0ZyP1Jdk1kUYbUBkrXCAPK
         TwJq7dN62TTL9UTC6ZNCJgoWUoWVRZ7Pdz3zbEdQovmcwNpAfCqqLPGWGF520mT6ns7z
         VBLLKRVO3jh/IlQZPtPUkFRD1OUSo3AtU8iowH6x76qXkUdJzpJakyNMO/bDuG+p+tow
         kSs9hc6fODnKvY+piFFm0iPjQSz0CqFzOEgoun7c5cdPiiKoJ/0qW0BqWWir7yCrnZnR
         ZMcQ==
X-Gm-Message-State: AOPr4FU+4h/MGYUYUAw+4XRepWRnEl9gXMUHbyEBiilwyI8Eiz/ZsbNYCNvoSkrC6wraujFKWuJ9Zgm+S027sg==
X-Received: by 10.60.94.40 with SMTP id cz8mr16213667oeb.65.1461617962917;
 Mon, 25 Apr 2016 13:59:22 -0700 (PDT)
Received: by 10.182.117.132 with HTTP; Mon, 25 Apr 2016 13:59:03 -0700 (PDT)
In-Reply-To: <CAGZ79kYmAr-O6_Jw2KO9eZEfZQ+_WBiERF=nhOYLJCZpUjSSyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292555>

On Mon, Apr 25, 2016 at 10:02 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Apr 25, 2016 at 3:39 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> Hi,
>>
>> a few folks from the Git LFS project and I try to make cloning of repositories
>> with a lot of LFS files faster.
>>
>> The core problem is that Git LFS uses a Git smudge filter to replace LFS
>> pointers with the actual file content. Right now, a smudge filter can only
>> be executed on an individual file which makes the operation slow for many
>> files [1].
>>
>> We solved this issue by temporarily disabling the smudge filter for the clone
>> command via Git config (optimized in 1a8630 [2]):
>>
>>     git -c filter.lfs.smudge= -c filter.lfs.required=false clone <url> <path>
>>
>> Afterwards Git LFS runs a special command to download and replace all LFS
>> content in bulk [3]. This works great for LFS repositories.
>>
>> However, I noticed that git config command line instructions such as
>> "-c filter.lfs.smudge=" are not passed to Git submodule operations. Thus
>> this does not work as expected:
>>
>>     git -c filter.lfs.smudge= -c filter.lfs.required=false clone --recursive <url> <path>
>
> I have cc'd Jacob Keller, who authored origin/jk/submodule-c-credential,
> which does work in that area (deciding which config option to pass down
> into the submodule commands).
>

This is a tricky question. The problem is that some configurations are
obviously not intended to go into the submodules, but determining how
is somewhat troublesome. There was some discussion on this previous
thread when we added support for credential options to pass through.

Thanks,
Jake
