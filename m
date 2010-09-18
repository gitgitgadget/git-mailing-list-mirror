From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git "smart http" server vs. http redirects
Date: Sat, 18 Sep 2010 10:16:41 +0200
Message-ID: <m262y3cvpy.fsf@whitebox.home>
References: <877hijvff7.fsf@catnip.gol.com>
	<20100918070315.GA30872@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Sep 18 10:17:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owsbe-0007MJ-9E
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 10:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007Ab0IRIQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 04:16:46 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:41519 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877Ab0IRIQp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 04:16:45 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 11A111C1566D;
	Sat, 18 Sep 2010 10:16:42 +0200 (CEST)
X-Auth-Info: Qqx/JX8YZkdKkeotE2rsAuCKMpI65vx0/gy4SvZsuWs=
Received: from whitebox.home (ppp-88-217-109-67.dynamic.mnet-online.de [88.217.109.67])
	by mail.mnet-online.de (Postfix) with ESMTPA id E1A2B1C005B7;
	Sat, 18 Sep 2010 10:16:42 +0200 (CEST)
Received: by whitebox.home (Postfix, from userid 501)
	id 44B801E5311; Sat, 18 Sep 2010 10:16:41 +0200 (CEST)
X-Yow: Is this the line for the latest whimsical YUGOSLAVIAN drama which also
 makes you want to CRY and reconsider the VIETNAM WAR?
In-Reply-To: <20100918070315.GA30872@LK-Perkele-V2.elisa-laajakaista.fi>
	(Ilari Liusvaara's message of "Sat, 18 Sep 2010 10:03:15 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156436>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> On Sat, Sep 18, 2010 at 01:33:48PM +0900, Miles Bader wrote:
>
>> The savannah.gnu.org admins are trying out the git "smart http" server,
>> but it doesn't seem to handle http redirects properly... should it?
>> Is this a bug with the git server?
>> 
>> The follow is from Sylvain Beucler;
>> > Hmmm, actually it works, but it doesn't support a HTTP redirect
>> > (namely git.sv.gnu.org -> git.savannah.gnu.org).
>> >
>> > $ git clone http://git.sv.gnu.org/r/freedink.git
>> > Initialized empty Git repository in /tmp/freedink/.git/
>> > error: RPC failed; result=22, HTTP code = 405
>
> 405 (Method not allowed)? Can you see what request it is trying to send
> and to where (the request that fails with 405 that is)?

I think this is a bug in the apache setup at savannnah.  It is
responding to POST .../git-upload-pack with both 301 and 405.  This does
not happen if you use the redirected address directly.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
