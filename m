From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Wed, 18 Nov 2015 13:36:42 -0800
Message-ID: <CAGZ79kbD54fubzozMD51fTpP1v-6bbBoBtKn=fibLuwMmiioKA@mail.gmail.com>
References: <CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
	<CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
	<20151113233807.GD16173@sigill.intra.peff.net>
	<20151113234116.GA18234@sigill.intra.peff.net>
	<CAGZ79kaUZ08GXZjKtYNmRYOCQ0EQpsGd8+6PYFDU1LxYLw818g@mail.gmail.com>
	<564A279C.6000802@web.de>
	<CAGZ79kbh_8oBRnQAmDzh3LANS6iGXNjLkYMLfuk9iysXghHQXg@mail.gmail.com>
	<CACsJy8D-TRJ---4BYrEZeEkd9_5-xgGp4U0nB9YHNtV3zgxrbg@mail.gmail.com>
	<20151117214347.GB27862@sigill.intra.peff.net>
	<CACsJy8Ah2PgO8CunCvWiKB7RfqMfovWa1a7ro5scHFK+AEAXpg@mail.gmail.com>
	<20151118211158.GA32071@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>, Terry Parker <tparker@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 22:36:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzAPQ-00047G-Ks
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 22:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202AbbKRVgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 16:36:49 -0500
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34639 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757176AbbKRVgn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 16:36:43 -0500
Received: by ykfs79 with SMTP id s79so86222260ykf.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2015 13:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ta6WSpvnyGswwoDa3M2GzQWvUq76oVqhQeXVl50fYvQ=;
        b=VTc4kCoQTevju8G+MeikPXz00FbyVbZNJ11x6AkVbJfjZyaM9cy995EtVgEBD9qn5C
         pVYOvLsMuS/m3NiVNGKvFMsn5EQhqLzXpVtc0bb+sXGvbvl8tkFFPB8sITkzB4czLYlN
         rwyd0zlYBOpoGLJSwkZxpR26q/wcu+4P2wURlPM3EsMSgXtWCGbt6lkxPh3bl1OefSnc
         kD8umQ0NfewDi3X3aAoxI8n21grsoKvxy0ZiA7nTzSIFTigJzevEHCVuNNdgEA92qvsc
         XznSuYegjgYh2MLiTdN0gY9hcYTD7gYXymQtn5qLryTmaouWpr1aU4CRV/j7WBQllyyR
         CBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Ta6WSpvnyGswwoDa3M2GzQWvUq76oVqhQeXVl50fYvQ=;
        b=NDhfeyazArmMLJsJFpZvHken5OzeSmdAj/AbZfGZa9K7jUbnDROip3K3yFBn3/S42A
         q3tul1bZw2Uo3LH1RaCpYx1diCpWIYq4NXdEjPq5yq0nU2LP6lzQz4e2ARPcxPzfZjmW
         cOxsYxucGcraHu3y2LaMNdfuWfOsKdmaoyx+XNEVSTplem8YPDpzhVI4RF4CZY/kQiF3
         vNVb71tiH7Y6bgIrtZxdOJ3ast+aUEwR41ICS8EsafV6/CGVV0+WEwlbojj9X/WEkwwq
         G5y8snl3R3UuDOJYlxj0/GMpNe15csDpA+QelKsQNad2JFW+0rwcfWGQ3t4bAn+rusET
         a0hQ==
X-Gm-Message-State: ALoCoQl+OFJSWEqFtWhRASUDkUMr60/EsDlZDAru2FeRiGPqSiGlS2rnGxNv15EAvxWQR2Y4dIYG
X-Received: by 10.129.133.69 with SMTP id v66mr4289636ywf.68.1447882602382;
 Wed, 18 Nov 2015 13:36:42 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 18 Nov 2015 13:36:42 -0800 (PST)
In-Reply-To: <20151118211158.GA32071@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281460>

On Wed, Nov 18, 2015 at 1:11 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 18, 2015 at 01:32:36PM +0100, Duy Nguyen wrote:
>
>> Yeah I think that was the 10k commits in Shawn's mail: the number of
>> commits we may have to walk until we hit a reachability bitmap. It
>> looks like C Git will create a bitmap every 5k commits, not 10k,
>> though, if I read the code correctly. The point is reachability test
>> with the presence of pack bitmaps is not O(n) anymore. Which is
>> probably good enough for now.
>
> There are some pathological cases, though. I hit one recently that still
> took 40s to do "rev-list --objects --all --use-bitmap-index" (it's 80s
> without bitmaps).  The problem is that it has over 20,000 refs. We try
> to put a bitmap at the tip of each ref, but it's tough when there are
> that many.

+Terry, who did optimize the JGit implementation for bitmaps,
as we also had a "lots of refs" hoarder repo, which underperformed
before.

>
> I suspect there's room for improvement in the commit selection in such
> cases. That code hasn't really been tweaked since it was originally
> written, and repositories like that are extreme outliers.
>
> -Peff
