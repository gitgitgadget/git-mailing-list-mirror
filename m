From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to prevent Git from compressing certain files?
Date: Wed, 22 Jul 2009 13:46:07 -0700 (PDT)
Message-ID: <m3r5w8bg69.fsf@localhost.localdomain>
References: <4A676D4B.7040004@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-14
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junio@pobox.com>
To: =?iso-8859-14?q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Wed Jul 22 22:47:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTiiQ-0003kS-4d
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 22:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbZGVUqL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 16:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753041AbZGVUqL
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 16:46:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:27074 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbZGVUqJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 16:46:09 -0400
Received: by fg-out-1718.google.com with SMTP id e21so139014fga.17
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 13:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=kKpathxsArhRZmNL4zs2P8GFdgUzP9Fp8R9q3qOWjZ0=;
        b=Ubfs25qB1YOntkC6I7Sfw8tl4nSLJcxEhOkCHidFGGRYVe8hLhcdlwAs4UVUuf+I1K
         bog7WgwAtX649zarx4pQFMAFB6zdjYdeFIsbT5nMYhwZGTqbDHH1wIqZRpKS9zPts2do
         ssiDO7RyMLrl6PYWjwblvaK1G5aKXQk3lSWUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=j1nB0T9iop5TaOIQJXAqSkvT8QZrwW20o2fKkrmbFvhRsRq9Z9kE4xKJ/kk5/iZQOq
         K/QjN+2p6UR81g5eElLOlTqhK9Qk9obu3k4sBcQ7jdVxbIMSGHZbtu+tuyKDZi/+jcOb
         vZzdS5YGKn0cHHnIMLUsh7yZyhKy26ft2H3i4=
Received: by 10.86.60.9 with SMTP id i9mr1173919fga.10.1248295568930;
        Wed, 22 Jul 2009 13:46:08 -0700 (PDT)
Received: from localhost.localdomain (abvd136.neoplus.adsl.tpnet.pl [83.8.201.136])
        by mx.google.com with ESMTPS id 12sm17456917fgg.19.2009.07.22.13.46.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 13:46:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6MKjdQ2001970;
	Wed, 22 Jul 2009 22:45:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6MKjJ8O001959;
	Wed, 22 Jul 2009 22:45:19 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A676D4B.7040004@dirk.my1.cc>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123771>

Dirk S=FCsserott <newsletter@dirk.my1.cc> writes:

> I'm (ab)using Git to store my media files, i.e. digicam pictures (*.j=
pg)
> and the like. This way I can e.g. comment a series of pictures withou=
t
> installing and learning a special purpose "Photo Archiving" tool. Git=
k
> shows the roadmap!
>=20
> Somewhere I read that Git isn't supposed to efficiently handle binary
> files. Of course, I don't want to merge my files, just store them wit=
h
> their history and git-push them to some "safe place".
>=20
> I figured that pushing and git gc'ing both try to compress those file=
s
> (or differences) really hard. Works great for "regular" files, but is
> pointless with jpegs.
>=20
> Question: Is there a way to prevent Git from trying to compress certa=
in
> files based on their extension?

There is _undocumented_ "delta" gitattribute, introduced by Junio C Ham=
ano
in a74db82 (Teach "delta" attribute to pack-objects., 2007-05-19), whic=
h
you would have to unset.

Like this:

  =3D=3D .gitattributes =3D=3D
  *.jpg   -delta

--=20
Jakub Narebski
Poland
ShadeHawk on #git
