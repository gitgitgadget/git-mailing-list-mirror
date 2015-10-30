From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with
 gdb
Date: Fri, 30 Oct 2015 11:55:29 -0700
Message-ID: <20151030185529.GH7881@google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
 <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
 <20151026191724.GE7881@google.com>
 <alpine.DEB.1.00.1510271036100.31610@s15462909.onlinehome-server.info>
 <alpine.DEB.1.00.1510301929020.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:55:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEpy-0008Mg-Vk
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760465AbbJ3Szg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 14:55:36 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34825 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759905AbbJ3Szc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 14:55:32 -0400
Received: by pasz6 with SMTP id z6so81870259pas.2
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 11:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qvnAuOOzqCgupVLy7EYYORJ49Q4IBWQ1/ixNhejKJBE=;
        b=IJ0kZUmLLkrgN29PQc9eWMZP7lJMFBS5TbPzg8365QkKxuTScPyLa6oAVHPFLWOA8M
         K58PKvVP16edYa5DsU3kw9uTlOERDSVZfBcNcEhbu2gvkdc9TddUHvAU2rXENNdIwbPl
         12QH55w5R9oB3lCn2snayzICGLp9EDP71PMm7vFI5Fyyysj1HTk3DgXH3iKA3erMq0qS
         WsRnHmygNP5v/Kbg4zHhgQRDAz54eSkAOET9iYeWg4aGxrw0T/BY5oQFgVy3yh79kFx6
         zfW/6ZbnGj7YOJDnVPFKPNuO+nqhP7f1RYlIN7DQLExTAB/6Yp5acVFZaseck4ZhO6JU
         Ndvw==
X-Received: by 10.66.170.238 with SMTP id ap14mr10224483pac.128.1446231332343;
        Fri, 30 Oct 2015 11:55:32 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c1d3:800a:733a:d60a])
        by smtp.gmail.com with ESMTPSA id ja4sm9573067pbb.19.2015.10.30.11.55.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Oct 2015 11:55:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1510301929020.31610@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280520>

Johannes Schindelin wrote:
> On Tue, 27 Oct 2015, Johannes Schindelin wrote:
>> On Mon, 26 Oct 2015, Jonathan Nieder wrote:

>>> Does the 'exec' after the fi need this as well?  exec is supposed to
>>> itself print a message and exit when it runs into an error.
[...]
> Actually, after reading the patch again, I think it is better to be less
> intrusive and add the error message *just* for the gdb case, as it is
> right now:

Why?  Unlike the C library function of the same name, the shell
builtin 'exec' prints an error message and exits on error.

Sorry for the lack of clarity,
Jonathan
