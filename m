From: Sam Vilain <sam@vilain.net>
Subject: Re: Apology/Bug report: git-send-email sends everything on Ctrl+C
Date: Wed, 26 May 2010 18:50:29 +1200
Message-ID: <4BFCC4B5.6070408@vilain.net>
References: <4BFCB9D0.3010400@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 26 08:50:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHARp-00040w-61
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934164Ab0EZGuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:50:32 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:39404 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab0EZGub (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:50:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 393A9335A0
	for <git@vger.kernel.org>; Wed, 26 May 2010 18:50:30 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TIhtbdnMDmiI for <git@vger.kernel.org>;
	Wed, 26 May 2010 18:50:29 +1200 (NZST)
Received: from [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0] (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	(Authenticated sender: samv)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id C726E33200
	for <git@vger.kernel.org>; Wed, 26 May 2010 18:50:29 +1200 (NZST)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <4BFCB9D0.3010400@vilain.net>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147772>

Sam Vilain wrote:
> Expect a mail storm shortly, sorry folks.
>   

I just had a look at patching git-send-email.perl; but it looks like it
is checking $? correctly at least since beece9da;

            system('sh', '-c', $editor.' "$@"', $editor, $_);
            if (($? & 127) || ($? >> 8)) {
                die("the editor exited uncleanly, aborting everything");
            }

I think I must have actually hit Ctrl-Z, not Ctrl-C.  So, it's all my
fault and I apologize profusely.

Sam
