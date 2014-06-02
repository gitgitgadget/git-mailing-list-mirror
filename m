From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v3 0/9] replace signal() with sigaction()
Date: Mon, 2 Jun 2014 13:25:18 -0700
Message-ID: <20140602202518.GA2012@hudson.localdomain>
References: <cover.1401645403.git.jmmahler@gmail.com>
 <538C5FD9.1010706@viscovery.net>
 <xmqqzjhv3zeu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 22:25:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrYnR-0003ya-Jz
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 22:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbaFBUZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 16:25:25 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:61675 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbaFBUZX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 16:25:23 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so4613290pbb.3
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 13:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=h/b+XcI+W8U9zVO2meq3kk27hSUipyOhFqGi/9aHh6I=;
        b=uMybXU00iRjzaKQ3XrE1jpEEPAYWYGmKJMheVLyPvUFLSjFF6PBG/+WIQ7KJuoqnO1
         VyQHT87bfwsQno3CJn2TEwad2W7hJzCKqOS5wITbFOCATyb+nOvfC8B61c9TLvZ1cC3q
         B2LPfeTLWCzg78ITC1e5BD5/K4dEnKBPE9bcHygbKV4yu1UbIHcbcYy6hwEQEPszimhQ
         mebLj35is9R+5X645J6Owh12VmN+wiGDB1/SPJ6k6fyhQ3r3dK2jbf5ftp3eYMOokob4
         E+Awrni1RmQp18dlSs5XW3H3fs4Gy3+Ox5O8/AcdTI4Q3hBwP26OYbHYK065gp5+OMJi
         axdw==
X-Received: by 10.67.1.39 with SMTP id bd7mr44256420pad.15.1401740722811;
        Mon, 02 Jun 2014 13:25:22 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id bv4sm21326343pad.25.2014.06.02.13.25.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 02 Jun 2014 13:25:21 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 02 Jun 2014 13:25:18 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqzjhv3zeu.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250592>

On Mon, Jun 02, 2014 at 12:05:29PM -0700, Junio C Hamano wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
> >> Jeremiah Mahler (9):
> >>   compat/mingw.c: expand MinGW support for sigaction
> >>   connect.c: replace signal() with sigaction()
> >>   progress.c: replace signal() with sigaction()
> >>   write_or_die.c: replace signal() with sigaction()
> >>   daemon.c: replace signal() with sigaction()
> >>   builtin/log.c: replace signal() with sigaction()
> >>   builtin/merge-index.c: replace signal() with sigaction()
> >>   builtin/verify-tag.c: replace signal() with sigaction()
> >>   sigchain.c: replace signal() with sigaction()
> >
> > The series without patch 9/9 works on Windows so far.
> >
> > Without patch patch 9/9 and a more complete implementation of sigaction in
> > compat/mingw.c the series misses its goal. But even if you complete it, it
> > is IMHO only code churn without practical merits.
> 
> Hmm, you sound a bit harsher than you usually do---although I
> sort of share with you the doubt on the practical merits.
> 

Alright, I'm dropping it.  Too much work for no real gain other than
some piece of mind.

Thanks Johannes and Junio for your feedback.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
