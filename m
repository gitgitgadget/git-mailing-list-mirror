From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: cloud tags feature produces malformed XML for errors
Date: Wed, 2 Mar 2011 09:24:28 +0100
Message-ID: <201103020924.32924.jnareb@gmail.com>
References: <20110301190229.11297.17767.reportbug@cassiopeia.kleinek> <20110301222141.GB7918@elie> <201103020105.04440.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, admin@repo.or.cz,
	John Hawley <warthog9@kernel.org>, Petr Baudis <pasky@suse.cz>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 09:25:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuhMi-0006qg-Sh
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 09:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926Ab1CBIYp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2011 03:24:45 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46855 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755916Ab1CBIYn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 03:24:43 -0500
Received: by fxm17 with SMTP id 17so5654131fxm.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 00:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=VwYx9RF3mebJoAjeA/3KSIAKVJr27SlJFqF+Z/YsVR8=;
        b=Qi2V5vQePYohC4DtEwCKlzfnm0EFWljSyTwHAtC/3pbl+WP2xxgZ5m4UztBho7JBq0
         H3XTdJ9H4LV0cF32OrqR+4o2bB0WDNuYqFRgl++EfUPDln/qr68snFwoxnUJBx8kls3r
         TBaGXLshiuYqstB0Tcxg+0LqSSE8j+q4yc9Ys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uJ1yz1wz93DBkzAGD6KLRkq26BU2xnTxbNO60OkQTwIhzejhdWWko05QewRbp/CAmZ
         wfBhSL4lynGzqRdNkRkBHCHYz/02m31WTEEG/eNOgNUU7KLaqGAiuUTKT0gEXPapDsOp
         zNutgdqpPgui/rCSZrB+7qLhUtMWqUpxCgtHQ=
Received: by 10.223.86.13 with SMTP id q13mr9454699fal.53.1299054282646;
        Wed, 02 Mar 2011 00:24:42 -0800 (PST)
Received: from [192.168.1.13] (abvi92.neoplus.adsl.tpnet.pl [83.8.206.92])
        by mx.google.com with ESMTPS id r24sm974274fax.3.2011.03.02.00.24.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Mar 2011 00:24:40 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201103020105.04440.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168299>

On Wed, 2 Mar 2011, Jakub Narebski wrote:
> On Tue, 1 Mar 2011, Jonathan Nieder wrote:
> > Uwe Kleine-K=C3=B6nig wrote [1]:
> > [1] http://bugs.debian.org/616005
>=20
> > > I experiment with $feature{'ctags'}.  After installing
> > > libhtml-tagcloud-perl (0.34-1) and adding
> > >
> > >	$feature{'ctags'}{'default'} =3D [1];

This is also invalid... but this one actually is described:

 # gitweb by itself can show existing tags, but it does not handle
 # tagging itself; you need an external application for that.
 # For an example script, check Girocco's cgi/tagproj.cgi.
 # You may want to install the HTML::TagCloud Perl module to get
 # a pretty tag cloud instead of just a list of tags.

 # To enable system wide have in $GITWEB_CONFIG
 # $feature{'ctags'}{'default'} =3D ['path_to_tag_script'];
 # Project specific override is not supported.

Using "$feature{'ctags'}{'default'} =3D [1];" would lead to errors when=
=20
you would want to create a tag from web interface.

--=20
Jakub Narebski
Poland
