From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rev-list docs: clarify --topo-order description
Date: Mon, 13 Aug 2012 22:33:22 -0700
Message-ID: <CAOeW2eE63JQbo+x7ZTDupt=auvo2_4Df790TPOtTEynCBK6z5g@mail.gmail.com>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
	<CAOeW2eGoNvgpbQ9iM0xHpSD1Z4XyC-J8VNVW0bVw3p9qOeijjg@mail.gmail.com>
	<7vobmebdfc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 07:33:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T19kv-0003YN-5r
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 07:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738Ab2HNFdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 01:33:23 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43046 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab2HNFdX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 01:33:23 -0400
Received: by yhmm54 with SMTP id m54so4374yhm.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2012 22:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bF9GGeeBwIJ/XeCWnUjf7nKvJmKiGBb7Tsod5IersVw=;
        b=g6WaD/sIPEYUiuryc6PfYe4FfXW9HJq2uKBMyaDwcmeBbc34X1XlEoYKlpzS01aWeK
         GhsL+LclyDAtQ6LMImu6l81jrjerItjfngkZqV+sXiMKUVGy3zPlR9NByExC9SSw7Mpb
         gZuojGq2fgJlFtRAy0/QCSECvxM8nHOkZUHDTD3PGo5IsZME2lATa//bwRHBxxZbW680
         DHV6MkCgqwsvKO8Vtgj0bKpep+5parzovJR1cAB7lbNW3EUV/oCsidZir4WIFNnvpado
         O9s2mUyCRS3RTTQrps3B9Kp9I0KoVJOedquVeUOzsqdlbi0uRYMT7arIphwdAaAYjxUA
         SYSQ==
Received: by 10.66.87.66 with SMTP id v2mr27480941paz.71.1344922402103; Mon,
 13 Aug 2012 22:33:22 -0700 (PDT)
Received: by 10.68.120.112 with HTTP; Mon, 13 Aug 2012 22:33:22 -0700 (PDT)
In-Reply-To: <7vobmebdfc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203385>

On Mon, Aug 13, 2012 at 4:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>
>>> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
>>> index 6a4b635..dc501ee 100644
>>> --- a/Documentation/rev-list-options.txt
>>> +++ b/Documentation/rev-list-options.txt
>>> @@ -579,15 +579,32 @@ Commit Ordering
>>>  By default, the commits are shown in reverse chronological order.
>>
>> It seems likely that those reading the above sentence will continue on
>> to read about --topo-order, but still, do you think the "descendant
>> commits are shown before parents" part belong here instead?
>
> I do not think so.  When you are not limited (i.e. limit_list() is
> not called), you could do something like "git rev-list 4 5" in a
> history like this:
>
>         --1---5---2---3---4
>
> and get end up getting "5 4 3 2 1", and "2" certainly doesn't get
> shown before "5" does.

Oh, interesting. I had no idea, although that does make sense. Thanks.

Still, the "Even without this option" strongly suggests to me that
what follows ("descendant commits are shown before parents") applies
to the "By default" case. Would it be correct to say something like
"By default, the commits are shown in reverse chronological order.
When commit limiting is in effect, descendant commits are shown before
parents."? I'm not sure the "commit limiting" section in the man page
involves the same options as "limit_list" (I rather think they don't),
but I don't know if there's a better term to use in the documentation
either.
