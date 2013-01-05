From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] Add getenv.so for catching invalid getenv() use via
 LD_PRELOAD
Date: Sat, 5 Jan 2013 02:39:00 -0800
Message-ID: <20130105103900.GA4200@ftbfs.org>
References: <CAEvUa7niTJVfp8_kuWs50kvhfZ59F-yAuAmeOXEduHXOq-tRFA@mail.gmail.com>
 <1357376146-7155-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Michael <fedora.dm0@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 11:39:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrRAD-0005wk-SQ
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 11:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573Ab3AEKjT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jan 2013 05:39:19 -0500
Received: from zoom.lafn.org ([108.92.93.123]:30503 "EHLO zoom.lafn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755564Ab3AEKjS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 05:39:18 -0500
Received: from yeeloong.ftbfs.org (pool-108-23-63-172.lsanca.fios.verizon.net [108.23.63.172])
	(authenticated bits=0)
	by zoom.lafn.org (8.14.3/8.14.2) with ESMTP id r05AdCN5080764;
	Sat, 5 Jan 2013 02:39:12 -0800 (PST)
	(envelope-from kraai@ftbfs.org)
Received: from kraai by yeeloong.ftbfs.org with local (Exim 4.80)
	(envelope-from <kraai@ftbfs.org>)
	id 1TrR9Y-00025G-Ry; Sat, 05 Jan 2013 02:39:01 -0800
Mail-Followup-To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Michael <fedora.dm0@gmail.com>
Content-Disposition: inline
In-Reply-To: <1357376146-7155-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97 at zoom.lafn.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212684>

On Sat, Jan 05, 2013 at 03:55:46PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>  Perhaps this will help the getenv bug hunting (I assume we do the
>  hunting on Linux platform only). So far it catches this and is stuck
>  at getenv in git_pager().

It seems like a static analysis tool might be able to detect these
problems.  Is there a way to do so using sparse?

> +		n =3D backtrace(buffer, 100);
> +		symbols =3D backtrace_symbols(buffer, n);
> +		if (symbols) {
> +			for (i =3D 0;i < n; i++)

s/;i/; i/

--=20
Matt Kraai
https://ftbfs.org/kraai
