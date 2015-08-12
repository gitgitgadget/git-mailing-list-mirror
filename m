From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v5 0/4] submodule config lookup API
Date: Wed, 12 Aug 2015 12:13:56 -0700
Message-ID: <1439406838-6290-1-git-send-email-sbeller@google.com>
Cc: hvoigt@hvoigt.net, git@vger.kernel.org, jens.lehmann@web.de,
	jrnieder@gmail.com, peff@peff.net, wking@tremily.us,
	sunshine@sunshineco.com, karsten.blees@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 12 21:14:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPbTd-0001vy-Iq
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 21:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbbHLTOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 15:14:06 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34728 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbbHLTOE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 15:14:04 -0400
Received: by pdbfa8 with SMTP id fa8so10314978pdb.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9tDGkdaes0X6n7IRGmZxzbAe+oDM4qMDMl5DFUbiCM0=;
        b=VbwjfGepowsI7UomPGWU+7qbY9rPbYbIEJtBjMnXIrNIlW/UNwcix56g+xIU4IAsbE
         8yZ3/tqfu44t+9fCdXE8xwMOcpbVMNNHMZio294WXC3Nz82JOxNGjFvJv8iSC0nBamvV
         H72iTtbO5kuwM1vPFudKb5cQl77G7mAVAnlQHOfGN3sRdfWLpXmGfeA03ifbqzS6Bg7K
         QN1RARYTbHVwRGQel9YAfmUSd3xbIl5MbJFCypOZTRn+LMq85d8mXwXRz3jjVKAPbj2f
         0px3iMS0qXQP+mJ0fN5bvWvVonKD7sUPaQXQtPPKtRD53FIbsOgyCLJTZWZtza4g8Mt7
         WCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9tDGkdaes0X6n7IRGmZxzbAe+oDM4qMDMl5DFUbiCM0=;
        b=golQVTLrHQvqZvSr4zji1kFEKEaqZROj9D6uSuWaQENm7MR/n4Yhl+nS7f9aoH6oxt
         XesOj6H9HJJ55wHHjI86PUF5XEcy60b+NCwaAiK1yV4quNrhrCbkFT8JQkdh9Se4/O3M
         tah3bXiomIWaKGuPrawSPYywggJQ340dR//R8wZl5UkYph8mQOAYmoLeai1BDHEV3oVm
         TPTHBmlzUPhZu5969Z4NjNObOq3XLHpcJ+0PcH/C7aHm/Nr2lraM7VoWUzM57HgZliSV
         EGJ2OQAwKZSgSzCG9Ys5zQDny28Qv2aKF9ijrv1aalIDY6V03DV0BzuzXCR7LGw1BN2K
         JdYw==
X-Gm-Message-State: ALoCoQkBlN3trcZ14TMHcetrwg3RQBtq65zG0fOqjDrT4Z5dFNJm4lMN5ekIj6X1rCRrMqmSYI5T
X-Received: by 10.70.101.200 with SMTP id fi8mr23793031pdb.139.1439406843517;
        Wed, 12 Aug 2015 12:14:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:d1d0:bd1:5138:d709])
        by smtp.gmail.com with ESMTPSA id iw8sm4611052pbc.21.2015.08.12.12.14.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 12:14:02 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.234.gefc8a62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275800>

On Wed, Aug 12, 2015 at 10:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Mon, Jun 15, 2015 at 2:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Thanks.  Will replace and wait for comments from others.
>>
>> I have reviewed the patches carefully and they look good to me.
>
> OK, I recall there were a few iterations with review comments before
> this round.  Is it your impression that they have been addressed
> adequately?

I payed only little attention to the previous rounds and the review comments
thereof, because round 5 was up for quite a long time and nobody commented so far.

However just as I was convinced of my review and sent out the email, I started
working with it. And I found nits which I'd ask you to squash into the round or
put on top.

>
> Do you prefer it to be rebased to a more recent 'master' before you
> build your work on top of it (I think the topic currently builds on
> top of v2.5.0-rc0~56)?

Looking at the reviews for the "RFC parallel fetch for submodules"
I'd like to use `argv_array_pushv` which was introduced via
85b343245b (2015-06-14, argv-array: implement argv_array_pushv())
and is already in origin/next, but not origin/master.
But as I first work on the submodule--helper (both the small helper
functions as well as the whole "update" thereafter), I think this
dependency is not a pressing issue yet.

>
> Thanks.

Stefan Beller (2):
  Fixup hv/documentation
  cleanup submodule_config a bit.

 Documentation/technical/api-submodule-config.txt |  3 +--
 submodule-config.c                               | 12 +++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.5.0.234.gefc8a62
