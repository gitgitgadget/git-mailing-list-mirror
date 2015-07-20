From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/9] ref-filter: add option to align atoms to the left
Date: Mon, 20 Jul 2015 13:47:44 -0400
Message-ID: <CAPig+cT-_Ha=zF1E832cjN-Yhqgs1W73+A2+O9MxgeJ+VJNzbQ@mail.gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
	<1437246749-14423-2-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRXsmi=UxRr-3rnt919d86jD6uMuTqdDxCComYLXk1TYw@mail.gmail.com>
	<xmqq8uaazu3v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 19:47:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHFAL-0002IF-Vc
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 19:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725AbbGTRrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 13:47:46 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36061 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616AbbGTRrp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 13:47:45 -0400
Received: by ykay190 with SMTP id y190so144663187yka.3
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 10:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SdLT/E4AwALOSMZKJYiluIXWwCe0PpW+sSU3BlVv/u0=;
        b=U1EwKw/eGlzlY4CKIq1mvR8n0fSl07jjLRsrxYA5c5u69YCN5iiPi4ogdHpdYBo0G8
         xI6pmjiLSXxQj0K00POibYEb8HheP9BSkI2hqQwS4bgDbrBSyjl7elDcwhLC4KUQf86H
         NsKpieoKxwx6teKgeZ6mY+H1jbC5CJKdFrGlKpPD1CWoNvj0ctV0d5f3UlDzguUBJIyZ
         YSl43lHDHxOsD9xpJVjVB7NsGhtoJEtU6aciLc4Kecr6n/ZZFVM6TbbuUR6V5btHTRtk
         AB4sDuT4rlJiKYrMlkNe/eONgBXSHvyIcRXjX1eESMkKbfILrLVGAhgrZbHan/G+2tG/
         TIAA==
X-Received: by 10.129.50.140 with SMTP id y134mr29409299ywy.39.1437414464733;
 Mon, 20 Jul 2015 10:47:44 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 20 Jul 2015 10:47:44 -0700 (PDT)
In-Reply-To: <xmqq8uaazu3v.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 62Hes4uonxJUtO1ZkVX43VxaPZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274335>

On Mon, Jul 20, 2015 at 12:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Sat, Jul 18, 2015 at 3:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> Add a new atom "align" and support %(align:X) where X is a number.
>>> This will align the preceeding atom value to the left followed by
>>> spaces for a total length of X characters. If X is less than the item
>>> size, the entire atom value is printed.
>>>
>>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>>> ---
>>> diff --git a/ref-filter.c b/ref-filter.c
>>> index 7561727..b81a08d 100644
>>> --- a/ref-filter.c
>>> +++ b/ref-filter.c
>>> @@ -53,6 +55,7 @@ static struct {
>>>         { "flag" },
>>>         { "HEAD" },
>>>         { "color" },
>>> +       { "align" },
>>
>> Not a new issue, but some compilers (Solaris?) complain about the
>> trailing comma.
>
> Hmm, are you sure?  I thought we avoid trailing comma for enum
> definitions, but not a list of values like this.

It's been years since I encountered such a compiler, so it's possible
that my brain is conflating different cases of trailing commas...
