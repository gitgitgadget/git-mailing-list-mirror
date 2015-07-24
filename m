From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Fri, 24 Jul 2015 08:31:55 -0700
Message-ID: <xmqq4mkto9lg.fsf@gitster.dls.corp.google.com>
References: <20150723012343.GA21000@peff.net>
	<CAGZ79kbY8hAom+voAOourkDy34nwaACQEM-n=f25Qbg0+ha_8g@mail.gmail.com>
	<20150724074028.GE2111@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 24 17:32:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIex9-0004Ft-FH
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 17:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbbGXPcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 11:32:00 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33102 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbbGXPb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 11:31:58 -0400
Received: by padck2 with SMTP id ck2so16121986pad.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=dOjVGpUgTTW/WOwN0yTOvOGde6gSlBIYj021T1bN1Wc=;
        b=OIz2YZ4H9LhovxmINzkmJ/5gI5dKXmgpAIzYbkWW+P/HsqsF0dO+Y3OX+jTnpZ0zMe
         v/RalujCPb2DSaqtYh0C5vu2afAY0oxjm8JNjG3wsEM51+5LHzdpSqOORFp2Ifz5Px2P
         oZGnXsaGnMAZqVyeYqmSHMuKXQx+6luW9+Vb8mQrnVkBvk0rtZll0QE5ppnHUVeUHLDA
         xGr6kA7MBN2y2RFyqyGF7Y4NA8ESMDVJoaoyLDPe4Y7wjmGzZrd5hMoBzfALjL25REDG
         popiMf15BxwhnrLKoNcc0HJXSxsiTGZ9E4cjjljOGBGsik1k9W5Ymgc5DJ+Oic58WC0r
         fGMA==
X-Received: by 10.70.1.7 with SMTP id 7mr32759636pdi.38.1437751918028;
        Fri, 24 Jul 2015 08:31:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:bdad:9e5d:aa9:33a9])
        by smtp.gmail.com with ESMTPSA id of5sm15206841pdb.52.2015.07.24.08.31.56
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 24 Jul 2015 08:31:57 -0700 (PDT)
In-Reply-To: <20150724074028.GE2111@peff.net> (Jeff King's message of "Fri, 24
	Jul 2015 00:40:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274573>

Jeff King <peff@peff.net> writes:

> Whoops. Usually I "format-patch -s" and then add any notes while
> sending. But the wifi at OSCON was so abysmal that instead I wrote the
> notes directly into the commit message to send the whole thing later.
> And of course format-patch is not smart enough to know that I meant
> everything after the "---" as notes. :)

I think in the cycle we merged Couder's trailer stuff we updated the
helper functions to locate where the S-o-b should go in an existing
message and consolidated (or, at least "talked about consolidating")
them into a single helper.  I do not think we wrote any special case
for "a line with three-dashes and nothing else on it" when we did
so, but that function would be the logical place to do so.
