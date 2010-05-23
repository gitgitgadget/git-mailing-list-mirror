From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH v2] autocrlf: Make it work also for un-normalized
 repositories
Date: Sun, 23 May 2010 11:30:40 +0200
Message-ID: <20100523093040.GA15602@localhost>
References: <20100511223757.GB16974@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Sun May 23 11:31:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG7Wc-0001Tb-15
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 11:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783Ab0EWJay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 05:30:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58074 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754699Ab0EWJav (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 05:30:51 -0400
Received: by fxm5 with SMTP id 5so1784507fxm.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 02:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=NhgsGKiv2F+T/bk0Ds4or9Pn4vYkikPrAMOAP2fwEjo=;
        b=EHWY3cCkZ9KEOzNxdVZsQl3xndYHbMtJBhYuTGa4MtlkHYAJL6e5ILu60Kb2wCiyqI
         wci3UF7dsbF1CdHT6e/Pk9woZMiNOlD8l5VqNejykGp0mfqB8cpxysveAT2HnclmC6P1
         anAghE1ApiA6v0WuGUeywJa6kiSLCQ6+cMlOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=KwBo0Tb68DEQnEX9BYe8T4tdNm2bS9UPwOGysW+io3hmyWBi2CB5tG2gN5tL1MchUA
         fUjZwyEIMNnLLfvNkk/fVGRPUL7C5AA93/MjmVym8EgyVIPLb9uxP01D7HWOlolosW4A
         1a9CFofaB6RZJOw5YjzQBem5DhjSqgALw1DPs=
Received: by 10.223.127.196 with SMTP id h4mr3444533fas.56.1274607047381;
        Sun, 23 May 2010 02:30:47 -0700 (PDT)
Received: from darc.lan (p549A5187.dip.t-dialin.net [84.154.81.135])
        by mx.google.com with ESMTPS id z12sm13734597fah.9.2010.05.23.02.30.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 02:30:46 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OG7W5-000478-02; Sun, 23 May 2010 11:30:41 +0200
Content-Disposition: inline
In-Reply-To: <20100511223757.GB16974@pvv.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147565>

On Wed, May 12, 2010 at 12:37:57AM +0200, Finn Arne Gangstad wrote:

> Change autocrlf to not do any conversions to files that in the
> repository already contain a CR. git with autocrlf set will never
> create such a file, or change a LF only file to contain CRs, so the
> (new) assumption is that if a file contains a CR, it is intentional,
> and autocrlf should not change that.

I think this is a good change. But it only covers the part where we
translate CR -> LF when staging changes. With Eyvind's patches, if
I understand correctly, it will be possible to convert files to
have LF line endings. Such files will be translated from LF -> CR
when adding changes.

So if the file already has LF line endings, will this cause the
same problem the other way around?

Clemens
