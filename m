From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 2/8] update-index: add --test-untracked-cache
Date: Mon, 7 Dec 2015 07:18:19 +0100
Message-ID: <CAP8UFD3qN-_OcdmuaGBAMBToQqf5c2pB+Dvdh3JPb9+S6m3vsQ@mail.gmail.com>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
	<1449001899-18956-3-git-send-email-chriscool@tuxfamily.org>
	<CACsJy8ChATsTatRdz2wM23vfXy_8o1V5FEwMXo+PBqTBzZBBQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 07:18:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5p7x-0001bx-Tr
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 07:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbbLGGSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 01:18:21 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33269 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbbLGGSV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 01:18:21 -0500
Received: by lbbkw15 with SMTP id kw15so50211771lbb.0
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 22:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Rlu/OcMP7BLBp9gihsWxNuKFeqzO4Y7SLdgoUAJO+eY=;
        b=xKroVQ36MK5PQa3rWRdul23d+vo1mZUqYFgPI7JrpGq2PWKFXNpHw9SO0jSPC5LZZ4
         T+gEFmAKZuut4WjNbZXQTe+AMHS0frVBgkTmnagk6Q+kE3CgLamQnMLxJO/pbPAazT12
         SSo/qZiQiPYwhDnUxZKYMY9ZnsLVEqaFBdk24SG8gIM6NnfHVHWR3H98Xbc5ObYuDiTB
         WWXmbaoT/RyFlWUp0A7Gv+R9UYWpPu7kJ0CFQ3Gb+2E2YYuyM/V5/V/+yzL3Lj7Ge1NG
         N6FKOs8V9yZXFiZm878vBsHG5tCG1EC1aNBvSo329COwjANpN+xLoe3LX1eIRCIOvqlX
         NSyw==
X-Received: by 10.112.36.130 with SMTP id q2mr3107766lbj.116.1449469099548;
 Sun, 06 Dec 2015 22:18:19 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Sun, 6 Dec 2015 22:18:19 -0800 (PST)
In-Reply-To: <CACsJy8ChATsTatRdz2wM23vfXy_8o1V5FEwMXo+PBqTBzZBBQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282084>

On Wed, Dec 2, 2015 at 8:17 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Dec 1, 2015 at 9:31 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> index e568acc..b7b5108 100644
>> --- a/builtin/update-index.c
>> +++ b/builtin/update-index.c
>> @@ -996,8 +996,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>>                         N_("enable or disable split index")),
>>                 OPT_BOOL(0, "untracked-cache", &untracked_cache,
>>                         N_("enable/disable untracked cache")),
>> +               OPT_SET_INT(0, "test-untracked-cache", &untracked_cache,
>> +                           N_("test if the filesystem supports untracked cache"), 2),
>>                 OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
>> -                           N_("enable untracked cache without testing the filesystem"), 2),
>> +                           N_("enable untracked cache without testing the filesystem"), 3),
>>                 OPT_END()
>>         };
>
> I think we got enough numbers to start using enum instead.

Ok, I will use an enum.
