From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Wed, 1 May 2013 00:10:26 +0530
Message-ID: <CALkWK0n=Pkutg9cMXYV_+QmSXLROuU46wCEJfQkxEcNMFsOTgQ@mail.gmail.com>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
 <87zjwguq8t.fsf@linux-k42r.v.cablecom.net> <20130430150430.GA13398@lanh>
 <7vehdsf19m.fsf@alter.siamese.dyndns.org> <CALkWK0kzjg+CPw8hq6ZAZxqVGdp7cf6HN-XHFCjbkNk9O=M5CA@mail.gmail.com>
 <CAMP44s0=5KniGDnVtKPg5sp=G8M-mPcq+Mu1nXqODfhT-MaNyg@mail.gmail.com>
 <CALkWK0kLZ9WLVcPBWuQZCjOku4A+WQ7=YeooPmKGpk9HuGYQnw@mail.gmail.com>
 <7vwqrjdh6v.fsf@alter.siamese.dyndns.org> <CALkWK0kcuaXTKbafmC72C3H+UZN6oeEY140T21LJUHveO=UBvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 20:41:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXFUO-0004hH-60
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 20:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655Ab3D3SlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 14:41:08 -0400
Received: from mail-ia0-f169.google.com ([209.85.210.169]:58622 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758953Ab3D3SlH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 14:41:07 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so742054iag.0
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Uox40efVPz42xE5lP6MfT2ckisQIv9oNrqnwZu0GKH8=;
        b=H2JvyWLqoqk/tlXR5nUD51bfuOBvZji9JgBsytG4E4iTcs01FOd05waCMQ0+uCt/1+
         wLuT/HMH58z2hf0z7IVzYCXPpN+7JtE2mLoEXs45nH4QQz3sduGmu8rMfeNKl9RBtFci
         LKE849vvf78TFCFGrjEr5N78U+/1fW0jYFX3RvaSb9gftzBw/1KWVlLRsw8hvIzgfeFe
         aS2jdErryFuY2Geo3CvRZor+Ecf19sGzu6PIINTNtstJijFhfSISg/Cast9RtogAJiEV
         x7wzXUXqtncedh8j/0giJP3rBt+Wsk0BOzomHCwo9dvwmUWyz0d5EeSDnPpcvhUyHcLV
         ecQw==
X-Received: by 10.50.73.65 with SMTP id j1mr4768588igv.49.1367347266548; Tue,
 30 Apr 2013 11:41:06 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 30 Apr 2013 11:40:26 -0700 (PDT)
In-Reply-To: <CALkWK0kcuaXTKbafmC72C3H+UZN6oeEY140T21LJUHveO=UBvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222985>

Ramkumar Ramachandra wrote:
> Therefore, @@{5.minutes.ago} should work with my implementation too.

Caveat: we won't keep reflogs for @ unless the manual override .git/@
is present (what's the point of keeping a duplicate of .git/logs/HEAD
in .git/logs/@?).  So, without the .git/@, @@{1} will complain that
the reflog only has 1 entry (in other words, it is "correct" but not
useful).
