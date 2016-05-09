From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t6302: simplify non-gpg cases
Date: Mon, 9 May 2016 17:37:54 -0400
Message-ID: <CAPig+cT_njtzMuuk=mFWraUtpZwU3OrJPho7=dbLgKf=inBFAg@mail.gmail.com>
References: <dea0877d-fe83-fb47-4df3-21fd69d8421d@web.de>
	<20160509160725.GA11861@sigill.intra.peff.net>
	<CAPig+cQ2kSVzy0K303J3Guhk3-NzcReb5V7ohqOy2pPL_5GrSA@mail.gmail.com>
	<20160509164859.GA8231@sigill.intra.peff.net>
	<CAPig+cQPbwM0+6yruK0VKKq2ujFLoCLogS7eQNN7WWgRjG5V0w@mail.gmail.com>
	<CAOLa=ZSZqs=++Hf8CF3pWEnJqmOA9ajuX03hzLMkuQ+ehXXCVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 23:38:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azssK-0007En-5Q
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 23:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbcEIVh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 17:37:56 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34236 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbcEIVhz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 17:37:55 -0400
Received: by mail-io0-f181.google.com with SMTP id 190so186433455iow.1
        for <git@vger.kernel.org>; Mon, 09 May 2016 14:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=eHYFtX4xbY19BIm29hU3Y1gHdRWcx/mx8lr5F9Y1+Ow=;
        b=pkh9UasKDRWUHWk2yL8VpSHaF1xI0pVcrFqSrrzbX6W3NTWGmtVPLkToOCUpUYXwBa
         jE0cI3j+wShb0uJucBExiveSLYF9U43andq8eEW6hSzRXKcd1KoWyWrGlMT0pKZ/oWlf
         e7saqDsmiHyuLBxrt39SXhvw3SUBD/aLBmSKAFjNjomKgqhwd+nQP0phOv1nxcRiKlDA
         urAo5Cxiw+4MpJQUHeRSyVL8BJUYT/AZJzMaoNNPjluALXZnIhXS/AyzPtk+ARq0TpQ1
         x/hxbjs0Ge3VPgX9gAtrOvSY6UU1TX6xUYf62hr6Xtn3lIhesnNHkGiBAYqx0IZQ4+EZ
         9dNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=eHYFtX4xbY19BIm29hU3Y1gHdRWcx/mx8lr5F9Y1+Ow=;
        b=JZOp7YKoxvWVOJbB42LG9RjPBSdBWpwS/m0A4F9J2qvTJAc6EiPPwx4Cz1n9vXXkyz
         JISbbi9b8hBd0ThYfBY7ZhDAlsbqkrbwXSbbwCbvK6askJUjalgXwFtODEg7f+vivkna
         nsz+NVRh9m+wawk/3ZiFY3tDEYrIpLFQQmBdAycvhZ8v+6saE0mAr55M92e5FISKeDF/
         n6q5pRo63rGD8AuRW0i+JIoOeU9/g3X/lmBnoEUabZU+O6TPxlcU7J0y5+8OGG+5V58l
         Boz1ePc5sh7L3ipB1j21fiGSZnlYnkqgPnGp9EXYjPj7ku7xApkKSnIpZC+NFOjnC8gA
         CLoQ==
X-Gm-Message-State: AOPr4FVgB6/d1bbDsHtilW9FiX1ndTKo6hY8DevQ83giBivcTgUFJ6Sf+FTgmVg8Gvjg+jr5NvpNbEy8llGETQ==
X-Received: by 10.107.132.66 with SMTP id g63mr42948672iod.34.1462829874430;
 Mon, 09 May 2016 14:37:54 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 9 May 2016 14:37:54 -0700 (PDT)
In-Reply-To: <CAOLa=ZSZqs=++Hf8CF3pWEnJqmOA9ajuX03hzLMkuQ+ehXXCVQ@mail.gmail.com>
X-Google-Sender-Auth: cpNKyEnWyqi_7SzcNBnfsm58fLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294074>

On Mon, May 9, 2016 at 4:24 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Mon, May 9, 2016 at 11:17 PM, Eric Sunshine <sunshine@sunshineco.com>
> wrote:
>> Should we cite bc9acea (ref-filter: implement %(if), %(then), and
>> %(else) atoms, 2016-04-25) here as an example of a commit for which
>> this was problematic (and which indeed broke the tests when GPG is
>> unavailable)?
>
> But it's still in pu and I'll be re-rolling it, would that be acceptable?

Ah right, therefore, no reason to cite that particular commit. Peff's
description is fine as-is.
