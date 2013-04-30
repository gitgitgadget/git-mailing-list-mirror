From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Tue, 30 Apr 2013 23:52:28 +0530
Message-ID: <CALkWK0kcuaXTKbafmC72C3H+UZN6oeEY140T21LJUHveO=UBvA@mail.gmail.com>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
 <87zjwguq8t.fsf@linux-k42r.v.cablecom.net> <20130430150430.GA13398@lanh>
 <7vehdsf19m.fsf@alter.siamese.dyndns.org> <CALkWK0kzjg+CPw8hq6ZAZxqVGdp7cf6HN-XHFCjbkNk9O=M5CA@mail.gmail.com>
 <CAMP44s0=5KniGDnVtKPg5sp=G8M-mPcq+Mu1nXqODfhT-MaNyg@mail.gmail.com>
 <CALkWK0kLZ9WLVcPBWuQZCjOku4A+WQ7=YeooPmKGpk9HuGYQnw@mail.gmail.com> <7vwqrjdh6v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 20:23:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXFCs-00034n-UR
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 20:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760813Ab3D3SXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 14:23:10 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:54179 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760203Ab3D3SXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 14:23:09 -0400
Received: by mail-ia0-f179.google.com with SMTP id p22so707055iad.24
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 11:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=O1X/eNpg9war94X1kuwMAzjYbzQ+wohpnqWBlIs+u6Y=;
        b=KaQda2ltcIZS0kkB5mmS9ItZO09079+0nJ/WBLbiGhC794v1iBF6DDWK3bcV1MVe6V
         Jf3Jk1pUvTC/yHnqOiRGtk4+tO4r4NsSg+FvaAFIJf94t89QVF7zkDeafLI88PYgxUV5
         7OzQbSouad72XJavRux0/dqLm3sbxZTrY6RMsah7DoX/AHOjtRidxoSl3eJpoqM0pe5a
         7PfmoG/MPxcZpigum+WExoA7W2hGOO510AbCcHFAyW8fhkPM4tQ+MiQfh5dnPojX8kj0
         lp7LLw0iDAbYG2cQRmA++Ore76p/hp5O2eFHgfgKzW/V6Voe9Y35e1B8NRA06rlwoQ3x
         NMmg==
X-Received: by 10.50.66.197 with SMTP id h5mr10712707igt.63.1367346188490;
 Tue, 30 Apr 2013 11:23:08 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 30 Apr 2013 11:22:28 -0700 (PDT)
In-Reply-To: <7vwqrjdh6v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222981>

Junio C Hamano wrote:
> @{-1}@{0} does.  That means @{0} is a revision and not a ref, but @{-1}
> is.

Right.  I missed that.

> '"@" given alone' has to be a ref if we want @@{5.minutes.ago} to
> resolve.

Yeah, I just realized that it's a bug in the @{u} implementation.
@@{5.minutes.ago} and @@{1} work perfectly fine on git.git master.
Therefore, @@{5.minutes.ago} should work with my implementation too.
Yes, it's just the default value of .git/@.
