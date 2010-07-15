From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/8] Introduce vcs-svn lib
Date: Thu, 15 Jul 2010 21:15:33 +0200
Message-ID: <20100715191533.GK22574@debian>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <1279210984-31604-3-git-send-email-artagnon@gmail.com>
 <20100715174629.GA32323@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 21:13:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZTsY-0004L7-5R
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 21:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934360Ab0GOTNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 15:13:49 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35577 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934276Ab0GOTNs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 15:13:48 -0400
Received: by ewy23 with SMTP id 23so360082ewy.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 12:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=YtlDE98CnGybIj46wwTx7EUNFUZL5ROoaGHvTmMCga8=;
        b=lHeCZCPbbIM+F9Tr0YOIrwUytp3C0egpf3lufFUoDQuQh5TUSHTifeDBvGtqLNO18M
         geoSyt7HIoPqKXexpIZouKtdfFSxxBmXkjjz/2g+fjirWRXy4xEc1OQqqqz/fMrgtyF5
         1lyvYufa4uV2wlLfIMdAEFtxVlt+3stv0aHXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ugpqLE9+mO+dWOoRmnC697yCERRAO8lPZzc5RG5GJRQhQEZ/uq5aCBs8ePLWvnO5QL
         LeTOSmC4Sxjs0MLQNfoKO90sQn2eEE0PAuM7ArldiRwIqnrfVFWJKHweEzEzbBnkiPem
         2rWt2f88ZWVrxRbEe7af1h9VnCeUp8Usm5/xE=
Received: by 10.213.6.193 with SMTP id a1mr165640eba.18.1279221226678;
        Thu, 15 Jul 2010 12:13:46 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id x54sm10586533eeh.11.2010.07.15.12.13.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 12:13:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100715174629.GA32323@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151112>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> > @@ -1908,6 +1912,8 @@ $(LIB_FILE): $(LIB_OBJS)
> >  $(XDIFF_LIB): $(XDIFF_OBJS)
> >  	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(XDIFF_OBJS)
> >  
> > +$(VCSSVN_LIB): $(VCSSVN_OBJS)
> > +	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(VCSSVN_OBJS)
> 
>  $ make vcs-svn/lib.a V=1
>  rm -f vcs-svn/lib.a && ar rcs vcs-svn/lib.a 
>  ar: vcs-svn/lib.a: No such file or directory
>  make: *** [vcs-svn/lib.a] Error 1
> 
> That is because the vcs-svn directory does not exist.  So
> probably the LICENSE should be added with the same patch
> (and git should learn to track empty directories).

Oops. Sorry about not checking this: it looked alright at a
glance. Yes, we can add LICENSE with this patch.

Junio: Could you squash in this diff?

--- /dev/null
+++ b/vcs-svn/LICENSE
@@ -0,0 +1,26 @@
+Copyright (C) 2010 David Barr <david.barr@cordelta.com>.
+All rights reserved.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions
+are met:
+1. Redistributions of source code must retain the above copyright
+   notice(s), this list of conditions and the following disclaimer
+   unmodified other than the allowable addition of one or more
+   copyright notices.
+2. Redistributions in binary form must reproduce the above copyright
+   notice(s), this list of conditions and the following disclaimer in
+   the documentation and/or other materials provided with the
+   distribution.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER(S) ``AS IS'' AND ANY
+EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) BE
+LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
+EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

-- Ram
