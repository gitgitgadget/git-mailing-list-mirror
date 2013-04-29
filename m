From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Premerging topics
Date: Mon, 29 Apr 2013 15:04:19 +0200
Message-ID: <CALWbr2xD4i4kipp4XAdbZ7pVKD2vk_UdBdE04oU-8nhTc5Dtbw@mail.gmail.com>
References: <CALWbr2wocjqs1mpa+yuQ_Zw8m+SX24q6Pby3E3v3-jd-0w1pvQ@mail.gmail.com>
	<CALKQrgfO9fd+EEA=Vwe94tJbxkX89uDmMHm9rj6L=d4x7JJjaQ@mail.gmail.com>
	<CALWbr2x5HDU2t7hpSCkZnuKjTJ1KxYC0v50wsDPT0fm4LyvzWw@mail.gmail.com>
	<CALKQrgeGPo--cYoGZ30nSfASh4CPzqGXQojkG9Ve96NFr+LrjA@mail.gmail.com>
	<7vzjwofpht.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 15:04:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWnkn-0006vE-AW
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 15:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756865Ab3D2NEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 09:04:21 -0400
Received: from mail-qc0-f173.google.com ([209.85.216.173]:64903 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661Ab3D2NEU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 09:04:20 -0400
Received: by mail-qc0-f173.google.com with SMTP id b12so3137999qca.32
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=sND4MlNuEMyZvoDnTTwye2ae/n4cDEHySxATsy9K9HI=;
        b=hVJc1NQCq+QZg34FvLJz3GUJMr0Nf+YA8EGI1e7PQ64qB0KrvXwgM5AZcTfEqaR9D7
         HSExAu3Md2Z7SRMa7SFIGGqUdK04uCnEr3dcQs0ZbD6X7ezuCqm+ETlBvoVLRtVQrOCp
         SpDqiR5Q+i+RdX69cj1pkGiETj/YvTQOpYTXNg+esThjqjSxWLPy06qs+1jK5ZHYYXBA
         gy8JWiuHv0nG/zF1Focq3XfAF3pCroq5/eKGgL8gKR/15C9kQwEOfdi+VotNaLeJlwNl
         vuuL8mvmgP0qT8EeArQYsJjXqlCCS0QNQoswfsS6/7sfSsaeGVU6pUhtBHztAoKMfILQ
         GrTA==
X-Received: by 10.49.95.163 with SMTP id dl3mr59680956qeb.38.1367240659687;
 Mon, 29 Apr 2013 06:04:19 -0700 (PDT)
Received: by 10.49.30.9 with HTTP; Mon, 29 Apr 2013 06:04:19 -0700 (PDT)
In-Reply-To: <7vzjwofpht.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222793>

On Wed, Apr 24, 2013 at 7:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> there
> could be textual conflicts and you could choose to leave them in, or
> you could choose to have rerere resolve it.  As long as you do the
> same when replaying this prepackaged evil merge, this choice does
> not matter, but using rerere will make your life easier

The problem is that rerere can not be easily shared, and I'm afraid it
would be almost impossible to go without it (do you commit N with
conflict markers hoping that F' will remove them?).
But, as it looks like you would save F on top of M, it means that M
would be reachable, and thus rerere would be "recomputable" from
somewhere else.
