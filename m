From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 2/6] msvc: opendir: allocate enough memory
Date: Tue, 23 Nov 2010 11:42:16 -0600
Message-ID: <20101123174215.GC12113@burratino>
References: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
 <1290533444-3404-3-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	gitster@pobox.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 18:42:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKwst-0001d3-So
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 18:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955Ab0KWRmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 12:42:22 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52439 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735Ab0KWRmV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 12:42:21 -0500
Received: by qyk12 with SMTP id 12so2561878qyk.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 09:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=d709AiCUdWcGKQiXsn3oPJYJbYLqW6F6hEnPv8+Z9FU=;
        b=tq9nYL0cqsU2sp/ejJd+vpUOBZ/DqFD9FRFZ9pInszJaAEQjDTs4cwiICadYBHH1ZX
         XDgVHPz6HeEsVvDd9qcn1QEwGotFonDXPvVVU4bTrUxKMKpKHpLmmzV7cuIsaK2Zlf5s
         6UIACTlTLL2rLvI2w1NC024d3YA8104z6qjEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fbDMAGJeHKsYrM2licMHxpl6Y3xkVcYnpVT+mEiPAEcJUco7zVUFgmkdJjoHGeTWoL
         C5JhbQO01rdnhn/UxrUpnds/EPs5v6tCgfFGt9wcPTPw+q2e2pn26yvHLmjIz6id1Ob9
         GpFA+VzrjAP/RxX4CtvK/J6aHY8tMzfoLxMec=
Received: by 10.224.6.137 with SMTP id 9mr6578160qaz.135.1290534141000;
        Tue, 23 Nov 2010 09:42:21 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id x9sm3764019qco.22.2010.11.23.09.42.19
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 09:42:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290533444-3404-3-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161992>

Erik Faye-Lund wrote:

> --- a/compat/msvc.c
> +++ b/compat/msvc.c
> @@ -5,12 +5,11 @@
>  
>  DIR *opendir(const char *name)
>  {
> -	int len;
> +	int len = strlen(p->dd_name);
>  	DIR *p;

Does this work?
