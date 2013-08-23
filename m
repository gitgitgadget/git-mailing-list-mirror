From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4 out of memory for very large repository
Date: Fri, 23 Aug 2013 08:16:58 +0100
Message-ID: <52170C6A.4080708@diamand.org>
References: <20130823011245.GA7693@jerec>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Corey Thompson <cmtptr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 09:17:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VClcd-0006Wh-H4
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 09:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824Ab3HWHRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 03:17:24 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35309 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792Ab3HWHRX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 03:17:23 -0400
Received: by mail-wg0-f47.google.com with SMTP id j13so198391wgh.2
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 00:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ii8dkKS7lVdJxZ0be+gMU/U4SeRC+grKs2fPUJxzu4E=;
        b=I0c3BF8wSYxhFBR+rOSHYPG4aF1QKQYm++yXTAMczatQPtBtAzesqpv+B5uSZ9vu0f
         VebTvUjokL2nLzNMNtgJcD1ZDaD1Ws8QzfVtkQfE2CnJU7ytoQcUT2zIgZ5H7gSE3Hdl
         hQdMCcfE1htOjWClBM37BucuEuSJRZQglChzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ii8dkKS7lVdJxZ0be+gMU/U4SeRC+grKs2fPUJxzu4E=;
        b=Cxz9O88DasY5lqM1cezA0cGYgXFJgd9BWepYRyiYx3UZ+84EZ1wG21sT5Cpe8CFhov
         6gIsmka0CTGZQU4PLvp/nAI7PBcxb21VMfqByQ2RjvNcRFPkR5BZBx5cNRzGUDpa+YDn
         6DDgQzPyDG3IkAwlG9RmNTN/NfIZk1jyJmwXQLxv0BOtGXAQtTIS1xHGYvwoav/RDA2z
         zpXhlN4pmyC1HfqYEDIVzZ5TxjjnhdFoxMv9zS6pyE8lct8yvgJzPWxHow9jy6pyIBzg
         14oaQraeMuWQp+tabxgNEu2iMASx10TxCWWQref5JSCn8BGoE8VPQGprwAUgcr2Y/y8t
         rc+g==
X-Gm-Message-State: ALoCoQnhV7O3/J8fbhVmuYhwiITePQmOSu7i6GXI23WTqngDZebrbbzcSRBMelC/xv4ey0hpY2xK
X-Received: by 10.180.160.240 with SMTP id xn16mr964051wib.62.1377242241718;
        Fri, 23 Aug 2013 00:17:21 -0700 (PDT)
Received: from [86.14.230.179] (cpc14-cmbg17-2-0-cust690.5-4.cable.virginmedia.com. [86.14.230.179])
        by mx.google.com with ESMTPSA id l5sm1631359wia.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 00:17:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <20130823011245.GA7693@jerec>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232801>

On 23/08/13 02:12, Corey Thompson wrote:
> Hello,
>
> Has anyone actually gotten git-p4 to clone a large Perforce repository?

Yes. I've cloned repos with a couple of Gig of files.

> I have one codebase in particular that gets to about 67%, then
> consistently gets get-fast-import (and often times a few other
> processes) killed by the OOM killer.

What size is this codebase? Which version and platform of git are you using?

Maybe it's a regression, or perhaps you've hit some new, previously 
unknown size limit?

Thanks
Luke


>
> I've found some patches out there that claim to resolve this, but
> they're all for versions of git-p4.py from several years ago.  Not only
> will they not apply cleanly, but as far as I can tell the issues that
> these patches are meant to address aren't in the current version,
> anyway.
>
> Any suggestions would be greatly appreciated.
>
> Thanks,
> Corey
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
