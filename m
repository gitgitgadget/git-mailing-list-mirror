From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] Teach git to change to a given directory using -C option
Date: Mon, 9 Sep 2013 13:42:50 -0400
Message-ID: <CAPig+cQEor+dBU6Xww25A4Sc-mgEOq1SDmBX-9xM6pKuMqu-NQ@mail.gmail.com>
References: <20130903115944.GA29542@gmail.com>
	<xmqq8uzdplqv.fsf@gitster.dls.corp.google.com>
	<CAEY4ZpN4xgt+gJSVeTfDNC--xt3N+M7vVLFBC7FTWBQtjvN8tw@mail.gmail.com>
	<20130904122020.GA25538@gmail.com>
	<CAPig+cRt9o=6Amhx6qTkzfk5R9aQfRZ=357BOVELm_hPsWE3WQ@mail.gmail.com>
	<CAEY4ZpNEae1UprRcpC8XUPP4XBQ89bDXP1A7yVcFdW405HZr0w@mail.gmail.com>
	<CAPig+cTNeqNhGwD-EZ3uszh5vJ4JeJ6L0RXdTsveb1FgXE5t3Q@mail.gmail.com>
	<20130909134743.GA11335@gmail.com>
	<xmqqtxhu3qil.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nazri Ramliy <ayiehere@gmail.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 19:42:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ5UG-0003Jr-AJ
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 19:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116Ab3IIRmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 13:42:52 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:35798 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab3IIRmv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 13:42:51 -0400
Received: by mail-la0-f53.google.com with SMTP id el20so5083403lab.26
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=21FEm48sc5OXOfV3upkmIss+Q2HlgxG0C9qGPhQiHPU=;
        b=BcZnUK9j6c34I4tkhsYI+Otys5w9+ZKMnr4ah6B2Cz8xG8SbY/24MGq0LsDS5fI8wa
         BsVkAntW7HwY4JF5KSPbCGQsLNB7BHeMRAQrpA6PsJrwlRlcLjEU2gBxTkp4nNSXrN44
         aCv4skRl1e876d7Nff51LU7o1REm2NGzmxmrubJQsNMMPj7IjY46FZBhhcREXQYNrYA8
         EYQ/xj2D2p2p5I7bcLQQnUSNzXyYNCE/hK6iRGwNfmuWCRKDG7V1ghgxzRYkK39XmXCZ
         BT43+O4igt6tOsyBIbb3A2X3Vjp9jd8x42HdQoKq+2/sFV3VjoPRt6RxXihWgN2D/SeM
         zClQ==
X-Received: by 10.152.87.143 with SMTP id ay15mr17510427lab.2.1378748570386;
 Mon, 09 Sep 2013 10:42:50 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Mon, 9 Sep 2013 10:42:50 -0700 (PDT)
In-Reply-To: <xmqqtxhu3qil.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: lc8GxjjkMPN-3FCPE8X-B6xlQro
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234352>

On Mon, Sep 9, 2013 at 12:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nazri Ramliy <ayiehere@gmail.com> writes:
>
>> Subject: git: run in a directory given with -C option
>>
>> +-C <path>::
>> +     Run as if git was started in '<path>' instead of the current working
>> +     directory.  When multiple '-C' options are given, each subsequent
>
> I think this should be `-C` to typeset it as "typed literally".
>
>> +     non-absolute `-C <path>` is interpreted relative to the preceding `-C
>> +     <path>`.
>> ++
>> +This option affects options that expect path name like '--git-dir' and
>> +'--work-tree' in that their interpretations of the path names would be
>
> Likewise for `--git-dir` and `--work-tree`.
>
>> +made relative to the working directory caused by the '-C' option. For
>
> and here.

I agree with all of the above, however, the unfortunate typesetting in
these cases was chosen deliberately to be consistent with the
immediately surrounding text. A separate typesetting normalization
patch, either before or after this patch, would not be unwelcome. (I
forgot to make such a suggestion in [1].)

[1]: http://thread.gmane.org/gmane.comp.version-control.git/233719/focus=234234
