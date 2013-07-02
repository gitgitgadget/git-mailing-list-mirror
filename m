From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [Q] Getting the latest available Linux-kernel version
 (v3.x.y-stable or v3.x.y-rcX)?
Date: Tue, 2 Jul 2013 13:19:29 +0200
Message-ID: <CA+icZUU8sA7L_a1sMEqhUXZbzuG5BKRf_NkZSrW_3im1hjRAKg@mail.gmail.com>
References: <CA+icZUV50bn4wjohfmKWL-GXpstidPNsNWqHuq+0gvEorWOaxA@mail.gmail.com>
	<CALkWK0nj3BG0VCxkzack_9sHa8oo=aypuv6KRusdRKyO1JCkAw@mail.gmail.com>
	<CA+icZUUMjKx2J+Q4xKc6QkiSQB71szVjZNURhkpLFMGjqgpqRw@mail.gmail.com>
	<CALkWK0mm4iB5Z2t0n7vBkfUNTPR-e0bU7D_V+4DXXEvrNj6R4w@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 13:19:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtycU-0007pl-9K
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 13:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058Ab3GBLTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 07:19:33 -0400
Received: from mail-qa0-f51.google.com ([209.85.216.51]:58126 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708Ab3GBLTa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 07:19:30 -0400
Received: by mail-qa0-f51.google.com with SMTP id f11so2582996qae.3
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 04:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=81SAGAU6ima1Uv2PKrJkEJWpAkOsQlVw+sp1Ci6Yt+8=;
        b=lECKVA8C76syxUDi5e1R6JQWudWSLaZOkotgiVL5gZ6w3ymxypVTaZnwyVGcT6T1eP
         F8GDPIVL4JfsNJ3cJlBYI9T1QXpBz3M/SS+nR5L1Q/y2cIbrM2fIkgCyFbbxeqsvD1L5
         y5E/bOdc0a6Ui51MTG0gKBPBktQ84S7uaClzrssyCKq96dJ4Bj0SimDFqgm7uzTHsfDw
         IhjFltUfv/OVFrgkiLPPI51sWEVSSXmYzth3lUNuu0ayK/VhGb8xxsPzo5/7b4PiS8rL
         afxDOSoYLBvi3A7avDHSgKQ0EqotYuO9PiiIHMYOYSduCbTf526JT5KwdOfGKMl3YzdW
         QPBQ==
X-Received: by 10.229.198.2 with SMTP id em2mr899735qcb.96.1372763969440; Tue,
 02 Jul 2013 04:19:29 -0700 (PDT)
Received: by 10.49.121.99 with HTTP; Tue, 2 Jul 2013 04:19:29 -0700 (PDT)
In-Reply-To: <CALkWK0mm4iB5Z2t0n7vBkfUNTPR-e0bU7D_V+4DXXEvrNj6R4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229392>

On Tue, Jul 2, 2013 at 1:06 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Sedat Dilek wrote:
>> Sometimes I need to bisect a previous Linux-Next version.
>>
>> What I am doing is to have the latest Linux-v3.x.y(-rcX) as stable base.
>>
>> $ git checkout upstream
>> $ git checkout -b Linux-v3.10-rc7 v3.10-rc7
>>
>> Afterwards I checkout the latest Linux-Next remote repository with all
>> its (new) tags (here: next-20130628)
>>
>> $ git checkout -b Linux-Next-v20130628
>> $ git pull linux-next --tags next-20130628
>>
>> How do I get the latest available linux-version in the downgraded
>> (current) Linux-Next local repository (example: I have parallelly
>> Linux-Next-v20130702 and Linux-Next-v20130628)?
>
> I'm not able to understand the question.  I'm not sure why you're
> creating branches from existing tags.  You can easily do:
>
>   $ git bisect start @ v3.10-rc7
>
> (@ is a synonym for HEAD in the latest git)
>
> You can also fetch all tags:
>
>   $ git fetch --tags
>
> and decide what to do with them later:
>
>   $ git merge next-20130628
>
> In the process, next-20130628 hasn't changed: you can still use it as a
> bisect endpoint.
>
>> If I have all -next tags merged-in, I will get always today's 'next-20130702'.
>> Due to my poor git skillz I do this manually for git-bisect sessions.
>
> *scratches head*
>
> Can you try rephrasing your question?

OK, I will try.

The base for my local Linux development GIT repository is the one from
Linus (aka upstream/mainline).
There-in I pull diverse Linux-next releases where I take its latest
Linux-upstream version as the new base.

EXAMPLES:

1. next-20130628 has its base as v3.10-rc7
2. next-20130702 has its base as v3.10

I am using always the version-tags for switching to a new local repo.

As said above I switch to the latest Linux-upstream version of the
corresponding -next and then pull in via '--tags' (see above).

Let's say I am on today's next-20130702 and switch back to my local
next-20130628 tree, the lastest version-tag available is always
'next-20130702'.

It could be my workflow is somewhere wrong.

Hope this is a bit enlightening.

Regards,
- Sedat -
