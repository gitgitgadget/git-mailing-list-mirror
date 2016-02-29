From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv20 00/12] Expose submodule parallelism to the user
Date: Mon, 29 Feb 2016 12:40:08 -0800
Message-ID: <CAGZ79ka7Wrc4kzXWwi8c+6JC0FVC45g=fu-F6QxXFe37sm5GMQ@mail.gmail.com>
References: <1456773250-5510-1-git-send-email-sbeller@google.com>
	<20160229193222.GX28749@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 21:40:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaUc6-0002Yq-CJ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 21:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbcB2UkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 15:40:10 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:32927 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbcB2UkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 15:40:09 -0500
Received: by mail-io0-f181.google.com with SMTP id z135so200859274iof.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 12:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=aG8HxyjWuDyjosRlccwiEg0ENFElwWt6KcfeWY7WCBc=;
        b=BtCUosLwq9vtnDxan++N/+ta0lpkrdAo/f17O2FFp46KR9O4wiKvZ7In6/yzwa8vKd
         C18GUxHtMsS2HgcQosORXQ4u/+Lt3cnr0zeHxurNDuj198yTdoN3NvmqiiwrqwrtQJC7
         UIbJJz3pvhSit6BCvy0LHQeirohBsQ7QXGUGnD7gPqMrVBR+OrabZ2vu/TxjS9gxyjqw
         lVK+lKvlEkzvl4eGNUa2Fm/yn2Q0Vy41e2ypSkgInE9uCwJqRmk+paTHw5820oXZv2YD
         L5O+eG79qlB9ftcPPTWDIxVf4SkiBI1couMFsvHga9Lmopc1y3Qq8CTc+/47olbHy7DJ
         7FFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=aG8HxyjWuDyjosRlccwiEg0ENFElwWt6KcfeWY7WCBc=;
        b=PfdQD2aPwKMKoRV+Mm4mHm91kYYHXb5eF9pEiCmKJbg4eW92zrkFqcni0BLsGfpdpD
         pxsDWePfkoPt5jTZecv2i2qkoIaqnnKsxsTRGhkStjGTsWYl3SWOToSsrWeykG2WLAqL
         DrQFJUhZ37ap1lua/bxbajohXoL1xKRtZArFEsEL+7ubqhLuBvZoJtaZPB/A0GB8tXNd
         /IgZzhzVROHnHybdJ0wZy6mMtVrBfkzlVWXMc5W4kBnTKZzpOhm5HrQX5ZYF24vlghzB
         +jmTgyXRtkArtby/1MGPn+W7Ar482nPHzwh2q50HX6k2GQMZGe24KCTKLiPAaFqUYGnC
         fn/Q==
X-Gm-Message-State: AG10YOQAr/AMPppRbMPhih6IMf9fPI6o3sK+tTCwIm7GtWauTH/xLMo8q26vVCsO4GWGzhokI3zDeISYSBZVQZYg
X-Received: by 10.107.168.149 with SMTP id e21mr21133304ioj.96.1456778408681;
 Mon, 29 Feb 2016 12:40:08 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Mon, 29 Feb 2016 12:40:08 -0800 (PST)
In-Reply-To: <20160229193222.GX28749@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287895>

On Mon, Feb 29, 2016 at 11:32 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>
>> I added your suggestions as amending and as a new patch.
>
> I think we're at the point where patches on top would work better.  I
> admit I was a little scared to see another reroll.

Yeah I am a bit scared too, so I'll do patches on top for further fixes
after one last reroll, fixing the issues below.

>
> [...]
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -299,10 +299,10 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>>
>>       if (ce_stage(ce)) {
>>               if (suc->recursive_prefix) {
>> -                     strbuf_addf(out, "Skipping unmerged submodule %s/%s\n",
>> +                     strbuf_addf(out,_("Skipping unmerged submodule %s/%s\n"),
>
> Missing space after comma.
>
> Usual practice for i18n would be something like
>
>         struct strbuf path = STRBUF_INIT;
>         if (suc->recursive_prefix)
>                 strbuf_addf(&path, "%s/%s", suc->recursive_prefix, ce->name);
>         else
>                 strbuf_addstr(&path, ce->name);
>
>         strbuf_addf(out, _("Skipping unmerged submodule %s"), path.buf);
>         strbuf_addch(out, '\n');
>         strbuf_release(&path);
>
> Reasons:
>  - translators shouldn't have to worry about the trailing newline
>  - minimizing number of strings to translate
>  - minimizing the chance that a translator typo produces an invalid path

Thanks for reminding me of that practice!

>
> [...]
>> @@ -319,7 +319,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>>       if (suc->update.type == SM_UPDATE_NONE
>>           || (suc->update.type == SM_UPDATE_UNSPECIFIED
>>               && sub->update_strategy.type == SM_UPDATE_NONE)) {
>> -             strbuf_addf(out, "Skipping submodule '%s'\n",
>> +             strbuf_addf(out, _("Skipping submodule '%s'\n"),
>>                           displaypath);
>
> Same issue here with the trailing \n.
>
> If the strbuf_addf + strbuf_addch('\n') pattern is common enough, we
> could introduce a helper (e.g. strbuf_addf_nl) to save typing.

I don't think it is common enough yet.

Thanks,
Stefan

>
> Thanks and hope that helps,
> Jonathan
