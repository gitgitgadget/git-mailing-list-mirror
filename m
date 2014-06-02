From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v3 0/9] replace signal() with sigaction()
Date: Mon, 2 Jun 2014 07:39:05 -0700
Message-ID: <20140602143905.GA2048@hudson.localdomain>
References: <cover.1401645403.git.jmmahler@gmail.com>
 <538C5FD9.1010706@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 02 16:39:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrTON-000791-7M
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 16:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910AbaFBOjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 10:39:11 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:50849 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbaFBOjK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 10:39:10 -0400
Received: by mail-pa0-f47.google.com with SMTP id ld10so4264178pab.6
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=9j6Tq2rkMAADzzuC78rqraCae9vEBtg0//wq7knM8NQ=;
        b=WoXzx2IeS9BKme84MWZAwXDv5yCee5htvhSrDJE3fGAgMCsOIY2oCaGYdbDpjKnyCu
         3bIlP2ERzUhJxr7m0lAchjEBOanwn9Afq9XCgerhIa+HeRPEXKjt8Yt0yB7RaNU5BfZE
         ECz+1qUz2//g3MF0iYyQEmHPg8OsnZHqC272b47e1+BOoBKyIPCVxlfJ00E/jzZ8cP/1
         QiMFXQRj/vQi3hFyWcLV9Hy1ZgSoodexTkzzCy36/gM7TIp6WnTmSlFdrsTptPl3JNQR
         ko+IlgHCVEQjnj11Nl431DnoNIOOoiO1rPtAVWFncX1x29x2vNwqYIg5LwLjAryxjymq
         517A==
X-Received: by 10.68.132.68 with SMTP id os4mr40772620pbb.129.1401719949765;
        Mon, 02 Jun 2014 07:39:09 -0700 (PDT)
Received: from hudson (o247-linksys-rtr.CSUChico.EDU. [132.241.18.53])
        by mx.google.com with ESMTPSA id pq3sm20843838pbb.57.2014.06.02.07.39.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 02 Jun 2014 07:39:08 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 02 Jun 2014 07:39:05 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <538C5FD9.1010706@viscovery.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250565>

Hannes,

On Mon, Jun 02, 2014 at 01:28:25PM +0200, Johannes Sixt wrote:
> Am 6/1/2014 20:10, schrieb Jeremiah Mahler:
> > This is version 3 of the patch set to convert signal(2) to sigaction(2)
> > (previous discussion [1]).
> > 
...
> >   sigchain.c: replace signal() with sigaction()
> 
> The series without patch 9/9 works on Windows so far.
> 
> Without patch patch 9/9 and a more complete implementation of sigaction in
> compat/mingw.c the series misses its goal. But even if you complete it, it
> is IMHO only code churn without practical merits.
> 
> -- Hannes
> 

You are right, I missed the case where the old signal was used, as is
done in sigchain.c.  Sorry about that.

Thanks again for looking at my patch.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
