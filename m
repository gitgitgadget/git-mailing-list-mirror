From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH v7 2/5] setup: sanity check file size in read_gitfile_gently
Date: Sun, 14 Jun 2015 19:21:44 +0200
Message-ID: <CAMpP7NZ2tqZ5cv=9=gJqDZ5m0LOZtsHGvt-ntZcp6cBA6X5tqg@mail.gmail.com>
References: <1433874279-30720-1-git-send-email-erik.elfstrom@gmail.com>
	<1433874279-30720-3-git-send-email-erik.elfstrom@gmail.com>
	<CAPig+cTQKxD9WRV3spVce=SfeECo4XR_ujZ1sGecuhTL-3DeRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 19:21:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4BbT-0004ZO-MY
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 19:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbbFNRVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 13:21:47 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35281 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbbFNRVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 13:21:45 -0400
Received: by obbgp2 with SMTP id gp2so50396202obb.2
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 10:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tdlUUf+wJW/ucZ8ywuuxrCi3piSru5mTgrW+C6odBf0=;
        b=rXgZNpZLooL0BUyw1Jr3ZUv1s2z/XYrAObsxM9Qoznx6GROHpMYX64Sf/9UjWpsvMw
         gJVLzfOavTfuGE8e0uVX1gR0eaOuD79KbGYc+AFw2GkG4827D6qlCLzkpwYOxBOIN+mV
         RBKy/Tab8G/NeFMjHd9tikaKg9dpZAb/I9NZBcyQXENEbTJRL9jm2/kvb3Th8dAutlSZ
         ItfCeCjTyOYd84M6uwT0ZCZy6Sf2aKVWChmb4Yh+p6jKQNE/YiBYFlTlF/WBPzBL2DFs
         mjDBE9jhWOkaAwgPNbat77w+AbWOUcBXvkbFTVTF6D6xTwSf07z4Jadz5TxlhGR1RlMG
         kGAg==
X-Received: by 10.202.72.207 with SMTP id v198mr19431260oia.116.1434302504575;
 Sun, 14 Jun 2015 10:21:44 -0700 (PDT)
Received: by 10.182.116.35 with HTTP; Sun, 14 Jun 2015 10:21:44 -0700 (PDT)
In-Reply-To: <CAPig+cTQKxD9WRV3spVce=SfeECo4XR_ujZ1sGecuhTL-3DeRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271641>

On Sun, Jun 14, 2015 at 5:42 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> This variable name doesn't convey much about its purpose, and
> introduces a bit of maintenance burden if the limit is some day
> changed. Perhaps "sane_size_limit" or something even more descriptive
> (and/or terse) would be better.
>

Would you be happy with this change?

-       static const int one_MB = 1 << 20;
+       static const int max_file_size = 1 << 20;  /* 1MB */
