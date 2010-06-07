From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Explanation for dropping write-back in mmap
Date: Mon, 7 Jun 2010 17:16:18 +0200
Message-ID: <AANLkTilrinkNo9awJ9Wso4tXzQKghWEd2bfDRhPHPOga@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 17:17:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLe4U-0007DB-Px
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 17:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049Ab0FGPQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 11:16:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46487 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab0FGPQl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 11:16:41 -0400
Received: by fxm8 with SMTP id 8so2172188fxm.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 08:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:cc:content-type;
        bh=xM0Y++7oY2FPXzqw/MC+zVM4SJmIF4q5X9sn9oLn16k=;
        b=viB76gEE3oEArvLm7QYZUwAD2UmPBYTIqtTX9Hs6+rjL3OO+y+Ps9N1TNEJrj7c1x/
         /br5xbkpWGsTJ4cl7upYMzqp7NDxqrBrqDxeSmsP+kYuFfxEf9fHIVW0yK2Y7yf+trr0
         PxYq2pQjUWD5cTmWxGSw+8WqIfMpygCg809uw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=txYSvgRoGpVcisSNkxI065u5CUyZMaF9hrb6D3Jc6/B40qBOXPK2Hg2KqVhIluSZGk
         5Yw+Km9Ouf3aw7BIHAHHQchyEyOF+v5Z5AsaYr5R9R6potUh6xgbujG59RAG+bH1EIb9
         R5V8xW13V2yu9aJQlZU56AN1/k2rcJFnzIgQ0=
Received: by 10.204.8.5 with SMTP id f5mr6805097bkf.209.1275923798958; Mon, 07 
	Jun 2010 08:16:38 -0700 (PDT)
Received: by 10.204.76.11 with HTTP; Mon, 7 Jun 2010 08:16:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148603>

Hi Junio,

In the commit f48000fcbe100, you've forced the caller to use
MAP_PRIVATE in the alternative mmap implementation dropping write-back
support. Could you kindly explain the rationale for this? David's SVN
exporter uses mmap with MAP_SHARED, and we figured that the merge
immediately breaks this functionality.

Noticed-by: Jonathan Nieder <jrnieder@gmail.com>

-----------------------------------------------------------------------------------------------------------
commit f48000fcbe1009c18f1cc46e56cde2cb632071fa
Author: Junio C Hamano <junkio@cox.net>
Date:   Sat Oct 8 15:54:36 2005 -0700

    Yank writing-back support from gitfakemmap.

    We do not write through our use of mmap(), so make sure callers pass
    MAP_PRIVATE and remove support for writing changes back.

    Signed-off-by: Junio C Hamano <junkio@cox.net>
-----------------------------------------------------------------------------------------------------------

Thanks.

-- Ram
