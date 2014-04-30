From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 08/12] MINGW: fix main() signature in http-fetch.c and
 remote-curl.c
Date: Wed, 30 Apr 2014 10:35:56 +0200
Message-ID: <5360B5EC.1070907@gmail.com>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org> <1398762726-22825-9-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 10:36:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfPzq-0008FR-7O
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 10:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758151AbaD3If7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 04:35:59 -0400
Received: from mail-ee0-f45.google.com ([74.125.83.45]:45479 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235AbaD3If4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 04:35:56 -0400
Received: by mail-ee0-f45.google.com with SMTP id d17so1068457eek.32
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 01:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=hYVG+zTPDpoF5pEPSDgmTt/BduZ/oPBzV8wpj0chhAQ=;
        b=T9RNc65yU9R5e8RDKHEeAcp7HuheNfQdBLgqBDRPrWhdiPq98StnfGldt4Yu1lSkTl
         l87tmkBf2hmXlYB7zINXNvvG6Y2UsUC38dQnJIXwE0G749BcG9gQ3Egvzk7mnfU/KXxk
         O0nQNpoLub4Yo8+xPjICCaqR6RhO3fmSaOVES3qzPmp92AScJ41mwb09bl5rpzRhJ5Gh
         ti29tw87srEf3XkMzr0mLaH87ZSzTxgoQ5hhk+Zy17Sy27wMGXdiMme18KHtKkobzkIu
         lNOwV38w6CkAXnDRHJvu2GEv3kPYWLE+OGEHXR7jzaWMPvq7/ZzImM/j8B528T3O62dm
         9aHQ==
X-Received: by 10.14.22.69 with SMTP id s45mr2778574ees.56.1398846955654;
        Wed, 30 Apr 2014 01:35:55 -0700 (PDT)
Received: from [10.1.116.60] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id o4sm65975503eef.20.2014.04.30.01.35.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Apr 2014 01:35:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <1398762726-22825-9-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247683>

Am 29.04.2014 11:12, schrieb Marat Radchenko:
> On MinGW, compat/mingw.h defines a 'mingw_main' wrapper function.
> Fix `warning: passing argument 2 of 'mingw_main' from incompatible
> pointer type` in http-fetch.c and remote-curl.c by dropping 'const'.
> 

Would you mind cross checking your changes with the msysgit fork? Fixing the same thing in a slightly different manner will just cause unnecessary conflicts (i.e. unnecessary work for the Git for Windows maintainers, as well as for you to come up with an alternate solution for something that's long been fixed).

See https://github.com/msysgit/git/commit/9206e7fd (squashed from https://github.com/msysgit/git/commit/0115ef83 and https://github.com/msysgit/git/commit/6949537a).
 
