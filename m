From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: cloud tags feature produces malformed XML for errors
Date: Thu, 3 Mar 2011 01:42:15 +0100
Message-ID: <201103030142.17258.jnareb@gmail.com>
References: <20110301190229.11297.17767.reportbug@cassiopeia.kleinek> <201103022218.46640.jnareb@gmail.com> <20110302215556.GL22310@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog9@kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, admin@repo.or.cz
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Mar 03 01:42:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Puwcj-0002vC-Bw
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 01:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233Ab1CCAm1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2011 19:42:27 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33389 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982Ab1CCAm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 19:42:26 -0500
Received: by wwb22 with SMTP id 22so727401wwb.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 16:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=btrelldxJBe9ZLLmPuJvyy/uZ4fywKs1H+my5c1g4dA=;
        b=FT8Rgm2Jz67NC0DSU6EetaHNWXD2JZH84Xd40pZDu8eGyPBRZ+XkT96f7jr8dEhMAW
         aut7eGUvDygIZR8Lv+2OgazMDj4Nf0PsBSFTDmpZiqVlAcCzScZLg6ATRBg1laDOvtnj
         kHOfDJNRVRqOutIPTC0SDdSFcZhiUZcLNuCPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=W9yrH2ezGAjjHvZNXLWj35u3O36Y47Ri7oupjaLMg8VGUtST+YIM9/c3HIeFRSvnJu
         OF7WBkbxyif8upobFnP1BMF28Db0WDFKpKvP44QhrmJR+VWT7aQaJVqMOgGvqQfDbDAV
         n60dLCXUNiDB+Rxl+ZCXZclFHDuw+GhQHH144=
Received: by 10.227.54.203 with SMTP id r11mr328036wbg.106.1299112945134;
        Wed, 02 Mar 2011 16:42:25 -0800 (PST)
Received: from [192.168.1.13] (abvi92.neoplus.adsl.tpnet.pl [83.8.206.92])
        by mx.google.com with ESMTPS id w25sm435179wbd.11.2011.03.02.16.42.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Mar 2011 16:42:23 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20110302215556.GL22310@pengutronix.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168364>

On Wed, 2 Mar 2011, Uwe Kleine-K=F6nig wrote:
> On Wed, Mar 02, 2011 at 10:18:44PM +0100, Jakub Narebski wrote:

> > What is most important that makes this feature to be considered for
> > removal (or rehauling) is that only half of this feature is impleme=
nted
> > in gitweb: the displaying part.  There is half-attempt of providing
> > some web interface for managing tags... which needs external script=
 with
> > strict coupling, doesn't offer any access control as far as I know,=
 do
> > not allow deleting tags, etc.
>
> For a small set of repositories the need to hand-edit the tags is OK
> IMHO.  That's what I intended to do.

So what would you like to see?

1. Hardening parsing of ctags files, so that gitweb does not crash on
   malformed entries, but e.g. just ignores them.

2. Generating tag cloud upfront, before sending any output to browser,
   to catch error better (and perhaps separate CSS for HTML::TagCloud).

3. Describe format of ctags files, either in comments in code, or in
   gitweb/README.

4. Either:

   A. Remove editing ctags from gitweb, or
   B. Add some simple generation of ctags file to gitweb

or should we remove ctags feature altogether?
--=20
Jakub Narebski
Poland
