From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/5] t1508 (at-combinations): more tests; document failures
Date: Thu, 2 May 2013 12:08:44 -0500
Message-ID: <CAMP44s2suBKMxKTPsOC15PxNrVZKCxDVz=0aaYc2v5h-DMHKRg@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-2-git-send-email-artagnon@gmail.com>
	<7va9oe5y6k.fsf@alter.siamese.dyndns.org>
	<CAMP44s31jyuGGG1Wn9D=D9udkJJdXQfwVAnHuOg02FWinpmn7Q@mail.gmail.com>
	<CALkWK0=B_Ym_ei181eV-WeqJZJyHPv-AmLzYwajm13wftJkB6g@mail.gmail.com>
	<CAMP44s1x8pu2B2h3wKmuBDXz3Tqyk9qyijshcD6iN+NpYDCQdQ@mail.gmail.com>
	<CALkWK0k5zyGwZaP84YMON8VZbfjRxQ3PG2ML2ds8GdQY38s7SA@mail.gmail.com>
	<CAMP44s2nqLrLRFM1bH028FpV+tPYUWYDz_AffaBhVfwwm4h=kg@mail.gmail.com>
	<CALkWK0m=gmf9g_O3uHmpGkSa165G-5VGROTgjQx87XwvDDQKSg@mail.gmail.com>
	<CALkWK0nqoffHD3mfRqzanEuh4yG-cCO-YBGw8ApnG2uLKJaenw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 19:08:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXx03-0005by-CG
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760167Ab3EBRIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:08:46 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34035 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759912Ab3EBRIp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 13:08:45 -0400
Received: by mail-lb0-f174.google.com with SMTP id r10so761497lbi.33
        for <git@vger.kernel.org>; Thu, 02 May 2013 10:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=SCIvcf57YipWCZFARNZ724U+VbCz+gmbs45enqq60UQ=;
        b=ZRgvNCJnJ1/W017onetwVbhwOar8CNUiKRhiTcb/CONS/US/ktNemAButLDN/N8n4/
         ZKxZGzkUqP/dv57jt4ebne9yDv5RpdZyOi1tFHkiRASFYuq92HBemWW7yf7h/nPcJOwT
         2N3z09tLFlPPuX4OaI8k0bTTeI1Jle9iti3bbB2DacmFehlvtpR1E0ELdUqjPs80tpzb
         yKahwgldHSM8WcFlXrXIH210gAVNJB2ffd/T2wOARooHxBtcA9voLyP4N6XH0HOlCSK2
         7BUCZ9EVN24hSMgybTH7T4zwpvWu0HJlX5wiC4EyJDNq8vIW81Ve9BDjQztsTaSAyrFX
         xSBA==
X-Received: by 10.112.135.70 with SMTP id pq6mr3057618lbb.82.1367514524212;
 Thu, 02 May 2013 10:08:44 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 2 May 2013 10:08:44 -0700 (PDT)
In-Reply-To: <CALkWK0nqoffHD3mfRqzanEuh4yG-cCO-YBGw8ApnG2uLKJaenw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223227>

On Thu, May 2, 2013 at 12:02 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Ramkumar Ramachandra wrote:
>> HEAD has been special right from the start, and we cannot elevate
>> anything else to its status now.
>
> As to why I agree with you: I audited the callers of branch_get() and
> found out there are some things that cannot be fixed just by fixing
> branch_get():
>
> For instance, 'git fetch origin M' will not work, and it's not
> branch_get()'s fault.  And that is just one instance: there are tons
> of other instances; and going and changing each one of them will take
> forever, and totally not be worth the pain.

We probably should fix those, but that is orthogonal to the '@' shortcut.

We can have the '@' shortcut *today*, with minimal changes to the code
and the documentation, in a limited and understood scope, with no
surprises.

We can fix the symbolic ref stuff slowly, step by step, no need to
delay the '@' shortcut for that.

-- 
Felipe Contreras
