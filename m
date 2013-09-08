From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sat, 7 Sep 2013 21:36:58 -0500
Message-ID: <CAMP44s2e59ZME4sVP1ZD7geMDKGbcY4ZKiRTR2z1A4gviQvK6g@mail.gmail.com>
References: <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
	<7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
	<xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
	<20130905080606.GE2582@serenity.lan>
	<xmqqd2onhyay.fsf@gitster.dls.corp.google.com>
	<20130905192646.GG2582@serenity.lan>
	<20130906214138.GA7470@google.com>
	<xmqq1u51wqbi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 04:37:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIUs6-0007GP-9P
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 04:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721Ab3IHChA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 22:37:00 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:34435 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563Ab3IHCg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 22:36:59 -0400
Received: by mail-la0-f51.google.com with SMTP id es20so3907727lab.38
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 19:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2p8VRpT0koc0ljPpIevNrH6f7V0eO6YSwOCTmV0Tiu4=;
        b=MyRW6jB/L61hYm9eAUnZnCf6l7DsomybjEZVPLCH14/DgyJPihJOZi3yWZx7x2uWK1
         srKU7HrhzvOTAHsZWGxE3UsRG+yoD7EkWDLEfbASgr0UyizlO2WiNzpwKnewl7KHhVBe
         NCMbfoiqWp8lLbiaBxc+scAXDDZinIkow8Or+npmQ5UWjFfIvGPOhOr2X1J3UVJia6Sh
         0fO54r17+ILRpk9vE4Dle/nDv2lkE2OJ7whHQZngHQPTEiaoI80Aejf7tC8kKwbhI6SZ
         C/iYvJyuAJ5kjFTwfrlakjciJTYDjdhHv3h9qEhnmXAetBSRX2IDj84zAzisFujVCPyw
         D2UA==
X-Received: by 10.152.10.99 with SMTP id h3mr9677634lab.13.1378607818349; Sat,
 07 Sep 2013 19:36:58 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 19:36:58 -0700 (PDT)
In-Reply-To: <xmqq1u51wqbi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234163>

On Fri, Sep 6, 2013 at 5:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> John Keeping wrote:
>>> On Thu, Sep 05, 2013 at 12:18:45PM -0700, Junio C Hamano wrote:
>>
>>>> I somehow thought that rebase by default looked in the reflog to do
>>>> exactly that. Perhaps I am not remembering correctly.
>>>
>>> It just does @{upstream} by default, which tends to get messy if the
>>> upstream has been rewritten.
>>
>> Maybe Junio is thinking of 'git pull --rebase', which walks the reflog
>> until it finds an ancestor of the current branch and uses that as the
>> <upstream> parameter to rebase.
>
> You're right.
>
> It makes me wonder why we did that one inside pull and not in
> rebase, though.

Because there's a huge difference between:

git rebase @{u}@{1} --onto @{u}

And

git rebase @{u}

I was in the process of fixing that, but you stopped me.

-- 
Felipe Contreras
