From: Daurnimator <quae@daurnimator.com>
Subject: Re: [PATCH v2] git-stash: Don't GPG sign when stashing changes
Date: Fri, 6 May 2016 16:06:11 +1000
Message-ID: <CAEnbY+cAzLKw9GJTWy5ZP4rGsve161qSX5DgqWimcC5kYRqkyA@mail.gmail.com>
References: <00000150dddb0eeb-b77240fb-1b63-4676-ac4b-1220b8d011ca-000000@eu-west-1.amazonses.com>
	<01020154733c27e9-deaa7a20-1de6-416a-a7d4-3229854117eb-000000@eu-west-1.amazonses.com>
	<xmqqoa8oqg19.fsf@gitster.mtv.corp.google.com>
	<CAEnbY+cu9E8DYGcg8FoK37NGZXbhSKvzVwMpLUEspXRYpPUdaA@mail.gmail.com>
	<CAPc5daXVBJ=2KJfqcdwyH1Eq54vw-QeOEBF1aGj2dn+Yihcy9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Cameron Currie <me@cameroncurrie.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 08:06:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayYuO-00050m-63
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 08:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbcEFGGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 02:06:16 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35074 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbcEFGGP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 02:06:15 -0400
Received: by mail-lf0-f65.google.com with SMTP id u64so12307372lff.2
        for <git@vger.kernel.org>; Thu, 05 May 2016 23:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daurnimator.com; s=daurnimator;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=FeqMaj6VXZlY63eE9gzIIREqlygJtg/Yb+D7yu4U5DY=;
        b=CO5Ez4SERwCyNTx3Ka3B9FfJWBDaAhMnUyNYd8NE3eTs+lSeVhrCdWCsEocXjjMiT2
         Y6dsjpSIlcImeu2YwebWaBeWo/BJhENgz01mbYLl+8MTDp/9ZL3+VMy1b38EFx1tWeKS
         dBFfqAsVK14GFCdO01X53c8DGcwqgS4YgEwGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=FeqMaj6VXZlY63eE9gzIIREqlygJtg/Yb+D7yu4U5DY=;
        b=nII+SaVl/J6CFSfoIU7oRa9g+0EglDCEw9Hs5WqnE0Xj65gWFGiKYbc/OKcjhwkI97
         +0nmvWd0zPwUtoLMUXZk/6826ujlFhSElc7h/JFEDpF9BPspm9TI2BDCn4QfNWaU9px+
         jF+vsQAC/zvCj7zOsp/Gdt48BRcNqKpzHxVJofjk3D7mW5sUKp5+y1vIZKJCXJ1G6mAa
         5gfJC5s02ztDRNGBbUSY6A+Q8ciYYQGTtQ9RZ5rcIhTd9uheKaHsbnX8ZSd1SRZ/0pNN
         aDZPdU7pzutQIwmepy08lrmihlfijkQMLC8QWTb0ZPEjYVxesMtyvcyWpB9Z6tVJAWMm
         E6FQ==
X-Gm-Message-State: AOPr4FXnbZ6Z9JBYBNXhDX7QDs7BOhoMnyD4SakXq7Q6D78VMzUiqm4AWL6l7cvMJok6Vg==
X-Received: by 10.25.159.3 with SMTP id i3mr7611667lfe.137.1462514773304;
        Thu, 05 May 2016 23:06:13 -0700 (PDT)
Received: from mail-lf0-f54.google.com (mail-lf0-f54.google.com. [209.85.215.54])
        by smtp.gmail.com with ESMTPSA id r3sm2121983lbj.26.2016.05.05.23.06.11
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2016 23:06:12 -0700 (PDT)
Received: by mail-lf0-f54.google.com with SMTP id u64so120467616lff.3
        for <git@vger.kernel.org>; Thu, 05 May 2016 23:06:11 -0700 (PDT)
X-Received: by 10.25.213.18 with SMTP id m18mr9229841lfg.0.1462514771613; Thu,
 05 May 2016 23:06:11 -0700 (PDT)
Received: by 10.25.141.10 with HTTP; Thu, 5 May 2016 23:06:11 -0700 (PDT)
In-Reply-To: <CAPc5daXVBJ=2KJfqcdwyH1Eq54vw-QeOEBF1aGj2dn+Yihcy9A@mail.gmail.com>
X-Gmail-Original-Message-ID: <CAEnbY+cAzLKw9GJTWy5ZP4rGsve161qSX5DgqWimcC5kYRqkyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293742>

On 3 May 2016 at 11:21, Junio C Hamano <gitster@pobox.com> wrote:
> On Mon, May 2, 2016 at 4:56 PM, Daurnimator <quae@daurnimator.com> wrote:
>> On 3 May 2016 at 07:57, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> I agree quiltimport should not, but I think filter-branch possibly
>> should... at least for your *own* commits.
>> I often think of filter-branch as an "advanced" `git commit --amend`
>
> But it does not do the gpgsign thing only for your own commits right now, and
> even if it did, you would not necessarily want it to always use the configured
> setting. That means that the command, if it wants to work well with the signed
> commits, must learn to honor command line option to enable or disable passing
> --gpgsign option to underlying commit-tree *anyway*.
>
> So I think it is a right thing to fix commit-tree to ignore
> commit.gpgsign at least
> by default.

Okay, that makes sense.
Will you work on a patch?
