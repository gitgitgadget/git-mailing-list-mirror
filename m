From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: rc4 - make quick-install-doc is broken
Date: Sat, 04 Aug 2007 12:00:48 -0400
Message-ID: <46B4A2B0.9080208@gmail.com>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 04 18:01:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHM3z-0002Gj-6n
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 18:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbXHDQAx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 12:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752940AbXHDQAx
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 12:00:53 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:2033 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbXHDQAx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 12:00:53 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1078569wxd
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 09:00:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=DabbWkutbBrp7uAo8wtCNy6UaxAMkxwH8l27Qbm/OdEmUGG5osnjgXPyarWDy7q/Aft1DIRFY3T9CEErsS1oi5xBK2NTyWIfmhG9sQz7QMVHHHP9C+2u/vwBHJYGWO0wQ/P2ZeVC7nEGDLzsG+2UIPfPdy19YY5StmugaHg95uM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BWEwvrtQQnXrSyQ7v69NThn915Yqn9OVOwm1ZJGNyeQBNlh/AmzpYsGYxREQoYT0ewgc0z2ieiXyO8ss5FGe6Z9dBjtjNB/9CR1QaT6YDEZ2Aiu24teVz8hpy9UQ4mtgSNzbNaw768YSUGNwrJbPhSIoDQrJ0VNR9wR0b7yirv0=
Received: by 10.70.98.17 with SMTP id v17mr6954928wxb.1186243252143;
        Sat, 04 Aug 2007 09:00:52 -0700 (PDT)
Received: from ?192.168.100.118? ( [72.66.124.87])
        by mx.google.com with ESMTPS id h13sm4198307wxd.2007.08.04.09.00.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Aug 2007 09:00:51 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
In-Reply-To: <Pine.LNX.4.64.0708041637450.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54870>

Johannes Schindelin wrote:
> Could it be that you did not find this commit by bisecting the issue?  I 
> highly doubt that said commit changes anything in the build process.
>
> Ciao,
> Dscho
>
>   
<snip ...>

git>git bisect good
6490a3383f1d0d96c122069e510ef1af1d019fbb is first bad commit
commit 6490a3383f1d0d96c122069e510ef1af1d019fbb
Author: Junio C Hamano <gitster@pobox.com>
Date:   Thu Aug 2 15:10:56 2007 -0700

    Fix work-tree related breakages

    In set_work_tree(), variable rel needs to be reinitialized to
    NULL on every call (it should not be static).

    Make sure the incoming dir variable is not too long before
    copying to the temporary buffer, and make sure chdir to the
    resulting directory succeeds.

    This was spotted and fixed by Alex and Johannes in a handful
    patch exchanges.  Here is the final version.

    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

:100644 100644 3653092ab657942639b6183fb04b3af783b77e7a 
4945eb3134c3e047f54e51db25cd0aa81d9c47d7 M      setup.c
