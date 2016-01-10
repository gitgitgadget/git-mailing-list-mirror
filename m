From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: RE: [PATCH v4] git-svn: add support for prefixed globs in config
Date: Sun, 10 Jan 2016 03:00:46 -0800
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5FF2055FF4@mail.accesssoftek.com>
References: <1451470149-14735-1-git-send-email-vleschuk@accesssoftek.com>
 <xmqq60zfehyb.fsf@gitster.mtv.corp.google.com>,<20160105081513.GA32695@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Victor Leschuk <vleschuk@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 10 12:06:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIDpX-0005kd-JM
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jan 2016 12:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756848AbcAJLGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2016 06:06:30 -0500
Received: from mail.accesssoftek.com ([12.202.173.171]:41695 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885AbcAJLGa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jan 2016 06:06:30 -0500
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jan 2016 06:06:30 EST
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Sun, 10 Jan 2016 03:00:47 -0800
Thread-Topic: [PATCH v4] git-svn: add support for prefixed globs in config
Thread-Index: AdFHlp+FE3H8FW+wQHWfnMTYRmxcWAD/qstE
In-Reply-To: <20160105081513.GA32695@dcvr.yhbt.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283616>

Hello Eric and Junio,

Thanks a lot for the comments and sorry for the delay with the response.

I think that's reasonable to widen the applicability of globs, will do it and prepare next patch.


-                       my $pat = $1 ? "${1}[^/]+" : "[^/]*";
+                       my $pat = quotemeta($l) . '[^/]*'. quotemeta($r);

Hm, that differs from the behavior I suggested at first time: in this case the 'test*' pattern will match all of the: "test", "test0", "test1". In my case it wouldn't match "test"...

However I think that's ok.
