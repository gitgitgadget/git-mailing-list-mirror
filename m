From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Fix git-svn to handle svn not reporting the md5sum of
 a file, and test.
Date: Sun, 27 May 2007 07:49:15 -0400
Message-ID: <4659703B.8070101@gmail.com>
References: <1179981426176-git-send-email-foom@fuhm.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, normalperson@yhbt.net,
	Junio C Hamano <junkio@cox.net>
To: James Y Knight <foom@fuhm.net>
X-From: git-owner@vger.kernel.org Sun May 27 13:49:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsHFa-0004R3-Cn
	for gcvg-git@gmane.org; Sun, 27 May 2007 13:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbXE0LtV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 07:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbXE0LtV
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 07:49:21 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:19779 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbXE0LtU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 07:49:20 -0400
Received: by wx-out-0506.google.com with SMTP id t15so995073wxc
        for <git@vger.kernel.org>; Sun, 27 May 2007 04:49:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=g6M2wZ0dPjJQ/ARlFXvHRivk2LqlzrG3xD/XeF73Rz2+SOISgKA33TfFAoQQRhM3979AoFXPuZtyOhyNpkigDb0rvT+zoT2KgGwSGJlw499HNPkHP7NtDHsgxz64tk2bP/YMi+86UgWEVf8+G32fSfgD75zHxVMoRl/GTJBBqSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ZbS3a22cyy97zMGBe0KVfKzXOlbXPzpFDgfvCsrl8pqryA0qObtxkd3ZvqFnCqrhH2fAiUUitmSgpbAeo4ZSzHGUKGNZ3qC+sBiL7F499xXnwuJqZNDH8P/B+NptxsUqwZJEvj0bB/8voRlvKilAf3ItPC7AwqXEPMZJtV7/KC8=
Received: by 10.70.123.14 with SMTP id v14mr6795120wxc.1180266557564;
        Sun, 27 May 2007 04:49:17 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.99])
        by mx.google.com with ESMTP id i39sm3699769wxd.2007.05.27.04.49.16;
        Sun, 27 May 2007 04:49:16 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <1179981426176-git-send-email-foom@fuhm.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48532>

James Y Knight wrote:
> ---
>  git-svn.perl                    |    2 +-
>  t/t9112-git-svn-md5less-file.sh |   45 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 1 deletions(-)
>  create mode 100755 t/t9112-git-svn-md5less-file.sh
[...]

The new test fails here (Suse 9.3 fully patched) w/ the following:

*** t9112-git-svn-md5less-file.sh ***
*   ok 1: load svn dumpfile
*   ok 2: initialize git-svn
* FAIL 3: fetch revisions from svn
         git-svn fetch
* failed 1 among 3 test(s)
make[1]: *** [t9112-git-svn-md5less-file.sh] Error 1
