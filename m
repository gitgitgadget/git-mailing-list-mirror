From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 05/18] convert trivial cases to ALLOC_ARRAY
Date: Mon, 15 Feb 2016 23:32:25 -0500
Message-ID: <CAPig+cSn29QtcWKRAaKMDzObuXetEySrVtLogkzfZXKXjPeufQ@mail.gmail.com>
References: <20160215214516.GA4015@sigill.intra.peff.net>
	<20160215215154.GE10287@sigill.intra.peff.net>
	<CAPig+cRTz4Fb10JDWLjmTEXzQ+FbvmKU51A9B3vmwBepDX+BYA@mail.gmail.com>
	<20160216042346.GB27060@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 05:32:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVXJP-0000SO-Ed
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 05:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbcBPEc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 23:32:27 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35407 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbcBPEc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 23:32:26 -0500
Received: by mail-vk0-f52.google.com with SMTP id e6so123132024vkh.2
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 20:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dlgfnGmrMFJG98hJxlu1hJfukDvnnlNjuMb3CMa86zw=;
        b=F6H494uSv38+1R7t3TTpQhZZz/0iApFxRZKcTbvdO4CVkqr3/KxtIgmmX1DuRcOuql
         gLCaGLjcTUfglJzsS8lZ0tU2niM+sVAThOpzYkEo1kq2bdY2xWysCfuZMpQ/sSbYpRAy
         oWciLt1ByZjxSGs+EzCmae1RhDetjhgindgnMkR1WhxQDrkhxhR4JlYNSv2lK+dQG7NH
         Xqc9nHv80CX8Kk46NVokK+xQn223XLOvhcEGIaF4PQV7pdzBp2CJW3o+hJb7/tdndqmP
         gTqUgC/Jbpz3oZZgRf3YUtdWVyqKd8BoEccaFn6leRkcQctslo3v2w3hghNCIYdNJYd/
         H5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dlgfnGmrMFJG98hJxlu1hJfukDvnnlNjuMb3CMa86zw=;
        b=nLr4+zaiIvpHXxuyDLMxnAPofISIGTa+IJs+4JVLvJDzC5Jvo5iAUyx9jl44bhiCVk
         APWAVx0fZchV+Wouw3Yef5ZM0dLrhn5NXYMKitxRAdA2uFsHoUZoYUlOw2w5/SE6UaDj
         vmoY9YmaAADzYHhUn7x4lBeDX7hAeY9wlyeYlj4AOdbhzSkj5VOnMk/Z08jIsesOD0Ny
         xuhfQfRr0fmypiJOEZZE/BnvrQYr75wD3PY/LZYYNlbiEUR/XeCpOAy+ay4gc0LptBmb
         1VLSXEISRGl9sCmOQ7k4TgqPgMLD1dnsOwIgLwPU6PA4xFN2ru3vMWMKXtBrSX2U7Dcq
         A9tQ==
X-Gm-Message-State: AG10YOSef8VcIoTXk0ECVjE6OPRjj7ckyTcAXZew571BZ67T/ZZH5ptaxbY6JbWZo/5LJ4xUqHyp6KlXI9RAHQ==
X-Received: by 10.31.146.2 with SMTP id u2mr14077300vkd.19.1455597145934; Mon,
 15 Feb 2016 20:32:25 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 15 Feb 2016 20:32:25 -0800 (PST)
In-Reply-To: <20160216042346.GB27060@sigill.intra.peff.net>
X-Google-Sender-Auth: vxjkwwDHtnvR_ft3BTBQuSk1p1o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286319>

On Mon, Feb 15, 2016 at 11:23 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 15, 2016 at 11:22:12PM -0500, Eric Sunshine wrote:
>> On Mon, Feb 15, 2016 at 4:51 PM, Jeff King <peff@peff.net> wrote:
>> > -       path = xmalloc((n+1)*sizeof(char *));
>> > +       ALLOC_ARRAY(path, n+1);
>>
>> Elsewhere in this patch, you've reformatted "x+c" as "x + c"; perhaps
>> do so here, as well.
>
> Will do. I noticed while going over this before sending it out that it
> may also be technically possible for "n+1" to overflow here (and I think
> in a few other places in this patch). I don't know how paranoid we want
> to be.

Yes, I also noticed those and considered mentioning it. There was also
some multiplication which might be of concern.

    ALLOC_ARRAY(graph->mapping, 2 * graph->column_capacity);

It would be easy enough to manually call st_add() and st_mult() for
those cases, but I haven't examined them closely enough to determine
how likely they would be to overflow, nor do I know if the resulting
noisiness of code is desirable.
