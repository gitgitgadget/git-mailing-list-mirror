From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH v5 2/6] t7030-verify-tag: Adds validation for multiple
 tags
Date: Sun, 17 Apr 2016 14:38:15 -0400
Message-ID: <20160417183815.GC1014@LykOS>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
 <1459872449-7537-3-git-send-email-santiago@nyu.edu>
 <CAPig+cSOLnCoX77O7khEX1cTh0Hu29d6MRdcpfN8ytTkUSVU=A@mail.gmail.com>
 <20160417173155.GA1014@LykOS>
 <CAPig+cQYAAG7hVe6Li3-TZb99etkE22QzcWbKBCzr8L0SP5LXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 20:38:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arraa-0004ET-Cu
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 20:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbcDQSiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 14:38:23 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34149 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbcDQSiW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 14:38:22 -0400
Received: by mail-qk0-f174.google.com with SMTP id r184so51122166qkc.1
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 11:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FauxLRzyXi8C2XcszYAwoR4njH1ZHM4zWKY3Ef7MwqM=;
        b=Pi0//vUA60pXbgidYlia/r/YsAOr5eJne069hV3unS/e0vvf2E1+//81JRXiZsFGzV
         q7i0BtoI4Oxr1065t/ogfGneSx2bUpcakm7Pkr0DQ0b0Y9ZKv1Ww+JehI1RbRf+iV072
         6usnqz6NYQqj+JTUZUz+CKEzZxzbl5nifSVbf1MnREn61kASXYpkkTGhpdieEyhVn6ER
         db5J4zqybz3/p/LPfUQ1CarP19h34uTikbjVPuEn0vtFVbUhQPDWaOIXDXlHWWdaVJGU
         8cN3uQsbDEXCGZEYYom4c1W3bFgf6MoJqxg7pUXJR69Wcb3gLmRm0PKQSrCqRvivn9Id
         +mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FauxLRzyXi8C2XcszYAwoR4njH1ZHM4zWKY3Ef7MwqM=;
        b=atvBJx0Zobp7qef0eBrfLMXL1/zYg+jMWuWyDLLQtsJ7cFjr5fNCCrhFs3TEMDmREa
         YH0V0aNVtV1Sqv7nJjiKk90zSbIuhKAm2BmcPtuv1iZFeao9jckQtTHWWPg9bSUHrwV9
         HWvLxNTIQW8xRcRbeZ193Cr8uBxR3NS2ok2OtM06r2vcQGuaxGD1HB2VD+CsxbNi1DXi
         K1WrJZp85Q+dXsk1ed1obiIzjSF5JbPKjpGIbDoyOsYaHCFLh7is9Sm2aFZaONi8Y3TY
         nCBzjcv47zOMSEqmzqorrpUgQWUHuLwJOIjrUfmh0PQQcZ780lqAt/44hZM/bk0HuUVA
         nWMg==
X-Gm-Message-State: AOPr4FXqRcXchk0ApzdLVHZWNbub8PJIVjHINp9Iplijxew7cICkN5pOzMe7har3ZbGjlpH+
X-Received: by 10.55.172.72 with SMTP id v69mr38951880qke.45.1460918296514;
        Sun, 17 Apr 2016 11:38:16 -0700 (PDT)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id y129sm25029735qka.33.2016.04.17.11.38.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Apr 2016 11:38:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cQYAAG7hVe6Li3-TZb99etkE22QzcWbKBCzr8L0SP5LXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291770>

On Sun, Apr 17, 2016 at 02:19:00PM -0400, Eric Sunshine wrote:
> On Sun, Apr 17, 2016 at 1:31 PM, Santiago Torres <santiago@nyu.edu> wrote:
> >> +       grep "^.GNUPG" <expect.stderr.1 >expect.stderr &&
> >>
> >> Hmm, is there a reason you didn't stick with the more strict regex
> >> Peff suggested?
> >>
> >>     ^.GNUPG:.
> >>
> >> (Genuine question: I'm not saying your choice is wrong, I'm just
> >> interested in the reasoning behind the decision.)
> >
> > I actually had missed the ":". I read the email and tried to internalize
> > what the new test was actually doing, then I rewrote the test.
> >
> > I think I could add it for completeness though.
> 
> Junio already made this correction and others in the three patches he
> queued on his 'pu' branch. It's possible that he also made other
> tweaks not mentioned in the reviews, so it's a good idea to compare
> what he queued against what you plan to send for the re-roll to ensure
> that nothing is missed. Thanks.

Oh, I'm looking at the patches in pu, I didn't know they were there yet.
Thanks for the heads up. 

Also, would it make sense to copy the commit messages as they are on the pu
branch? for consistency? Or should ommit those three patches and work
on 4+ for the re-roll instead?
