From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation/Makefile: fix interrupted builds of
 user-manual.xml
Date: Thu, 22 Apr 2010 05:24:09 -0500
Message-ID: <20100422102254.GA701@progeny.tock>
References: <20100422011820.GA30355@progeny.tock>
 <FA4A6177-AB3E-4C5C-8042-1BFBAE09528B@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 12:24:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4tZl-0004SG-3R
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 12:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256Ab0DVKX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 06:23:59 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59456 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319Ab0DVKX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 06:23:58 -0400
Received: by pwj9 with SMTP id 9so5827261pwj.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 03:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FNJmMg0sJEm1QM27kIjE3jI2MCd+ILm6Sv+RtOpSiNg=;
        b=wglQeVcIZgXs4GVCyLcrAXamAZuiPL7ey82dBZb9emyW37/051UfXGKUKTJYVkhliQ
         XvmpnTGfqlApd7yBeNGkipez8b641gH3cGTout4/UpSHObH8Yd18SlALJIoelAW9ezwd
         IgVI+3mHf6YWryYk6psz4qlwkH4TBhPhUWipQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=js7mEIF4NEZPahJPB+7FVp0Ci9PzMrP6h7w6y34Gv8bxeeVcdW0mdolTyQslm4Xrzv
         2O9dIRGU19lRcMrIEIcAwDi7dqkwzyejcMPLX6HMfjQz8VwAnu7FkgS1Fn13w/ozQkp5
         iEd50PNVFrSN7Z8l/d8Z4PYIT6tv2jSZ5HHAg=
Received: by 10.143.21.9 with SMTP id y9mr4366776wfi.153.1271931837837;
        Thu, 22 Apr 2010 03:23:57 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm7287654iwn.0.2010.04.22.03.23.56
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 03:23:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <FA4A6177-AB3E-4C5C-8042-1BFBAE09528B@pobox.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145516>

Chris Johnsen wrote:
> On 2010 Apr 21, at 20:18, Jonathan Nieder wrote:

>> user-manual.html: user-manual.xml
>> -	$(QUIET_XSLTPROC)xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
>> +	$(QUIET_XSLTPROC)$(RM) $@+ $@ && \
>> +	xsltproc $(XSLTOPTS) -o $@+ $(XSLT) $< && \
>> +	mv $@+ $@
>>
[...]
> I suppose it is obvious enough what is going on in this in this
> second hunk, but there is no mention of this change in the commit
> message. Is this hunk due to a similar problem with xsltproc? Or
> maybe this is just "defensive coding"?

xsltproc indeed has the same problem, as I learned while testing
the first hunk.  Thanks for asking.

Sorry for the incomplete explanation before.
Jonathan
