From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] teach fast-export an --anonymize option
Date: Sun, 31 Aug 2014 06:34:08 -0400
Message-ID: <CAPig+cSKfxAsr+RQp8N8GAOe9fa_6kGPi_-X99Vs-2bYbBoC8A@mail.gmail.com>
References: <20140827165854.GC1432@peff.net>
	<20140827170127.GA6138@peff.net>
	<CACsJy8B3gFC7kLf-cLhAk3BgQ+v427rMXWHTqjU4LYP3NQte7Q@mail.gmail.com>
	<20140828123257.GA18642@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 31 12:34:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XO2Sc-0003EF-Uj
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 12:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbaHaKeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 06:34:11 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:61739 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbaHaKeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 06:34:09 -0400
Received: by mail-yk0-f176.google.com with SMTP id 19so2555366ykq.21
        for <git@vger.kernel.org>; Sun, 31 Aug 2014 03:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=a2A/SQ019d0WLMr0PUA3Nfr6hu+Jl2WiRQT7RGHI3vw=;
        b=BNs9BIuJHFo8Ba0nF1kK0id6uiuazfVFJs0n3bk+wT9Hq7sOgih+ebf2HRuolC21A+
         hpoKEml5zHi/lK4wyo9qxl4N4etvbh3piG2WRupDdg1ZkWddVrKJZW1Nq9kjnTExmJv/
         VUN8btmmzN90eZtuymihcPxGDCRKEXIys2kYDXGTbSMO+ujTCveqckH4q/ZlfeSTOs24
         SgFVjap8Yf8glrFFFf8zMIRsiwELtzBuUhgekUuA8XFOKu106e6QzqehjGSrWxghSkjt
         QpjWhJdvldyLgptmejzimqCnjNIn1CyfUXaLOpt3AwILvYiSdZ8wWminhJPtvbI4mZPS
         lTPg==
X-Received: by 10.236.128.176 with SMTP id f36mr3644638yhi.87.1409481248350;
 Sun, 31 Aug 2014 03:34:08 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Sun, 31 Aug 2014 03:34:08 -0700 (PDT)
In-Reply-To: <20140828123257.GA18642@peff.net>
X-Google-Sender-Auth: rjLEKgx-JkwRVgO-GblSrkqS_L4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256283>

On Thu, Aug 28, 2014 at 8:32 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Aug 28, 2014 at 05:30:44PM +0700, Duy Nguyen wrote:
>
>> On Thu, Aug 28, 2014 at 12:01 AM, Jeff King <peff@peff.net> wrote:
>> > You can get an overview of what will be shared
>> > by running a command like:
>> >
>> >   git fast-export --anonymize --all |
>> >   perl -pe 's/\d+/X/g' |
>> >   sort -u |
>> >   less
>> >
>> > which will show every unique line we generate, modulo any
>> > numbers (each anonymized token is assigned a number, like
>> > "User 0", and we replace it consistently in the output).
>>
>> I feel like this should be part of git-fast-export.txt, just to
>> increase the user's confidence in the tool (and I don't expect most
>> users to read this commit message).
>
> Hmph. Whenever I say "I think this patch is done", suddenly the comments
> start pouring in. :)

Considering that the value of --anonymize is not yet known, is such an
invasive change to fast-export.c warranted? Would it make sense
instead to provide "anonymize" functionality as a contrib/ script or a
distinct git-anonymize-foo command which accepts a fast-import stream
as input and anonymizes it as output?
