From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Q] Getting the latest available Linux-kernel version
 (v3.x.y-stable or v3.x.y-rcX)?
Date: Tue, 2 Jul 2013 16:36:31 +0530
Message-ID: <CALkWK0mm4iB5Z2t0n7vBkfUNTPR-e0bU7D_V+4DXXEvrNj6R4w@mail.gmail.com>
References: <CA+icZUV50bn4wjohfmKWL-GXpstidPNsNWqHuq+0gvEorWOaxA@mail.gmail.com>
 <CALkWK0nj3BG0VCxkzack_9sHa8oo=aypuv6KRusdRKyO1JCkAw@mail.gmail.com> <CA+icZUUMjKx2J+Q4xKc6QkiSQB71szVjZNURhkpLFMGjqgpqRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: sedat.dilek@gmail.com
X-From: git-owner@vger.kernel.org Tue Jul 02 13:07:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtyQf-0006hc-4O
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 13:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366Ab3GBLHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 07:07:16 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:60337 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879Ab3GBLHM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 07:07:12 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so11599107iec.22
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 04:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1MIC9CJYjyqaxDRZ+e6hRitPtHdj8xxZw8xw6WDZCMs=;
        b=A/xRYnYSr5ktN/GBkH+x9S8ACT7t3UXnDrC4l79EHAkdHtM87YjjjX//OzRnL/zfcw
         RbGlahRO7gYZCr1qm6+lJbz7s0OQsfdiQy5LE8s4BNgEeIfGiSikuUsxUxbKvTG2rzLy
         KZR9DpnEkJQqlQn6rSexPeUsAZV2Jnc4A/PQT/YQSrUVHpMRa8HKT5lFYSOMw+1VxdmN
         7Etlx2OaigryKyab7up+OjX3hPKSnMgq+/vxmgeQ+VHY3AZKOl5acD9ACIkAa5ZWZcxZ
         TLmW9Hy6MR3s1pZTOr8AUX8VTnwTuAOs0lG/eqN4sSyYOl8aoLpt6KeAGfbWAAKYdSXn
         RMSA==
X-Received: by 10.50.126.99 with SMTP id mx3mr6372104igb.48.1372763231577;
 Tue, 02 Jul 2013 04:07:11 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Tue, 2 Jul 2013 04:06:31 -0700 (PDT)
In-Reply-To: <CA+icZUUMjKx2J+Q4xKc6QkiSQB71szVjZNURhkpLFMGjqgpqRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229391>

Sedat Dilek wrote:
> Sometimes I need to bisect a previous Linux-Next version.
>
> What I am doing is to have the latest Linux-v3.x.y(-rcX) as stable base.
>
> $ git checkout upstream
> $ git checkout -b Linux-v3.10-rc7 v3.10-rc7
>
> Afterwards I checkout the latest Linux-Next remote repository with all
> its (new) tags (here: next-20130628)
>
> $ git checkout -b Linux-Next-v20130628
> $ git pull linux-next --tags next-20130628
>
> How do I get the latest available linux-version in the downgraded
> (current) Linux-Next local repository (example: I have parallelly
> Linux-Next-v20130702 and Linux-Next-v20130628)?

I'm not able to understand the question.  I'm not sure why you're
creating branches from existing tags.  You can easily do:

  $ git bisect start @ v3.10-rc7

(@ is a synonym for HEAD in the latest git)

You can also fetch all tags:

  $ git fetch --tags

and decide what to do with them later:

  $ git merge next-20130628

In the process, next-20130628 hasn't changed: you can still use it as a
bisect endpoint.

> If I have all -next tags merged-in, I will get always today's 'next-20130702'.
> Due to my poor git skillz I do this manually for git-bisect sessions.

*scratches head*

Can you try rephrasing your question?
