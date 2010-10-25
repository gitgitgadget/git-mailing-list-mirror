From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Documentation: refactor config variable descriptions
Date: Mon, 25 Oct 2010 17:49:02 +0200
Message-ID: <201010251749.04784.jnareb@gmail.com>
References: <cover.1287690696.git.trast@student.ethz.ch> <201010251444.08780.jnareb@gmail.com> <20101025151125.GD28278@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 25 17:49:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAPIi-0005tx-97
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 17:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442Ab0JYPt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 11:49:26 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53057 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab0JYPtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 11:49:25 -0400
Received: by vws13 with SMTP id 13so140987vws.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=NZ4Y6i81xixWGJL/EULfftmI8sTsaSGbVDrrAbyjm1s=;
        b=ap4uB4kJKGsm3jHKrpMXZ8u98cunYtRDhOiDdkai4glVeGgStifYHWnxVCVuqBmF+3
         o30BmNeokr3x4Ux7v5j8ZHaPOUtdmEfYsMhtdEJWZ3+TNQZ6lNhWGGMFKl/eqdASyPN1
         C3phOknrRCTA5iLhzmppkCv3Z1jSdEsgXbHzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wW1wA3yjzqFBhANJwfjdJ4AJtPc58gKaX9UVlkf+XT6OkeAzCaNkvjkyFX6pXhUqvE
         DQvXiizpyYsfq/Fcol431+lyXelebcqwyjfQZvDAWkzI5ys9Z+XB4WgfYZgwB6KLcfUW
         o8oo7aQfmz0RDyXuPf1gFTEx1ukVUnY7uf/tQ=
Received: by 10.103.219.1 with SMTP id w1mr8564700muq.113.1288021763947;
        Mon, 25 Oct 2010 08:49:23 -0700 (PDT)
Received: from [192.168.1.13] (abwi90.neoplus.adsl.tpnet.pl [83.8.232.90])
        by mx.google.com with ESMTPS id y19sm2956851fau.41.2010.10.25.08.49.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Oct 2010 08:49:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20101025151125.GD28278@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159961>

On Mon, 25 Oct 2010, Jeff King wrote:
> On Mon, Oct 25, 2010 at 02:44:06PM +0200, Jakub Narebski wrote:
> 
> > 2. With checking for CONFIGURATION-like, we would miss the following
> >    configuration variables:
> > 
> >      http.getanyfile:: (for git-http-backend, in 'SERVICES')
> >      http.uploadpack:: (for git-http-backend, in 'SERVICES')
> >      http.receivepack:: (for git-http-backend, in 'SERVICES')
> > 
> >    These are in git-http-backend manpage, in 'SERVICES' section, which 
> >    probably should be named then 'CONFIGURING SERVICES'.
> 
> I would argue those should probably go in a CONFIGURATION section for
> consistency with the rest of the manpages.

What consistency ;-)?  But I agree, if we can switch all the following 
variants to 'CONFIGURATION', it should also go in 'CONFIGURATION'
section.  If we cannot, then 'CONFIGURING SERVICES' as section name,
and /^Config/i as a regexp detecting if we are in relevant section.

> >    BTW, CONFIGURATION-like means:
> > 
> >     * Configuration
> >     * CONFIGURATION
> >    
> >   but also
> > 
> >     * CONFIG FILE-ONLY OPTIONS
> >     * CONFIGURATION FILE
> >     * Configuration Mechanism
> >     * CONFIG VARIABLES
> >     * CONFIGURATION VARIABLES
> >     * Configuring database backend
> 
> Again, I think for consistency for the reader, it may make sense to
> switch them all to CONFIGURATION. I'd have to look at each page and see
> how appropriate that is, though.

Right.

> > >   2. You recursively follow includes via include::. This means that the
> > >      make rule is not accurate. E.g., try:
> > [...]
> > We do that: see 'doc.dep' target in Documentation/Makefile.  We just
> > need for this target to also add dependencies for config-vars.txt
> > (perhaps separate mode for make-config-list.perl, or perhaps 
> > build-docdep.perl should be config-vars-src.txt aware...).
> 
> Yeah, that would definitely work.

Though simpler would be just to not use or turn off following includes,
as it turned out that it doesn't matter to follow includes in manpages:
if we include with config variables, it is to also include it in 
config-vars-src.txt.

Well, assuming that we don't have to follow includes in config-vars-src.txt;
otherwise we have to generate line in doc.dep for that include anyway.

> > Note however that make-config-list.perl only creates minimal documentation,
> > just link(s) to appropriate mapage(s).  Include-ing merge-config.txt both
> > in git-merge.txt and config-vars-src.txt means that we have merg config
> > variables defined in git-config(1) manpage, which I think is nice to have.
> 
> I disagree. I think one of the benefits of this exercise is generating a
> more concise list. 

I can agree with eliminating those blocks that consist only of list of
variables and reference to main page, like the following[1]

  sendemail.<identity>.*::
        Identity-specific versions of the 'sendemail.*' parameters
        found below, taking precedence over those when the this
        identity is selected, through command-line or
        'sendemail.identity'.

  sendemail.aliasesfile::
  sendemail.aliasfiletype::
  sendemail.bcc::
  sendemail.cc::
  [...]
  sendemail.thread::
  sendemail.validate::
        See linkgit:git-send-email[1] for description.


and perhaps also this block

  imap::
        The configuration variables in the 'imap' section are described
        in linkgit:git-imap-send[1].

[1] Though only if we can ensure that they are added below 
'sendemail.<identity>.*', which refers to them.

> That being said, I don't think there's any reason we
> can't have a terse list in gitconfig(7) and a much larger one in
> gitconfigfull(7) or something like that (or even put it later in the
> manpage of gitconfig(7), or whatever).

You can mechanically move or copy description of config variables from
config-vars-src.txt to individual manpages.  Moving in reverse direction,
like in your autogenerated gitconfigfull(7) proposal, is not that easy:
description of config variables in individual manpages can refer to
other parts of said manpage (and barring AI you cannot reliably detect
such situation).

-- 
Jakub Narebski
Poland
