From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 02/15] mingw: implement syslog
Date: Mon, 11 Oct 2010 17:37:46 -0500
Message-ID: <20101011223746.GA6637@burratino>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-3-git-send-email-kusmabite@gmail.com>
 <20101011221146.GB6277@burratino>
 <AANLkTinkpTavtw3Rmubfht56tzGnHckHXRc0L-C83daE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com,
	Mike Pape <dotzenlabs@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 00:41:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5R3S-0008KM-46
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 00:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756791Ab0JKWlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 18:41:08 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54085 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756672Ab0JKWlH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 18:41:07 -0400
Received: by gwj17 with SMTP id 17so1203564gwj.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 15:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jlK7/FPuxs+A8lk3AKI/D4HA0bIsfWiwPrU8QdUndJQ=;
        b=oRdvdBAJLOYssIA/rqkPxOox2lre0QYG+uXXyCKMdODfEclm8Mw8e8tPLj6ZC4AMEL
         mZVxUOBN4MPuagKgg24CUYfy3lWIA2dHRlxjWpxhxVIcHhDCPBNcbkhc6arRoO+NeB1r
         6/LOP3os1i0r3rIzlS6CbM4uBkBRMdpn1a2bU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TE2gSzGSWNzm1OwXKn4K+auK2XSH+NFNtaPIs452RiCDUwxwlEOnBjRtvD8RNVkb1w
         IjROuug1HmaooN0Cez+9Wsfq2N4e0ifAzauSzmE/8PDxUBr4NL3gx99kqoYd7JGwvM5q
         vt/rE18SWT1Tl8kVToWHqoOxZW1QSjjd3h7wQ=
Received: by 10.101.132.35 with SMTP id j35mr3104349ann.211.1286836865473;
        Mon, 11 Oct 2010 15:41:05 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id z10sm59795anj.34.2010.10.11.15.41.03
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 15:41:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinkpTavtw3Rmubfht56tzGnHckHXRc0L-C83daE@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158811>

Erik Faye-Lund wrote:

> The string gets inlined into itself (with a limit of 100 expansions)
> leading to string like "foo %1 bar" becoming "foo foo foo ... foo %1
> bar bar bar ... bar". With our expansion, it becomes "foo % 1 bar"
> instead.

Ah, ok.  Sounds like there is no need to worry about requests for "%%1"
etc.  Thanks for explaining.

Maybe the symptoms and cases not covered (%2, %%1) would be worth
mentioning in the log message?
