From: Patrick Donnelly <batrick@batbytes.com>
Subject: Re: Can I fetch an arbitrary commit by sha1?
Date: Mon, 6 Oct 2014 14:25:55 -0400
Message-ID: <CACh33FpWPuyJRryf6hzbAkqWJMwzz1mLLDDRxEQ0niT2CznTRg@mail.gmail.com>
References: <CAENte7htO13s91UJFNzW4aBhsGxE=LpnvaZfce+vqQU5+a-cYg@mail.gmail.com>
	<CAPBPrnsA4KxNximtKXcC37kuwBHK0Esytdm4nsgLHkrJSg3Ufw@mail.gmail.com>
	<20141002161006.GB2505@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dan Johnson <computerdruid@gmail.com>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 06 20:26:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbCyv-0005up-Ml
	for gcvg-git-2@plane.gmane.org; Mon, 06 Oct 2014 20:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223AbaJFSZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2014 14:25:57 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35896 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbaJFSZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2014 14:25:56 -0400
Received: by mail-lb0-f169.google.com with SMTP id 10so4787924lbg.0
        for <git@vger.kernel.org>; Mon, 06 Oct 2014 11:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pQpsm8BOih5Vn7J+Zs6jugn1Mf/5G2dvnIYnkQisokk=;
        b=Qfsz0LqRV4OIgWXr3fimUViR4rd8V/PgGqR1p/et8sU/8HpBXTtVOJPRxgMcTlLA6X
         NVHa2enKklx4yAa5+IOiMsu0C7yo3hXb6v2koY0JZya6ZOFVXTf6lHBBOjjiMKP+Kz0b
         7jIRQzZfmToR8TExugWzZXy7bMj+HpAqTPi9jR4E5u+NGG9L5hvQy8xuZMvbVaGoP6Cp
         SNWox7Tpr9M7w+lWdxoHt62aJ1y7sxsUNorumYREj0boDgp1EDS/CZJM+oBU/t0IA9lo
         SuKUSUQgcwGQsH+0ARX4opP3q8qi4peTytRWnXbJNgI6yB9MyDd6ddiaHZmqORV0xxEf
         +P8g==
X-Gm-Message-State: ALoCoQmFTaWNtsect2dZJOUyCX6pmkeUtp7OgQDW3/fqaUMJKJgBxdEWU9aQtZy5HRELctWXJbk+
X-Received: by 10.112.144.228 with SMTP id sp4mr26187989lbb.54.1412619955301;
 Mon, 06 Oct 2014 11:25:55 -0700 (PDT)
Received: by 10.112.147.72 with HTTP; Mon, 6 Oct 2014 11:25:55 -0700 (PDT)
In-Reply-To: <20141002161006.GB2505@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257912>

On Thu, Oct 2, 2014 at 12:10 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 02, 2014 at 10:22:50AM -0400, Dan Johnson wrote:
>> My understanding is that you are allowed to ask for a SHA1, but most
>> git servers refuse the request. But if you already have the SHA
>> locally, then git doesn't neet to bother asking the server for it, so
>> there's no request to be refused.
>
> That's right. It is the server which enforces the "you cannot fetch an
> arbitrary sha1" rule.
>
> But I think Christian is arguing that the client side should complain
> that $sha1 is not a remote ref, and therefore not something we can
> fetch.  This used to be the behavior until 6e7b66e (fetch: fetch objects
> by their exact SHA-1 object names, 2013-01-29). The idea there is that
> some refs may be kept "hidden" from the ref advertisement, but clients
> who learn about the sha1 out-of-band may fetch the tips of hidden refs.
>
> I'm not sure it is a feature that has been particularly well-used to
> date, though.

There are efforts in the scientific communities at preserving
experimental software and results. One of the things we'd like to do
is shallow clone a specific sha1 commit from e.g. GitHub. [I think
GitHub has this disabled though? I haven't been able to get it to
work.] I guess this feature was a step in the right direction but it's
not usable AFAIK. Tags are not really suitable as they could change
and there are possible namespace issues.

-- 
Patrick Donnelly
