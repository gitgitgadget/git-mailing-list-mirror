From: Jed Brown <jed@59A2.org>
Subject: Re: Creating own hierarchies under $GITDIR/refs ?
Date: Sun, 02 Feb 2014 16:44:56 -0700
Message-ID: <878utt84g7.fsf@jedbrown.org>
References: <87a9e92424.fsf@fencepost.gnu.org> <CACsJy8CdKRQ_au3QqVoUdedvPpkPh_2vodKJwLZ7VrrwRJSDXQ@mail.gmail.com> <8761ox2240.fsf@fencepost.gnu.org> <20140202113141.GB29976@serenity.lan> <87wqhdzqo3.fsf@fencepost.gnu.org> <20140202122432.GC29976@serenity.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>, David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 00:51:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA6ok-0006oJ-3F
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 00:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbaBBXvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 18:51:09 -0500
Received: from jedbrown.org ([198.199.121.66]:50482 "EHLO jedbrown.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558AbaBBXvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 18:51:08 -0500
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Feb 2014 18:51:08 EST
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by jedbrown.org (Postfix) with ESMTPSA id 1351E80D8A;
	Sun,  2 Feb 2014 23:45:34 +0000 (UTC)
In-Reply-To: <20140202122432.GC29976@serenity.lan>
User-Agent: Notmuch/0.17~rc2+3~g5fa88cb (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241392>

--=-=-=
Content-Type: text/plain

John Keeping <john@keeping.me.uk> writes:
> I actually wonder if you could do this with notes and git-grep; for
> example:
>
>     git grep -l keeping.me.uk refs/notes/amlog |
>     sed -e 's/.*://' -e 's!/!!g'
>
> That should be relatively efficient since you're only looking at the
> current notes tree.

I added notes handling to gitifyhg and would search it similar to this.
Since gitifyhg is two-way, I could not modify the commits.  Later, when
we converted several repositories (up to 50k commits/80 MB), I appended

  Hg-commit: $Hg_commit_hash

to all the commit messages.  This way it shows up on the web interface,
users don't have to obtain the notes specially, and "git log --grep"
works naturally.  I think it's worth considering this simple solution;
existing Git users won't mind recloning once.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS7th4AAoJEM+2iNHeMalNJS8QALpmt+TVIiJobZ0RyOUi6x+f
HHaotUfodLHSyOXBeauZ5U54MOSYKT0+w4KqHCpTT1Vu/lhFBmn0uRGV8o29AcgZ
m1kdtPAtoeI7buzfwcglGC+70XorPBfHETD3RLJma9cohM0aOHA29MMkXkQ+8lRI
8I8WW0/sSkRR7SzhR7o7iWUEPPwp9PdS4wpNGqBWINMVMWqogwIFrRLbXk0uvaHB
UVqWICwsITAZaTQViRbfGRk+S58AsKKRE2eRTJ0Y/ygIjIY0HwKWfJamyFabNzot
ia/q2vh80vJTtCP+WUKOp1cn/nrLUEmBKgyAiWwimOy2jJG8v2e3nznFbjMhx2qW
V3VUHlySObjVJ9892f+W1CeLo1t8qwKtO1K7RA0+gD3ZWaEF3WL1F+NxRoKzaz5z
HYLu4h6oC53QjeVZc02rQ58CLevRh4Iw1e0gD4+DatO6qE2eWDusFzkRzMmu2Kz1
/0BeW77O2+LJDl0dovQvn5NwUjnHOF+TVsLxZpQm/u4JAucqJcHpgnY6g6DqpTr/
NNCewEqKnSaf3g/wUt04a3EU7mMdYIBeGzXbqI1H7TuMKgfG1YycfWSNG4jPeroP
iHQhrRFuSDmMm8xXAtF35ferZEd5x4xbC3zxTVl19GiIrzggwQ4EP6LnwQZkru8D
R1z1Y1WOomOfOjaNBpiH
=2bMP
-----END PGP SIGNATURE-----
--=-=-=--
