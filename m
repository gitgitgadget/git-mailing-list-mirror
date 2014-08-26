From: Oliver Busch <oliver.busch@arc-aachen.de>
Subject: Bug report: Author/Commit date in ISO 8601 format
Date: Tue, 26 Aug 2014 09:29:44 +0200
Message-ID: <53FC3768.3090905@arc-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 09:29:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMBCQ-0002hZ-J6
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 09:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933938AbaHZH3r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Aug 2014 03:29:47 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60232 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933874AbaHZH3p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 03:29:45 -0400
Received: from [192.168.43.193] ([194.8.202.70])
	by mrelayeu.kundenserver.de (node=mreue004) with ESMTP (Nemesis)
	id 0MR97T-1WtLEe48QZ-00UXHg; Tue, 26 Aug 2014 09:29:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V02:K0:bWZaFTRmotvOoahKeAt8OinAMYL9yXGB6hySkk7lo8I
 XiZEBjsy5QGPSb6giMW/w8yoRnz0gbETM0LGGO+FppPVcczu+S
 GbSqmjK1I0sHUGyrmfjTr/G6re0qvaFI1K+uNTx/Y4SVC41F1Y
 pwNjma2lD46RJn9Z513QTtT//HKEKioEpwR87sl83QR6o2PClu
 7Hw5F/9C4a9DwenaiMQ4yOQlqJyqgG/Z23Rt5Ly8Yna6SCiLx1
 7jkjyYGsU54CKKhxzXon+qt0rppWKjpc3iHueuCq/eyIrI30yX
 PQKrzqgQSsboTolMp6Ay4qPO7KwYTDb27TYi1VsPTVrk1V5iqI
 Vjl1n71ecnho8G5i55AxenLis4C7oIxp6HW95lRLB
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255879>

Dear git community,

I encountered the following problem: When using the date formatting=20
option ISO (either by setting --date=3Diso or using format:%ci for the=20
committer date), the output is formatted like this:

2014-08-25 17:49:43 +0200

But according to ISO 8601, should be formatted like this (see=20
http://www.w3.org/TR/NOTE-datetime):

2014-08-25T17:49:43+02:00

This difference makes it impossible to use automated string conversion=20
(in my case, I tried to use Delphi's XSBuildIns=20
(http://wiert.me/2011/07/19/iso-8601-delphi-way-to-convert-xml-date-and=
-time-to-tdatetime-and-back-via-stack-overflow/),=20
which converted git's output "2014-08-25 17:49:43 +0200" to a TDateTime=
=20
of "2014-08-25 02:00:00"; conversion worked correctly when using=20
"2014-08-25T17:49:43+02:00" as input).

I therefore suggest to adapt the output when using --date=3Diso or=20
format:%ci to comply 100% with the ISO 8601 specs, or at least change=20
documentation to say the output is only "ISO-like".

Kind regards,

Oliver Busch

--=20

Oliver Busch, M.Eng.

Airport Research Center GmbH
Bismarckstra=C3=9Fe 61
52066 Aachen
Germany

Phone: +49 241 16843-161
=46ax: +49 241 16843-19
e-mail: Oliver.Busch@arc-aachen.de
Website: http://www.airport-consultants.com

Register Court: Amtsgericht Aachen HRB 7313
Ust-Id-No.: DE196450052

Managing Directors:
Dipl.-Ing. Tom Alexander Heuer
