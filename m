From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Repacking a repository uses up all available disk space
Date: Sun, 12 Jun 2016 17:25:14 -0400
Message-ID: <20160612212514.GA4584@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 23:25:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCCt6-00053x-TG
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 23:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932892AbcFLVZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2016 17:25:20 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:33295 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932884AbcFLVZS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 17:25:18 -0400
Received: by mail-io0-f174.google.com with SMTP id d2so18507207iof.0
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 14:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bN93IbNLPje7XXfmfvD7ZAFMz0MU3XHUi44mi/+JY2A=;
        b=VEStVhCzC0ng+yYTFA1KYsfSG0/gTr+Ivh8VAFxdukgfXA/WXqJcEXKH8gooMulcow
         1AWvynXYoB/wthFp7xwTuNL3Trkg6qcaA2ms5etR7gscloiJ8J05LojW1af8mvMeD5ca
         vlzMKp+/ZAh/ryRF7XfvbxQlm4eVevXev339c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bN93IbNLPje7XXfmfvD7ZAFMz0MU3XHUi44mi/+JY2A=;
        b=DBNZNRoCOYWLVxlPTRiu+AKvMGFVQM5z6eQhTtFIlUwNOqRrYJJss8CXELEXYZHlX3
         Yoomj8T3IH6PJMGe9+1aVWggvLMnYbgTVC3O505F5d3T+rTSRNF/cGT3P1BqiD38pVxz
         HmA7CmcfjfWBfFLMJdb1PeZxMY2QE2AguJVtyUDnm0Pj+RUBAO4IzA9gn/VitAgWS0Yw
         Lz3iKNVoyz/RazzRrM7W1kGkBltebCfMmpdPfTf4pwIw9jhng68aowzY8nckxYSj45+J
         Ta+VXOfarpU2IhJG07uYAAN4wBh3SuVlOvLt+zrPcwd8zGYirupo7pk8vvSGT44/FKth
         r+yQ==
X-Gm-Message-State: ALyK8tKeU4fYRm8/BanilmpHBd7iYDlglN/j6ldJq8WK+a1Wp0e/6DWIJhtF5VaaBVBd+9/t
X-Received: by 10.107.56.131 with SMTP id f125mr18277945ioa.188.1465766717186;
        Sun, 12 Jun 2016 14:25:17 -0700 (PDT)
Received: from gmail.com ([2001:470:1c:4d3::ada])
        by smtp.gmail.com with ESMTPSA id i13sm55961iod.33.2016.06.12.14.25.15
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 14:25:16 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297140>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello:

I have a problematic repository that:

- Takes up 9GB on disk
- Passes 'git fsck --full' with no errors
- When cloned with --mirror, takes up 38M on the target system
- When attempting to repack, creates millions of files and eventually
  eats up all available disk space

Repacking the result of 'git clone --mirror' shows no problem, so it's
got to be something really weird with that particular instance of the
repository.

If anyone is interested in poking at this particular problem to figure
out what causes the repack process to eat up all available disk space,
you can find the tarball of the problematic repository here:

http://mricon.com/misc/src.git.tar.xz (warning: 6.6GB)

You can clone the non-problematic version of this repository from
git://codeaurora.org/quic/chrome4sdp/breakpad/breakpad/src.git

Best,
--=20
Konstantin Ryabitsev
Linux Foundation Collab Projects
Montr=C3=A9al, Qu=C3=A9bec

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXXdM3AAoJEDS6uAr58ke4UEEQALa2s8rnPjbrt3fePouYa3vC
86BQVkNMpb9xyPOEd17Gcp73Yl5PbAYlOq7Y5WptZ0GrVOT21EzBeDIXf2AQXtaA
m1B9UTm/Vr18kSLStZBDvf7ORgSXmNL5oeQGz04y2HJGKDpUinN7j0o7MBc9qG8m
voHjFfY5y0DifJZPyA1xQFZqnQSQ0OHCVbAMGZE4KOj0Mvdg0aZHmhxUXlu3j/Ub
QU0sVLJROjiuhJ7+WBR5nU0Qzh09fngj94b5xSZz1iS4pLC2JH6OL4hX2cSvej6x
3vxJ+1DE2EHGgGXnwfq1sixqUia28JZY1+Nyd0G9zu/r2ZAtxLKtCGiABlFqYkEG
f/S25Blq+IRxfNgJ7l9xdUt8fLeFTodj0wemZOCd+1zn7iI7HpM/P/cK0sidhSra
dbxiaO364bIax4+5Hihzby0W1YjPSWSYHcZvSyrA4qecZz4RfsDhtyE8yIc0dNl4
5Kn4+Tl9RzfZN0ua3JfT22/QGulq4GGjMyltsYasJwda8bbbpVLU8rtljJ6YUwte
6fmqrvUV+OCtdszJt1SJ27vLoP+KbEs9Gn6rGypOj5Uxh40gRX6gr6t/R8NISEO/
1iJaSp0LKPHsCVe8SCdTV8eOU1ZwsUHhkgmkI7dTYfZI2rvyFEzUfSToFcQMqMRn
L2KOO+lPFTk1mfnzPbYy
=aP23
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
