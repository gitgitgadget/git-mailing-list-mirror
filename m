From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: move highlight config out of guess_file_syntax()
Date: Mon, 26 Jul 2010 22:45:32 +0200
Message-ID: <201007262245.35518.jnareb@gmail.com>
References: <1280000767-31895-1-git-send-email-asedeno@mit.edu> <201007260135.35059.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Alejandro R. =?utf-8?q?Sede=C3=B1o?=" <asedeno@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 26 22:46:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdUYw-00077B-L0
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 22:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540Ab0GZUqI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 16:46:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39078 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab0GZUqF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 16:46:05 -0400
Received: by bwz1 with SMTP id 1so2995361bwz.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 13:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AYZFmkrAlFufP+w2hUPpWWJouHwACU9dpBgZZfJKayM=;
        b=DhSuw3yqGQ0X4M7eJvgVR2p/PrIAroyS4hid0nFtIFhpX2c1KPbvYS2AaDbwc7HJrw
         lnGTCJ/QauUGAbfu2PeGw0Nd9rpkFCpe7qFDH36eEsvdnV5xaKiVLSjxRHOZtnRIfJRD
         /xahbyo2QpU2ygjDtI/N9n5Zi7k4WWWbWOjik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mFQTHWWKEHOuChiSgy1qEiqcT+JDUli+cUKSa7G4cT4g+5dLYNrlDKk888QYAet26B
         VtM/VlhNh7Qy5CGDyyskJ/pEyX07mTm4Okef6Fb4XOTlshkYNEqk4yAuU+1H5RUbHrmq
         8RJKwQKAgZzpPhkkwJPe+f44LPoamGpZFZmkg=
Received: by 10.204.142.205 with SMTP id r13mr5645602bku.207.1280177164111;
        Mon, 26 Jul 2010 13:46:04 -0700 (PDT)
Received: from [192.168.1.13] (abwn25.neoplus.adsl.tpnet.pl [83.8.237.25])
        by mx.google.com with ESMTPS id s34sm3175567bkk.1.2010.07.26.13.45.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 13:45:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201007260135.35059.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151893>

On Mon, 26 Jul 2010, Jakub Nar=C4=99bski wrote:
> On Sat, 24 Jul 2010, Alejandro R. Sede=C3=B1o wrote:
>=20
> > Move highlight config out of guess_file_syntax() so that it can be
> > extended/overridden by system/user configuration.
> >=20
> > Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
>=20
> Good idea.
>=20
> The only _possible_ problem is that this configuration is fairly spec=
ific
> with respect to currently the only one sipported hightlighter, i.e. t=
he
> external binary 'highlight' (http://www.andre-simon.de).  If we are t=
o
> add support for other programs (e.g. GNU Source Highlight) or Perl mo=
dules
> for syntax highlighting (e.g. Syntax::Highlight::Engine::Kate or=20
> Beautifier) in the future, this could mean backward incompatibile cha=
nge.
>=20
> The culprit is using extensions (in 'highlight' main syntax files are=
=20
> named by extensions) rather than format names in %highlight_basename
> and %highlight_ext, e.g. 'py' rather than 'python'.  I don't know if
> it would be much of the problem.
>=20
> So perhaps I am worrying about nothing...

I am worrying about nothing.  The default syntax highlighter would be
'highlight' program; if one wants to change highlighter, one can also
modify required configuration (names of 'syntax' to choose from might
be different for different highlighting engines).

Therefore:

Acked-by: Jakub Narebski <jnareb@gmail.com>

--=20
Jakub Narebski
Poland
