From: Lance Linder <llinder@gmail.com>
Subject: Re: git-p4 move/delete errors
Date: Fri, 9 Jul 2010 12:06:13 -0500
Message-ID: <4843A2FF-CA22-4C85-8731-5AB72B2DD601@gmail.com>
References: <AANLkTinN0Av1CO7mZU-QKeApq43UmEykUV093eyTtKQN@mail.gmail.com> <AANLkTikPHJuf5JUe096BWTWO_oF9u3gNlVNuw7Ik32WQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Thomas Berg <merlin66b@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 19:06:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXH1r-0007s3-6i
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 19:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757721Ab0GIRGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 13:06:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56092 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243Ab0GIRGR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 13:06:17 -0400
Received: by iwn7 with SMTP id 7so2394120iwn.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 10:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=vBsciDMZP1ADl9RMuBV653zUJnjoVAGUOt/zwejX4i0=;
        b=hYHX26n/FmnuUfx1CzFbfr5RCw6phSRv1FoVD1EHMQfvxoHMPWEOUN0eE2VJ8Oom8O
         io2QQ5yNTiNDR+2n33Rn9e3F74c8eFDCtM0Tm6z7N76cpWEucwH5BEmRec1OZVXE2AmK
         nSV/JaEuBhLUKZ7Fa5rZb247n0PjWzKCTOHTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=LB9WFCH+7WnTMEiPMmCDLI6Df7VJWKxSaYT5iup5cneAkO8hCinAQwIFa7H2ZjTaxJ
         180ANQnKNO4uUgyrYMnfk4BzjG68ZixYPir39MDy+68ZajaTIAjX6rjRBaBH9Ztxbv+C
         /yXlFY8FjVu0c6iWfvD7agX5Yen0FxjPf6Wfo=
Received: by 10.231.169.145 with SMTP id z17mr10768377iby.13.1278695176204;
        Fri, 09 Jul 2010 10:06:16 -0700 (PDT)
Received: from hanuman.int.medicomdigital.com (gateway.medicomdigital.com [75.146.145.33])
        by mx.google.com with ESMTPS id g31sm4985134ibh.10.2010.07.09.10.06.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 10:06:15 -0700 (PDT)
In-Reply-To: <AANLkTikPHJuf5JUe096BWTWO_oF9u3gNlVNuw7Ik32WQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150680>

I spent some time trying to debug this problem but couldn't resolve it myself. It is a huge pain and if I happen to find a fix I will definitely post an update but right now I have given up.

Hopefully someone smarter than myself finds a way to fix this because it is a nightmare to delete/rename files with git and submit back to perforce.

Lance


On Jul 9, 2010, at 10:05 AM, Thomas Berg wrote:

> Hi,
> 
> On Fri, May 28, 2010 at 2:30 AM, Lance Linder <llinder@gmail.com> wrote:
>> Until recently I have been successfully using git-p4 with much joy and
>> happiness. Then suddenly git-p4 submit started throwing "Command
>> failed: p4 diff -du ..." when ever I delete or move a file.
>> 
>> We recently upgraded our perforce server ( Rev.
>> P4D/NTX86/2009.2/238357 (2010/03/15) ). It was about this time that
>> the problem came up. First thing I did of course was upgrade to the
>> latest version of git ( now on 1.7.1 ) but the problem still persists.
>> Next I updated my p4 client ( Rev. P4/MACOSX104U/2009.2/238357
>> (2010/03/15) ) but still same problem. All other submits work fine as
>> long as there are not any deletions or moves.
> [...]
>> 
>> Anyone else seeing these issues?
> 
> 
> Indeed, we just upgraded our Perforce server too, and now I'm getting
> this exact error. Did you find a solution to the problem?
> 
> If not I'm very interested in solving it. Seems like the p4 diff
> command has changed behaviour and broken the git-p4 script.
> 
> Cheers,
> Thomas
