From: Graham Hay <grahamrhay@gmail.com>
Subject: Re: Seems to be pushing more than necessary
Date: Wed, 18 Mar 2015 11:26:58 +0000
Message-ID: <CAABECY2_MQWAkOu=6rR=mN=wKz-Yfzsu8o2+wb6F+h4FjBe9Mw@mail.gmail.com>
References: <CAABECY3HbZ4q3uo82outUmCyQLXO39H+Fd2m8bLwkaubE9gJCw@mail.gmail.com>
	<CAABECY1_L34sq0VPmD9UwRcwb3Fuh95OFcF26LM2eX1z-+8vkQ@mail.gmail.com>
	<CACsJy8Au48iFoC=Eo4T-fm6r6tA7VffRJyH2JbuC==wa61=G5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 12:27:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYC7r-0002kU-PU
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 12:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489AbbCRL07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 07:26:59 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34920 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488AbbCRL06 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 07:26:58 -0400
Received: by oiag65 with SMTP id g65so33313499oia.2
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 04:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JD2vu38G3Day4u5B9MZmdmYlPRqXJTlURDGKXEpynn4=;
        b=UOiltRzjqQ58KYX3dnl6HiNbiRzzXj0K0LqLA7QFDrRjtuTvRCItHschVrfweWvHu0
         DgYPJBv5eQBuGjcksrF8zdTnaF7R7iNu8Yk2IfJ0BWAI/kPdnfTe+ks2F2MhVS7PWMx4
         LLaaNA99hM0zo3ndS9gIy6WQnHPD+A1D1UXKbByQPHWWhL1j+jmhePU+U9q9vTpYP+BP
         9Lqt6BaMgl/DKxlIZD/DUhb9xCwI8Cr55xLcEBCf0VJg7vMsklrYIR90aGchL2Yv0fhk
         w1ok+xbWS4nI0+pa+0J9/cf6/cxpnTnIQ0Q48oIFXjFa2RI0KzToYnaFrGzkFxnMVJRK
         FQ8Q==
X-Received: by 10.60.173.167 with SMTP id bl7mr51985777oec.3.1426678018113;
 Wed, 18 Mar 2015 04:26:58 -0700 (PDT)
Received: by 10.76.13.8 with HTTP; Wed, 18 Mar 2015 04:26:58 -0700 (PDT)
In-Reply-To: <CACsJy8Au48iFoC=Eo4T-fm6r6tA7VffRJyH2JbuC==wa61=G5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265718>

> It would help if you pasted the push output. For example, does it stop
> at 20% at the "compressing objects" line or "writing objects". How
> many total objects does it say?

It rattles through "compressing objects", and the first 20% of
"writing objects", then slows to a crawl.

    Writing objects:  33% (3647/10804), 80.00 MiB | 112.00 KiB/s

>
> Another question is how big are these binary files on average? Git
> considers a file is "big" if its size is 512MB or more (see
> core.bigFileThreshold). If your binary files are are mostly under this
> limit, but still big enough, then git may still try to compare new
> objects with these to find the smallest "diff" to send. If it's the
> case, you could set core.bigFileThreshold to cover these binary files.

None of the files are very big (KB rather than MB), but there's a lot
of them. I'll try setting the threshold to something lower, thanks.
