From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] diff-tree: do not show the sha1 of the given head with --quiet
Date: Thu, 23 Jul 2015 22:13:39 +0200
Message-ID: <CAHGBnuMdpGHm7wGSA9qCAqns=nd5F5-vg9g4AW9Z6k-4NYk3jw@mail.gmail.com>
References: <0000014eb518dc87-a69705c4-31e7-4983-99a8-f780a743aeac-000000@eu-west-1.amazonses.com>
	<xmqqmvyoq6gh.fsf@gitster.dls.corp.google.com>
	<CAHGBnuM5TG6m7Rwd-EZTUXnaDNYomidthmCamCevNECTQCTnmA@mail.gmail.com>
	<xmqqegjyrfrq.fsf@gitster.dls.corp.google.com>
	<xmqq615aregb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 22:13:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIMsD-0004NP-3p
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 22:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbbGWUNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 16:13:41 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37874 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758AbbGWUNk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 16:13:40 -0400
Received: by igbpg9 with SMTP id pg9so54684igb.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 13:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IQojEbQmNiEVMt3wzHQ73ulFSQiQlQwbhtahtdmq1fg=;
        b=ZaT3XQXlMrFlWQakvqQeKqaEzYBPvTZDPayvLNFE97VUdTCiTax+XY4VL88SA253s4
         lvD3B8dV/FxKlwtxM9RT6IYr+3JqVWHdhddvTZCnVedgZWoiaNKl62010bEFoqbsrDDJ
         6U2YTCM/k/6ilPRohYfNwmEV9GGUhNop205X1uogHUaXSkeffy2P9/s11NuUS0asun+K
         AltoGEtI/cAgF5TiwIlQSkiE/iE5sbgfOE47b0dOxVbxWX0NFL7Ht0Rky/o9pUxGSYFM
         Gni8ucOzbzHPNy1xW12ygaqNi1lpTRICCJd1VRMUymHv2rUYJOaGowVnPDs7wdffJRyt
         CInA==
X-Received: by 10.107.46.96 with SMTP id i93mr15896855ioo.102.1437682419577;
 Thu, 23 Jul 2015 13:13:39 -0700 (PDT)
Received: by 10.107.29.149 with HTTP; Thu, 23 Jul 2015 13:13:39 -0700 (PDT)
In-Reply-To: <xmqq615aregb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274523>

On Thu, Jul 23, 2015 at 7:06 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Existing scripts by definition would not be using a new option you
> will invent that used not to be a valid one.  So that would be one
> way that you can shorten your script without breaking other people.

True. If it was only for shortening my script, I still could do ">
/dev/null 2>&1" which is just as short (or long) as a newly introduced
"--really-quiet" option. But I'm also concerned about consistency and
making options do what they sound they would do.

> In "git rev-list ... | git diff-tree --stdin" output, the commit
> object name is absolutely necessary, with or without --quiet, as it

Why is printing the object name also necessary with "--quiet"? I'd
argue that any script that uses diff-tree that way uses --stdin
without --quiet, just like you do in your example, so suppressing the
object name if "--quiet" is given probably would not break as many
scripts as you think.

> But we do not live in an ideal world.

True, but we should never stop striving after making it one :-)

-- 
Sebastian Schuberth
