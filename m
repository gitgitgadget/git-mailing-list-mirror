From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: svn clone Checksum mismatch question
Date: Thu, 26 Mar 2009 10:34:29 -0400
Message-ID: <eaa105840903260734p1a6b95ewb293974f49fc7f24@mail.gmail.com>
References: <22719363.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gilbert Liddell <gliddell@totalrepair.co.uk>
X-From: git-owner@vger.kernel.org Thu Mar 26 15:36:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmqgm-0006Pr-Po
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 15:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213AbZCZOel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 10:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757136AbZCZOel
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 10:34:41 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:32992 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756977AbZCZOek (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 10:34:40 -0400
Received: by yw-out-2324.google.com with SMTP id 5so493960ywb.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 07:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=C6F5WcPLVVgPYGtjnrq0QPiq1oWvKIPEwoPB0txJmjg=;
        b=RC7e1cbsZXPyj3SHUur7cZREYzAhqLvRMN/geR6Ah4eOnvyQOKkjQuAop4Suc7TVPW
         SofuNdwAVT4EXnY4GXyavc+N4xzTnAX8mHZS5+lz2+KJUsPemDnyd0T2utLOnIFWGWsb
         aOXuHct5lx/oqhxSINresv2T0b1coic/NmKOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=esB/kY+6aodd9VCQBi7ZsAQyEGnC1SKt9jveirjzWRFH42dKnm8HdnO/UPuNk9PNih
         C879yjvZWkUC2vIrT5TH4dUEb1MeRPCq3j3J8e62vPzl+3JvBj+R104Y8LtLgtZb3ilw
         B15P7qfTt3iuJiADVBuW4uVAS2rd/g3uYOkRE=
Received: by 10.100.33.15 with SMTP id g15mr602618ang.103.1238078069466; Thu, 
	26 Mar 2009 07:34:29 -0700 (PDT)
In-Reply-To: <22719363.post@talk.nabble.com>
X-Google-Sender-Auth: 9c517b7e0e9c1991
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114783>

On Thu, Mar 26, 2009 at 6:31 AM, Gilbert Liddell wrote:
>
> This morning i decided to test the clone with the full project i'm working
> on (11,000 files) and I get the error message Checksum mismatch: vn2.sln
> 0f7a82f1d38b819 expected: fde799e5ba0d1d07e6b539016bea3260
> got: e71db1010a0da06ea76d4163c452df72
>
> Can someone help with why this error is happening? Is there an issue with
> the GIT clone and large repositories?

(since you mentioned msysgit in another reply) What is your
core.autocrlf setting? Did you default it to 'true' or 'input' when
you installed msysgit?

Try "git config core.autocrlf false" and resume the import process
(with "git svn fetch" or similar).

Importing from svn with autocrlf on only works if every text file has
svn:eol-style=native set in every revision. *.sln files are even
worse, since they look like text to git, but they're really binary (so
nobody sets svn:eol-style on them).

Peter Harris
