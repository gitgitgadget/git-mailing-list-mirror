From: John Szakmeister <john@szakmeister.net>
Subject: Re: [BUG] clone: regression in error messages in master
Date: Fri, 21 Jun 2013 06:07:07 -0400
Message-ID: <CAEBDL5UNNHnogHb2ztq2G8OxyCNMoLia7xYFNSy+kfHD3pS1pQ@mail.gmail.com>
References: <CALkWK0n7S8s-ABQ1qV5JSsyhYo6=rmK1UT+uYW9hjjeWjambug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 12:07:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpyFQ-0001P4-EY
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 12:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab3FUKHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 06:07:10 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:41549 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab3FUKHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 06:07:09 -0400
Received: by mail-wi0-f178.google.com with SMTP id k10so432575wiv.17
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 03:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=D7eX2r+if6PRFiB0zYuAKbxiYrc+P2ucWryD8uIqhd8=;
        b=hLN29L3sXoaUpU5Lrv/44JVVPWqZCZXhZnx9LNhJSF6vU+gpDimEgt1y3f/ZY3JeVN
         6FYcYHC4y5QBoKLvKRZeqf49FOmb/IPD+b57xidB/mHz++9aCRGNFFOPVqWqRBaLkVhr
         vBdu4dZ7KR73eGAzRO1CzK1Z3dcmPp3g+2TQw0l2KQOCA6YJD3tmlGgTuOayOaumBuIo
         z8fOoZvbcxisIGh8ojQq8dQLp5Uh6y66/qGe6QxcOwQlvZSjyLRQ6u95qFdLi4i527Ps
         goG02JKVWSUJiCIWCirtQi0qdRWLOZpo6YDDKMaXYEX/RFVDy+UMs1Oj+k5jc9ThnZ4C
         o2bw==
X-Received: by 10.180.98.233 with SMTP id el9mr2196253wib.54.1371809227817;
 Fri, 21 Jun 2013 03:07:07 -0700 (PDT)
Received: by 10.180.24.5 with HTTP; Fri, 21 Jun 2013 03:07:07 -0700 (PDT)
In-Reply-To: <CALkWK0n7S8s-ABQ1qV5JSsyhYo6=rmK1UT+uYW9hjjeWjambug@mail.gmail.com>
X-Google-Sender-Auth: GHg3aui65TKbqe6vP9qyn5xtBu8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228591>

On Thu, Jun 20, 2013 at 9:16 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Hi,
>
> So this should explain the problem:
>
>   # using v1.8.3.1
>   $ git clone https://google.com
>   Cloning into 'google.com'...
>   fatal: repository 'https://google.com/' not found
>
>   # using master
>   $ git clone https://google.com
>   Cloning into 'google.com'...
>   fatal: repository 'https://google.com/' not found
>   fatal: Reading from helper 'git-remote-https' failed

I can see where this is confusing, but can also see how it's useful
information to have.  On clone, it's probably not that useful since
you're looking right at the url, but I could see that information
being more useful on a pull or push with the default arguments (when
the source and destination aren't quite as obvious).

-John
