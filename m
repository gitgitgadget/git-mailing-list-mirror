From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config settings
Date: Thu, 28 Apr 2016 09:09:44 -0700
Message-ID: <CAGZ79kZFLTARQ25h4u4SGgNn=Q4TQi-kxFLN3sQvOmejsRmAWA@mail.gmail.com>
References: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de>
	<cover.1461837783.git.johannes.schindelin@gmx.de>
	<89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
	<20160428112912.GB11522@sigill.intra.peff.net>
	<alpine.DEB.2.20.1604281405540.2896@virtualbox>
	<20160428134953.GB25364@sigill.intra.peff.net>
	<CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com>
	<20160428153902.GF31063@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:09:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avoVm-0006bv-2h
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 18:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbcD1QJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 12:09:47 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34059 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156AbcD1QJp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 12:09:45 -0400
Received: by mail-io0-f172.google.com with SMTP id 190so76012468iow.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=lsf3nDD+rysfCxbppTZ+vcuZ4zg4ze5qhHbCNzxh0oA=;
        b=EEAAm5QPb4NBbvKV5Fq8klMIjITakSIkt/5UI5pi9j6VMYlL6U7HfHu84nqEuQHO8p
         Xs+yYGyJE+TGEsv8Y4RQdyScc6CzPQ5jNdhvf+7nUADk0/YRGnic5bF00PtGLZebJULZ
         UnCRTzJadf30ckzVjISIFeIQfAKK7VF0nl2cGbQ0Wk0Ymz3M/Na531w+r/QtIV703cNl
         vGznKhl7z6tC4fAQbfgLmakQ9W7cGXhZH/PW0xiUtM7O3JwuBORmW2qmPIdYHD3nFaQg
         1lnhAPxzoz5BMNUh+l0Vy22y66YWPJLDlJOiGSAlyqYM8U4ZT7FEsl8lYQRqE1nTguxN
         G8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=lsf3nDD+rysfCxbppTZ+vcuZ4zg4ze5qhHbCNzxh0oA=;
        b=ABUueO8agQ0aS/4tDXxSUOlDUqq4C3hyfjBBvfhZjw2vkx4ljhhNiE8a/dJcleheFZ
         eJWXoIFn5CJZBOyllOkt1w49XMc7s7b4JvxUGgoA9O+9lq3xK6HfSbX5MIeEMQpEIFtc
         QVs+kD7RJek77Zl8ZeyoFh3WUWHqCf6nlo+FgBEEFRZLLkLtUtO7oXh6YpNC1i9UiSLO
         p1btaQ6ilPKj/5Rdkw0bjT0t8uj52v4kL9VZWxh7HjXSgE7LzlDLPN8PYtlJyOAv+nJ6
         Cg0/a3CNckDh7SWeJg2JGyL4O3SHqhWkna/4Rq8yAwRUYhNXq6Po2AKJv1YII74Ihom3
         BHRA==
X-Gm-Message-State: AOPr4FUTxeyZ/7EpXiBF9UE0WoODvzB56sVCA4J5pqmOCIGIEHIGmabuV5I346eM/+GoDVuH3a34xPq8ZAJyQqGI
X-Received: by 10.107.161.68 with SMTP id k65mr20850311ioe.110.1461859784269;
 Thu, 28 Apr 2016 09:09:44 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 28 Apr 2016 09:09:44 -0700 (PDT)
In-Reply-To: <20160428153902.GF31063@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292912>

On Thu, Apr 28, 2016 at 8:39 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 28, 2016 at 08:37:10AM -0700, Jacob Keller wrote:
>
>> I think I prefer a blacklist approach, since it reduces the need for
>> future changes, since most cases will either not put config on the
>> environment or (based on feedback on the mailing list and bug reports)
>> the user will believe it should be applied.
>>
>> A black list which only removed configurations we know are harmful
>> would be easier to maintain but risks new additions forgetting to do
>> so. A whitelist means we only fix things as they come up but also
>> means we aren't "breaking" anything that works today, where as a
>> blacklist could break something that works today.
>
> I think the key thing with a blacklist is somebody has to go to the work
> to audit the existing keys.

Would it be sufficient to wait until someone screams at the mailing list
for some key to be blacklisted? (I mean in the short term that would be
of less quality, but relying on the larger community would result in a better
end result? So your going through is just a jump start this process of
listening to the community?)

Thanks,
Stefan

>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
