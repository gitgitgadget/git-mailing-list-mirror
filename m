From: Vitaliy Ivanov <vitalivanov@gmail.com>
Subject: Re: [PATCH] tests: cleanup binary images usage
Date: Wed, 20 Jul 2011 00:38:42 +0300
Message-ID: <1311111522.1659.1.camel@vitaliy-Vostro-1400>
References: <1311096107.8532.39.camel@vivanov>
	 <7v39i29jpe.fsf@alter.siamese.dyndns.org>
Reply-To: vitalivanov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Vitaliy Ivanov <vitalivanov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 23:38:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjI0B-0008IC-SF
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 23:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382Ab1GSViq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 17:38:46 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:38157 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab1GSViq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 17:38:46 -0400
Received: by fxd18 with SMTP id 18so544945fxd.11
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 14:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=c1XbpEA/LUM3kxI0Z16TRcAEItU9OdegVSyOkWa5Y1M=;
        b=J9AspnvbOYb5DWZZQZXOUmb8rxm3O0EA455KMgzm1R3byc/skv7+peiCRhB+cfjJCO
         xv5qAJYxTOQ0JBaiviFihDBCyIV3JusP3J1bSYmVjuy3YtNvJPcH7s70lHj+MR0MrgJd
         wtpUG6UXlKg6TgJ2OxgJqpYq2gtA3ZO9G9Xng=
Received: by 10.223.95.153 with SMTP id d25mr10703661fan.4.1311111524896;
        Tue, 19 Jul 2011 14:38:44 -0700 (PDT)
Received: from [192.168.0.101] ([194.44.123.233])
        by mx.google.com with ESMTPS id h20sm229609fai.44.2011.07.19.14.38.43
        (version=SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 14:38:44 -0700 (PDT)
In-Reply-To: <7v39i29jpe.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177508>

On Tue, 2011-07-19 at 12:03 -0700, Junio C Hamano wrote:
> Vitaliy Ivanov <vitalivanov@gmail.com> writes:
> 
> > ---
> >>From bff3916939fcd226278a2e983ddc77bb711296e7 Mon Sep 17 00:00:00 2001
> > From: Vitaliy Ivanov <vitalivanov@gmail.com>
> > Date: Tue, 19 Jul 2011 20:07:08 +0300
> > Subject: [PATCH] tests: cleanup binary images usage
> 
> Thanks.
> 
> Drop the above five lines and replace them with a single "-- >8 --" line.
> The lone "---" line is especially harmful as it tells our tools to stop
> reading anything below when finding your commit log message.
> 
> > Images are being shared between tests and this is OK.
> > By this patch I name images independently of tests plus
> > remove unneeded images.
> 
> The point of these test vector files are that they are binary and it is
> secondary that they happen to be images.
> 
> Perhaps like this.
> 
>   Hi, list,
> 
>   Extra and redundant explanation that you could have just let your
>   proposed commit log message speak for itself comes here, if you really
>   need one.
> 
>   -- >8 --
>   tests: cleanup binary test vector files
> 
>   The test4012.png test vector file that was originally used for t4012 to
>   check operations on binary files was later reused in other tests, making
>   it no longer consistent to name it after a specific test. Rename it to more
>   generic "test-binary-1.png".
> 
>   While at it, rename test9200b to "test-binary-2.png" (even though it is
>   only used by t9200).
> 
>   Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
>   ---
>   <<diffstat and patch here>>
> 
> > Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
> > ---
> >  t/t3307-notes-man.sh           |    6 +++---
> >  t/t4012-diff-binary.sh         |    2 +-
> >  t/t6023-merge-file.sh          |    2 +-
> >  t/t6027-merge-binary.sh        |    2 +-
> >  t/t9200-git-cvsexportcommit.sh |   14 +++++++-------
> >  t/test-image1.png              |  Bin 0 -> 5660 bytes
> >  t/test-image2.png              |  Bin 0 -> 275 bytes
> >  t/test4012.png                 |  Bin 5660 -> 0 bytes
> >  t/test9200a.png                |  Bin 5660 -> 0 bytes
> >  t/test9200b.png                |  Bin 275 -> 0 bytes
> >  10 files changed, 13 insertions(+), 13 deletions(-)
> >  create mode 100644 t/test-image1.png
> >  create mode 100644 t/test-image2.png
> >  delete mode 100644 t/test4012.png
> >  delete mode 100644 t/test9200a.png
> >  delete mode 100644 t/test9200b.png
> 
> Also have you considered using "format-patch -M" to send this patch?

Thanks Junio for your comments. Sending updated version for this patch.

- Vitaliy
