From: Stephen Boyd <bebarino@gmail.com>
Subject: [BUG?] gitweb search fails with non-ascii characters
Date: Wed, 07 Oct 2009 18:03:32 -0700
Message-ID: <1254963812.1940.34.camel@swboyd-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 03:08:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvhUK-0002o2-P9
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 03:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210AbZJHBEP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Oct 2009 21:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755064AbZJHBEP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 21:04:15 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:50737 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbZJHBEO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 21:04:14 -0400
Received: by ewy4 with SMTP id 4so2455621ewy.37
        for <git@vger.kernel.org>; Wed, 07 Oct 2009 18:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=4SXgLzRB34SkWjNx4EdwqHmpxVP4ClACYnUcU+MdD7s=;
        b=cE3ARmnsApBqP3zx+Ds8zUrbHdIRuYwiBheV9VTWjdyGdIoA8yxbZMsoFcqxiZjlh3
         DxFrm9W8dkO4N9Gd8+MX79vMcb8St7DEdbpYjopi86bcjX15Stz8Ujnu2J61bM2xFe/f
         hUTQQh7jDp3bw59g6IJDHJnxKzHyetHqQZHwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=nX6b0pDlLUfcd0eyX8j7aMV/GdzK1APo0DXEUTkR+A4H0sW0aMXjkUK5RIwFK2RJRL
         S56gNLktUJtH4xMAgE5I4LZF4wVrxrBQ3uFN3DEvudH1Xm6dFeu27h8W2Ue1OLxJSgcE
         vdCx2oTf6hm8bJzM/b4jI3qsMcrd2wG4zOlZo=
Received: by 10.216.90.15 with SMTP id d15mr160753wef.219.1254963817672;
        Wed, 07 Oct 2009 18:03:37 -0700 (PDT)
Received: from ?192.168.1.6? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id u14sm415091gvf.3.2009.10.07.18.03.35
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Oct 2009 18:03:36 -0700 (PDT)
X-Mailer: Evolution 2.28.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129667>

Easiest way to trigger this is by putting =C3=A1 in the commit search b=
ox and
then hitting enter. On git.kernel.org you get a 403 Forbidden. On
gitweb.samba.org it works. I know that git.kernel.org is non-standard,
but I can reproduce locally when I run instaweb (I think my system coul=
d
be mis-configured though).

Even odder, in all cases the letter in the search box becomes mangled o=
n
the results page. Meaning searching again by hitting enter will not be
the same (and actually makes the search box text even worse).
