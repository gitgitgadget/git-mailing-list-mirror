From: Timur Sufiev <tsufiev@gmail.com>
Subject: Re: [PATCH 1/4] Add routines for filenames encoding <local encoding> <-> UTF-8
Date: Wed, 28 Oct 2009 10:15:29 +0300
Message-ID: <4ae7ef9d.0f1abc0a.5b53.1a73@mx.google.com>
References: <1256651643-18382-1-git-send-email-timur@iris-comp.ru> <alpine.DEB.2.00.0910271515270.17168@ds9.cixit.se>
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:15:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32l3-0007BA-PZ
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757502AbZJ1HPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 03:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757481AbZJ1HPj
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:15:39 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:35431 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757383AbZJ1HPi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 03:15:38 -0400
Received: by bwz27 with SMTP id 27so597979bwz.21
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 00:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:cc:subject
         :in-reply-to:references:comments:x-mailer:date;
        bh=XyWPDNQsTVXrrR6UUl88BLlFf21YcHM4LY/ddYQwniU=;
        b=BzX/K4biZpVhd/Egw/IUqiruWmSHS/598bijb5DUc4D5AkHYvS5sMVoxZhrRB8o/YQ
         p4pi5i9BQbnJ4YBsiWIdLjOiOslQpFu7MoP3Ol9kswLlgiS9g4hvZzfY7a/VZU+8fdTn
         XrfcGBflvV0NQOmAoGTCt9WyqngH+xx5bBB0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:cc:subject:in-reply-to:references:comments
         :x-mailer:date;
        b=LLMHzKPMvDz6xjkVVsr3Cb/oJk170TzRk4Eur76rcExPJVaTmeGh6Ey1d16nDsZZWu
         b+jl73E3UMsxPCzIPJQ6cvTG//+JY6gW1D4AQgk4AvzXU2UBfn1SaGsVip6J+FkDhZ9N
         dbNImduZ4euyyLvFlLfU8ak+Jn7thSkGreTfo=
Received: by 10.204.15.16 with SMTP id i16mr6927503bka.72.1256714142357;
        Wed, 28 Oct 2009 00:15:42 -0700 (PDT)
Received: from localhost ([89.250.7.252])
        by mx.google.com with ESMTPS id 15sm191051bwz.0.2009.10.28.00.15.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 00:15:41 -0700 (PDT)
In-reply-to: <alpine.DEB.2.00.0910271515270.17168@ds9.cixit.se>
Comments: In-reply-to Peter Krefting <peter@softwolves.pp.se>
   message dated "Tue, 27 Oct 2009 15:16:59 +0100."
X-Mailer: MH-E 8.1; nmh 1.3; GNU Emacs 22.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131413>

>> If `i18n.filenameslocalencoding' option was set via git-config to a 
>> correct <codepage> encoding, 2 things should be done:
> 
> Windows supports UTF-16 file names, but need to use wchar_t APIs for fopen() 
> and friends. Have you looked at any of that?

No, I didn't look towards Windows handling of Unicode, because Git under
Windows works well enough without that: I've built Git in MinGW/MSYS
environmment (using the patches we're discussing) and it handles
cyrillic filenames in Windows ANSI CP1251 codepage just as was planned:
writes filenames to tree objects in UTF-8, checks out them into working
dir in CP1251, other stuff as git-clone, git-diff, git-status, etc also
works ok. One remaining issue (offtopic here, as far as I understand) to
make TortoiseGit work with UTF-8 Git's output.
 
> -- 
> \\// Peter - http://www.softwolves.pp.se/

-- 
Timur Sufiev
