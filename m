From: Magnus Therning <magnus@therning.org>
Subject: git-http-backend: anonymous read, authenticated write
Date: Tue, 9 Apr 2013 07:45:53 +0200
Message-ID: <20130409054553.GA1537@mteis.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 09 07:46:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPRNw-00040J-71
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 07:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933087Ab3DIFqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 01:46:20 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:46726 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205Ab3DIFqT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 01:46:19 -0400
Received: by mail-la0-f41.google.com with SMTP id er20so970262lab.14
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 22:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent:x-gm-message-state;
        bh=V18Gq22+WJP34X34Awt7Mk4Oh0PUYXJ46VbmHZCvDGc=;
        b=TbjyaBmHb5njYCa5ubZI+n/qlEBB7SyotCC0eVBH3cjLKnzKByof0jRQcBgZEUQ0aR
         zzPn1HWH+sdeDLMIlS4nYQUc9jhWSckfU4KM0ATqKgV3NQJ+OPAwRRoW7xWOvnKS5EHF
         bKTqQt9zC+78y4nKu0Woy1JVuqiQ2BHQuS3UV1x9p5T9uhVckeZISUTThXItBXSYlOc1
         5WER6tXY6sSHygPIBaboArVhZ7gzGFkN2opAY7tuVXRkYYMFe0XMzuJb1Gpk6eRVgKsG
         1gOgZQ5x3CcW7RGq6aMoHLWy+uoAUbMxh4LwWfcLdBVt5lh2cwbaAljqNC0qnNqHwUNQ
         Sfuw==
X-Received: by 10.152.134.40 with SMTP id ph8mr13119257lab.39.1365486377426;
        Mon, 08 Apr 2013 22:46:17 -0700 (PDT)
Received: from mteis.lan (92-32-222-34.tn.glocalnet.net. [92.32.222.34])
        by mx.google.com with ESMTPS id f7sm7900338lbj.13.2013.04.08.22.46.15
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 22:46:16 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQk5j+QAJFtAMUoc6avP+Io9NGjzR0zH/jQ6GOUjoVtm3tLqe263eO4hOjvdQ6O+GkjjTkPF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220551>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've been trying to set up git-http-backend+lighttpd.  I've managed to
set up anonymous read-only access, and I then successfully configured
authentication for both read and write.  Then I get stuck.  The
man-page for git-http-backend says that the following snippet can be
used for Apache 2.x:

    <LocationMatch "^/git/.*/git-receive-pack$">
        AuthType Basic
        AuthName "Git Access"
        Require group committers
        ...
    </LocationMatch>

However, when I put in this match on location in my lighty config and
try to push I'm not asked for a password, instead I'm greeted with

    % git push=20
    error: The requested URL returned error: 403 Forbidden while accessing =
http://magnus@tracsrv.local/git/foo.git/info/refs?service=3Dgit-receive-pack

AFAICS this means the man-page is wrong, and that I instead ought to
match on the "service=3Dgit-receive-pack" part.  Is that a correct
conclusion?

/M

--=20
Magnus Therning                      OpenPGP: 0xAB4DFBA4=20
email: magnus@therning.org   jabber: magnus@therning.org
twitter: magthe               http://therning.org/magnus

I invented the term Object-Oriented, and I can tell you I did not have
C++ in mind.
     -- Alan Kay

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iF4EAREIAAYFAlFjqxEACgkQxZ8oagHN9cEFVwD9HZyRX50N5VrNmredM5rmM1gu
SM+7/U4Oh3vfOarcIgEA/jE/qN1avLOiINkskJinWxy+1keXuclSVnvhYoJ06qlB
=p6RX
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
