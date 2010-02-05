From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: git-grep: option parsing conflicts with prefix-dash searches
Date: Sat, 6 Feb 2010 00:27:19 +0100
Message-ID: <adf1fd3d1002051527j72fd302byc85a2f0980ce9998@mail.gmail.com>
References: <alpine.LSU.2.01.1002052351060.30204@obet.zrqbmnf.qr>
	 <alpine.LSU.2.01.1002060009430.30204@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:27:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdXaA-0000nB-Vq
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933352Ab0BEX1V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2010 18:27:21 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:48258 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932632Ab0BEX1V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2010 18:27:21 -0500
Received: by fxm20 with SMTP id 20so4556272fxm.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 15:27:19 -0800 (PST)
Received: by 10.102.200.17 with SMTP id x17mr2261582muf.125.1265412439118; 
	Fri, 05 Feb 2010 15:27:19 -0800 (PST)
In-Reply-To: <alpine.LSU.2.01.1002060009430.30204@obet.zrqbmnf.qr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139120>

On Sat, Feb 6, 2010 at 12:17 AM, Jan Engelhardt <jengelh@medozas.de> wr=
ote:
> On Saturday 2010-02-06 00:09, Jan Engelhardt wrote:
>
>>What works is (3).
>>
>>(3) =A0 =A0$ git grep -- -- '->cnt' net/ipv4/netfilter/
>
> No, I spoke too soon. This command will search for --, not ->cnt.
> So git cannot search for patterns starting with a dash at all,
> as I see it. This is getting fun..

You should use -e:

     -e
           The next parameter is the pattern. This option has to be
used for patterns starting with - and should be used in scripts
passing user input to grep.

The working command is:

$ git grep -e '->cnt' net/ipv4/netfilter/

Although there is not such pattern in net/ipv4/netfilter, maybe you
wanted '->counters' :-)

HTH,
Santi
