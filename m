From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] cherry-pick: make sure all input objects are commits
Date: Thu, 11 Apr 2013 17:12:06 +0530
Message-ID: <CALkWK0kb+2KZLvRJDJb_VrNNs1k4grsfyFv0HfYv0Kr9v4sChQ@mail.gmail.com>
References: <20130403092704.GC21520@suse.cz> <7v38v1yn8o.fsf@alter.siamese.dyndns.org>
 <20130411092638.GA12770@suse.cz> <CALkWK0n6FjGbXTqiOT_O6NbB5h0DLaNWKCCTQAFSO_BL-pPdBA@mail.gmail.com>
 <20130411110324.GD12770@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Thu Apr 11 13:43:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQFuA-00021W-1G
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 13:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab3DKLms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 07:42:48 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35988 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705Ab3DKLmr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 07:42:47 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so1900404ieb.29
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 04:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/gE98mn6xfqBepusk7UcCIcdZzLuUtMD2xs0cGZdjX0=;
        b=Dahgg6ArCj4R88vzptKYuvSsAJfDbOnjp6tE70XkpWDQDsbZbXGuC3wzvjO5jYd9rk
         eUCLZjgYc3iUH0sqPSX0YeNIUG4545Pnxz5P6d7E/InZ7KCpTuYY0/n1II19/RxJMtMI
         p7wxTCEHyEgRj8CEV7kJNW2T+HlShKiz5RVSitjaBB/Zjzz3NRglrp2T4mGopW1g3xVQ
         MCGBkaf/ItzdnWhp40r1X6mvZ0v0SCjLlilSNt7GAiRGdu20AY6lw03wSl0luS3bvHGC
         yw0hC7tefylDB0lsd38kmO7qGu6eBqzq9JzNiLMuNZrzjWxlNZnZ0edagf/40onjJihs
         +O5Q==
X-Received: by 10.42.50.202 with SMTP id b10mr3727150icg.7.1365680567024; Thu,
 11 Apr 2013 04:42:47 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Thu, 11 Apr 2013 04:42:06 -0700 (PDT)
In-Reply-To: <20130411110324.GD12770@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220847>

Miklos Vajna wrote:
> I guess that is a should-not-happen category. parse_args() calls
> setup_revisions(), and that will already die() if the argument is not a
> valid object at all.

Then why do you have an if() guarding the code?  In my opinion, you
should have an else-clause that die()s with an appropriate message.

> Yes. If you would want, I could of course add test cases for two other
> cases when we already errored out and now the error message is just
> changed, but I don't think duplicating the error message strings from
> the code to the testsuite is really wanted. :-)

Nope, I'd never suggest that: this is fine.  What I meant is: you
should clarify that you're fixing a bug and adding a test to guard it,
in the commit message.
