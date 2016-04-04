From: "Boettger, Heiko" <Heiko.Boettger@karlstorz.com>
Subject: git mv - exclude source / create target directory option
Date: Mon, 4 Apr 2016 06:45:06 +0000
Message-ID: <8C0042D8869AEA4AA334B49AFBBCEF82B53D470F@TUT-EX02-PV.KSTG.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 04 08:45:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amyGB-0005mi-OL
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 08:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926AbcDDGpK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2016 02:45:10 -0400
Received: from mx1.karlstorz.com ([62.134.46.135]:10063 "EHLO
	mx1.karlstorz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbcDDGpJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2016 02:45:09 -0400
X-IronPort-AV: E=Sophos;i="5.24,439,1454972400"; 
   d="scan'208";a="40492027"
Received: from tut-ex03-pv.kstg.corp ([10.0.10.233])
  by mx1.karlstorz.com with ESMTP; 04 Apr 2016 08:45:07 +0200
Received: from TUT-EX02-PV.KSTG.corp ([169.254.2.132]) by
 TUT-EX03-PV.KSTG.corp ([10.0.10.233]) with mapi id 14.03.0266.001; Mon, 4 Apr
 2016 08:45:07 +0200
Thread-Topic: git mv - exclude source / create target directory option
Thread-Index: AdGOPX/+4wM78IvSRcyQV2Hw/2SrWA==
Accept-Language: de-CH, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.3.60.88]
x-kse-serverinfo: TUT-EX03-PV.KSTG.corp, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 4/4/2016 2:20:00 AM
x-kse-attachment-filter-scan-result: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290679>

Hi,

sometimes I want to reorganize the content of a directory and simply mo=
ve everything into a subdirectory. This seems to be more complicated th=
an it should be. Since git mv requires the destination to exist, I need=
 to create the target directory first. Unfortunately this results in gi=
t mv * to include that directory which results in an error since moving=
 a directory into itself is not possible. My current workaround is rath=
er long by using extglob:

mkdir -p newfolder/subfolder
shopt -s extglob
git mv !(newfolder) newfolder/subfolder
shopt -u extglob

=46or my usecase it would be much easier to archive that target by have=
 a parameter to simply create the target if it isn't existing.

Best Regards
Heiko B=F6ttger

STORZ Endoskop Produktions GmbH
Niederlassung Schaffhausen
Schneckenackerstr. 1
8200 Schaffhausen
Switzerland
