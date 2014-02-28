From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] branch.c: delete size check of newly tracked branch names
Date: Fri, 28 Feb 2014 19:43:03 +0700
Message-ID: <CACsJy8BaGL9EQW87MSC98sKTfN6V9tPbqWXPAtM+nvoxV_NShg@mail.gmail.com>
References: <1393585744-2569-1-git-send-email-jacopo.notarstefano@gmail.com>
 <CACsJy8A7jVM1wdU2BK-NyQ5HJoY_19oKhSXCKqV_7qNN+OA+mw@mail.gmail.com> <CAL0uuq263WEFWvZFDeqdN4=fAJGPUtux2wwFGOUQEMfzmDOweQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <christian.couder@gmail.com>
To: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 13:43:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJMmx-0002k9-7K
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 13:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbaB1Mnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 07:43:35 -0500
Received: from mail-qc0-f171.google.com ([209.85.216.171]:50251 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaB1Mnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 07:43:35 -0500
Received: by mail-qc0-f171.google.com with SMTP id x3so616892qcv.16
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 04:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tEKSTulOaK8tZv4UuzUEqTyC95fEEmsuAuDnzHmUExQ=;
        b=VINIQBF3i2efpuiPY+HuCtO1g2KIZxzCad6fnJywi9sUyrM5YHBPqcpI7ekB/Zc1zs
         a93YSjXffcVB+2HTu31k/li5ANzYkMrebTW2g1E2tzCMWrWOI7cymhAPMMmBFz7IsLK1
         lX+uM/YmdRZksQmuOJHi4CwfOGMx/79AcVLXP2veN3IJYWCISERnXJj1fUOZwzVp4ULF
         gTcDdCNJwGAY7tJz6acGtRhAV5nxcdf2OeYNHIL8wdhXMWb4XJq7lIeWa3OGRJj8dhKX
         tlfSYoPLEQ5IP84el8o8V9c+m1/Xjr18gxsiVlXbZejpuSrhSeYuB2JpSFdilczKcErD
         u7NA==
X-Received: by 10.224.26.71 with SMTP id d7mr3113637qac.89.1393591414498; Fri,
 28 Feb 2014 04:43:34 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 28 Feb 2014 04:43:03 -0800 (PST)
In-Reply-To: <CAL0uuq263WEFWvZFDeqdN4=fAJGPUtux2wwFGOUQEMfzmDOweQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242951>

On Fri, Feb 28, 2014 at 7:14 PM, Jacopo Notarstefano
<jacopo.notarstefano@gmail.com> wrote:
>> Nice. new_ref is passed in install_branch_config() in latest code. I
>> guess you already made sure this function did not make any assumption
>> about new_ref's length?
>>
>
> The function install_branch_config uses the strbuf, as I wrote in the
> commit message. The contents of this buffer are then fed to
> git_config_set, which, after a few more function calls, parses the key
> with git_config_parse_key. This function does not rely on any
> assumptions (as far as I can tell!) on the name's length, and
> allocates enough space for it in
> https://github.com/git/git/blob/master/config.c#L1462.

Thanks for checking!
-- 
Duy
