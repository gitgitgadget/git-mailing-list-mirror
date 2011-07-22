From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [RFC PATCH] Move git-dir for submodules
Date: Fri, 22 Jul 2011 21:02:23 +0200
Message-ID: <20110722190223.GA27076@kolya>
References: <1311267139-14658-1-git-send-email-iveqy@iveqy.com>
 <7vhb6f1ipp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de, hvoigt@hvoigt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 22 21:02:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkKzS-0005g3-Bg
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 21:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584Ab1GVTCM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jul 2011 15:02:12 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:52648 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab1GVTCL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 15:02:11 -0400
Received: by fxd18 with SMTP id 18so5636598fxd.11
        for <git@vger.kernel.org>; Fri, 22 Jul 2011 12:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5lfG/di1DNMYyrMAdhb0iaS9VpFAvVJzi/WmonMPSjs=;
        b=gn6Kt8aYhbEBPTxQ5fSVRzBMlyk2JM7D6F/slzPbeJfHXIa27Q0H7MloCQ4WZEMm27
         1TVGy3lGEyQiGjsqH/dBaG79iNUqaOaIv4hnUAV6x7VmZj9XlxX46tNvdhTEkd5S8H3w
         ck12lpPV1bmKKT6kljPjy19md5z+kUZT+AyWU=
Received: by 10.204.23.5 with SMTP id p5mr586681bkb.346.1311361330492;
        Fri, 22 Jul 2011 12:02:10 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id sz1sm589458bkb.58.2011.07.22.12.02.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jul 2011 12:02:09 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QkKzP-00073H-Do; Fri, 22 Jul 2011 21:02:23 +0200
Content-Disposition: inline
In-Reply-To: <7vhb6f1ipp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177655>

Thanks for the review. I'll send an updated series soon.

On Thu, Jul 21, 2011 at 01:28:50PM -0700, Junio C Hamano wrote:
> Is it really necessary to have an ugly
> loop to make things relative, though?
The path must be relative to allow the superproject to be moved
around.

> I wonder if we want a new option to "git rev-parse" so that we can sa=
y
>=20
> 	git rev-parse --is-well-formed-git-dir init/.git
>=20
> to perform these checks without exposing the implimentation detail.

How about using
(cd <repo>; git rev-parse --verify HEAD" >/dev/null)
instead?

Med v=E4nliga h=E4lsningar
=46redrik Gustafsson
