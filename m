From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2] git: submodule honor -c credential.* from command line
Date: Thu, 25 Feb 2016 13:48:14 -0800
Message-ID: <CA+P7+xoMZA4TX2nB3VsgpjsozAf=0PaEDSGcyefFcnVfNwUVqA@mail.gmail.com>
References: <1456358352-28939-1-git-send-email-jacob.e.keller@intel.com>
 <20160225014149.GA31616@sigill.intra.peff.net> <CA+P7+xpfuPkwcdeXVTiTdqRCX16J4pus-wmxe7Sipu_GXCNSoA@mail.gmail.com>
 <20160225070036.GA5654@sigill.intra.peff.net> <20160225071159.GA22529@sigill.intra.peff.net>
 <CA+P7+xqa8+DopurNGnuW1HKMOmj2r2mvahossK_11SyMSWm2_g@mail.gmail.com> <xmqqziuomsyi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 22:48:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ3m3-00079W-MQ
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 22:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbcBYVsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 16:48:35 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:33476 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbcBYVse (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 16:48:34 -0500
Received: by mail-io0-f182.google.com with SMTP id z135so103847995iof.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 13:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8NlsPQK/lyVB4lyPxuh9DtSOjqO/fIRYECwoSIY9hxw=;
        b=vaJOz2tudOE9tKkAnN1SiNIcCL/uQWl7ruPRmCCjG+rQD6y2UzekDfzUpjflgASsJz
         sDdc4bPX90qBKjT4y09vT8zxTCpcCvlKqgbqGELk1/87UV6OmWGNGgKc9DvBH3XzHvlc
         fCZk/q+V2naBXrxQ8zNttqpugK/qVmdN/pQkwrYNaL+fVrKys5pN/lNs4qKSmGnPt0Wt
         kxCE7JF/X38zyEjUGFsNrhG+7TlocbN3Q437hhRcgRhFMTV3rmeWIwsW2yoM/rzaGXxp
         Ppr9p75+5i3hBxHV3a+EB7cKr3uhhVK0rCR8YTfqmfJcGbJj4Ch8kw7w0FBOaVdviQk8
         ODXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8NlsPQK/lyVB4lyPxuh9DtSOjqO/fIRYECwoSIY9hxw=;
        b=a4ZFYoUUSfRXQUhZPZt/KtI26relsom49au17ssGVifvwZMC53zyX5jiGK+6RHP1tP
         hmc9xTNfJ7WfqSmCQplKA4/N9MVT4IDyTlUB2LfNWzKlV/yLEpQHT1tN9DDto9mNr9tC
         O9Mj7hHIUpOp+/mlXv5sJH/QQHadopIg6v7MICx1NRiag96tDTdrb3zBfhSqQ8iZJZdi
         8YXqwe4QbqVSBFNK1bUM+J6Uf/rIZTolscgmhVvq9rszFyW6CVM+asTvmP2vJALeJuv3
         XZ4hrwh0wMBRC1YOe0cLQ6mIrbrDvozJgOYXgT0H9i1YFZUd/+fHqhaKhbFJnhqVEBE/
         TmfQ==
X-Gm-Message-State: AG10YOTteH/2huTatquNu+tonG65UOmD2DVTOmu4co+ZJSVKYowEga3xwp0h6uehMLMoyFEk6TVPb8zSaqGCAA==
X-Received: by 10.107.156.14 with SMTP id f14mr6079151ioe.0.1456436914039;
 Thu, 25 Feb 2016 13:48:34 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Thu, 25 Feb 2016 13:48:14 -0800 (PST)
In-Reply-To: <xmqqziuomsyi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287442>

On Thu, Feb 25, 2016 at 12:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> On Wed, Feb 24, 2016 at 11:11 PM, Jeff King <peff@peff.net> wrote:
>>>  static int clone_submodule(const char *path, const char *gitdir, const char *url,
>>>                            const char *depth, const char *reference, int quiet)
>>>  {
>>> @@ -145,7 +166,7 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
>>>         argv_array_push(&cp.args, path);
>>>
>>>         cp.git_cmd = 1;
>>> -       cp.env = local_repo_env;
>>> +       add_submodule_repo_env(&cp.env_array);
>>>         cp.no_stdin = 1;
>>>
>>>         return run_command(&cp);
>>
>>
>> Ignore my previous comment. The cp.env API is *very* subtle. If the
>> line is just a name, it removes the environment variable, while
>> "name=value" adds it. That is definitely not what I was expecting
>> here, so I misread how it works.
>
> I think that is modelled after how putenv(3) is made capable of
> removing an existing environment variable.

Yes. It makes perfect sense once you read it, i was just very confused
at the initial glance because it felt like it was copying the entire
local_repo_env into the submodule child process. I just read the
technical API documentation and understand it now.

Thanks,
Jake
