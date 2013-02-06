From: "R. Diez" <rdiezmail-buspirate@yahoo.de>
Subject: How to diff 2 file revisions with gitk
Date: Wed, 6 Feb 2013 15:57:53 +0000 (GMT)
Message-ID: <1360166273.33888.YahooMailNeo@web171204.mail.ir2.yahoo.com>
References: <1360164008.49200.YahooMailNeo@web171204.mail.ir2.yahoo.com>
Reply-To: "R. Diez" <rdiezmail-buspirate@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 16:58:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U37OG-0004ib-Qy
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 16:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757553Ab3BFP6A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2013 10:58:00 -0500
Received: from nm10.bullet.mail.ird.yahoo.com ([77.238.189.39]:47449 "HELO
	nm10.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757495Ab3BFP5z convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Feb 2013 10:57:55 -0500
Received: from [77.238.189.53] by nm10.bullet.mail.ird.yahoo.com with NNFMP; 06 Feb 2013 15:57:54 -0000
Received: from [212.82.108.118] by tm6.bullet.mail.ird.yahoo.com with NNFMP; 06 Feb 2013 15:57:54 -0000
Received: from [127.0.0.1] by omp1027.mail.ird.yahoo.com with NNFMP; 06 Feb 2013 15:57:54 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 103215.99133.bm@omp1027.mail.ird.yahoo.com
Received: (qmail 35009 invoked by uid 60001); 6 Feb 2013 15:57:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1360166274; bh=4fRIoHheZa8cKbWBxKEDZmAzaqpmBPh+dAlOsjgvXZk=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=OZuD/So4CfZXuM9162R0Pp7FwHLuvfcu/e9tXAjuuRPI3c3t6NaXx+ytTaSpAcArxR8Xt52sjUN7tRYg3QbyW5oFIJisbEUtzSRHxjM6w3HIRT8FuZFAxkvIpgD8vrtwoLpGCiH1XBMlgoKleGYH/TjC14DA/Fw9fxYiiEHJ4Co=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=PcgdRt6fiXgKMVgeigWvjGg6ATyEz67lJFEpAsyz2S7tItPcrh1h109xnvlwwSpvwU/Y6uODqLbBmFZzi5OfLKfsJrYP7XzbyYtzs8zm1+wHHGeO0YqdAW+Qd4wi4nZ6R3RlPDkjTFxFoJlsp9Z7RpQW8B+O/om3wuRUufVd/DQ=;
X-YMail-OSG: SFRUKOcVM1kSsho4yBuKu_vm.RcDEMH07q7lVA5Wv7Q52Bi
 DHJ6Qy9AUJ7xfljxCryMG755bSh2PUGMT6oxE8xn0tzY7zYbE4vc38CeCk8B
 f5r9EtEo8h0N3xZF2WFCzWVIC1H0Swn6AnS2k0CBOLzQj4S9sZ_z9tjX0ZmO
 5Tx8T5BiKW2u163MUN4fjMJasIhClSgjSrbayV9gwuhSnFqbkHEkn43mduJC
 QL1Heg80Q.VvQ_j._S0znGTtwWJYiMd8KNacHmZrfVz9_y0_uphUqzfpErgY
 CGcru4KW.6.l1tvrT9QYFIUmppS4y80ccTT19aIIaTdlUeA6IlsOgf6Zb_Kg
 Zz5QBBEbZwOeMn9jZtIJHyamP9YH1qZjQ8zg5vc0f2qsBpQaWnzI8CIUVyY5
 .gFNaBH6veEtxnkNJX0ZAunJbRrHX6coTaMjODy64.MDPNwvOGaF04kn94tI
 3vsBbUWqtOwkHKLgSaTxhUVK0ibj8cQxHzMVtZiWaD923RmOWqUBTYwy_QWb
 rSGN5zLRTXTzkUI4RrQj7.Yxm3zf.e7APSEH4O_M8dhvLzHJeCkv6Z75alfv
 H_SBKmTt6CU2KrOwMuCyNwUrEsCA-
Received: from [84.246.251.221] by web171204.mail.ir2.yahoo.com via HTTP; Wed, 06 Feb 2013 15:57:53 GMT
X-Rocket-MIMEInfo: 001.001,SGkgdGhlcmU6CgpJIGFza2VkIGEgZmV3IGRheXMgYWdvIHdoZXRoZXIgSSBjb3VsZCBlYXNpbHkgZGlmZiAyIGZpbGUgcmV2aXNpb25zIHdpdGggdGhlIG1vdXNlIGluIGdpdGssIGJ1dCBJIGdvdCBubyByZXBseSB5ZXQsIHNlZSBoZXJlOgoKCsKgwqAgSG93IHRvIGRpZmYgdHdvIGZpbGUgcmV2aXNpb25zIHdpdGggdGhlIG1vdXNlICh3aXRoIGdpdGspCsKgwqAgaHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9mb3J1bS8jIXRvcGljL2dpdC11c2Vycy85em5zUXNUQjBkRQoKSSBhbSBob3BpbmcgdGhhdCBpdCABMAEBAQE-
X-Mailer: YahooMailWebService/0.8.132.503
In-Reply-To: <1360164008.49200.YahooMailNeo@web171204.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215593>

Hi there:

I asked a few days ago whether I could easily diff 2 file revisions wit=
h the mouse in gitk, but I got no reply yet, see here:


=A0=A0 How to diff two file revisions with the mouse (with gitk)
=A0=A0 https://groups.google.com/forum/#!topic/git-users/9znsQsTB0dE

I am hoping that it was the wrong mailing list, and this one the right =
one. 8-)

Here is the full question text again:

--------8<--------8<--------8<--------8<--------

I would like to start gitk, select with the mouse 2=20
revisions of some file and then compare them, hopefully with an externa=
l
 diff tool, very much like I am used to with WinCVS.

The closest I
 got is to start gitk with a filename as an argument, in order to=20
restrict the log to that one file. Then I right-click on a commit (a=20
file revision) and choose "Mark this commit". However, if I right-click=
=20
on another commit and choose "Compare with marked commit", I get a full=
=20
commit diff with all files, and not just the file I specified on the=20
command-line arguments.

Selecting a filename in the "Tree" view and choosing "Highlight this on=
ly", as I found on the Internet, does not seem to help.

I have git 1.7.9 (on Cygwin). Can someone help?

By the way, it would be nice if gitk could launch the external diff too=
l from the "Compare with marked commit" option too.

--------8<--------8<--------8<--------8<--------

Thanks in advance,
=A0=A0 rdiez
