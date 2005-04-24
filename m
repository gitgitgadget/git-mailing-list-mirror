From: Morten Welinder <mwelinder@gmail.com>
Subject: fsck-cache problem
Date: Sat, 23 Apr 2005 21:55:20 -0400
Message-ID: <118833cc0504231855145c10a5@mail.gmail.com>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Apr 24 03:50:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPWGg-0005Ih-16
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 03:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVDXBzY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 21:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVDXBzY
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 21:55:24 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:57077 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262217AbVDXBzV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 21:55:21 -0400
Received: by rproxy.gmail.com with SMTP id a41so732184rng
        for <git@vger.kernel.org>; Sat, 23 Apr 2005 18:55:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hAlT4kUSzIKyp1qiQNX0lCjD+L6gyg+keqToGC8I6pJBzrLhOAiM8rSIYYXSO6wG5u5nEn0hwzEvPYe59szlqExDTat9gGHj6TUqt2Z2EbvZQi/JRj9yOI8iTGBzPOjjHDdv0m2tqkf5t28wN+/rF01iIwmwZ+RUI+3us4z+PrM=
Received: by 10.38.6.75 with SMTP id 75mr4486284rnf;
        Sat, 23 Apr 2005 18:55:20 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Sat, 23 Apr 2005 18:55:20 -0700 (PDT)
To: GIT Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

While downloading the sparse git database I got impatient and ran
fsck-cache on it.
I got...

...
missing (null) ff515b91674ff2f5b082a927676dbf392d04d9ce
missing (null) ff94be6fbcce10b83824defbdc2f8819121bbd4d
missing (null) ffa4ddda950185bf313654e903207a3fc2d5f261

That "(null)" is not from git, but from glibc in response to NULL
passed for %s.  It might
as well crash (as some other libc do) or send in the marines.

Morten
