From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: Unable to compile Git on HP-UX B.11.31 U ia64
Date: Wed, 14 Nov 2012 12:25:33 +0100
Message-ID: <50A37FAD.1030901@gmail.com>
References: <30295_1352891883_50A37DEB_30295_18278_1_67156E3FC2DDE6479DE35C159B9C2B582C59CEE6@wptxexmbx03.ptx.fr.sopra>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Quintin Ronan <ronan.quintin@sopragroup.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 12:25:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYb6P-00060E-T1
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 12:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159Ab2KNLZk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2012 06:25:40 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49846 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161052Ab2KNLZj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 06:25:39 -0500
Received: by mail-lb0-f174.google.com with SMTP id gp3so282424lbb.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 03:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=p/Nl/5jrOtX0mOYdQsqf70sP3U74yKCjOaT4TT46Gu0=;
        b=zbpcXF7PtKAwHpy24wf4Ch4OJxSjH/ASbbazikBNviSRmujqXSMr4TBGQDN5EW//Wh
         egsi7etnqIJZFE732WoKpajoUMJ24b0MzAmFuKKV77x2twgNCnkAOB6JmNvyyIiuP+Wk
         47DHHR2X/EjiBG/2sxketXhhFs9JIFKnJeiRT39dqwq5ezSC6k8mz6H12DZPGsvrylPP
         7+LsjvFithYQRgJVmvopm8rUjiTs5ZovG2Vne67QaadTuRjr9968L3hpAYerVJi4//db
         MigD+vXVYersgzsIpJNf5ELIM7BIp0p2qmgzyxs0SFAxLIMk5Sw1ccAL1lIYDVCmIbci
         AnEg==
Received: by 10.152.104.148 with SMTP id ge20mr24150639lab.51.1352892338016;
        Wed, 14 Nov 2012 03:25:38 -0800 (PST)
Received: from [192.168.178.21] (host247-100-dynamic.8-87-r.retail.telecomitalia.it. [87.8.100.247])
        by mx.google.com with ESMTPS id g5sm4890984lbk.7.2012.11.14.03.25.36
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Nov 2012 03:25:37 -0800 (PST)
In-Reply-To: <30295_1352891883_50A37DEB_30295_18278_1_67156E3FC2DDE6479DE35C159B9C2B582C59CEE6@wptxexmbx03.ptx.fr.sopra>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209711>

On 11/14/2012 12:18 PM, Quintin Ronan wrote:
> Hello,
>=20
> I=E2=80=99m trying to compile git 1.7 on a HPUX server using make.
> The ./configure worked well :
>
> [SNIP]
>=20
> But when i run make (with =E2=80=93d) it simply doesn=E2=80=99t work =
with a message
> which isn=E2=80=99t really helpfull :
>=20
>   [SNIP]
>   Make: line 313: syntax error.  Stop.
>=20
> Can you help me ?
>=20
The Git build system requires GNU make, but it seems to me you are usin=
g
your system native make instead.  That won't work.  It might be the cas=
e
GNU make is installed on your system, but is named something like 'gmak=
e'
or 'gnumake' rather than just 'make'.  What happens if you run the
following?

   $ gmake --version
   $ gnumake --version

If GNU make is not installed on your system, you can download the lates=
t
version from here:

    <http://ftp.gnu.org/gnu/make/make-3.82.tar.gz>

=46or more information about GNU make:

    <http://www.gnu.org/software/make/>

HTH,
  Stefano
