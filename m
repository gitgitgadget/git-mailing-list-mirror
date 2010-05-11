From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb, FastCGI and PSGI/Plack
Date: Tue, 11 May 2010 11:29:07 +0200
Message-ID: <201005111129.10931.jnareb@gmail.com>
References: <g2s693254b91005091428ib188cbd1le5ffa90eace741a8@mail.gmail.com> <201005102310.47879.jnareb@gmail.com> <AANLkTimypauJKP-ifPKDmM9TK0u0JsSG5PlcpWdkkbVd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Vereshagin <peter@vereshagin.org>,
	Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Tatsuhiko Miyagawa <miyagawa@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 11 11:29:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBlmM-0002W5-9D
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 11:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757163Ab0EKJ3Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 May 2010 05:29:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:58104 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756634Ab0EKJ3X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 05:29:23 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1194982fgg.1
        for <git@vger.kernel.org>; Tue, 11 May 2010 02:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=SEJxTHFVh2RxFRbcxn6CW0edOYYJeQmKXh+dgx1x6Zk=;
        b=s1CGu294OuyC45F/4+/PWS4cnvCQ25WC+o4kkUR7v8VQ6jDbVbcOIPOmUT9Gs7pBjr
         LivIK9uvu5HYmoJaODO4BkauaawFDjHRHC4hAT9Y5pAY0s1PP0oCOftaRVbgy++RsN91
         DNSw7kwyfuQ2s03XodQF9eY8qb5CFWOXdUXUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=N4CDwLkSLu7yeM7G60UQMbZXRJaSQ01jwSgCtBuvixAzbTafMaFKk0CjGDOwILLMgs
         Zx3anxWhQWmFMlUT9sgq31YPOv3VFvSn0UQrPG6ntPFPr0NqKL8K+tTPLR8QAxksPRll
         7jH5teJS2Rkl2DGmgBE/1nTzIahYHOBGUieIE=
Received: by 10.87.1.2 with SMTP id d2mr11599052fgi.34.1273570161275;
        Tue, 11 May 2010 02:29:21 -0700 (PDT)
Received: from [192.168.1.13] (abwc23.neoplus.adsl.tpnet.pl [83.8.226.23])
        by mx.google.com with ESMTPS id e3sm9363928fga.29.2010.05.11.02.29.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 02:29:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimypauJKP-ifPKDmM9TK0u0JsSG5PlcpWdkkbVd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146881>

On Mon, 10 May 2010, Tatsuhiko Miyagawa wrote:
> On Mon, May 10, 2010 at 2:10 PM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
> >
> > Well, the support for 'plackup' in git-instaweb is / would be done =
not
> > by converting gitweb from CGI to PSGI app, but by using gitweb.psgi
> > wrapper.
>=20
> Wrapping gitweb.cgi with gitweb.psgi is a legitimate way to say
> "converting CGI to PSGI app".

I have misunderstood you then, I'm sorry.
=20
> > I also wonder how running via wrapper script affect performance, as
> > compared to modified gitweb running as FastCGI script, using CGI::F=
ast
> > and FCGI.
>=20
> Based on my experience CGI::Emulate::PSGI doesn't have much of an
> overhead because it's just swapping STDIN and STDOUT handles and
> doesn't require stuff like tie or overload which tends to be slower.

Nice to know.

Unfortunately I don't have mod_fcgid / mod_fastcgi installed, so I can'=
t
do a benchmark comparing PSGI wrapper + FCGI handler with modified
gitweb running as FastCGI script (using ab, ApacheBench).  Do you know
any pure-Perl FastCGI server with minimal dependencies, and pure-Perl
HTTP server benchmarking tool (like ab and httperf)?
=20
> > P.P.S. One of constraints to gitweb development is that it should r=
un
> > with minimal set of non-core modules.  Some people even complain th=
at
> > gitweb (or was it about git in general?) requires at least Perl 5.8=
=2E6 or
> > about (because of Encode module and Unicode support).
>=20
> I know, but git-instaweb is a different story, since you rely on the
> fact that the system has one of web servers like apache, lighttpd or
> mongrel.
>=20
> And that's exactly why I've been suggesting to you use WrapCGI
> (CGI::Emulate::PSGI + CGI::Compile) instead of converting gitweb.cgi
> to natively support PSGI. We're on the same page and I don't
> understand why you keep disagreeing with me :)

I might have misunderstand you as arguing against modifying gitweb to
add FastCGI support via CGI::Fast...

P.S. discussion !=3D disagreeing ;-)
--=20
Jakub Nar=EAbski
Poland
