From: Taylor Braun-Jones <taylor@braun-jones.org>
Subject: Re: [PATCH 0/3] git-clone fails when current user is not in /etc/passwd
Date: Thu, 10 Dec 2015 21:20:55 -0500
Message-ID: <CAKfKJYvXfW+hOFcC=TUybLhkVbRm9dznaTAiHCO+RM14nGPbDw@mail.gmail.com>
References: <CAKfKJYsyHn7FUOu65AqbvjZD-wAyRScjqUL6kgGDCVzG1myZTQ@mail.gmail.com>
 <CACsJy8AQFSvcxKqSdWfvGArV60RA96WcvvofpfJ4EuG+q_=t0Q@mail.gmail.com>
 <CACsJy8Dc3Lsqa2zccoqH7UkDitqDbOTX3EXsUCcN9OHY=LfaKw@mail.gmail.com>
 <CAKfKJYuP1E5aC7SPO91j-KS-P41pYaM7NkTJ9uG6b=VvxbOBwg@mail.gmail.com>
 <20151210183426.GA27609@sigill.intra.peff.net> <xmqqtwnqgjpm.fsf@gitster.mtv.corp.google.com>
 <20151210204034.GA29055@sigill.intra.peff.net> <20151210213228.GB29055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 11 03:21:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7DLF-0006US-JA
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 03:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbbLKCVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 21:21:46 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34471 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbbLKCVR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 21:21:17 -0500
Received: by qgeb1 with SMTP id b1so177794003qge.1
        for <git@vger.kernel.org>; Thu, 10 Dec 2015 18:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=braun-jones.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VB3B4RhH5vssNifEV7saOxK6sGfwMCtbXP1gIXcKaZM=;
        b=gM9yUUlfi08guMYKIRB32ZOEozz8jRBKgBPQQwK3yGxevTljw77htqU0VL900dlFvg
         RNj6XQro6o3Ioeq8tSXSSxa2pYGHiK+tiIsUGmeRJzyRnSKsXT20XGlgMzfIg0faHZPg
         ifLXT6OUK5rJVBscRwUS9mfPIeH3U6vck+kx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=VB3B4RhH5vssNifEV7saOxK6sGfwMCtbXP1gIXcKaZM=;
        b=jPQIawjrISifSqP/zLE8ZLA7PnMkXlTiQFtjq4u2pkV7HkHtJ+m/zj1Pe92hNY4/N4
         iEX+Om655pGGxnRlr7wPmRCe6D3dyIF3TikdjqytpCEzgkyFmhfC744yxq7G6gi5KBvI
         p3Nb+UGf28E8JIE78V8JgcBItHgqqfqOD5+gAAMd18di8QYlKGsjh3n5DnNWieB2dWyQ
         gwOM9DTf4fX7q25nJFlDnzarD/B6awdF7X+HNt/tTOyGAoVy/4UthQthHecYKaM0nzmM
         dBUwnWTKFzmF+kouUMqEsFohvAyIqT5imRLw/mvJH5dRv/VV03M46VGLGdu7rqS2MNHb
         iQyA==
X-Gm-Message-State: ALoCoQnVP6pLNzykgx90khdnRaBqpszMT2JnKPSG5513dJMz7y8b2uzxWLw/SlLvqrh1MKTr0aQIcojQOcXOikLmaBpo7vcLEw==
X-Received: by 10.140.23.83 with SMTP id 77mr19632174qgo.58.1449800476408;
        Thu, 10 Dec 2015 18:21:16 -0800 (PST)
Received: from mail-qg0-f51.google.com (mail-qg0-f51.google.com. [209.85.192.51])
        by smtp.gmail.com with ESMTPSA id b107sm7318662qga.10.2015.12.10.18.21.15
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Dec 2015 18:21:15 -0800 (PST)
Received: by qgec40 with SMTP id c40so176432521qge.2
        for <git@vger.kernel.org>; Thu, 10 Dec 2015 18:21:14 -0800 (PST)
X-Received: by 10.140.254.69 with SMTP id z66mr11376612qhc.5.1449800474971;
 Thu, 10 Dec 2015 18:21:14 -0800 (PST)
Received: by 10.55.128.198 with HTTP; Thu, 10 Dec 2015 18:20:55 -0800 (PST)
In-Reply-To: <20151210213228.GB29055@sigill.intra.peff.net>
X-Gmail-Original-Message-ID: <CAKfKJYvXfW+hOFcC=TUybLhkVbRm9dznaTAiHCO+RM14nGPbDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282249>

On Thu, Dec 10, 2015 at 4:32 PM, Jeff King <peff@peff.net> wrote:

> So here's my solution, which instead carries the "is it bogus" flag
> along with the default strings.
>
>   [1/3]: ident: make xgetpwuid_self() a static local helper
>   [2/3]: ident: keep a flag for bogus default_email
>   [3/3]: ident: loosen getpwuid error in non-strict mode

1 definitely makes sense to me. As a newcomer to the git code base, I
was wondering why it wasn't this way already.

2 and 3 solve my original problem - thanks!

Taylor
