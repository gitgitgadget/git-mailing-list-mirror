From: Luke Diamand <luke@diamand.org>
Subject: Re: BUG: checkout won't checkout?
Date: Thu, 18 Jun 2015 23:56:47 +0100
Message-ID: <CAE5ih78-1EDFTNhxy-PZBtT=HHNMPa=nX0UyfoXYXZXEKy0hPw@mail.gmail.com>
References: <CAE5ih7-=WPme_BxgAjtm9hrShxTk1z+uDM-LXzc3BcN3n2vqAg@mail.gmail.com>
	<xmqq4mm4d53f.fsf@gitster.dls.corp.google.com>
	<CAE5ih79KhNXqvSNW-w8pMmiys2Dv24Rt4KFdRdoA9EuPDS3ELw@mail.gmail.com>
	<xmqqvbekbpc0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 00:57:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5ijv-0006sH-Cl
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 00:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbbFRW4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 18:56:49 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33981 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbbFRW4s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 18:56:48 -0400
Received: by oigx81 with SMTP id x81so68470616oig.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 15:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1PNa8e8l5msS9rR/0xosYZbalt2xGmIzURsiawZrnJg=;
        b=gjdLUOh++RnxR9krKYJ+XSSsAM3vQWl1dz4r7e+8pcnamAkM4UhABhZxo0PZ7g/TcU
         zP1is857YEnYxaO27pkdkd3sWlvbsHnIDuIx0kntCxnVlVDYpvU2t7wRPx0yKKW9wusf
         uCDMvXtG5F1305bvJ1ufDd9AWKX7n+ifiUSLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1PNa8e8l5msS9rR/0xosYZbalt2xGmIzURsiawZrnJg=;
        b=dULyZNLMHlZX2c9rCq5WhIuIJfUbNTGDkfxdhz/hRbxx59t6pAi1P6QzaPttRKJMfV
         nnAXjo5cmxXVPrh4tqm8kMe8AklznrLXjmEa2FHsVuIxXDVIMwFGh8xNzW05zsVFAYMP
         pagzWpLgO4H7uk04q6egXwYTwuZlkuSevUlnCzp+YjjI9Dcpr4y/IMkcp9ocKVOcHPFi
         TnOKR7nJOQCRUYMsvpb7iqbnEiFdVt5SvLtxHMhIKhv7qLBh4evpfexUz4U/lHEhSX0J
         ZrN9pPydTJUrN5MV+l6m4ASt8hTrpdgKjzusUjdzI3w78jLhhTeb9qUAgcucXoi4Hncn
         AeEA==
X-Gm-Message-State: ALoCoQk4gHhkjHt8Z6uCrqvjROwQiKJZRrPnQza5MlOhZHlYkxS1+K7JnH5ye12xiuMvrNAEY5uX
X-Received: by 10.182.236.5 with SMTP id uq5mr11019445obc.13.1434668207533;
 Thu, 18 Jun 2015 15:56:47 -0700 (PDT)
Received: by 10.60.162.5 with HTTP; Thu, 18 Jun 2015 15:56:47 -0700 (PDT)
In-Reply-To: <xmqqvbekbpc0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272094>

On 18 June 2015 at 23:53, Junio C Hamano <gitster@pobox.com> wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>>>> $ git checkout upstream/master -- subtree
>>>> $ git diff upstream/master -- subtree
>>>> -- still lots of deltas
>>>
>>> Does this show _ONLY_ additions?  Or does it include modifications
>>> and removals?
>>
>> There are indeed _ONLY_ additions.
>
> http://thread.gmane.org/gmane.comp.version-control.git/234903/focus=234912
> http://thread.gmane.org/gmane.comp.version-control.git/234903/focus=234924
>
> In short, it is an intended behaviour, both Peff and I consider that
> the intention is bad and the behaviour should be changed.

OK, thanks, it makes sense now!

>
> But nothing has happened yet (it is listed as one of the "leftover
> bits" http://git-blame.blogspot.com/p/leftover-bits.html).

OK, I'll keep it in mind.

Luke
