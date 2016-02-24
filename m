From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] git config: report when trying to modify a
 non-existing repo config
Date: Wed, 24 Feb 2016 20:29:59 +0700
Message-ID: <CACsJy8CuLPCYAtNn4u-RYHhL=LqGJH_GFNwbAWHxfdAximLtug@mail.gmail.com>
References: <c4027d758b0914dbc2e1ff5df344b0669aac4447.1456299545.git.johannes.schindelin@gmx.de>
 <b225aec8c83a184f90dc6bfa821177b52ef4b3f4.1456318031.git.johannes.schindelin@gmx.de>
 <20160224125930.GA1422@lanh> <alpine.DEB.2.20.1602241425180.3152@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 24 14:48:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYZnX-0003HT-9a
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 14:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbcBXNsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 08:48:07 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33202 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757281AbcBXNab (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 08:30:31 -0500
Received: by mail-lf0-f46.google.com with SMTP id m1so11821305lfg.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 05:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CJTAlc5uOvU556u6FyE5C4TqWv/CJWqDMkzabW/RYDs=;
        b=KGXk6FHMU+TkI647f/KzlDh9c+hkf7ilaUSYWmBDDtQhmvM3j/s4VCYzopT6RxTvbn
         /F1dA9FIX/RpUeIUttk5rLDskyXotByZdT67uoXe8Ak0rbRIDpOXaKrN0PqtBWa+BEvc
         64C9Ta7ufGq+0rO5sT14r+Y39qecxmtjR2q7gjeeOWAiXUzcIz8t83YxTLFcmmeRu97c
         9MHZRdSiWcxXIqGcnC40KUiIUGRaHFDdgnxElcMvfbbm4A1u6cVWPkqQ82q1cL1ZOGwo
         25ZQVnd0VppPMKzkgYRH/rityWAbaC+dmCo2cEZ9WR66l3JsSgGo6JzVuII99tu+bMQ8
         PV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=CJTAlc5uOvU556u6FyE5C4TqWv/CJWqDMkzabW/RYDs=;
        b=Ex22X5dEFmDDjQAEPncHswF9U4+5SLQ37Tiv2WZ6OOy7I/pGjSLK0F12DVGSlH/EaY
         zq1lxTfO3czxjb0T6c+rH5S7uykvZPwVp/Ois8o0cXcOfvZjue5GzaOU3/6BWWSYiyWK
         fKku1BzUJNoi8iPAhga8annVwqHi/dN01z8bBshGBp9r51uC97VdFc838fJMqEEq4v7D
         k3sps1CSJ8zPo1gbUzY/L4cfahhvYLnHEHSQmBMhprlDHPEF6KhnaNtYnGTcjpe71fiC
         4nW2NrxWSd6YlpJ07+9KwZ7uHo3OtMsCDXmFP3yfpLYFaO9Eh05gPMTJaIx+blnWdTC3
         AyeA==
X-Gm-Message-State: AG10YOReYjLaHeidW0FuqMDZE41sfRPDyN7RNtRx3CSpznfJBTcBc4LAVUDJ5jOcJCiAOuyrgG7dvsNMLgBbLw==
X-Received: by 10.25.147.202 with SMTP id v193mr14922621lfd.162.1456320629550;
 Wed, 24 Feb 2016 05:30:29 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 24 Feb 2016 05:29:59 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1602241425180.3152@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287211>

On Wed, Feb 24, 2016 at 8:26 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Wed, 24 Feb 2016, Duy Nguyen wrote:
>
>> On Wed, Feb 24, 2016 at 01:48:11PM +0100, Johannes Schindelin wrote:
>> > +           die("not in a git directory");
>>
>> Maybe wrap this string with _() for translation? Then we can pile this
>> patch on top to fix the rest in builtin/config.c.
>
> Given that the context lines contain die() calls *without* _(), I would
> find it more logical if your patch patched also the line I introduced,
> together with the other die() calls.

No problem. I'll go over all changes in 'next' and 'pu' some time
later and try to fix them all.
-- 
Duy
