From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: Failing a test on OpenServer 6 t5100-mailinfo.sh
Date: Mon, 10 Aug 2009 09:25:27 -0500
Message-ID: <9NpKOKLSn88JzY2TZHUJ89wA2DmHDCazUmQpdWGi9Wi25O90kUipEg@cipher.nrlssc.navy.mil>
References: <alpine.LNX.2.00.0908081014560.13290@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 16:25:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaVof-0005lc-Uy
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 16:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbZHJOZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 10:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752145AbZHJOZ2
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 10:25:28 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46977 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbZHJOZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 10:25:28 -0400
Received: by mail.nrlssc.navy.mil id n7AEPRpf024534; Mon, 10 Aug 2009 09:25:27 -0500
In-Reply-To: <alpine.LNX.2.00.0908081014560.13290@suse104.zenez.com>
X-OriginalArrivalTime: 10 Aug 2009 14:25:27.0316 (UTC) FILETIME=[68099D40:01CA19C6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125447>

Boyd Lynn Gerber wrote:
> Hello,
> 
> With a config.mak.autogen that is fixed for OpenServer 6.
> 
> I now have three tests that fail.
> 
> The first is because of the OS does not allow perl to do somethings.
> 
> The second is a new problem.

Probably your system is missing support for some character encodings.

> *** t5100-mailinfo.sh ***
> *   ok 1: split sample box
> *   ok 2: mailinfo 0001
> *   ok 3: mailinfo 0002
> *   ok 4: mailinfo 0003
> *   ok 5: mailinfo 0004
> *   ok 6: mailinfo 0005
> *   ok 7: mailinfo 0006
> *   ok 8: mailinfo 0007
> *   ok 9: mailinfo 0008
> *   ok 10: mailinfo 0009
> *   ok 11: mailinfo 0010
> * FAIL 12: mailinfo 0011

This uses charset ISO8859-15.

> 
>                         git mailinfo -u msg$mail patch$mail <$mail
>> info$mail &&
>                         echo msg &&
>                         test_cmp "$TEST_DIRECTORY"/t5100/msg$mail
> msg$mail &&
>                         echo patch &&
>                         test_cmp "$TEST_DIRECTORY"/t5100/patch$mail
> patch$mail &&
>                         echo info &&
>                         test_cmp "$TEST_DIRECTORY"/t5100/info$mail
> info$mail
> 
> *   ok 13: mailinfo 0012
> *   ok 14: mailinfo 0013
> *   ok 15: split box with rfc2047 samples
> * FAIL 16: mailinfo rfc2047/0001

ISO8859-2

> *   ok 17: mailinfo rfc2047/0002
> *   ok 18: mailinfo rfc2047/0003
> * FAIL 19: mailinfo rfc2047/0004

ISO8859-8

> *   ok 20: mailinfo rfc2047/0005
> *   ok 21: mailinfo rfc2047/0006
> *   ok 22: mailinfo rfc2047/0007
> *   ok 23: mailinfo rfc2047/0008
> *   ok 24: mailinfo rfc2047/0009
> *   ok 25: mailinfo rfc2047/0010
> * FAIL 26: mailinfo rfc2047/0011

ISO8859-2

You can just skip these tests if you don't want to install the missing
encoding support.

-brandon
