From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PULL maint] two fast-import "ls" fixes
Date: Fri, 9 Mar 2012 22:30:27 -0600
Message-ID: <20120310043027.GA1992@burratino>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
 <1331184656-98629-1-git-send-email-davidbarr@google.com>
 <20120308070951.GA2181@burratino>
 <7vty1zdp2b.fsf@alter.siamese.dyndns.org>
 <20120310031228.GA3008@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 05:30:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6Dx1-0005dD-Lp
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 05:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757019Ab2CJEaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 23:30:35 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65160 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756229Ab2CJEae (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 23:30:34 -0500
Received: by yhmm54 with SMTP id m54so1402438yhm.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 20:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4621aieQMEKEheAE+62cH+HbpVRESKXCruZ5arWWbi8=;
        b=0JADe+7o9xSE5Ja01CK8gzlRbWLlmMREhHkr0syM4lAernlPLqSJfoK+Z8zyyKrU8i
         wQGIJTgM0tBc7//5w3V+45HB8ZZclRraEWRfC/5ww5kkVsONfLApDgOIvzXIb09n2njT
         l6Q6KR6Qdpw7df1yDcUhHNqDvTpOzeqfX2n5SdoIfJ6KLOQYXZB0Cp23+M3V8AYE+fD3
         hPDtjM4YAhm9ZK7GPabDhcDkAiN2sd7x73ovBrAeHsw3GVSmk9QeGWCzQyWzK4MZb8/D
         q6TLdI4QbPvyw1FFTxmABunLsgp2vPCpp9QOOjlNljuaYFdkK8zGkJ2UlKP4NeTbXcPP
         FAGQ==
Received: by 10.60.22.70 with SMTP id b6mr1682971oef.5.1331353833712;
        Fri, 09 Mar 2012 20:30:33 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id c7sm4086118oeh.1.2012.03.09.20.30.32
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Mar 2012 20:30:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120310031228.GA3008@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192766>

Jonathan Nieder wrote:

> After sleeping on it, here are two patches for 'maint'.

For your convenience, these changes can also be found at:

  git://repo.or.cz/git/jrn.git tags/fast-import-ls-fixes

      fast-import: leakfix for 'ls' of dirty trees
      fast-import: don't allow 'ls' of path with empty components

 fast-import.c          |    4 ++++
 t/t9300-fast-import.sh |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
