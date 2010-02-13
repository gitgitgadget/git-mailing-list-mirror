From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 5/5] Use kwset in grep
Date: Sat, 13 Feb 2010 16:58:27 +0100
Message-ID: <4B76CC23.8040605@gnu.org>
References: <20100213141558.22851.13660.stgit@fredrik-laptop> <20100213142110.GF9543@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 17:05:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgKUk-0003zF-Vn
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 17:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793Ab0BMQFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 11:05:17 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:52457 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033Ab0BMQFP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 11:05:15 -0500
Received: by fxm27 with SMTP id 27so60521fxm.25
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 08:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=LRGg+QjGaWc4akHutT2Tj2nKVhzbFC7QpyT13iW5f9I=;
        b=mkGd/W+IazpVoJgOa+7xNjTugm5pIllg3B/5slEYxNLPYXDbUeg4E53S+d3oSe6vO0
         5Ab8/i6mbnBTvr3rmkwWK4qRGmI7hmRUJw4WumlLxt0QsFZGJjVHi2CwCDg2ZK5njZtM
         pL/zfVV9KRvGHgGqP5vU0s194pwzDcJtF3oN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=fyE4ArXtJJkfOmZbH72XwAoR1wEL4lqLsDBgoEr3iATzvIx6bhD0quYA0Q2HSfEmKn
         jyTCOD5xYJR2sqMMy5KpfzeC5skdsJMbGMgaY1172rStmX4pcLG1q+QJKp521sS8qouq
         cPvI7r4R1k/ZiMdsR0kEPnGlrJJjHlDAgjkqU=
Received: by 10.223.2.216 with SMTP id 24mr3250497fak.72.1266076711290;
        Sat, 13 Feb 2010 07:58:31 -0800 (PST)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id 2sm7345437fks.43.2010.02.13.07.58.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Feb 2010 07:58:30 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <20100213142110.GF9543@fredrik-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139810>

On 02/13/2010 03:21 PM, Fredrik Kuivinen wrote:
> Best of five runs in the linux repository:
>
> before:
>
> $ time git grep qwerty
> drivers/char/keyboard.c:        "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */
>
> real	0m1.065s
> user	0m1.400s
> sys	0m0.536s
>
>
> after:
>
> $ time git grep qwerty
> drivers/char/keyboard.c:        "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */
>
> real	0m0.621s
> user	0m0.560s
> sys	0m0.564s
>
> So we gain about 40% by using the kwset code.

I like it, thanks for doing this!

Paolo
