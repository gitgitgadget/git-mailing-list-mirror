From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFCv4 1/4] Documentation: Preparation for gitweb manpages
Date: Tue, 20 Sep 2011 02:10:12 +0200
Message-ID: <201109200210.13772.jnareb@gmail.com>
References: <1316352884-26193-1-git-send-email-jnareb@gmail.com> <1316352884-26193-2-git-send-email-jnareb@gmail.com> <20110919233703.GF6343@elie>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	admin@repo.or.cz
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 02:10:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5nuy-0002jp-Nw
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 02:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756906Ab1ITAKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 20:10:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65028 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab1ITAKT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 20:10:19 -0400
Received: by fxe4 with SMTP id 4so5799fxe.19
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 17:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=aqIqlgXSVLdKbF9sAeBibnuF5jDeJydiV+0GYhbpwsM=;
        b=rEGyLFKZ7CWtlR358oe0Suil1wtHfLRfFeDzwTWvLer8vBW4cEEWq8n6rmkMsCuCxo
         uIEkDhZYlNfyHJjUeF6VZIRDrL/LmiVhnFN/uctORTGwbqjT+Wi5oUkaB7eHf2tb4381
         pN9IncV/i7IDzhMrvkuQUl1FaQ8hD/YDetcvg=
Received: by 10.223.76.10 with SMTP id a10mr249673fak.30.1316477418214;
        Mon, 19 Sep 2011 17:10:18 -0700 (PDT)
Received: from [192.168.1.13] (abvo48.neoplus.adsl.tpnet.pl. [83.8.212.48])
        by mx.google.com with ESMTPS id n12sm19783475fan.9.2011.09.19.17.10.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Sep 2011 17:10:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110919233703.GF6343@elie>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181721>

Thanks a lot for all language fixes.

Nb. I'll respond to other comments separately.

On Tue, 20 Sep 2011, Jonathan Nieder wrote:
> Jakub Narebski wrote:

> > This way to build gitweb documentation one can use
> >
> >   make -C gitweb doc
> >
> > or
> >
> >   cd gitweb; make doc

Actually it should read "to build only gitweb documentation"...

> Does "make -CDocumentation man html" build the gitweb documentation,
> too (and "make install-doc" install it)?
> 
> [...]
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -170,6 +170,9 @@ info: git.info gitman.info
> >  
> >  pdf: user-manual.pdf
> >  
> > +GITWEB_DOC = $(filter gitweb.%,$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7))
> > +gitweb-doc: $(GITWEB_DOC)
> 
> Looks like no, alas.

... because of the fact that gitweb.txt is in DOC_MAN1, and gitweb.conf.txt
is in DOC_MAN5, then 'make doc' would among others build gitweb
documentation.  'make -C Documentation gitweb-doc' / 'make -C gitweb doc'
just builds a _subset_ of said documentation.

> 
> Except for that detail, this looks good.


Nb. what is also missing is having links to gitweb(1) and gitweb.conf(5)
in git(1) manpages together with the rest.

-- 
Jakub Narebski
Poland
