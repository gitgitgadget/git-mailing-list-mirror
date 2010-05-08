From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] Hacky version of a glob() driven config include
Date: Sat, 8 May 2010 10:18:58 +0200
Message-ID: <201005081018.59757.jnareb@gmail.com>
References: <u2i51dd1af81004060115t5f837840z5adcf83622fa8882@mail.gmail.com> <201005080143.21172.jnareb@gmail.com> <u2p46dff0321005071930n21de08bcv62d88377f082521@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, git <git@vger.kernel.org>,
	Eli Barzilay <eli@barzilay.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 10:19:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAfFk-0006fk-Ss
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 10:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab0EHITK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 May 2010 04:19:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:26044 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab0EHITG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 May 2010 04:19:06 -0400
Received: by fg-out-1718.google.com with SMTP id d23so995314fga.1
        for <git@vger.kernel.org>; Sat, 08 May 2010 01:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=zx/zmmKTd2FNyPbDUqkPqFw/h8LpSkJ7QoTmnePWDpk=;
        b=Vg+2mKY/LPrM+tPqFXoqbKm+y/800KVdUax5C9l1I0rVp8Kt76+F2INfelsalO0crQ
         EldIJS+vBTvo4OKcdRUViIgv8NJSGdKdN95IGHStIX4XBvUNEyfdvnILRu88jzK5/8dh
         LWHvVcnEl9Wu7L/twA8bYpI2BKM22I+PYsdSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Q4B+VZ+5YnF7e06EeqVbyIOuLPVmkx7nSI1jsk7jiPORtG2lRcEF8QSP8HjA9Oj8mZ
         TUUDqCs+oP/L8gS8BLAieWeG2ogbr9r1vTyUqwV/xia6jW6Bggjz8ckRXIZjfQWc7qvH
         Ec+I3SfP0k7VUOWYRa60XDAm+WhEWfGqYpT5s=
Received: by 10.87.19.37 with SMTP id w37mr5457480fgi.25.1273306745334;
        Sat, 08 May 2010 01:19:05 -0700 (PDT)
Received: from [192.168.1.13] (abvu105.neoplus.adsl.tpnet.pl [83.8.218.105])
        by mx.google.com with ESMTPS id 22sm5641354fkq.47.2010.05.08.01.19.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 01:19:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <u2p46dff0321005071930n21de08bcv62d88377f082521@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146648>

On Sat, 8 May 2010, Ping Yin wrote:
> >
> > But perhaps we can break backwards compatibility here. =C2=A0I don'=
t know...
> >
> I think we can. Because config file is not in repository, so if your
> older git doesn't support it, you should not use this new syntax.

Actually per-repository $GIT_DIR/config file *is* in repository... but
is not distributed (it is not transferred on clone / fetch).

The problem with breaking backwards compatibility is when repository is
on shared filesystem (be it networked filesystem such as NFS or
CIFS/Samba share, or portable USB (pen)drive), and can be accessed by
different versions of git.


=46rom mentioned backward-incompatibile proposals, there is one that is
already used (at least in some Perl modules in CPAN), namely

  [@foo]

syntax, which is used by Dist::Zilla (where 'foo' is name of "bundle",
which roughly means set of pre-defined configuration variables). =20
Although it does not support globbing...

The '@INCLUDE =3D db_config.ini' is taken from OpenInteract2::Config::I=
ni.
--=20
Jakub Narebski
Poland
