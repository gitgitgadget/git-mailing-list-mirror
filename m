From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv8 0/5] pathspec magic extension to search for attributes
Date: Mon, 23 May 2016 11:49:20 -0700
Message-ID: <CAGZ79kZPPdUK1=GB6fnHP0cJyoM_VYmDj3wizApN5iHdCQCUyg@mail.gmail.com>
References: <20160519010935.27856-1-sbeller@google.com> <xmqqiny9j2sc.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZvZQxPUkECupvqk0KRbq-pRK6y=GksOiYn_zz+TM=dBA@mail.gmail.com>
 <xmqqshxdhi76.fsf@gitster.mtv.corp.google.com> <CAGZ79kYx_pX81bmpyXCvJSVsZW=t3VpBizUPQ90Wz9=HdG42UA@mail.gmail.com>
 <CACsJy8CpYmp9t01RSeVY_UAw=zPmhGTY1TZ_p2E2zLuu7LpXhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 20:49:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4uv5-0002hQ-Nd
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 20:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbcEWStZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 14:49:25 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37262 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962AbcEWStW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 14:49:22 -0400
Received: by mail-ig0-f172.google.com with SMTP id l10so29280734igk.0
        for <git@vger.kernel.org>; Mon, 23 May 2016 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MTHvPqpdX1oMP3wWqWXvza5Qg3nICBYUFD6DqXsSWy4=;
        b=oN/8EvczB8jZ5t8EsITWt6p1ahDEsdWVY9VuJ8PbxYqZliLcG1z8zUohTF4Cc7sSvT
         LkL1ScIW7d/1cn4N8oRx66ffYN2Mcrg2uATsYceMv97XRWQSDp4kjs8XCn0y4CuIh9Eh
         LGdYVPys/WdUCaO6zjizhr6qgSUp2iuvOOz4dv3BiM89s0/Bfq7edcFt0ypD05aZVdk1
         XhECQMutLvnFfKTu51HVLZ1Pxr1sFkRVF0qrTDMW/etmxHx4RWSQzs0v5da2BhQcZnZf
         xwacVZ/50l+PhXjLnLovN20XVn78udyWp2j1ERtbqHfSAFHTcdkYk72ciNIBlV1V+aM0
         KFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MTHvPqpdX1oMP3wWqWXvza5Qg3nICBYUFD6DqXsSWy4=;
        b=SNOpbYqVFB6SZwERiCg0BYQtJZuVXfOkcD2eoodeTGqAETOcy1CTezL2lOFK5ylcqC
         r/Sqyj4RuJAU14k1H0pIMJF3HTyX4gSSb3U4WIHYeHTupgcgUkXSPRwqpmm3m6h/p8Rb
         W9JvdmPPc6YOyLH6PRtWne/Qi/ccAcJP8RBZyUrfDxZ+3L6KPhYHgSpF41BiCgExXysJ
         JpTXZVVVDSnmP+CEPM2U3PEoOo8o6hon4pfmDEj8y3jLFdH1Uiowkr1DifnPcimwOMH+
         RBTlNO6aagrZfug5FhJBhZICXUa3wRVUJzCo8eXSpu5z0bXNYWX3RrD7Tu5DRWbhB+JE
         YSrg==
X-Gm-Message-State: AOPr4FXknbG7g6TFdaI6PLbdsUJvrkZXWW02QzlYossrxyVBn7VZDUiJ8CwVeo6atiqdyIlVIMBCyBl/g97pEOPZ
X-Received: by 10.50.30.228 with SMTP id v4mr14322262igh.85.1464029361406;
 Mon, 23 May 2016 11:49:21 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 23 May 2016 11:49:20 -0700 (PDT)
In-Reply-To: <CACsJy8CpYmp9t01RSeVY_UAw=zPmhGTY1TZ_p2E2zLuu7LpXhA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295348>

On Sun, May 22, 2016 at 4:45 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, May 20, 2016 at 4:25 AM, Stefan Beller <sbeller@google.com> wrote:
>>> My take is to pretend sparse checkout does not exist at all and then
>>> go from there ;-)
>
> Hehe.. shameless plug, narrow checkout [1] should be its great
> successor where everything is done right (famous last words). Maybe I
> can convince Stefan to finish that off then I'll finally bring narrow
> clone!

I started reviewing that (see separate email).

So conceptually the narrow checkout is "sparse checkout just for
directories" IIUC.

A submodule is treated as a files (sometimes, e.g. diff) and sometimes
as a directory (e.g. in the working tree)

>
> [1] http://article.gmane.org/gmane.comp.version-control.git/289112
>
>> Using these pathspec attrs are a good example for why we would
>> want to make it more generic. Imagine a future, where more attributes
>> can be codified into pathspecs and this is one of the possibilities:
>>
>>     git clone --sparse=":(exclude,size>5MB,binary)
>>
>> which would not checkout files that are large binary files. We could
>> also extend the protocol (v2 with the capabilities in client speaks first)
>> to transmit such a requirement to the server.
>
> I think you need narrow clone there ;-) It's the first step to have a
> clone with missing directories. I think then we can extend it further
> to exclude (large) files.

But if we only exclude some files we are not having a binary
decision for a directory, so narrow checkout doesn't work here?

    git clone --sparse=":(exclude,size>5MB,binary)

would maybe lead to have
  dir/path.c #included
  dir/binary-asset.img # excluded

so it is more a sparse thing than a narrow thing?

>
>> Why is sparseness considered bad?
>
> It does not scale well when the worktree gets bigger. It can be slow
> (but this is just a technical problem I haven't spent time on fixing).
> And it does not enable narrow clone (not with lots of hacks, I think I
> did just that in some early iterations).
>
>> If I wanted to just do the submodule only thing, this would be a smaller
>> series, I would guess.
>
> No no no. Do more. Start with narrow checkout. I'll help ;-)

Thanks for the encouragement!
How is the interface going to look like for the narrow checkout/clone ?
If the UI is supposed to be very similar, we can merge the two concepts
and make it one thing.

But if the UI is different enough, we may want to keep it separate as
it is not as confusing to the user as we'd think?

What I imagine UI-wise, see
http://thread.gmane.org/gmane.comp.version-control.git/295221


Thanks,
Stefan

> --
> Duy
