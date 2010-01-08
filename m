From: Marinescu Paul dan <pauldan.marinescu@epfl.ch>
Subject: unchecked mallocs
Date: Fri, 8 Jan 2010 22:59:32 +0100
Message-ID: <D6F784B72498304C93A8A4691967698E8EE2C45017@REX2.intranet.epfl.ch>
References: <D6F784B72498304C93A8A4691967698E8EE2C45016@REX2.intranet.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 08 23:00:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTMsa-0003rD-Kc
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 23:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458Ab0AHWAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 17:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753898Ab0AHWAU
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 17:00:20 -0500
Received: from smtp3.epfl.ch ([128.178.224.226]:38080 "HELO smtp3.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750904Ab0AHWAT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 17:00:19 -0500
Received: (qmail 27190 invoked by uid 107); 8 Jan 2010 22:00:16 -0000
X-Virus-Scanned: ClamAV
Received: from slb-nat-128-178-224-64.epfl.ch (192.26.45.64)
  by smtp3.epfl.ch (AngelmatoPhylax SMTP proxy); Fri, 08 Jan 2010 23:00:16 +0100
Received: from REX2.intranet.epfl.ch ([128.178.50.202]) by
 ewa4.intranet.epfl.ch ([128.178.224.64]) with mapi; Fri, 8 Jan 2010 23:00:16
 +0100
Thread-Topic: unchecked mallocs
Thread-Index: AQHKkKXUcsP1wOyqcUipnpDBVqlFe5GMOms+
In-Reply-To: <D6F784B72498304C93A8A4691967698E8EE2C45016@REX2.intranet.epfl.ch>
Accept-Language: en-US, fr-CH
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, fr-CH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136482>


While checking out the git code in xdiff/xpatience.c and xdiff/xmerge.c I
came across several (three) locations where the return values of xdl_malloc
(#defined as malloc) is not checked. Shouldn't this be done here?

In git 1.6.6 the calls are at

xmerge.c:567
merge.c:571
xpatience.c:191

Paul