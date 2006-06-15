From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: [PATCH] auto-detect changed $prefix in Makefile and properly rebuild to avoid broken install
Date: Thu, 15 Jun 2006 11:11:55 +0000
Message-ID: <f36b08ee0606150411q67fce728vad6dc0403160f95a@mail.gmail.com>
References: <0J0V00LDT7B9BU00@mxout2.netvision.net.il>
	 <7vver3cxlw.fsf@assigned-by-dhcp.cox.net>
	 <f36b08ee0606141330l28330d79hab1aec5c741188c7@mail.gmail.com>
	 <7vhd2nctjk.fsf@assigned-by-dhcp.cox.net>
	 <f36b08ee0606141438u7d7b59e1ra68bc23e2e926290@mail.gmail.com>
	 <E1Fqo70-0003pZ-PU@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 15 13:12:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqplq-0000QP-FI
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 13:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWFOLL5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 07:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWFOLL5
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 07:11:57 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:57896 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030198AbWFOLL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jun 2006 07:11:56 -0400
Received: by py-out-1112.google.com with SMTP id i49so249248pye
        for <git@vger.kernel.org>; Thu, 15 Jun 2006 04:11:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lrce4ENCDNS3fBpqWDbG/EJic6hBuDz6806oiTV5ZKWxnggt5Q58By+zWQzZ3eOj0rMWtnpaq/m8I08cG5AZ1GPq6CQZk8zfXaoZGOCEk+llL6vLkXZmQSGDyQil78pZTcjkzlmIO/DYu9KMKWtTP54/xSay3mimU96kpVl9qJg=
Received: by 10.35.134.12 with SMTP id l12mr2742701pyn;
        Thu, 15 Jun 2006 04:11:55 -0700 (PDT)
Received: by 10.35.14.20 with HTTP; Thu, 15 Jun 2006 04:11:55 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <E1Fqo70-0003pZ-PU@moooo.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21888>

On 6/15/06, Matthias Lederhofer <matled@gmx.net> wrote:
> > Either GIT-CFLAGS or GIT-BUILD-FLAGS,
> > whichever is shorter :-)
>
> I would not take GIT-CFLAGS because there is an environment variable
> used by make named CFLAGS and means something else.

What is your preference for this filename ? Is GIT-BUILD-FLAGS
better ? GIT-FLAGS ? Other ?

GIT-CFLAGS is filename here, whereas  $(CFLAGS) is variable.
Maybe writing it the filename ./GIT-CFLAGS would
emphasize betterthat it's not make variable, but a filename ?

> What is the target test-prefix-change good for? Should it really be
> included?

The purpose of 'test-prefix-change' is to check that there are no
missing GIT-FLAGS as prerequisite which would result in broken install
if prefix changed between 'make' and 'make install'. The
'make test-prefix-change' would catch it if GIT-FLAGS happened
to be missing in some places that if substantially dependent of $prefix.

Yakov
