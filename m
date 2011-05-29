From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCHv2 1/2] Starting work on a man page for /etc/gitweb.conf (WIP)
Date: Sun, 29 May 2011 22:58:39 +0200
Message-ID: <201105292258.42845.jnareb@gmail.com>
References: <1306698626-32402-1-git-send-email-jnareb@gmail.com> <1306698626-32402-2-git-send-email-jnareb@gmail.com> <7vwrh9nsyr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 29 23:20:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQnP3-00085g-M7
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 23:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755551Ab1E2VTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 17:19:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36691 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747Ab1E2VTu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 17:19:50 -0400
Received: by fxm17 with SMTP id 17so2148803fxm.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 14:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=DPQqTRVtMRtM15fwL2hfZCGTxn5ZAxj/Z9qxnDRK544=;
        b=tpm0KMni6qYTRMAWSTg+Dt3X4lhlqTLV+Nw5lU4YradbOgYahc4PzoaA1h9Wkjgw/r
         h62/t/+zOveLmnho1vytoYpd83D7yeuefMDaSxVKjlYyvvvsP9JIv0D4kEEoVVCFDd6v
         o5yZh4n+lx4eJCHtE8qgEKT6ZzUrf+5SfNsf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Cni5k6ydNVEKJ8ezSHQHAdvHN+JYPw4XdUnzifxuoPqbqKYspuX19UlkAC4VQ2PthE
         MI1sQSnEO1Xm1Rvs+jzsyrgmbVjSAmdCL5TI5kfyJMS3jYzMlp/s9adzECKY6MY16MKN
         RzgOQTBGhkhqNbYez3eAwlyp76JKH7lRcy1Rg=
Received: by 10.223.79.151 with SMTP id p23mr4730621fak.78.1306702730475;
        Sun, 29 May 2011 13:58:50 -0700 (PDT)
Received: from [192.168.1.13] (abvt40.neoplus.adsl.tpnet.pl [83.8.217.40])
        by mx.google.com with ESMTPS id l26sm517320fah.14.2011.05.29.13.58.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 May 2011 13:58:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vwrh9nsyr.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174709>

On Sun, 29 May 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > diff --git a/gitweb/Makefile b/gitweb/Makefile
> > index 0a6ac00..582e1b0 100644
> > --- a/gitweb/Makefile
> > +++ b/gitweb/Makefile
> > @@ -112,6 +112,14 @@ endif
> >  
> >  GITWEB_FILES += static/git-logo.png static/git-favicon.png
> >  
> > +GITWEB_MAN5_TXT = gitweb.conf.txt
> > +GITWEB_MAN_TXT = $(GITWEB_MAN1_TXT) $(GITWEB_MAN5_TXT) $(GITWEB_MAN7_TXT)
> > +GITWEB_MAN = $(patsubst %.txt,%.1,$(GITWEB_MAN1_TXT)) \
> > +             $(patsubst %.txt,%.5,$(GITWEB_MAN5_TXT)) \
> > +             $(patsubst %.txt,%.7,$(GITWEB_MAN7_TXT))
> > +GITWEB_HTML= $(patsubst %.txt,%.html,$(GITWEB_MAN_TXT))
> > +GITWEB_DOC = $(GITWEB_MAN) $(GITWEB_HTML)
> > +
> >  GITWEB_REPLACE = \
> >  	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
> >  	-e 's|++GIT_BINDIR++|$(bindir)|g' \
> > @@ -155,6 +163,11 @@ test-installed:
> >  	GITWEB_TEST_INSTALLED='$(DESTDIR_SQ)$(gitwebdir_SQ)' \
> >  		$(MAKE) -C ../t gitweb-test
> >  
> > +### Documentation
> > +
> > +doc:
> > +	$(MAKE) -C ../Documentation $(GITWEB_DOC)
> > +
> >  ### Installation rules
> >  
> >  install: all
> 
> I am not sure if this target is needed or even desirable.

Well, this is the target that it is nice to have.  The implementation
needs to be improved, as you noticed.

> The only potential benefit this complexity and risk of these build
> procedure knowledge diverge what is in ../Documentation is to let you say
> "cd gitweb && make doc" and avoid building the rest of the documentation,
> but I personally do not find it necessary at all.
> 
> Aren't you making a mistake similar to the one that let instaweb have
> intimate and unnecessary knowledge of how to build gitweb, which you
> recently cleaned up?

Thanks for sanity check!

Instead of duplicating Documentation/Makefile knowledge in gitweb/Makefile,
let's just proxy to Documentation/Makefile like for 'test' target:

  +doc:
  +	$(MAKE) -C ../Documentation gitweb
  +

In Documentation/Makefile the new 'gitweb' target could look just like
this:

  +GITWEB_DOC = $(filter gitweb.%,$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7)) 
  +gitweb: $(GITWEB_DOC)

And it would be much shorter, too.

-- 
Jakub Narebski
Poland
