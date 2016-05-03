From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-stash: Don't GPG sign when stashing changes
Date: Mon, 2 May 2016 18:21:19 -0700
Message-ID: <CAPc5daXVBJ=2KJfqcdwyH1Eq54vw-QeOEBF1aGj2dn+Yihcy9A@mail.gmail.com>
References: <00000150dddb0eeb-b77240fb-1b63-4676-ac4b-1220b8d011ca-000000@eu-west-1.amazonses.com>
 <01020154733c27e9-deaa7a20-1de6-416a-a7d4-3229854117eb-000000@eu-west-1.amazonses.com>
 <xmqqoa8oqg19.fsf@gitster.mtv.corp.google.com> <CAEnbY+cu9E8DYGcg8FoK37NGZXbhSKvzVwMpLUEspXRYpPUdaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Cameron Currie <me@cameroncurrie.net>,
	Git Mailing List <git@vger.kernel.org>
To: Daurnimator <quae@daurnimator.com>
X-From: git-owner@vger.kernel.org Tue May 03 03:21:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axP1z-0007Fj-Rn
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 03:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933534AbcECBVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 21:21:41 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34360 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933224AbcECBVk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 21:21:40 -0400
Received: by mail-yw0-f195.google.com with SMTP id i22so432678ywc.1
        for <git@vger.kernel.org>; Mon, 02 May 2016 18:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YWd4tOmRdt8tQNrSvsGTapDhwe761UlvFWHkuMOyFKs=;
        b=SygFEUGgObmhvd0TE1ABQdoLr8P8mPf4UOp3eS5Uj/cbeyXEzDuqZ7owx9KjvTnGEJ
         DSIB19s3mwygOacZWyD7e/xPiuBhKCCgex6phCsBfD1jIFlmo4CuhaktFkWbIgWf/gcc
         JRjXQybqa3FTvMynv88g7jNCYM7G2lXGxmcynWUoZgUBpfnJVb7eekj46xa16aru9EBg
         8awcgTZFp3PCLf1P2z7HAg5929Oc3IVJD/8MYeUetd0cQgsPwUX+/4R3AcIv5r3nLV2y
         8jb3/wv52OEQeGa2+VlTAlflEk10sD9MQwDTuOX8tlCRFtum2MT0XiGh5YhwR7gb4YZe
         FOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YWd4tOmRdt8tQNrSvsGTapDhwe761UlvFWHkuMOyFKs=;
        b=BZGPdwMWHUGFxt2tqlRAT1M7dztVeHpU/5QQIp+DGJxbSCFkw0RJHcI6wSdxNi045F
         /2letqQyLL8mEtlYm0irNwZljMmNhe+5Nx/gOeBiCsqmApyYcXWtIQLbEdbXwmHrAs/S
         DdYOA8RtzRBY0bNu47KOykcfTOgjtN0isDaM8tRC8EO30l4UOyOysHvK9JnSoDEKQlln
         gwkjOGGGThYAyIpQTLJ+yGj//BcZUO4t/k9k3+TOAcPulAnclnl8lb51VLD5dzz01L3e
         BHH7wMKsq0kDx79g6YwmbE/X6G21f3mVPhTdMA+TH2Q0yfZ3IUkaQ5VjMPoQU0w6TDlo
         lGhw==
X-Gm-Message-State: AOPr4FVSDr3kuR/covldGqUmLF+9b5Ef1OPTF3Y6+lH4RXo0L9urTJgc8DRKAKQ3Uc2USs4r8C+WciqRb08HWQ==
X-Received: by 10.13.215.75 with SMTP id z72mr23266290ywd.278.1462238499214;
 Mon, 02 May 2016 18:21:39 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Mon, 2 May 2016 18:21:19 -0700 (PDT)
In-Reply-To: <CAEnbY+cu9E8DYGcg8FoK37NGZXbhSKvzVwMpLUEspXRYpPUdaA@mail.gmail.com>
X-Google-Sender-Auth: 4Q8LPjiYSHepBnmrX77ako3lEI8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293316>

On Mon, May 2, 2016 at 4:56 PM, Daurnimator <quae@daurnimator.com> wrote:
> On 3 May 2016 at 07:57, Junio C Hamano <gitster@pobox.com> wrote:
>
> I agree quiltimport should not, but I think filter-branch possibly
> should... at least for your *own* commits.
> I often think of filter-branch as an "advanced" `git commit --amend`

But it does not do the gpgsign thing only for your own commits right now, and
even if it did, you would not necessarily want it to always use the configured
setting. That means that the command, if it wants to work well with the signed
commits, must learn to honor command line option to enable or disable passing
--gpgsign option to underlying commit-tree *anyway*.

So I think it is a right thing to fix commit-tree to ignore
commit.gpgsign at least
by default.
