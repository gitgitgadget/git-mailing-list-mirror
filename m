From: Darren Oakey <you@darrenoakey.info>
Subject: Fwd: Compiling git 1.8.1.4 on 64bit centos 5.6
Date: Sun, 24 Feb 2013 00:13:11 +1100
Message-ID: <CA+B9=JLaZ5P+H-b-A6Xo-TRMcQYwGawjD-G62m8asnC0qMwmdg@mail.gmail.com>
References: <CA+B9=JLWASmrK_TNTkJxRH1cZrVjhXN8kKmCZcnHgKXwX9WUiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 14:14:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9EwK-00053J-Iz
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 14:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758933Ab3BWNNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 08:13:14 -0500
Received: from mail-we0-f171.google.com ([74.125.82.171]:33637 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179Ab3BWNNN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 08:13:13 -0500
Received: by mail-we0-f171.google.com with SMTP id u54so1289189wey.30
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 05:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=+dzpDlptC/2IxapOxXuvavg8liC7/omVT6qtXp/Wa3o=;
        b=0l7Q9qSx7SpU9FC3TlBqqfliDHvryhk8NknzX265n0SMck6cKVyU7nPoMFgxOqvBMk
         vV8JFiXfEU/Z2m/ZZTlYAlQ7n7VtQou04nI7Amk1wix6bXDsVzQmbr298OnJVfC3u5vp
         ayWvNHOP2KorPb3r35JUUYckPPw033e7yRudAe8jEwAhYT1Y8cxbAWjW2QavOrwjyPDu
         OIBDsOZwFCqT3RwWqHakCnZQ3U0HvW4W7jQ01kNO6JF+6uhqxv4cIyvWcFkIOKXaVhVd
         6SbHie0w54QNdR8C5nZ7ErhMHh+TEd8+y399X2zoqL1dXCAqSbpbu61QHAEo9eNHYOVc
         b3Mw==
X-Received: by 10.180.77.9 with SMTP id o9mr2637644wiw.16.1361625191949; Sat,
 23 Feb 2013 05:13:11 -0800 (PST)
Received: by 10.194.119.41 with HTTP; Sat, 23 Feb 2013 05:13:11 -0800 (PST)
In-Reply-To: <CA+B9=JLWASmrK_TNTkJxRH1cZrVjhXN8kKmCZcnHgKXwX9WUiA@mail.gmail.com>
X-Google-Sender-Auth: BXLqgmF5Ec2N2tDIOjLi9VxMArM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216895>

g'day,
got a web host where I want to put git - it has no c compiler, so I
have to compile elsewhere.    ssh is also locked out, so I have to use
https.         The site uses both 64bit and 32bit hosts.

On a 32bit vm, I compiled the 32bit version of git fine with -static,
sent the binaries over, and it works perfectly.

On a 64bit vm, I just cannot get a 64 bit version of git compiling
with -static...  or more precisely - I can but can't whatever I have
tried get a remote-http and remote-https to turn up in libexec.
Even when I hack the configure to force NO_CURL=  and NO_OPENSSL=   -
and add every extra library I seem to need   (-lcrypto, -lssl -lkrb5
-ldl) it refuses to compile - giving me a bunch of missing krb5_*

If I compile without static, it works - but the shared libraries
aren't found when it's run from the web host.  If I try running the
32bit version on the 64bit host, it doesn't find some library - and if
I try the 64bit version that I can properly get compiling statically,
I get an error saying no remote found for https.

Please help - it's driving me insane... can anyone tell me how to
compile a 64 bit static version of git under centos 5.6?

Thanks,
Darren
