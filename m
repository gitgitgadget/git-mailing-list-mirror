From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH v5 4/5] p7300: add performance tests for clean
Date: Tue, 28 Apr 2015 21:36:36 +0200
Message-ID: <CAMpP7NZM2CUbL_UEJozbgzb9yDnSp29B4hj7XY4pVKA_OZDgRg@mail.gmail.com>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
	<1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
	<1430030985-14499-5-git-send-email-erik.elfstrom@gmail.com>
	<20150428063311.GN24580@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 21:36:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnBJB-0005uE-TU
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 21:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030853AbbD1Tgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 15:36:37 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33857 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030737AbbD1Tgg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 15:36:36 -0400
Received: by obfe9 with SMTP id e9so4327534obf.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 12:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Muuoj/eP5MdbHIjvKkssIO0dMvpU58d0FniXvkcxDBM=;
        b=awSIrTKMKEH7vIaEvupW/tly8pk1kXMip9JMpqmoeDNTPvhG3aFSt4vEbDdJYaVCKm
         cSRYqwXu3/q/ri03dgj3k1e8xTdTry36b95jF07c3FQHvEobNZEnUUQDhlJ64AX9uZ/K
         tVWcJ3s+dE9UgeJzFqMH4zveMBb7QYSw18LndFnZGrZt47o3fAf37zvmBpRjC0uPHvwk
         510Ka4vlJOznRwe91VJY2DgNUng1RBcuj4dGuCLOFY4rCe7KvnFKIGEDC1RrLXroRSSQ
         M9C5aJ/0buE0mgUK6HUS+5FiCYAisYg8u//lht2mWRb6QYKAeQZSEPzrxNoCCTDmEdGi
         WHxQ==
X-Received: by 10.202.72.213 with SMTP id v204mr15023840oia.116.1430249796073;
 Tue, 28 Apr 2015 12:36:36 -0700 (PDT)
Received: by 10.182.154.72 with HTTP; Tue, 28 Apr 2015 12:36:36 -0700 (PDT)
In-Reply-To: <20150428063311.GN24580@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267935>

On Tue, Apr 28, 2015 at 8:33 AM, Jeff King <peff@peff.net> wrote:
>
> Do we actually need a large repo here? The real cost is coming from the
> directories we create. We could actually start with a totally empty
> repository if we wanted (though I don't think the t/perf system handles
> that right now). But if there's not a reason to use the large repo, I
> think using test_perf_default_repo is better, as it works out of the box
> without specifying extra environment variables (well, it works either
> way, but you get a nasty warning from perf-lib.sh).
>
> -Peff

Sure, I'll change this to the default. I wasn't sure about the
performance characteristics of clean (does working tree size matter?)
when I started so it felt safest to go with a large repo.
