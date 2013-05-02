From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/5] t1508 (at-combinations): more tests; document failures
Date: Thu, 2 May 2013 22:32:41 +0530
Message-ID: <CALkWK0nqoffHD3mfRqzanEuh4yG-cCO-YBGw8ApnG2uLKJaenw@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-2-git-send-email-artagnon@gmail.com> <7va9oe5y6k.fsf@alter.siamese.dyndns.org>
 <CAMP44s31jyuGGG1Wn9D=D9udkJJdXQfwVAnHuOg02FWinpmn7Q@mail.gmail.com>
 <CALkWK0=B_Ym_ei181eV-WeqJZJyHPv-AmLzYwajm13wftJkB6g@mail.gmail.com>
 <CAMP44s1x8pu2B2h3wKmuBDXz3Tqyk9qyijshcD6iN+NpYDCQdQ@mail.gmail.com>
 <CALkWK0k5zyGwZaP84YMON8VZbfjRxQ3PG2ML2ds8GdQY38s7SA@mail.gmail.com>
 <CAMP44s2nqLrLRFM1bH028FpV+tPYUWYDz_AffaBhVfwwm4h=kg@mail.gmail.com> <CALkWK0m=gmf9g_O3uHmpGkSa165G-5VGROTgjQx87XwvDDQKSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 19:03:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXwum-0000Gi-VD
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758325Ab3EBRDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:03:24 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:47065 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432Ab3EBRDX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 13:03:23 -0400
Received: by mail-ie0-f169.google.com with SMTP id bn7so936469ieb.28
        for <git@vger.kernel.org>; Thu, 02 May 2013 10:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=UoHNOqYN9BnBp2WBugRdEruJknc/svkukS0hSJ5gc9Y=;
        b=UOl7oereoHN7fYlNYxNxON8T6lN/7+Kq6KEszMDMSUSMAbp/GDEfhBZy3cKpqhnsZX
         wTVfXTGsZ2o91fbYbi2UwTMMoQHNc3iCtotwFARCqH8VhpRj2+AiptDqc2vZ2bTE4kq9
         H3ThbRk9rWUR7GZz6KIK9+GxZSSMCPP1CMEy+Shfpsc5Xg3BK8ZynhM25ZaY4MZcR5Jg
         0Vfk1D07fU+rqyL5m4lz+BTPbIMSARtKFtIUmjxJaiB925oWe3leeyfaKywO0Wf30iBV
         S4XzO2+rHA209zDMVx1n+QZm1cKlNs9vSIAJNHQdNgzis7CRwSjd90PCihTPn16+/Kqw
         3jCg==
X-Received: by 10.50.72.65 with SMTP id b1mr4112411igv.63.1367514202143; Thu,
 02 May 2013 10:03:22 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 2 May 2013 10:02:41 -0700 (PDT)
In-Reply-To: <CALkWK0m=gmf9g_O3uHmpGkSa165G-5VGROTgjQx87XwvDDQKSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223225>

Ramkumar Ramachandra wrote:
> HEAD has been special right from the start, and we cannot elevate
> anything else to its status now.

As to why I agree with you: I audited the callers of branch_get() and
found out there are some things that cannot be fixed just by fixing
branch_get():

For instance, 'git fetch origin M' will not work, and it's not
branch_get()'s fault.  And that is just one instance: there are tons
of other instances; and going and changing each one of them will take
forever, and totally not be worth the pain.

In other words; symbolic refs are a dead end.  The future is in
getting everything to use the standard revision parser.
