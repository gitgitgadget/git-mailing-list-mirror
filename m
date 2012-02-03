From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [PATCH, RFC] Fix build problems related to profile-directed optimization
Date: Fri, 3 Feb 2012 13:19:34 -0500
Message-ID: <BEE56B27-1C86-4C26-A584-3FF179B7A3D6@mit.edu>
References: <1328209417-8206-1-git-send-email-tytso@mit.edu> <7vvcnpuhpo.fsf@alter.siamese.dyndns.org> <20120202201226.GA1032@thunk.org> <7vvcnou40u.fsf@alter.siamese.dyndns.org> <20120203020743.GE1032@thunk.org> <7vr4ycsbga.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 19:24:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtNoc-0002la-Ds
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 19:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592Ab2BCSYn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 13:24:43 -0500
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:59327 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751664Ab2BCSYm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 13:24:42 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Feb 2012 13:24:41 EST
X-AuditID: 1209190c-b7fad6d000000920-ff-4f2c253b022b
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.D7.02336.B352C2F4; Fri,  3 Feb 2012 13:19:39 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id q13IJcmn002690;
	Fri, 3 Feb 2012 13:19:38 -0500
Received: from [192.168.145.179] ([66.102.14.20])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id q13IJZ3m004992
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Feb 2012 13:19:36 -0500 (EST)
In-Reply-To: <7vr4ycsbga.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1251.1)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsUixCmqrGutquNv8P+BqsXxCZYW/+ZMY7Xo
	utLNZNHQe4XZgcXjzspj7B7zTgZ6XLyk7PF5k1wASxSXTUpqTmZZapG+XQJXxqFLu1kKTnNX
	/Fi8kbGBsYuzi5GTQ0LAROLI9v2MELaYxIV769m6GLk4hAT2MUocm3MFylnPKPH8w0ZWCGcl
	k8TS9WdZQFqEBUIlXn76ywZi8woYS6y59Q4sziygJ7Hj+i9WEJtNQEnizqf9YHFOATOJ9S3t
	7CA2i4CKxLy/2xlBhjILNDFKTFzewwzRrC2xbOFrIJsDaKiVxPNJUFf8Y5T4MvkjE0iNiICa
	xMS2QywQd8tLtHy9wzaBUXAWkjtmIbljFpKxCxiZVzHKpuRW6eYmZuYUpybrFicn5uWlFuka
	6uVmluilppRuYgQHuSTPDsY3B5UOMQpwMCrx8B44quUvxJpYVlyZe4hRkoNJSZRXTVnHX4gv
	KT+lMiOxOCO+qDQntfgQowQHs5IIb+orbX8h3pTEyqrUonyYlDQHi5I4r4rWOz8hgfTEktTs
	1NSC1CKYrAwHh5IE7zwVoKGCRanpqRVpmTklCGkmDk6Q4TxAw6+A1PAWFyTmFmemQ+RPMepy
	tO77dp5RiCUvPy9VSpx3DUiRAEhRRmke3BxYcnrFKA70ljDvCZAqHmBig5v0CmgJE9ASBgtN
	kCUliQgpqQZGEV7dywaLGKUUkwv3/18g8t6utbJcKuJN0L66dU/F6w3EK9yvaicY9b4ODtgh
	5f/p3HPLo53hsTUfGzvYrXKDD9qp9Rw6PPnQyssGGivvOCV4rOxV35kXnst1VnaD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189789>


On Feb 3, 2012, at 1:00 AM, Junio C Hamano wrote:

>=20
> * I am happy that this version handles this well:
>=20
>   $ make PROFILE=3DBUILD install
>=20
>   even though you did not advertise as such in INSTALL ;-).

I can mention it, although it will mean adding more verbiage about prof=
ile-directed optimization into the INSTALL.

My assumption was that people who did this would usually be installing =
into --prefix=3D/usr as root, but there certainly will be anal people l=
ike myself who want to install profile-optimized binaries into ~/bin.  =
:-)

> * However, I think "clean" target should remove *.gcda unconditionall=
y.
>=20
>   $ make PROFILE=3DBUILD install ; make clean ; git clean -n -x | gre=
p gcda

Will fix.

> * Running "make PROFILE=3DBUILD install" immediately after another on=
e,
>   without "make clean" in between, resulted in full rebuild and test
>   before the second "install", which somewhat surprised me.  I howeve=
r do
>   not think this is a big show-stopper problem.

Hmm=85 that surprises me too.  If

	make PROFILE=3DBUILD all
	make PROFILE=3DBUILD install

works correctly, I don't understand why a second "make PROFILE=3DBUILD =
install" issued after the above sequence would result in complete rebui=
ld and test pass, unless something in the "make install" rules is modif=
ying the build tree as a side-effect of the install pass, which I'd arg=
ue is a bug.  I'll take a look at it.

-- Ted
