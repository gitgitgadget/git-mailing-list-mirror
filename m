From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 04/13] utf8: add function to align a string into given strbuf
Date: Fri, 14 Aug 2015 09:06:13 -0700
Message-ID: <xmqq1tf5kg7e.fsf@gitster.dls.corp.google.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
	<1439129506-9989-5-git-send-email-Karthik.188@gmail.com>
	<CAPig+cS+rS=xKX-LrJSTqFgaopuLzbh3hqURFWXfzMXH=XUk2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 18:06:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQHUq-00012k-Fz
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 18:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbbHNQGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 12:06:16 -0400
Received: from mail-pd0-f196.google.com ([209.85.192.196]:36168 "EHLO
	mail-pd0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153AbbHNQGP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 12:06:15 -0400
Received: by pdbfa8 with SMTP id fa8so3768659pdb.3
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 09:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Jeq2uf/Pr5trtng8ILoLnwWYFEeFspevkxZLtuxXf+g=;
        b=CzKEqiSLDzXuAtum2//PyN3jx7Ws/FIha0Fw84Z9TNRmdadE5hZzMIREGG0HiIqrCw
         kpln/NJcqRJ5v3TAH1Q2OmjwZ2BJKZDtXazD++BpoDIo3SuaLbiBbdzJx1Pz739UZiXK
         gAzPWTUDYhdSq2SIbYBtHPkC0DA/Ul7ExJwpbxhNyukrqNEjmjDUvdnAT+NKRhLHnF5x
         GiNJiq7fHZiFgiG+zxXyOp4PbvlSnoiPpEfM1ObtwGADsF96G/2sHF1B3zVd/kxHooAJ
         u0imhkjX776V4HVVIq3bSQrR5OuPVcpyVjqy8u/TVLojYuz56nUnH9uXzACKw3qdJi2z
         5kdw==
X-Received: by 10.70.93.36 with SMTP id cr4mr25140299pdb.101.1439568374968;
        Fri, 14 Aug 2015 09:06:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id d4sm6477825pdc.93.2015.08.14.09.06.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 09:06:14 -0700 (PDT)
In-Reply-To: <CAPig+cS+rS=xKX-LrJSTqFgaopuLzbh3hqURFWXfzMXH=XUk2w@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 13 Aug 2015 15:08:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275908>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Please extend this documentation to state explicitly that this
> function preserves (does not truncate) the input string if it is wider
> than 'width'. That's quite important information for the caller to
> know.
>
> (Aside: I could easily see this function being extended to support
> optional truncation, but that's a separate topic, and something that
> can be done by someone else when the feature is actually needed; it's
> not your responsibility.)

Thanks for being explicit.  That is exactly what I had in mind when
I commented on this part with "mental note".

Extending what the function does is outside the scope of this topic,
but documenting the current design decision is, in order to help
those who might want to do so.
