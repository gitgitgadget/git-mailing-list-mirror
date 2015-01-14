From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: sporadic git failures on interactive rebase
Date: Wed, 14 Jan 2015 16:02:03 -0500
Message-ID: <CAPig+cSAbo0NJP4+NS7=vfhqL4KzWFiYX6mzESnp1HkSEeFVUw@mail.gmail.com>
References: <trinity-5098e61e-b59a-4225-9d4c-8879dc78bb53-1421146472532@3capp-gmx-bs08>
	<20150114121915.GB30383@peff.net>
	<20150114123536.GA31530@peff.net>
	<xmqqvbk9b81d.fsf@gitster.dls.corp.google.com>
	<20150114205437.GB1155@peff.net>
	<CAPig+cQ9GpL9r6Rr96jc6G=EvCArodSXC-qMzSBp=e7c7QQbtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Henning Moll <newsScott@gmx.de>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 22:02:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBV4r-000893-NB
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 22:02:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917AbbANVCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 16:02:05 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:41622 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbbANVCE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 16:02:04 -0500
Received: by mail-yh0-f42.google.com with SMTP id v1so5559561yhn.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 13:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dgx6riiB7bWmdPIvvZWQCOT++DQ+qHzlfGoAHwoBD5I=;
        b=hRBcI3doHqeKfdeTyoZeu3abXARxc3eTeuO7+sK4XieyhWyhiG9TqCFWOoMNRqQvvj
         sofmBTIJ4QzBmdTdZlwOCj1Ty1r4941cEmWk5LEkmL5a5OA2rA+n3qtcC3ICBEG6YvE+
         dfiT+qaNjAkK+p7ALFXuBbfzY1tuidFzxqYzOSyQmhkkLMLDvYr8cIOWc01EBU8E0RUJ
         M+ahNQ8g+cE0Z9qtjFbOjCrbR3F5ZV+iN2Uglhw9oLpIAy7MOJDoWRu5bt08PHbSl9UG
         cl0AgjXE6HE/3PL4BBc+N6jux/k8BGFIFrZwZdjFOvCAtrE80MfZqc+PMbw7faqofiHs
         ONuw==
X-Received: by 10.236.7.107 with SMTP id 71mr3363726yho.148.1421269323711;
 Wed, 14 Jan 2015 13:02:03 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Wed, 14 Jan 2015 13:02:03 -0800 (PST)
In-Reply-To: <CAPig+cQ9GpL9r6Rr96jc6G=EvCArodSXC-qMzSBp=e7c7QQbtA@mail.gmail.com>
X-Google-Sender-Auth: YLciOXmGI4so4Yq-pnBp7uflqXQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262428>

On Wed, Jan 14, 2015 at 4:00 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jan 14, 2015 at 3:54 PM, Jeff King <peff@peff.net> wrote:
>> On Wed, Jan 14, 2015 at 09:12:46AM -0800, Junio C Hamano wrote:
>>
>>> Jeff King <peff@peff.net> writes:
>>>
>>> > What happens if we rebase with it?
>>> >
>>> >   $ git checkout 01319837
>>> >   $ git rebase -i HEAD^
>>> >
>>> > will yield a todo file with the 8-character unambiguous abbreviation.
>>> >
>>> > So I guess all is working as intended there. Perhaps you really were
>>> > just very unlucky and an earlier step of the rebase created a
>>> > conflicting sha1.
>>>
>>> That would mean 75c69766 (rebase -i: fix short SHA-1 collision,
>>> 2013-08-23) did not fix what it intended to fix, no?  Is the symptom
>>> coming from pre-1.8.4.2 version of Git?
>>
>> Yeah, you're right. I didn't even remember that commit at all. On the
>> off chance that the abbreviation code was different in that earlier
>> version, I also checked rebasing 01319837 with an older version, but it
>> does work fine.
>>
>> So yeah, the most plausible theory to me so far is unluckiness combined
>> with pre-1.8.4.2. That should be easy to disprove if Henning tells us
>> his git version.
>
> Henning mentioned it at the very top of his original problem report:
>
>     "(git version 2.2.0)"

For completeness: http://article.gmane.org/gmane.comp.version-control.git/262334
