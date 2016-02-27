From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 3/3] git: submodule honor -c credential.* from command line
Date: Fri, 26 Feb 2016 16:01:08 -0800
Message-ID: <CA+P7+xroP8PFKe+zSdT-j9oq+APT6OKOkbzS_DM8HyVjM-v_og@mail.gmail.com>
References: <1456514328-10153-1-git-send-email-jacob.e.keller@intel.com>
 <1456514328-10153-3-git-send-email-jacob.e.keller@intel.com>
 <20160226220553.GA1835@sigill.intra.peff.net> <CA+P7+xqSZGAJD7ryvx2A2qM1wd0rKMmjT2tcBPann33sUUHGcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 27 01:01:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZSKC-0008Qd-Sn
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 01:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755551AbcB0AB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 19:01:29 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:36837 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158AbcB0AB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 19:01:28 -0500
Received: by mail-io0-f170.google.com with SMTP id l127so137867604iof.3
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 16:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=04yljw26rh3N/bImHxhpTW6V9BRU8Qqyfyoc0xJV7L4=;
        b=rYhF39uDEKjQ6LIWLp+xNAN5ZMpJin1Gs0sJ876IFqN7xxV9bNr0wNh9TF5lTAevQD
         loet2jcB7DkkYkA5ckA+/t08jmY1iaD3EO2NKbecFawaC21IkQOozmdikAzpkmSbFoPH
         JgtLx2UdiOS7L4fXolfV8RH54ocamQViZlgbjjT1NJL8P4tNiB0x8I41LkwiZCq2pJaM
         Fd6KbX3mwOj1HyHw3MlPsxFm6UzmrC3eD4k5lFLM0pmfzlpQEs6v06uyyDFmUqwHg/ea
         NRwaZtNFr+3S7ojooJjyzv9kcJVaiYG8zKkhXS/zTm4IqFZ+YM8zfPw6DRJjHAp+9yKW
         yszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=04yljw26rh3N/bImHxhpTW6V9BRU8Qqyfyoc0xJV7L4=;
        b=AgB9qoun8vuT1oThhPD4Xlv1aMGKJXVjexwztL55E9bd6hZxfXodjgQhV19hXpFo1Z
         GiA/IOGRpob3NOzf5WJltlnv38PTR1Q/yqfTW71yLExHD2wVuYt+w1jN6J8cFyIBZ7kM
         Kdcpwlq636ABSTVa5OlrAhRDZ5p9A7wQN8v7XECR2PqrnBNGAU2xvMgjfSHhtdxyXD+9
         fNAK6YB7lJy92/4edhCrG158KPzA91rZ7dVvgTlSvXJZoZ5E3F3JPzgeCVf9YSotZj5o
         LnDbPxBAWp32xGDNH/6IsWOiQ0LOkpgvUhRI3NXt5808ORgBF5a5TFVfxZbhB1IIVgmk
         sw1A==
X-Gm-Message-State: AG10YOTMYvsl7NZTatdoKSAogwb5tKCIpoNjfVIHKyRgjqvyd+9CpAlF5XKmec/xGQzohfZwvLGyM0tliIebXQ==
X-Received: by 10.107.156.14 with SMTP id f14mr12585478ioe.0.1456531288011;
 Fri, 26 Feb 2016 16:01:28 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Fri, 26 Feb 2016 16:01:08 -0800 (PST)
In-Reply-To: <CA+P7+xqSZGAJD7ryvx2A2qM1wd0rKMmjT2tcBPann33sUUHGcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287644>

On Fri, Feb 26, 2016 at 2:20 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> that is slightly more verbose, but it does let us keep the main body
>> inside single-quotes, without restoring to confusing backslash escaping.
>>
>
> I think I prefer the double quotes myself but will use this if people prefer?
>
>> -Peff

On second thought, I'd prefer consistency and I think using single
quotes is probably better, so I'll use this solution in v5.

Thanks,
Jake
