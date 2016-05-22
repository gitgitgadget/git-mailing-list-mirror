From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCHv8 0/5] pathspec magic extension to search for attributes
Date: Sun, 22 May 2016 18:45:38 +0700
Message-ID: <CACsJy8CpYmp9t01RSeVY_UAw=zPmhGTY1TZ_p2E2zLuu7LpXhA@mail.gmail.com>
References: <20160519010935.27856-1-sbeller@google.com> <xmqqiny9j2sc.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZvZQxPUkECupvqk0KRbq-pRK6y=GksOiYn_zz+TM=dBA@mail.gmail.com>
 <xmqqshxdhi76.fsf@gitster.mtv.corp.google.com> <CAGZ79kYx_pX81bmpyXCvJSVsZW=t3VpBizUPQ90Wz9=HdG42UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun May 22 13:51:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4Ruo-0005td-3G
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 13:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbcEVLvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 07:51:23 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:38267 "EHLO
	mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbcEVLvM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 07:51:12 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 May 2016 07:51:12 EDT
Received: by mail-it0-f45.google.com with SMTP id l63so16504172ita.1
        for <git@vger.kernel.org>; Sun, 22 May 2016 04:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=frHc211Ur3kH7RTrHPKk9KIZiJMyucj+MpoYCxKbdAU=;
        b=f7zErgkVlwAWx3wpj2Qhl4puSqsTgZPERJIKRJzbL/L4m3WiBHFMTetQJD/8iIE5A7
         XSbsOTzxvfJhMdG3T3PE6AZKVgASrx1GM1xQXked9A7eI63fOqH9cXvQhjDAaclJ0445
         cp5q+LMQHj5uTfO8W18z8SpFXEhq6vSJo5hLRsaFvGwg4KN04ecybqgqmxmGFMi7AAY5
         THQEAQVSLBUzni3EMO2wSL6S16Vl3nzeIrJ414hp1IdT4yTzl4KhP8Y9m4Umdvw3K07n
         Q1fsTOER6TTG9NU+n5nC12c5QoLogx5wAfbPv1BEhsW2f8Aje7FOn3We5O18aymzQ8UD
         euRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=frHc211Ur3kH7RTrHPKk9KIZiJMyucj+MpoYCxKbdAU=;
        b=eg9PUjGAmqyiBEZJBZp+oNggxo1vaiQ2IbSa0SWk63Woo3/qNRV8a0EZH4HOCTUIXq
         GXl1aopNvWneNiuZb5JAok9i9amHhNbQL+4kdn/LZw/MHysKlsQDL6Xznnp5YSFP9bTJ
         Twah2l+XE5Brab9rJOxZJ1aNJElm87y//Bs/6XuUB8c/itOVLZzHJgQ/IfbKv9jhI/Gp
         YnnPTiCptYS7k8KS1r/sfBGymYe1WdX1MQXx742JlyGPMlmcEaMmDL/5e0xsOYNrUudK
         q5KnjRxHVsr2sQwtNZGptWJM8CxTMrdZykepHbilZaDaVf4CJiPhEejfox5BkZqTyDF0
         M4dg==
X-Gm-Message-State: ALyK8tINVWLCBygzqotNGQRj/YVJWGfndVPbfvabrjyWxwpq7SdE3hf058TjuvtoFHO4PPNgJSlZyonIHgD7wA==
X-Received: by 10.36.211.4 with SMTP id n4mr4355454itg.57.1463917567729; Sun,
 22 May 2016 04:46:07 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Sun, 22 May 2016 04:45:38 -0700 (PDT)
In-Reply-To: <CAGZ79kYx_pX81bmpyXCvJSVsZW=t3VpBizUPQ90Wz9=HdG42UA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295284>

On Fri, May 20, 2016 at 4:25 AM, Stefan Beller <sbeller@google.com> wrote:
>> My take is to pretend sparse checkout does not exist at all and then
>> go from there ;-)

Hehe.. shameless plug, narrow checkout [1] should be its great
successor where everything is done right (famous last words). Maybe I
can convince Stefan to finish that off then I'll finally bring narrow
clone!

[1] http://article.gmane.org/gmane.comp.version-control.git/289112

> Using these pathspec attrs are a good example for why we would
> want to make it more generic. Imagine a future, where more attributes
> can be codified into pathspecs and this is one of the possibilities:
>
>     git clone --sparse=":(exclude,size>5MB,binary)
>
> which would not checkout files that are large binary files. We could
> also extend the protocol (v2 with the capabilities in client speaks first)
> to transmit such a requirement to the server.

I think you need narrow clone there ;-) It's the first step to have a
clone with missing directories. I think then we can extend it further
to exclude (large) files.

> Why is sparseness considered bad?

It does not scale well when the worktree gets bigger. It can be slow
(but this is just a technical problem I haven't spent time on fixing).
And it does not enable narrow clone (not with lots of hacks, I think I
did just that in some early iterations).

> If I wanted to just do the submodule only thing, this would be a smaller
> series, I would guess.

No no no. Do more. Start with narrow checkout. I'll help ;-)
-- 
Duy
