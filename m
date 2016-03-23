From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git-apply does not work in a sub-directory of a Git repository
Date: Wed, 23 Mar 2016 17:15:28 +0700
Message-ID: <CACsJy8DCk5YintK3PoO1BWdNmsiSLpAcGL4pU7QgNEG6S41CsQ@mail.gmail.com>
References: <CA+DCAeQQQH59Lb43Y4Bi1xktPNoODV11KkUBbKNG1OZ7mDb-UQ@mail.gmail.com>
 <CAGZ79kYmoKX1w5X8jE5_yGb3VKricHEwxAianTyt4VUd71qH-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mehul Jain <mehul.jain2029@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:17:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifpu-0004p6-CF
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759AbcCWKQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:16:18 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:32836 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859AbcCWKQB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 06:16:01 -0400
Received: by mail-lb0-f175.google.com with SMTP id oe12so6693407lbc.0
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MDPcQAonWwg/PTUyb2THNPOH4y/G16aTcDfN6+WzEHQ=;
        b=rCo2zBxVpxJHr7H2bxhkj46YJPeDa2dAkdjXLpaIhyvbxa24diyx5GynMurnk1CLoR
         EUlCS/H7dVcDBtxqEXfoV5E5i6ta4HrzQ49WXWVJVsbsVIv0/++MD27Iir601gzvDXme
         /QeOsEFBMtF4GCNuApKJ3++PKqBISUl8ZrZ8Kgjh+fGSbR2YrWtvk7RPKx7P06ZQ4aci
         qcqjvLccLbaOEjuBiWWxM8M4NMGqG0nXNKKnLn2a5ySu7Knxnkf+Dgl2qKG3hJ/uKR5x
         mLNWYcTCZzE0yJBywLBI21GcjGoIeHdd2YKYQJWpA9YTqySDF32Khh7tQuybJlX04xjv
         3UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MDPcQAonWwg/PTUyb2THNPOH4y/G16aTcDfN6+WzEHQ=;
        b=HMzHffqDQ/sXcqzXooIKFUXkzp0htcfajs+usHiBBpcLsJN2i+B12syQOBk96+fLB9
         5fHZfDuhRle9TQDAAvJjGunEs0Z9roXxN5VpSKikuffQC+KbPTeIDvwDJxGr9DEUAZ5G
         nke5ert1gzBe0T6m7ie23hnBa46o/PTCPtg6mzlQBFJ9Rkn34ITwC7Kbl/HwuVYfkjJV
         /OYkW6tLrBAYdWQCHXSkisIGGr0ssjj80f9rFheACndTO+397GcbpNo2i7da16GvzhGG
         0ZIEyrFLoW7+RE8sdCHvqs3cXlxuWJb8/mQVzD8E8BCn6uwRyIV1b0Iw5YW9JTC24FZC
         yTyQ==
X-Gm-Message-State: AD7BkJLNaARnmuUAJ4Dz+iJr7bv7HWe2Lsa3p6TIj+t5mtK49hiIMu83nT49oeftlE4R2jVgTVBK/vYxqnbPXA==
X-Received: by 10.112.157.105 with SMTP id wl9mr802982lbb.137.1458728158447;
 Wed, 23 Mar 2016 03:15:58 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 23 Mar 2016 03:15:28 -0700 (PDT)
In-Reply-To: <CAGZ79kYmoKX1w5X8jE5_yGb3VKricHEwxAianTyt4VUd71qH-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289636>

On Wed, Mar 23, 2016 at 5:14 AM, Stefan Beller <sbeller@google.com> wrote:
>> Hello everyone,
>> As you observed, patch wasn't applied. Is it intended behaviour of
>> git-apply? Usually to apply the patch I have to copy it to top directory
>> and then use git-apply.
>>
>> I tried out git-am to apply the patch ("git format-patch" was used to
>> make patch) while being in the "outgoing" sub-directory and it worked
>> fine. So why does git-apply show this kind of behaviour?
>
>
> Think of git-apply as a specialized version of 'patch', which would also
> error out if there are path issues. (Inside outgoing/ there is no file found at
> ./main)
>
> git-am is the porcelain command which is what is recommended to users
> who interact with Git and patches.

git-am is about patches in mailbox form, not plain patches, isn't it?
In that view, it's not a replacement for git-apply.

How about we start deprecating the old behavior?

1) add --no-index to force git-apply ignore .git, --git (or some other
name) to apply patches as if running from topdir, add a config key to
choose default behavior
2) when git-apply is run without --git, --index or --cached from a
subdir and the said config key is not set, start warning and
recommending --no-index
3) wait X years
4)switch default behavior to --git (if run inside a git repo)
-- 
Duy
