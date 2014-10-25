From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: git-svn performance
Date: Sat, 25 Oct 2014 06:23:23 +0100
Message-ID: <1414214603.1212.BPMail_high_carrier@web172304.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Sat Oct 25 22:36:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xi847-0001ik-9H
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 22:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbaJYUf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2014 16:35:56 -0400
Received: from nm35-vm1.bullet.mail.ir2.yahoo.com ([212.82.97.124]:35000 "EHLO
	nm35-vm1.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751220AbaJYUfz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2014 16:35:55 -0400
Received: from [212.82.98.124] by nm35.bullet.mail.ir2.yahoo.com with NNFMP; 25 Oct 2014 05:23:23 -0000
Received: from [212.82.98.111] by tm17.bullet.mail.ir2.yahoo.com with NNFMP; 25 Oct 2014 05:23:23 -0000
Received: from [127.0.0.1] by omp1048.mail.ir2.yahoo.com with NNFMP; 25 Oct 2014 05:23:23 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 610188.65969.bm@omp1048.mail.ir2.yahoo.com
Received: (qmail 58017 invoked by uid 60001); 25 Oct 2014 05:23:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414214603; bh=LBrdtNE/v7DzP+Vi4PBIRskeGWtegEtkDJpB1bw7K+4=; h=Message-ID:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=1trILHDdDLGnp+wMN2OINzqmtnAt3RN/6Tc+d/C/XKFzrdxa1E61ntLbAmFxyy8mgvIL6LZjUe9Ibs4m1HQc3dezY8BSqp0uyNMxBghsVf+2pYqyALd481OeBADt/H1VQEAkOKpHsP/jnTq/kkkCEe1DLIpzJk3LAWJAoV8Je68=
X-YMail-OSG: cys1WBEVM1mBmlBdmVoYdIwOSZQxBG7Z5_4Li80s.hZU0Uy
 ZCvwh2kPTOxOTmrt95xs8IuO5yZ2SBjYjL2Z5l6kF_4gcRN7yhgIBpp_OCee
 kQa7f95z5tE7MkfbtLqEPCGCSP3XvhUsflK9vh2J0mM1bHa5uK7VOgP4TYuY
 8zF658YsLGeE9FFTaUSwgtBSler1KnYbLnpsBKR_gTk7VcYhuvQ1ZefeWYCU
 djJOvyrF1DR5sDAAnht.QcNWB6bcZKbu1F5wIU5MBpOuR8_vuYYXuuR1MS9v
 26UNRBEjYNu77dgbiaShXCY9P7TInPrOsXDkW.G7A.MPyKJ7_I6vML8koCHh
 UnFk6H6RvvOheqhvCj.0REL1.2cL2cMGUa_LwFQKqi_edWIdpjnGVTzTCTVS
 1U6ils92UzMuvdRtNFYmewnQtKK1.qKp8otLID1uEo2Oz8ge8eHLiSbejDiA
 dB6PTIt0QkOjTkpKhXEmhvBQCkczkLJQC1hKWJp9ukhQOs6nCv53EVoeL0VM
 _6ECA7dWCBjcGf8.57hcGPmtm2P7xJd4D3drEsK__WsS2jcTICxWl3AMzSpZ
 3O6xhvNrtmvKSMgs-
Received: from [86.30.137.134] by web172304.mail.ir2.yahoo.com via HTTP; Sat, 25 Oct 2014 06:23:23 BST
X-Rocket-MIMEInfo: 002.001,Cg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpPbiBTYXQsIE9jdCAyNSwgMjAxNCAwMTowMiBCU1QgRXJpYyBXb25nIHdyb3RlOg0KDQo.SGluLVRhayBMZXVuZyA8aHRsMTBAdXNlcnMuc291cmNlZm9yZ2UubmV0PiB3cm90ZToNCj4.IENvbXBhcmluZyB0cnVuayBvZiBvbGQgYW5kIG5ldywgSSBzZWUgb25lIGRpZmZlcmVuY2UgLSAgT25lIHNob3J0DQo.PiBjb21taXQgbWVzc2FnZSBpcyBtaXNzaW5nIGluIHRoZSAqb2xkKiAodGhlICJBZGQgY2hlY2tQb0ZpbGVzIGV0Yy4iIHBhcnQpDQo.PiABMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailWebService/0.8.203.733
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



------------------------------
On Sat, Oct 25, 2014 01:02 BST Eric Wong wrote:

>Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
>> Comparing trunk of old and new, I see one difference -  One short
>> commit message is missing in the *old* (the "Add checkPoFiles etc." part)
>> and so all the sha1 afterwards differed. Is that an old bug that's fixed
>> and therefore I should throw away the old clone? 
>
>I don't recall a bug which would cause a revision to be skipped.
>I suppose it's alright now the new clone has that revision.
>Perhaps there was a power outage or improper shutdown?
>
>At least we can be glad current versions see this revision...

the old didn't missing a revision - just a revision 'message' - blank instead of 3 words, above the git svn id. I supppse it is possible some power problem or etc caused this. I'll check the other branches as well, and possibly clone again to be sure. ( The new clone did have one break...)
