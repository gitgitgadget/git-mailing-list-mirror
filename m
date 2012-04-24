From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] git-svn: fixes for intermittent SIGPIPE
Date: Tue, 24 Apr 2012 12:09:47 -0700
Message-ID: <xmqq62cpgd50.fsf@junio.mtv.corp.google.com>
References: <cover.1335250396.git.rkagan@mail.ru>
	<20120424094541.GA30803@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roman Kagan <rkagan@mail.ru>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 24 21:09:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMl7b-0002Jh-AL
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 21:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757133Ab2DXTJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 15:09:51 -0400
Received: from mail-fa0-f74.google.com ([209.85.161.74]:64142 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439Ab2DXTJu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 15:09:50 -0400
Received: by faaa25 with SMTP id a25so19810faa.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 12:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=Y2AqNi3F0k57zNGC9axUi+TK21vPyiHqhzbnNIzLx5s=;
        b=DMgGWHOYngZpCHTxzOCppgauZZuTUQWSDB2PdT530aZMmrLLpECH7tY6U1kk7TjL+p
         Ct3k+OzvIcBq+Ae8uUEhyoB5K3PB54DSUmxpxAKUxIWE3fcuin67EifQMAZdkoMaXS4F
         QGI6OI2lCBLKQpd7drwO5vrwi5RwKWBBPkmP0x+Tg8olF+jTVXx1BRIQ/SsrDZkhicAO
         GrvQdGSsrZA0XZX9TMlsEIKM4gfAQMrWx5bImQOW7Rh25qrLM4eyMFSd7WfAxcRESd3M
         UBro2uDBMeCvwlzRqG1siVDPVjhLd4s0TYDvk7dI6jLCn4iyC+oCa4CUW7tYu2nLCNr5
         schA==
Received: by 10.213.2.198 with SMTP id 6mr12394ebk.25.1335294589079;
        Tue, 24 Apr 2012 12:09:49 -0700 (PDT)
Received: by 10.213.2.198 with SMTP id 6mr12375ebk.25.1335294588683;
        Tue, 24 Apr 2012 12:09:48 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id t8si13808842eef.1.2012.04.24.12.09.48
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 24 Apr 2012 12:09:48 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 62890200057;
	Tue, 24 Apr 2012 12:09:48 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id B1BEDE125C; Tue, 24 Apr 2012 12:09:47 -0700 (PDT)
In-Reply-To: <20120424094541.GA30803@dcvr.yhbt.net> (Eric Wong's message of
	"Tue, 24 Apr 2012 09:45:41 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlbgWXcITK+cxyvzy8A+1QuBnFzN8xcQ9wSLETrm4ayMMXP7khKIaJlrFjvB745+c5z/Jxz+t3tYNqyn0AU37RYO8H1sgusk/3MJ0o+A5WNUANh7/d6Ur+tzJSIfsQ81oVQ1E+CLUtzCRP+lUmC89nMF9iaKXIDAbTN0vvDfMDx6dg3sEM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196238>

Eric Wong <normalperson@yhbt.net> writes:

> Roman Kagan <rkagan@mail.ru> wrote:
>> This is the third version of the series; compared to the previous submission
>> the log message of the first patch was reworded to make it more palatable.
>> 
>> Roman Kagan (3):
>>   git-svn: use POSIX::sigprocmask to block signals
>>   git-svn: ignore SIGPIPE
>>   git-svn: drop redundant blocking of SIGPIPE
>
> Thanks for this series, acked and pushed to git://bogomips.org/git-svn

Thanks, both. I agree that the first one is much more nicely explained
than the previous one.
