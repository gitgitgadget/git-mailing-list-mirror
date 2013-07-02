From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [Q] Getting the latest available Linux-kernel version
 (v3.x.y-stable or v3.x.y-rcX)?
Date: Tue, 2 Jul 2013 11:05:55 +0200
Message-ID: <CA+icZUUMjKx2J+Q4xKc6QkiSQB71szVjZNURhkpLFMGjqgpqRw@mail.gmail.com>
References: <CA+icZUV50bn4wjohfmKWL-GXpstidPNsNWqHuq+0gvEorWOaxA@mail.gmail.com>
	<CALkWK0nj3BG0VCxkzack_9sHa8oo=aypuv6KRusdRKyO1JCkAw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 11:06:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtwXA-0007dn-Sp
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 11:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489Ab3GBJF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 05:05:57 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:41881 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225Ab3GBJF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 05:05:56 -0400
Received: by mail-we0-f169.google.com with SMTP id n57so4159961wev.14
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 02:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=538l0OWFo78IMYBRk4yY8ObV2yTkfmNjv3LUklpiDck=;
        b=jublqXVzfsmu31bTjFVJNBPnVJ2SeQwmKPDbINI6Uq1kndsw7aV9HApZjb8QG/VH9B
         edcvlWt56ZkJO0ZuYnVNW7ruJEHbwqJHuX4Nz4ffLiyBzOG+Tlg6adupOf/hwlo3jimZ
         Xm7S4yXjChPr+kJ+Uy5tUJ2lKyxVxDQSWQOL6UStbLc+OqEkwA81zYFP4ounZtgBFbrc
         /nY7rvL86dszVpTfvdCc3DXYQ4Jru06RVRzhj+ABfxkVypb3y9za1laGp9YllzyDNQ4Q
         iR/qPxFHD1jdBht6aIkA5GXmKMVs9bNj48BtfaCiettmW9SMkWCix8OJSBeXVvCpSS/+
         ZiiQ==
X-Received: by 10.194.48.116 with SMTP id k20mr23331246wjn.23.1372755955286;
 Tue, 02 Jul 2013 02:05:55 -0700 (PDT)
Received: by 10.216.192.8 with HTTP; Tue, 2 Jul 2013 02:05:55 -0700 (PDT)
In-Reply-To: <CALkWK0nj3BG0VCxkzack_9sHa8oo=aypuv6KRusdRKyO1JCkAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229381>

On Tue, Jul 2, 2013 at 10:46 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Sedat Dilek wrote:
>> for my Linux-kernel build-script I am searching for a reliable check
>> of getting the ***latest*** version.
>
>   $ git describe HEAD
>
> If you want a sorted list of tags,
>
>   $ git for-each-ref --sort=taggerdate --format="%(refname:short)" refs/tags
>
> Are you looking for something else?

Hi Ramukar,

Thanks for the quick answer!

Cool, this seems to keep version-chronology!

$ git for-each-ref --sort=taggerdate --format="%(refname:short)"
refs/tags | grep ^'v3.[0-9]*' | tail -1
v3.10

$ git for-each-ref --sort=taggerdate --format="%(refname:short)"
refs/tags | grep ^'next-[0-9]*' | tail -1
next-20130702

Another question if I may ask:

Sometimes I need to bisect a previous Linux-Next version.

What I am doing is to have the latest Linux-v3.x.y(-rcX) as stable base.

$ git checkout upstream
$ git checkout -b Linux-v3.10-rc7 v3.10-rc7

Afterwards I checkout the latest Linux-Next remote repository with all
its (new) tags (here: next-20130628)

$ git checkout -b Linux-Next-v20130628
$ git pull linux-next --tags next-20130628

How do I get the latest available linux-version in the downgraded
(current) Linux-Next local repository (example: I have parallelly
Linux-Next-v20130702 and Linux-Next-v20130628)?
If I have all -next tags merged-in, I will get always today's 'next-20130702'.
Due to my poor git skillz I do this manually for git-bisect sessions.

Thanks again, you helped me a lot with the above!

- Sedat -
