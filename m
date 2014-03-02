From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] implemented strbuf_write_or_die()
Date: Sat, 1 Mar 2014 22:08:23 -0500
Message-ID: <CAPig+cRgc4UtmJMieS9Mdrz7vjUNiu7QFu1PSBppKo22Ln5G-A@mail.gmail.com>
References: <1393672871-28281-1-git-send-email-faiz.off93@gmail.com>
	<CAJr59C0e22OuDWU5Xc0A=cc+zY32nfum6SXTDU3wLCPyFPF70A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Faiz Kothari <faiz.off93@gmail.com>, git <git@vger.kernel.org>
To: He Sun <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 04:08:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJwlp-00050V-PK
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 04:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbaCBDIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 22:08:24 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:65362 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbaCBDIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 22:08:24 -0500
Received: by mail-yk0-f171.google.com with SMTP id q9so6804997ykb.2
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 19:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=BOP/kGgvWK4LokKoSW2hBS9wkYfeX7SjE0ooNTqY8eo=;
        b=wlNLl6Ft0VDYilI1x4YJYLUs+EdSqZdHEwSklZOjLBSNzkdwCcMVPau7fBEv2VqTR1
         U8FoSvcy7QXxSqJhIjPIXrLvhTHGfHaGNaxWJpJClDLx0ShaETYcSTXEcpWxTb6UcLwB
         Y+XGRMIjV/EXJlaRAt7ng/m5Iu2Cvy8kWoL1wxfggH1NRx353CdR82H5Kesto95q2UUt
         rJcEglq5pDNzPJnARyyGpLJTVqnMx/G8VMjvtRKngNMw2KtSLeOv0rM3bU+104bROIA/
         SZjEZ81Qi3VgHLdXFnE6c+++EqfHyAHNq/2zC4Cv7Iq+kajzyCcpkUMHvtZrzgwiMr2L
         0ejA==
X-Received: by 10.236.66.143 with SMTP id h15mr11654655yhd.36.1393729703602;
 Sat, 01 Mar 2014 19:08:23 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sat, 1 Mar 2014 19:08:23 -0800 (PST)
In-Reply-To: <CAJr59C0e22OuDWU5Xc0A=cc+zY32nfum6SXTDU3wLCPyFPF70A@mail.gmail.com>
X-Google-Sender-Auth: hS-zLPyvRzNG92tpKkvL_yCyUxM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243126>

On Sat, Mar 1, 2014 at 7:51 AM, He Sun <sunheehnus@gmail.com> wrote:
> 2014-03-01 19:21 GMT+08:00 Faiz Kothari <faiz.off93@gmail.com>:
>> diff --git a/remote-curl.c b/remote-curl.c
>> index 10cb011..dee8716 100644
>> --- a/remote-curl.c
>> +++ b/remote-curl.c
>> @@ -634,7 +634,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
>>         if (start_command(&client))
>>                 exit(1);
>>         if (preamble)
>> -               write_or_die(client.in, preamble->buf, preamble->len);
>> +               strbuf_write_or_die(client.in, preamble);
>>         if (heads)
>>                 write_or_die(client.in, heads->buf, heads->len);
>
> This should be changed. May be you can use Ctrl-F to search write_or_die().
> Or if you are using vim, use "/ and n" to find all.

It's not obvious from the patch fragment, but 'heads' is not a strbuf,
so Faiz correctly left this invocation alone.
