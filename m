From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: How do I run tests under Valgrind?
Date: Sat, 22 Sep 2012 01:28:27 +0530
Message-ID: <CALkWK0kWvrirPjXXzBBBQxKDcwpd_+nQ2eeT6SE8gDFW5T7WFQ@mail.gmail.com>
References: <CALkWK0m_9OsAfG_pF3hUDW+EKCyZCn9NiDKKEW6AEOMmAw=yuA@mail.gmail.com>
 <20120917172022.GA1179@sigill.intra.peff.net> <CALkWK0m378ApSwa1xiYUqEjMny5m0wt3KacqdDRU1qt=cw6k8g@mail.gmail.com>
 <20120917173531.GB1179@sigill.intra.peff.net> <CALkWK0kDPGY_3v5SLPtyf+azUwA7msvQOvA+MaCgueZ71i2yGw@mail.gmail.com>
 <20120917174439.GD1179@sigill.intra.peff.net> <CALkWK0mkBbY7dUyaZAqqKE3ZMfE_xU6em_KCOKM9nsTjUP-9pA@mail.gmail.com>
 <20120917182957.GF1179@sigill.intra.peff.net> <CALkWK0=nMxNfmAaBTmXeADQubTayC_2_ut5Nq3QXba9yfQr9yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 21:59:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF9NL-0000Ug-DY
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 21:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757979Ab2IUT6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 15:58:49 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:57765 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757923Ab2IUT6s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 15:58:48 -0400
Received: by qcro28 with SMTP id o28so2897283qcr.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 12:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FfA6/MKMRUZd0JAeX0wRbtJXWgUYV7Y25UJUOhivj6g=;
        b=w5TqRomUQi3WCcmrSQYoBjVEZs4kYuvA2zlX4VdCmDUJR2azFyaX53RkntxJrZ7fOU
         NJEEqSvA7wcstTl3RNXdH/MrhKgAp5TUx0vTFywasBOdoGFoUUD0o4Gmk4bQeeewQRFU
         WWgmtp8NWZ8ffgk+ay496Ce65ZJb0keCNvnxe3atPHpCAYCZZeud2I8nQv2BgcXW5C44
         5RT18aA54DYzt28mdRO8TblkE0OxJnyiHzM3AOOaKgqPQYLwdRt+8px5Tss2AmbsEqS0
         VXp8ewnJbtjqHfIS/Tf9f5hlVh6fYQ0MOG61OJNEDDQg+hkx+Hl4uyuG95Qb8CvLcz29
         UG9g==
Received: by 10.224.10.11 with SMTP id n11mr14774558qan.23.1348257528246; Fri,
 21 Sep 2012 12:58:48 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Fri, 21 Sep 2012 12:58:27 -0700 (PDT)
In-Reply-To: <CALkWK0=nMxNfmAaBTmXeADQubTayC_2_ut5Nq3QXba9yfQr9yA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206155>

Hi again,

Ramkumar Ramachandra wrote:
> I was able to reproduce the problem on all my machines, and I consider
> this very disturbing.  However, I was successfully able to corner the
> issue. I have an overtly long $PATH that's not getting split properly
> by `IFS=:` in one corner case -- in other words, this shell script
> fails to execute properly when called with `--tee` (just set a really
> long $PATH and try):

Oops.  Looks like it has nothing to do with an overtly long $PATH.  It
has something to do with $SHELL being zsh though, because other shells
work.  Looking deeper into this.

Ram
