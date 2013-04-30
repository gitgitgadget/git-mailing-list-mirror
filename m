From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Wed, 1 May 2013 00:20:17 +0530
Message-ID: <CALkWK0nBs0R3UJMN=JqcCFetQ4KCxE9XhqGp=83b7DiMdysfLw@mail.gmail.com>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
 <87zjwguq8t.fsf@linux-k42r.v.cablecom.net> <20130430150430.GA13398@lanh>
 <7vehdsf19m.fsf@alter.siamese.dyndns.org> <CALkWK0kzjg+CPw8hq6ZAZxqVGdp7cf6HN-XHFCjbkNk9O=M5CA@mail.gmail.com>
 <CAMP44s0=5KniGDnVtKPg5sp=G8M-mPcq+Mu1nXqODfhT-MaNyg@mail.gmail.com>
 <CALkWK0kLZ9WLVcPBWuQZCjOku4A+WQ7=YeooPmKGpk9HuGYQnw@mail.gmail.com>
 <7vwqrjdh6v.fsf@alter.siamese.dyndns.org> <CALkWK0kcuaXTKbafmC72C3H+UZN6oeEY140T21LJUHveO=UBvA@mail.gmail.com>
 <CALkWK0n=Pkutg9cMXYV_+QmSXLROuU46wCEJfQkxEcNMFsOTgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 20:51:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXFdn-00068c-K9
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 20:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933035Ab3D3Su7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 14:50:59 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:48167 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669Ab3D3Su5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 14:50:57 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so1043559ieb.40
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=evWJdmE7v1UlXWMCgGuUVLYWG9tm5gFXvIXG3jna5ww=;
        b=urDu22uBw1NyEwyLNw3wD2iQBKGC7ishAj+Bk0n6OKzOHeh3uauQ4Ev/OCoUFHNypZ
         IZ/UrHpnrq2LCtpROgeHjyHewibP+RTSxeBHFAd6BSiaWYRr7KayrbLE2M7sOQuBM4xe
         YBZAMoEJCnhxbbRoJFYgVQ6q3wnbd8onrym+icZQhnCSTxegIPBV/3Riu+C/kHf7u83x
         3q8K8ILL8PXxazjMUW5ny73Ba5WZEBT+mcGWl5JhlO3oqyaBT61w1H/ZF4ZKVZgpYe/0
         XpgvGvoIrxQMdVPy2ByNES/DZTn1QmXKlsSNhtokpFt0BJi8VAuRjaZFpohJH1kBLAhk
         98ew==
X-Received: by 10.50.66.197 with SMTP id h5mr10773777igt.63.1367347857394;
 Tue, 30 Apr 2013 11:50:57 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 30 Apr 2013 11:50:17 -0700 (PDT)
In-Reply-To: <CALkWK0n=Pkutg9cMXYV_+QmSXLROuU46wCEJfQkxEcNMFsOTgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222988>

Ramkumar Ramachandra wrote:
> So, without the .git/@, @@{1} will complain that
> the reflog only has 1 entry (in other words, it is "correct" but not
> useful).

Even better idea.  When not overridden, @@{<n>} will show the reflog
for HEAD.  To the user, it looks like @ is behaving like a true ref by
keeping a reflog, but we're just cheating.
