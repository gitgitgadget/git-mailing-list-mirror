From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: t3010 broken by 2eac2a4
Date: Thu, 22 Aug 2013 16:54:10 -0400
Message-ID: <CAPig+cQHTvmTWvGfg1Z3KfBrPD+QbSEbYBYz6XWT3KKu3-+jyQ@mail.gmail.com>
References: <82078845-3AB9-4B36-9130-039CC33C8A7A@gernhardtsoftware.com>
	<xmqqbo4qu3g4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 22:54:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCbtY-0004Vf-8D
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 22:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193Ab3HVUyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 16:54:12 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:46622 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438Ab3HVUyL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 16:54:11 -0400
Received: by mail-lb0-f182.google.com with SMTP id v20so2170099lbc.27
        for <git@vger.kernel.org>; Thu, 22 Aug 2013 13:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=w0Q6s9hQzWzhMiiiPJg7rhpFRi5i7AFb9MuZ3QQuLOA=;
        b=c3lEiw1bH3om0+D9Q6LAsyH4w9fxZmRG9YTDVjOUSVPmONziwLU8QHJb3yc+3yip9T
         SV36BHWiS/qQm+/gedGKlEuLMGAyW3/q+qf6AFhFcUq8bGDY/q4kwWn6cOUXzfB1zKKw
         1KPPqQpcoddBhfDdvZxINZAL/KL7fMpw8QgNahiMct8pdN+B1tTTZCkYiW8COw3Ks+px
         cGaZZFGrRDInuFI4XoOL5srxPLuqANwh7oG8PGf2mXghrRrIV6fall60nJq2IYUJzSLy
         3OXRxAQBOq6mHgru4gfWKi6Ghk7VK+mdn/2x7EB1TmQBQaYt0U7LaqkE6m2mmruumScP
         oHNg==
X-Received: by 10.152.6.97 with SMTP id z1mr12179894laz.26.1377204850066; Thu,
 22 Aug 2013 13:54:10 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Thu, 22 Aug 2013 13:54:10 -0700 (PDT)
In-Reply-To: <xmqqbo4qu3g4.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: ABFK_P0981PXvcr3VMbwNiLY_f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232775>

On Wed, Aug 21, 2013 at 5:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brian Gernhardt <brian@gernhardtsoftware.com> writes:
>
>> With 2eac2a4: "ls-files -k: a directory only can be killed if the index has a non-directory" applied, t3010 fails test 3 "validate git ls-files -k output".  It ends up missing the pathx/ju/nk file.
>>
>> OS X 10.8.4
>> Xcode 4.6.3
>> clang "Apple LLVM version 4.2 (clang-425.0.28) (based on LLVM 3.2svn)"
>
> Very interesting, as it obviously does not reproduce for me.

I can confirm this failure on OS X, however, I am somewhat confused by
the follow-up t3010 changes in 3c56875176390eee. Are the t3010 changes
supposed to fail without 2eac2a4cc4bdc8d7 applied? For me, on Linux,
the tests succeed whether 2eac2a4cc4bdc8d7 is applied or not. On OS X,
the tests succeed without 2eac2a4cc4bdc8d7 but fail with it applied.
