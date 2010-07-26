From: Julian Foad <julian.foad@wandisco.com>
Subject: Re: [PATCH 06/13] Dump the revprops at the start of every revision
Date: Mon, 26 Jul 2010 15:03:27 +0100
Message-ID: <1280153007.2404.65.camel@edith>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
	 <1278461693-3828-7-git-send-email-artagnon@gmail.com>
	 <20100707190434.GA2732@burratino>  <20100721185513.GB23839@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarb@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 16:03:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdOHL-0004fH-C4
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 16:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021Ab0GZODd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 10:03:33 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51354 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab0GZODc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 10:03:32 -0400
Received: by wwj40 with SMTP id 40so182317wwj.1
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 07:03:31 -0700 (PDT)
Received: by 10.227.157.138 with SMTP id b10mr6069719wbx.13.1280153010913;
        Mon, 26 Jul 2010 07:03:30 -0700 (PDT)
Received: from [192.168.1.3] (120.20.169.217.in-addr.arpa [217.169.20.120])
        by mx.google.com with ESMTPS id b18sm3160412wbb.1.2010.07.26.07.03.28
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 07:03:29 -0700 (PDT)
In-Reply-To: <20100721185513.GB23839@kytes>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151839>

On Thu, 2010-07-22, Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:
[...]
> > > +			/* Output name length, then name. */
> > > +			svn_stringbuf_appendcstr(*strbuf,
> > > +						 apr_psprintf(pool, "K %" APR_SSIZE_T_FMT "\n",
> > > +							      keylen));
> > > +
> > > +			svn_stringbuf_appendbytes(*strbuf, (const char *) key, keylen);
> > 
> > Is the cast needed?  (The answer might be "yes" if this code is meant
> > to be usable with C++ compilers.)
> 
> These casts are all over in the source tree, so I'm guessing the
> answer is "yes".

Actually no - Subversion C code is not intended to be compilable as C++
and that cast is not needed.  (Other casts that you see in Subversion
code are for different situations.)

- Julian
