From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v5 0/3] pass credential.* to submodules
Date: Fri, 26 Feb 2016 16:37:23 -0800
Message-ID: <CA+P7+xo_LU0-B9MbHefCuba2yDauKj87XGjpeuku31ZAptF=2A@mail.gmail.com>
References: <1456532000-22971-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 01:37:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZStJ-0003rV-Nd
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 01:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517AbcB0Aho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 19:37:44 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36934 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158AbcB0Ahn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 19:37:43 -0500
Received: by mail-ig0-f175.google.com with SMTP id z8so46485236ige.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 16:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XUY78eduWu8nxpwmuYRNqAsjdUf9PC+UFulfxqR+VsU=;
        b=kEm8XKj3FXjsXM7GxUyIU6hFi3xd6JK2OTrEOFDrqJL6weWr+q/tvIN08W9h1PP8QM
         5wyrXIQuVanHrZaNP7oBWXa2adWKaEyD0wiU4dH+4vnUpCvuurs7PkQD64wFf4L+6ZSI
         n/Dfxp17Z5Sg30K/X4TjYb0JBlZM70yb9CCUjELJrQ92WrZc/sVrEQvjYGnpyMDiK1HJ
         V97IDGDkulZEtH1ci6dXJLIctQQe++aQXe5N56znQ7USOgbZP5R7KgLqcbx8cfh2i7Da
         4Qyw0dFZ2ObY5m4NIzw2FMk6UT3iNPw8DZd9LqxYdmRhFYY4f1IAvqTveWHIWqlbrtux
         TBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XUY78eduWu8nxpwmuYRNqAsjdUf9PC+UFulfxqR+VsU=;
        b=NBjo6VlFEnB1Z+Uep2nKOomWEPCyDNZjqqESA76H7RmMu5xgZTV6TG8G6A5fRk0KPo
         dYKxk9/aLyTI0spOu1U7QLsf2qDaoHhNFXmUqplNMfPMzHr6UTrHA97ynhdT6MCY9MPM
         ORiXCw+hjY1wsp6S0vb4K19PPlnKt/iYDcz4azrKeHFbdMyiAJP2wj9z67TxxO+eu54I
         BYQVtyLcEHL3CoSK0HoPtUR9WtY8MPrfeo8Q9c9oqm3oNYQCev6OwvlWUKdfHwWA8im/
         Uook/urO9DxfKIjT3GIEYcpGJZVSpgVBtCi1LZ6ZqdNQb9srB3UQM6hRUKGuqAmzk0Cq
         pkAQ==
X-Gm-Message-State: AD7BkJITblhwYZxkWzkMGNz23a43JH4sXLmCYRVNT34nI2rkP4ViSaQuv3ovC+vsxjROM/kR+l3jEO1xGQHW+Q==
X-Received: by 10.50.43.168 with SMTP id x8mr642275igl.92.1456533462715; Fri,
 26 Feb 2016 16:37:42 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Fri, 26 Feb 2016 16:37:23 -0800 (PST)
In-Reply-To: <1456532000-22971-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287650>

On Fri, Feb 26, 2016 at 4:13 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> This version of the series fixes up a few issues and implements
> sq_quotef function to help make intent more clear in the code. I also
> chose to use Jeff's implementation for the test fix since I think it
> works better and I prefer the consistency of implementation.
>

Junio, I didn't use -4 when sending email so the patch which fixes
apache.conf is not here. I still need it myself for running the test,
so it should be queued somehow.

Regards,
Jake
