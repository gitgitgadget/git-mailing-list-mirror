From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: How to find a commit that introduces (not removes) a string?
Date: Thu, 03 Nov 2011 10:56:23 -0500
Message-ID: <4EB2B9A7.5090909@gmail.com>
References: <j8to8h$vqd$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 16:56:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLzeb-0007hW-GU
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 16:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933827Ab1KCP43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 11:56:29 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64347 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933779Ab1KCP42 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 11:56:28 -0400
Received: by mail-yw0-f46.google.com with SMTP id 7so1463252ywf.19
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 08:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=as5RX+BxeHoFBVzj0/O8/++a8rOSNVec0JWEKYwYDqI=;
        b=hgGvY/aZTG2laerxmWyGrtZQrWU9Gr00bhJEKDwNn9ljvMRP9hlVPeVyl8uVsNSTpa
         L5RJ/1M9ydRCY/pqx3/2G0PEWnieiGddu7rw5OoMLF59E8Etu4K3UNAJguu1zkU/uiko
         ukFTyS4GwaXvw55vYJkBwSIVgQQIfHMPYcvq4=
Received: by 10.236.173.202 with SMTP id v50mr10287114yhl.102.1320335788309;
        Thu, 03 Nov 2011 08:56:28 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id n5sm10048973yhk.1.2011.11.03.08.56.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Nov 2011 08:56:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.20) Gecko/20110804 Thunderbird/3.1.12
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <j8to8h$vqd$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184724>

On 11/3/2011 4:50 AM, Sebastian Schuberth wrote:
> Hi all,
>
> I know about git log's -S / -G, but I'm unable to make these search through *introduced* strings only. Is there a way to do so?
>
> Thanks!
>
> PS: I also read [1], but although the author claims to be interested in introduced strings only, he seems to be satisfied with -G, which slightly puzzles me.
>
> [1] http://stackoverflow.com/questions/5816134/git-finding-a-commit-that-introduced-a-string
>
If you are using linux, here is git diff command I use to find leftover 
debug statements.  I imagine the -S option will work the same in git 
log.  I pipe the results into grep to filter the results to show only 
the additions. (I'm using git 1.7.1)

$ git diff --unified=0 -S"DEBUG" <commit> <commit> -- <path> | grep -e 
"diff --" -e "+" | grep -v -e "@@" -e "+++"

maybe you will find this helpful.

v/r,
neal
