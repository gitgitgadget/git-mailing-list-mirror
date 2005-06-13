From: Mark Allen <mrallen1@yahoo.com>
Subject: Re: [PATCH] Unset TZ in t5000
Date: Mon, 13 Jun 2005 10:27:57 -0700 (PDT)
Message-ID: <20050613172757.41222.qmail@web41215.mail.yahoo.com>
References: <42ADAC4D.7050408@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 19:24:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dhsei-0002NH-2D
	for gcvg-git@gmane.org; Mon, 13 Jun 2005 19:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVFMR2G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 13:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVFMR2G
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 13:28:06 -0400
Received: from web41215.mail.yahoo.com ([66.218.93.48]:38520 "HELO
	web41215.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261156AbVFMR2C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2005 13:28:02 -0400
Received: (qmail 41224 invoked by uid 60001); 13 Jun 2005 17:27:57 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=C8O1054slrP2OoSQwsvy8RnHW3Gp4HyIg8Wya8YTm6i7sLG3iWdXgQR9/Pzax7alcV8/hQG4Tejee/9Q601ZUl8vAq1RjmxO3l3lkijj0mf8lsPpRfQ8BJ6UZWpvdsvgGQCMXvveav24mOiFBndzatojGSG6ZDjQWKP5sfwXSRA=  ;
Received: from [65.173.207.2] by web41215.mail.yahoo.com via HTTP; Mon, 13 Jun 2005 10:27:57 PDT
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <42ADAC4D.7050408@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--- Rene Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
> What kind of AWK is that?  The One True AWK certainly has a length
> function for strings and POSIX mandates it, too, so it's not a GNUism.
> 
> The expression
> 
>    length($5)<7 ? $5":00" : $5
> 
> (where $5 is a time value) is there to cope with tars that format the
> time like hh:mm instead of the expected hh:mm:ss.  If you have to remove
> the call to "length", please replace the thing with something
> equivalent, like
> 
>    match($5, /:.*:/) ? $5 : $5":00"
> 
> or similar, instead of simply dropping that test.

Hi Rene,

I'll test your suggestion later tonight (US time) when I get home from work.  Sorry I
don't know much about awk. (I usually break out perl for any job I used to give awk) When
I ran the t5000 script in --verbose mode, all I could see was awk complaining about the
length directive.

It *is* possible that there's some kind of quoting/character escape problem which Linux
tolerates but is causing the syntax error on my home system. (It's Mac OS 10.4.1/Darwin)

Thanks,

--Mark
