From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] Splitting gitweb and build-time configuration variables
Date: Tue, 17 Aug 2010 22:03:21 -0500
Message-ID: <20100818030321.GB21185@burratino>
References: <201008172015.37353.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@suse.cz>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	John Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 05:05:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlYxj-00024X-3u
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 05:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977Ab0HRDFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 23:05:05 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46792 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab0HRDFD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 23:05:03 -0400
Received: by gwj17 with SMTP id 17so17546gwj.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 20:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mEA0jlTRy1C1uNtpSrMQkQk4gm0UDTbPUPwSEakqWI8=;
        b=CQThPkALfxt98YjgWKlSzLwAxj5dY/QTaqaGVc8veijDNiQPiz351NP7LdaPkXNmfl
         Ckf6/wP7qw/fjZHCONoUNMynXu3YXaaxxIF5WkjTrAYXTqZc54miSwn9X8gfF+t0kQ68
         JIC25ILPdJ1L8M87m6iSermv3ID/e0ZAC+Bys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NPpcFUV2fjRHlDgP5HcyGVqIlBJY5FSAaXwgBClnr4sx4f+6BZflciQ/pDP/bBpwkK
         rR02o2cqAnm9FlpZV91scsAaV/sqwY3fcvGSDpSoEeRyKWPrAXI+bwOXg9K1VRwMsz96
         /N61npw1j8OPtLeTzXPb7Ck+OVMg94ZwfEeGY=
Received: by 10.150.149.19 with SMTP id w19mr8029454ybd.415.1282100702661;
        Tue, 17 Aug 2010 20:05:02 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id 36sm1572270ybr.20.2010.08.17.20.05.01
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 20:05:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201008172015.37353.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153806>

Jakub Narebski wrote:

> 1. Description of build-time configuration variable is in the module
>    that defines it, and each block of variables coming from the same
>    module would have notice where one can find description of those
>    variables
[...]
> 2. Description of build-time configuration variables is in gitweb.perl,
>    and in each module there is comment that full description of those
>    variables can be found there, e.g. (proposal):
> 
>      # Values of those variables are set during build time in 
>      # gitweb/gitweb.perl (main script).  You can find their description
>      # there.
[...]
> 3. Duplicate description of those variables

With #2, a person reading the Makefile can grep for some particular
substitution (++GITWEB_PROJECTROOT++) and quickly find the name and
description of the variable it is used for.  If there were a 1:1
correspondence between the variables in gitweb.perl and the Makefile,
I would even suggest moving the description to the Makefile.

In practice, I suspect the run-time configuration is more important to
people.  That is already fairly well documented in gitweb/README.

Just my two cents,
Jonathan
