From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 21/25] fetch: define shallow boundary with --shallow-exclude
Date: Mon, 15 Feb 2016 00:56:07 -0500
Message-ID: <CAPig+cSL--T7f5OdR2+b7t-AHof8TGb9=P8XKa2t3K3y2yu0MQ@mail.gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-22-git-send-email-pclouds@gmail.com>
	<CAPig+cQA6yV369b7hM_Q8aPuAwF8tR1xT=jr1r2PH1KsCtHWtQ@mail.gmail.com>
	<CACsJy8B=p0frmU8ahc9bnk-uoDPNUT_6UB0MVRPiLc9DqNz3vQ@mail.gmail.com>
	<CAPig+cR01WCgyJQuDcq-j5Z6u3S-LO5kUVuT+g-jdu-hoH-5yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 06:56:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVC8r-0004hW-HF
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 06:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbcBOF4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 00:56:09 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34484 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbcBOF4I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 00:56:08 -0500
Received: by mail-vk0-f67.google.com with SMTP id e6so7425939vkh.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 21:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2NMB7W6cXLy7m67OFUN7tYgZeHAGwRyJsdeKGxXVCR8=;
        b=FlShOyvZWtyt5XS805ZRbxZybrcZq6k7OwBMw3JDF2Se74PVI0wIAh5RXZ918/ysTt
         0rJ7/nMSqVgiwyp3WPUq4nlWESdaco4ud3/apAWc0YNwD998PEVbRXO9AgugzmUSDvYJ
         9ydmDtZcz9wAvxa7rkCbbNL1pB9+Anb5TKuDPI9xlZ9Chd8NVzib9PyDzYz8JUeutRGg
         wdctC5mPP/zB0cBxmiI9thZCcE1hZDnJ2kdVUKeIS8NBWEg+rIeuvG2URJ8EnN1pxaOb
         zjUGhhlzLlONUomJS71zuXzMTRVP6gGvCNYSB9Yz7c5Pm6eM0RgdRQ3I4BFXirp2EGbd
         jv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2NMB7W6cXLy7m67OFUN7tYgZeHAGwRyJsdeKGxXVCR8=;
        b=MbHrWmtC/J/n4q7WZ5zshoSoIrP431aGqMbxyjCVFAVU8uNDM2bmpUseqQsPb12UB6
         /Fgje7bDCZoaDLEPs878ElOwehcPiPmmAsD8ataUVWzCOGfpTTtFVRxlcRFBquUBnEDa
         upch8XE6s6+j2JWNAl9yRrUhE5SuqOpmrneb9JOw1a6rUz2lH9v87c5CoAU+aTiBWEDG
         7yUVywrUDCT1255SSLlYbmudlPHLiwJ+36BioABHBNcCozkKEbWMcylp20UCuKPEMYvL
         L+2GQAyhNmIdSEPIcMPOUqzxuD0cb3OkGTh8/lGQxyYhc2aVO4zYH0YV7dKm7FfdSItr
         zhhQ==
X-Gm-Message-State: AG10YOQfNVq6x48j3o6Du2xJVFX2tIL/hKzgtDZqAMPGfMAEOC5AGffu/Liq/C1xKSoY8Knh7+wpnh8aGK3KjQ==
X-Received: by 10.31.168.76 with SMTP id r73mr11814922vke.117.1455515767236;
 Sun, 14 Feb 2016 21:56:07 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 14 Feb 2016 21:56:07 -0800 (PST)
In-Reply-To: <CAPig+cR01WCgyJQuDcq-j5Z6u3S-LO5kUVuT+g-jdu-hoH-5yw@mail.gmail.com>
X-Google-Sender-Auth: 0HtW26zuK29DuS2Fpl5p8AulMYQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286175>

On Mon, Feb 15, 2016 at 12:52 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Feb 14, 2016 at 10:53 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Fri, Feb 5, 2016 at 12:26 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> Hmm, can't this be simplified to:
>>>
>>>     if (skip_prefix(arg, "--shallow-exclude=", &value)) {
>>>         if (!args.deepen_not) {
>>>             args.deepen_not = xmalloc(sizeof(*args.deepen_not));
>>>             string_list_init(args.deepen_not, 1);
>>>         }
>>>         string_list_append(args.deepen_not, value);
>>>         continue;
>>>     }
>>
>> args.deepen_not is const, so no, the compiler will complain at
>> string_list_init and string_list_append. Dropping "const" is one
>> option, if you prefer.
>
> Yes, dropping 'const' was implied. I didn't examine it too deeply, but
> it did not appear as if there would be any major fallout from dropping
> 'const'. It feels a bit cleaner to keep it all self-contained than to
> have that somewhat oddball static string_list*, but it's not such a
> big deal that I'd insist upon a rewrite.
>
>>> Or, perhaps even better, declare it as plain 'struct string_list
>>> deepen_not' in struct fetch_pack_args, rather than as a pointer, and
>>> then in cmd_fetch_pack():
>>>
>>>     memset(&args, 0, sizeof(args));
>>>     args.uploadpack = "git-upload-pack";
>>>     string_list_init(&args.deepen_not, 1);
>>
>> There's another place fetch_pack_args variable is declared, in
>> fetch_refs_via_pack(), and we would need to string_list_copy() from
>> transport->data->options.deepen_not and then free it afterward. So I
>> think it's not really worth it.

Upon re-reading, I suppose this also is an argument for keeping the
static string_list* rather than dropping the 'const'...(?)
