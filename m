From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/9] Prefix-compress on-disk index entries
Date: Wed, 2 May 2012 08:58:50 +0700
Message-ID: <CACsJy8DZ4t0f_mdDJTUZvz_pBPrPTsEBxHEkYREowWm6D1ikkw@mail.gmail.com>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
 <CACsJy8A+cJtzKdqJSWbmjT1LgP10LB69-NHfOv8S6BusGcMeFw@mail.gmail.com>
 <7vpqbn8hgr.fsf@alter.siamese.dyndns.org> <CAFfmPPNHkK3SB8cGjfJiVoQoSg2OLL8B5--mwH8HShhJ1WGy2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Wed May 02 03:59:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPOql-0008Qa-5k
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 03:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757607Ab2EBB7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 21:59:22 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:45479 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757445Ab2EBB7V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 21:59:21 -0400
Received: by wibhq7 with SMTP id hq7so116183wib.1
        for <git@vger.kernel.org>; Tue, 01 May 2012 18:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XX6zo7iw9er9k09AqdkksGu23p5tid09u2lT2/Ylv1s=;
        b=O6pLCHRirO0xhEyuckNq59b9/G0KsBJIOIar4UfDfqajKbsBo8yRjroZa6X8TZEDRs
         fhmKwN21syYDtbKhh6XdNoIPXwo+91cNOux8PvYKS6hpHHlRhw8LVfx2eupfVEd1CxmD
         Z+J5EXje8JTNTemmVY2Xk8yCs+igC5+QrtVgjAuKNgJMqoeDfXuVejDUeu38+Kt/uG/J
         zeywqh28GrHdzJMG/xgkBAUVM7zUmUFmgOsdioOaiExgb5i1fzP1FrLI5Tz5+yHbm7on
         HAM4jUQnpDjsurWx5u68bdtrhFTLdM8A6yQKixs2xiSPLthaNokMmiFrPrzTlD/0VUAd
         4sTg==
Received: by 10.180.83.38 with SMTP id n6mr11181363wiy.1.1335923960683; Tue,
 01 May 2012 18:59:20 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Tue, 1 May 2012 18:58:50 -0700 (PDT)
In-Reply-To: <CAFfmPPNHkK3SB8cGjfJiVoQoSg2OLL8B5--mwH8HShhJ1WGy2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196776>

On Fri, Apr 6, 2012 at 3:41 PM, David Barr <davidbarr@google.com> wrote:
> On Thu, Apr 5, 2012 at 4:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>
>>> On Wed, Apr 4, 2012 at 5:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> ...
>>> I wonder what causes user time drop from .29s to .13s here. I think
>>> the main patch should increase computation, even only slightly, not
>>> less.
>>
>> The main patch reduced the amount of the data needs to be sent to the
>> machinery to checksum and write to disk by about 45%, saving both I/O
>> and computation.
>
> I hacked together a quick patch to try predictive coding the other
> fields of the index. I got a further 34% improvement in size over
> this series. Patches to come. I just used the previous cache entry as
> the predictor and reused varint.h together with zigzag encoding[1].
>
> That's a total improvement in size over v2 of 62%.

Have you posted (and I missed) the patches? I'm interested in seeing
what changes you made.

> [1] https://developers.google.com/protocol-buffers/docs/encoding#types
-- 
Duy
