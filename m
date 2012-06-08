From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [BUG] Out of memory on git log --simplify-by-decoration --first-parent
Date: Fri, 08 Jun 2012 22:23:16 +0200
Message-ID: <4FD25F34.1060400@lyx.org>
References: <4FD24330.2030805@lyx.org> <7vwr3hbm6x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 22:23:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd5iN-0005aR-N2
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 22:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934430Ab2FHUXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 16:23:20 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57885 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933473Ab2FHUXT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 16:23:19 -0400
Received: by wgbdr13 with SMTP id dr13so1222151wgb.1
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 13:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=8VrfiD5cs2AmygK8TZBL1Z8T2eK+nuBLB/abjiQswf4=;
        b=HLC9961Zm0APvFyODKnLJmXTCRKjtoiOTB3qzAUt/jqunL1hK/0lq8Amc1/RKYu71o
         bFc5WdtQPk/e5v0J768ceY2of7lLehY6CJijdkzbAoEsYABmEEYH2SwCL5mlmUs5i5rO
         8+gcgvFiNvZSrizuSmWVOPznKHNGJL0R1uM+Edv55OY20YRsZs40DclmP1ZbEKj6ZI2Q
         +iEJETSiUlDfDbqNab3UFpYHZ6NW/fuzGd5sEf9sFM9TYLub9Vq2NrXdovZXqQ7SH9zE
         S5neKIOp+9JgrJlqn+P40t6kRWOx/EIMoPWY1JZdkLgjUPWF/aAvm5BHnWWZmz3qVgNG
         vT1A==
Received: by 10.216.141.213 with SMTP id g63mr2088465wej.34.1339186998005;
        Fri, 08 Jun 2012 13:23:18 -0700 (PDT)
Received: from [192.168.1.3] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id z8sm5540622wiy.1.2012.06.08.13.23.16
        (version=SSLv3 cipher=OTHER);
        Fri, 08 Jun 2012 13:23:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7vwr3hbm6x.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQl9yYQz3qFSB6QScPFMZrw+TWjtgcZhMOtIfXwbVaEmSSFLtYclyFuoYCrJROhdOpfGdZ5P
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199530>

Op 8-6-2012 22:09, Junio C Hamano schreef:
> Vincent van Ravesteijn<vfr@lyx.org>  writes:
>
>> git dies after calling the following command on the git repo:
>>
>> $ git log f623ca1c...b9cfa4e9 --simplify-by-decoration --first-parent
> I wouldn't be surprised anything random happens when --first-parent
> is used together with simplify_merges(); the function needs full
> analysis of all commits in the specified range, and first-parent
> traversal specifically tells us not to descend into other parents.
> It might not be a bad idea to forbid this combination when the
> command line options are parsed.
>
> What information were you trying to get out of the above command?

I was using gitk and I tried to simplify the history a bit, just for 
visualization,... so I tried by checking "Limit to first parent" and 
"Simple history". Then, git errored out with an out-of-memory error.

Vincent
