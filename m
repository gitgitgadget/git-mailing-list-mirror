From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 00:47:27 +0530
Message-ID: <CALkWK0kqE_s3QT7NPRFqTtmhWQDZj4YxsTw55eVTaVbT4H04tA@mail.gmail.com>
References: <7vr4im7m1y.fsf@alter.siamese.dyndns.org> <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
 <20130407161209.GG2222@serenity.lan> <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <20130407185905.GK2222@serenity.lan> <CALkWK0=v6SD_zEw=taauYWvYD5pHzdrED0vrhuFHKeS2zfgxSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Apr 07 21:18:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOv6W-0008SC-5Z
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 21:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933039Ab3DGTSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 15:18:10 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:47505 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932959Ab3DGTSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 15:18:09 -0400
Received: by mail-ia0-f173.google.com with SMTP id h37so4577097iak.32
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 12:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=CTGnyHPuDNC34dKM/i+bZSAtGjOm/ipll9/7zXSZUIU=;
        b=GAL3EgKKYx9EM1CRFEPiKoy5o3+UJvdbTeL5jQys/D0HLM5/NeS5eg/XfEH5lUE4u2
         DLCN1XAHbEcbb1XDRTwkCOWyik6WgCbb3UwlPrBH5oFxF42u2OY/nC2GeGzB9ppoVKR3
         X4cxpp8Km2FAVPXRLAZmKDM++r/KlipRvQG4I/b/vbEmrvLddhVrhaqFoSaao5+fQ3Ud
         t1AXe6OiAsruVNsGnGG8nFFeDFzuAq+xJqhDYfJIjmtpkw2+bTNcBbX8vrM2Lfi0Y09Y
         MEkuX3k8HJhH+sd0Z7hhtkbc+GEExrtm7k3oZN0B+24PT6dPz+TwYop1KmLpxxTRGtJL
         2XqQ==
X-Received: by 10.50.117.3 with SMTP id ka3mr4504397igb.107.1365362289120;
 Sun, 07 Apr 2013 12:18:09 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 7 Apr 2013 12:17:27 -0700 (PDT)
In-Reply-To: <CALkWK0=v6SD_zEw=taauYWvYD5pHzdrED0vrhuFHKeS2zfgxSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220363>

Ramkumar Ramachandra wrote:
>> The only proposed change that seems to me to be impossible with the
>> current .gitmodules approach is the "submodule in a non-initialized
>> submodule" feature, but I've never seen anyone ask for that and it seems
>> likely to open a whole can of worms where the behaviour is likely to
>> vary with $PWD.  The current hierarchical approach provides sensible
>> encapsulation of repositories and is simple to understand: once you're
>> in a repository nothing above its root directory affects you.
>
> That can be implemented in the current submodule system too, fwiw.

And yes, it's going to be very ugly: I imagine special refs pointing
to blobs, or something like that.  Then again, what do end-users care
about?
