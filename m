From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 04:01:23 +0530
Message-ID: <CALkWK0mB9BChMJpMfU8xETGG1mMJc7GjqKy1N5RWgBeyKu+HwA@mail.gmail.com>
References: <20130410202456.GF24177@sigill.intra.peff.net> <CALkWK0k_gYWg9=zjRKGrq-evsWG+hCrLjrpLfYp=_uoHVKBzHw@mail.gmail.com>
 <20130410210455.GA2999@sigill.intra.peff.net> <CALkWK0k-YJwT__8Tc4B4WXq30ij3i8_d6qwyOCP5RLsKF9eazQ@mail.gmail.com>
 <20130410211824.GC27070@google.com> <CALkWK0nxpoLL4zoinE4j8y8NLHo0-b=PcimNLykCjMjOpWYEfQ@mail.gmail.com>
 <20130410212911.GE27070@google.com> <CALkWK0m=iDw+N0zcfEEt1jzFD4wOOzLgyBWNyc=HZ+xLe5SBLw@mail.gmail.com>
 <20130410215658.GC6215@sigill.intra.peff.net> <CALkWK0=Y-pO3+g21PLCWOxx+M-7fSmp2FedMBtZ68PWU_TOHDw@mail.gmail.com>
 <20130410222334.GC6930@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 00:32:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ3Yo-0007uj-MA
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 00:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933050Ab3DJWcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 18:32:06 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:50682 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756630Ab3DJWcF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 18:32:05 -0400
Received: by mail-ie0-f181.google.com with SMTP id 17so1249225iea.26
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jGPyzxRA+AYqT/w/32fCO3MY2sbjT5ZNfht7IoXn6fM=;
        b=xnaPzHFon+idrLgBr96cV/0CERGRWUTVOTDpRFccXtv7Q8bgfSziMXo5+cWpYKJPzk
         /ChDhPa1MSYKCxVHKXQ0cHQXS/g0A4+m5It7WRXABdXvKdD3zIy6DgvnycsgCOBKmUhT
         WuxlHFr/7lxwz/3OaFX0xtgvk65oFO0Hb/wqQiwQ3rnBDjGZhMY9stwJZO+U5/63eb2h
         19yCpWhGVaJ6EgIh8paA9OuInx1DOj/QS6wisXuQTknwQmGISTkXPpOc7KQyn3FQD29j
         ZoGI1LIMPEvwjrXih1ruxMm5QTC56l8AhAmjm2xEbqG4Qjg+/wja56FS0Rrp3usbkOh5
         dB5w==
X-Received: by 10.50.108.235 with SMTP id hn11mr2671196igb.107.1365633123886;
 Wed, 10 Apr 2013 15:32:03 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 15:31:23 -0700 (PDT)
In-Reply-To: <20130410222334.GC6930@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220790>

Jeff King wrote:
> To flesh out my earlier example:
>
>   $ git clone https://github.com/upstream/project.git
>   $ cd project
>   $ hack hack hack; commit commit commit
>   $ git tag -m 'something of note' my-tag
>   $ git remote add me https://github.com/me/project.git
>   $ git config branch.master.remote me
>   $ git tag -m 'something of note'
>   $ git push master my-tag
>
> My intent there is publish both master and mytag, but my-tag goes to
> origin. It's obvious if you think carefully about (and know) the rules,
> and it's user error. But what fault do we take for designing a feature
> that causes confusion?

Good example.  Sorry, I misunderstood your one-liner.  I agree that
this is confusing.  Tags are a bit of an outlier, and we have to think
of some way to behave sensibly with them.  I'll let you know if I
think of something in the next few hours.
