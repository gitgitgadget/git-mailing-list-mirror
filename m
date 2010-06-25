From: Jonathan Nieder <jrnieder@gmail.com>
Subject: OT: typesafe callbacks in C (Re: [WIP PATCH 1/7] Add skeleton RA
 svnclient)
Date: Fri, 25 Jun 2010 10:30:32 -0500
Message-ID: <20100625153031.GA9702@burratino>
References: <1277310140-16891-1-git-send-email-artagnon@gmail.com>
 <1277310140-16891-2-git-send-email-artagnon@gmail.com>
 <20100625001427.GA4683@burratino>
 <alpine.561.2.00.1006251156180.2064@daniel2.local>
 <AANLkTimirObq-HBrB4rQdAprN8mfd92rfFKSegJKwMsc@mail.gmail.com>
 <alpine.561.2.00.1006251412170.2144@daniel2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Shahaf <d.s@daniel.shahaf.name>
X-From: git-owner@vger.kernel.org Fri Jun 25 17:30:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSArk-00049z-7v
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 17:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062Ab0FYPaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 11:30:46 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50090 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab0FYPap (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 11:30:45 -0400
Received: by pwj8 with SMTP id 8so2397345pwj.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 08:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=acJ6YDahFTOin1E2nS4pOYtEQ0eDauW25/qG0plHzZg=;
        b=IBZwt2zUj6qwuTUXwe19wccoMDPrHfWSRXD4icYWL5UzIa1ttD2i35gfl3u89eVcio
         PT+PZ9h9Qxl2/q+r/nLEB4Xqvytiz5AXKkg60JKQ3eVfVYcPg/4k0DZzCWxNdEfjieAn
         yCn7lvelNNhGj1QQDXL6iZIuDx2NfBd06WTVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HeppcQvjeg14uiIlz63XCSaUNBI30UAH74igdTlE9/hdAxbj+PKz/u9T+U8CMzUgOG
         vYSUb0sDQuIa69Me3L9YCLOaLhEF3RrmeY6N3emLIZ6CPA2bTQZaWBNmeuxSUnmN5pzI
         vsq5mi9ErjwhVdMrM6+Oh4PKANMu1RNqYqsdQ=
Received: by 10.115.134.32 with SMTP id l32mr1053943wan.44.1277479844219;
        Fri, 25 Jun 2010 08:30:44 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id eb42sm1194870ibb.17.2010.06.25.08.30.42
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 08:30:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.561.2.00.1006251412170.2144@daniel2.local>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149693>

Daniel Shahaf wrote:

> By the way, a common pitfall is to mis-treat the void *baton argument as
> the wrong type of baton.  That is, code of the form
> 
>     f(void *baton) {
>         foo_baton_t *fb = baton;
>     }
> 
> instead of
> 
>     f(void *baton) {
>         bar_baton_t *bb = baton;
>     }

Just for kicks, I should mention

  http://ccan.ozlabs.org/info/typesafe_cb.html

which makes code like this cause warnings with gcc.

Maybe some version of Subversion years from now could use it.
