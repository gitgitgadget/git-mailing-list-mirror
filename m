From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Tue, 30 Apr 2013 19:02:38 +0530
Message-ID: <CALkWK0kx28+bfBYZ8bGyDoQ_+2bVVbeqvZ8DK7qe_ZVyVsBVtw@mail.gmail.com>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com> <87zjwguq8t.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Apr 30 15:33:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXAgO-0005yn-6L
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 15:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760460Ab3D3NdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 09:33:19 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:43592 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759580Ab3D3NdS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 09:33:18 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so580392iej.30
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 06:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=tv5SBuBNKinhbnzsoCEgwKqBoVDZKJds8N0EO3H/PEQ=;
        b=RA7IVgvpCmdlc06aSvTdi3hVWy7py6LGUlGwwEBxtCC4HpEH1IrfdBdrE7L+/UXDbo
         Ph7UNqh5uxj9XfGYcPB5paMuOd9WV1X77Pv6w8LGFlDxQBNztWFZF7/AyLOQisrJgP3X
         sGAyYqS6c5uCF9P6bLCEHiAummYSbtFGTpIlINoZlIFx45Bc/srGz33Plk5VX4O45vDp
         pffWudaCXimiyse3rn8H60Ebksl1WEJjN4f2NcM3gRFAeuAlcbeOr5ABvD8NmX3A874Y
         D5bbxaldw29oItfOp44XxaeGw/sJZ7uDMfluZhjrhMu/Rq4fQzTI833JkF1IgldkxuTD
         behw==
X-Received: by 10.50.57.200 with SMTP id k8mr10385106igq.44.1367328798302;
 Tue, 30 Apr 2013 06:33:18 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 30 Apr 2013 06:32:38 -0700 (PDT)
In-Reply-To: <87zjwguq8t.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222936>

Thomas Rast wrote:
> But then why don't you just 'git symbolic-ref H HEAD' for a sort of
> "local alias"?

Yes, I already have @ pointing to HEAD.  And I think it's much nicer
than H (also since H@{u} doesn't resolve [1]).  The purpose of this
patch is to standardize @ for everyone.

> What annoys me more is that there's no way to say
>
>   git symbolic-ref U @{u}

That's because the part after "ref: " in a symref is expected to point
to a concrete ref, and doesn't go through the get_sha1_basic()
machinery.  Making symrefs peel recursively might or might not be a
good idea; I haven't thought about it enough.  However, it's not my
itch: write a patch and start a discussion?

[1]: http://thread.gmane.org/gmane.comp.version-control.git/222852/focus=222916
