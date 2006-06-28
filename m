From: "Morten Welinder" <mwelinder@gmail.com>
Subject: connect.c and errno
Date: Wed, 28 Jun 2006 12:56:12 -0400
Message-ID: <118833cc0606280956s4081029ci5b3cd1fdf4b10c97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jun 28 18:56:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvdL3-000304-69
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 18:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWF1Q4S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 12:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWF1Q4R
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 12:56:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:5668 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751467AbWF1Q4N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 12:56:13 -0400
Received: by ug-out-1314.google.com with SMTP id a2so3209715ugf
        for <git@vger.kernel.org>; Wed, 28 Jun 2006 09:56:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hPAt9TSoO7K0eYsSGeka/6uAa8yougVwElk7ESgWlKUBRQF5RVN4yb85W+6Hgnyn1px6/ao3NeAMaLmAJeWadamdZJp4b37M87pro7h1pGq6hmR6mE0Q9Qeoawt3gY3bnfeIJv+r3UD+ip+lT/wUAu/DCQP/rXzY/EZEygfxp4Y=
Received: by 10.67.19.13 with SMTP id w13mr935465ugi;
        Wed, 28 Jun 2006 09:56:12 -0700 (PDT)
Received: by 10.67.86.4 with HTTP; Wed, 28 Jun 2006 09:56:12 -0700 (PDT)
To: "GIT Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22813>

It looks like connect.c waits too long before it uses errno in both copies
of git_tcp_connect_sock.  Both close and freeaddrinfo can poke any
non-zero value in there.

M.
