From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 05/13] ref-filter: add option to filter out tags,
 branches and remotes
Date: Sun, 30 Aug 2015 03:16:06 -0400
Message-ID: <CAPig+cRK9Ljj_qO36JhYtt+2aGC0NfhC0AeuT65B_mYj25+nnw@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
	<1440857537-13968-6-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRHc29TL=sHv3dkEewVQzPo0m8O4d1VL+dWA6PC5pHowA@mail.gmail.com>
	<CAOLa=ZSn6z03+jU1Ytn6nL0f0hQ36YAxG4629E1jTpyiaO7BZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 09:16:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVwqr-0008Sr-7U
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 09:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbbH3HQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 03:16:08 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34881 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbbH3HQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 03:16:07 -0400
Received: by ykbu129 with SMTP id u129so19973401ykb.2
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 00:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gRJK1Ctfuh48hO2vp4P+4WlAmFXTl9HXJZxmzQI9p+s=;
        b=UJMfh25wj0f3v36jRQGx+4AlCV2HWEJZ8P+HxGEgFFgr1OsHW1FkgTzj9qu4Ol7+QC
         CAeaEAbg9q7fI96NmeE1k7V88sJVLBX7GPF0u+TwMOTtlzLHBtJv0urDBuv/W/Nb/uyl
         +X6Q1C7kWeGzKiVfCJ3XCS+qQx5qfR3JbSSDDvOzsHrF57NdQB3S4H2CQzppx5ZS+obA
         jaCQ7BONHuShfqmItJq/zgwVBTVG7IiahY/wdzLaDBtiVDDtoBbQlZ3W7llbPtx76Acq
         TO48xriHEPS7KxqwCwwVZJw5NuDkUxau+GG4Rh2FmkJFaTtVGXMJgEK8/eisBuvySxKg
         ee7g==
X-Received: by 10.129.70.215 with SMTP id t206mr16397169ywa.4.1440918966827;
 Sun, 30 Aug 2015 00:16:06 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sun, 30 Aug 2015 00:16:06 -0700 (PDT)
In-Reply-To: <CAOLa=ZSn6z03+jU1Ytn6nL0f0hQ36YAxG4629E1jTpyiaO7BZQ@mail.gmail.com>
X-Google-Sender-Auth: m3aJRR0KtNpKW6vI9cYNFRSLfEE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276806>

On Sun, Aug 30, 2015 at 2:51 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Sun, Aug 30, 2015 at 9:00 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sat, Aug 29, 2015 at 10:12 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> +int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
>>
>> Booleans such as 'broken' are typically declared 'int' in this
>> codebase, rather than 'unsigned int'.
>
> But doesn't it make more sense to have it as unsigned, since its values are
> either 0 or 1?

In C, zero is false and any other value is true, so from that
viewpoint, the type doesn't matter much. However, beside being raw
instructions for the computer, code should ideally convey its
intention as clearly as possible to other programmers. 'int' for
boolean has been idiomatic since C's inception, thus is a good way to
do so, whereas 'unsigned int' is typically used for magnitude or bit
flags, thus is misleading.
