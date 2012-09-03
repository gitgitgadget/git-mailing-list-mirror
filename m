From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Mon, 3 Sep 2012 12:51:46 +0200
Message-ID: <CANGUGtB26sSfsBayHX9+EXfTDs3XxSEdMj-5pH6zD3i4GPHEdQ@mail.gmail.com>
References: <5040C59A.6090303@gmail.com>
	<50412E2D.7070503@kdbg.org>
	<5041BC94.7000304@gmail.com>
	<504214AA.9080706@kdbg.org>
	<50425F8B.5020406@gmail.com>
	<7voblognny.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 12:51:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8UG4-0007zL-0M
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 12:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755690Ab2ICKvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 06:51:48 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59647 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab2ICKvr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 06:51:47 -0400
Received: by eekc1 with SMTP id c1so1931668eek.19
        for <git@vger.kernel.org>; Mon, 03 Sep 2012 03:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cPLN6Ni4PqGUb0m8fy+M4YKrF4OvnMYlAvuZUc3Nqts=;
        b=QbsyTOV5QLiA1wJCbQc5qqAC0z5utRz6Sa1ZNtyxBsUVwTBmJXP9UzbFE3MtqCkzGn
         b+y5bpLSNeh6YdrplZal/GPDySj8de+5czo9xcNL6jLBpKCqyyogaNR84l3K3eU5j7+9
         0DVoUmKC0aGQrF0ofT8Nu0sEAh9zD0jLMqOhnFhsXIkXGJIh161wBlRVTmoXIB4Ti9bW
         2eUXM1OKIy+9jgnl1EUlZ56LoxMsfXf/ERS/mT6fsYiC0qYgaKMv3ny5EfHpV4eJAOf7
         XxBqJ94mFN19oB3fhC7fv9zaJ7WOIOsHydklWf9vYjNae0y1UoWS3hiOKHzIeC8AMpRj
         vPkg==
Received: by 10.14.182.134 with SMTP id o6mr20790713eem.26.1346669506581; Mon,
 03 Sep 2012 03:51:46 -0700 (PDT)
Received: by 10.14.68.129 with HTTP; Mon, 3 Sep 2012 03:51:46 -0700 (PDT)
In-Reply-To: <7voblognny.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204684>

2012/9/2 Junio C Hamano <gitster@pobox.com>:
> Marco Stornelli <marco.stornelli@gmail.com> writes:
>
>> Il 01/09/2012 15:59, Johannes Sixt ha scritto:
>>
>>> Look how you write:
>>>
>>>    perl -e '... $ENV{'PATCHTMP'} ...'
>>>
>>> That is, perl actually sees this script:
>>>
>>>    ... $ENV{PATCHTMP} ...
>>>
>>> (no quotes around PATCHTMP). That my be perfectly valid perl, but is not
>>> what you intended.
>>
>> I don't understand what you mean when you say "is not what you
>> intended"...
>
> When you wrote this:
>
>     CCS=`perl -e 'local $/=undef; open FILE, $ENV{'PATCHTMP'};...
>
> which one of the following did you mean to feed Perl?
>
>  (1) open FILE, $ENV{'PATCHTMP'};
>  (2) open FILE, $ENV{PATCHTMP};
>
> The patch text makes it look as if you wanted to do (1), but what is
> fed to perl is (2), as Johannes points out.
>
> Saying:
>
>     CCS=`perl -e 'local $/=undef; open FILE, $ENV{PATCHTMP};...
>
> would have been more natural if you really meant to do (2), don't
> you think?  So what you wrote is at least misleading.
>
> But I think I agree with Johannes's rewrite of the loop, so this may
> be a moot point.

Ok, I'll try to rewrite it as Johannes has suggested.

Regards,

Marco
