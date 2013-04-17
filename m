From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Wed, 17 Apr 2013 17:44:17 +0530
Message-ID: <CALkWK0mp5H2hXXBX6YDMSto+DHjXsAojQDb3vcJksUwoOV=2jg@mail.gmail.com>
References: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin> <CACsJy8BoWfng7p=kHbiF9s6XYH1mPMtAGW6BRz54uYM5454O0w@mail.gmail.com>
 <CALkWK0mcnA8Qss3uxRXhfHst65RLkv43wje9xdFxmFKi7MtZvA@mail.gmail.com>
 <CACsJy8Bz+yNefiiwEivaaUgRymHTmUUKEFs8_uuonhmRfT3UGg@mail.gmail.com>
 <CALkWK0m9QmZaSDruY=+2F-Kkw+fd6E1TYCTBpVQHRJrzq2VjCQ@mail.gmail.com> <CACsJy8Bw6x=WiQUi0C4ZtEQiA9ia8ZFgz5uH61K6kf-JPy1xyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 14:15:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USRGU-0000jI-51
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 14:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966315Ab3DQMPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 08:15:00 -0400
Received: from mail-ia0-f175.google.com ([209.85.210.175]:63763 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966246Ab3DQMO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 08:14:59 -0400
Received: by mail-ia0-f175.google.com with SMTP id e16so1369472iaa.34
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 05:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=hcjj2gyU27UrJk++52zdBfXo8VhnjFUbHVVwpct/lpQ=;
        b=OEbbuE0Ou5GGDlUGqdP75S3CfSnx7x7/T8DJVdE1g/85AyIT3twDWukWKNmXIAFB/D
         7B6prUJl+RXhKNtCTbD/uOripFe9TMYuElwO5K0Wo0KK6G7aSCLv8w5GtvIzL7iEQXFf
         L/C4oxAgDGskfwObrDmZ+DkMKoLh7my3oRRgnllarTXZMUHXL2wlfXbabq4QiMCAb8Us
         aG+u74KaSP6RkpuylIrNbqqjFLiYACkRXSxjDXcZBZdrccseI1Zh/DRfFh4C8O8ePs1Z
         gqStIdFLGc7eNR6enjGxmDdaUlGM/QkHVfdJOywrnL4ypX924JGlWbjTWM+voDB6y6eV
         kfXg==
X-Received: by 10.42.50.202 with SMTP id b10mr3477310icg.7.1366200899225; Wed,
 17 Apr 2013 05:14:59 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 17 Apr 2013 05:14:17 -0700 (PDT)
In-Reply-To: <CACsJy8Bw6x=WiQUi0C4ZtEQiA9ia8ZFgz5uH61K6kf-JPy1xyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221540>

Duy Nguyen wrote:
> On Wed, Apr 17, 2013 at 9:56 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>>> why not reuse tag object with some nea header lines?
>>
>> Or a unified blob, which is currently what we have.  The point is to
>> have structured parseable information that the object-parsing code of
>> git code and easily slurp and give to the rest of git-core.
>
> I think you misunderstood. I meant instead of introducing new object
> type OBJ_LINK, you can reuse tag object and add new header lines for
> your purposes.

Oh, I interpreted your typo "nea" as "neat", when you meant "new".
Yeah, it's worth exploring: I don't know what backward compatibility
benefits it will yield yet.
