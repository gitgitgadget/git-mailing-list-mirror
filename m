From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 0/14] fork/exec removal series
Date: Sun, 14 Oct 2007 11:10:56 +0200
Message-ID: <4711DD20.8070600@op5.se>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at> <20071014021149.GO27899@spearce.org> <Pine.LNX.4.64.0710140348550.25221@racer.site> <20071014025857.GQ27899@spearce.org> <20071014071239.GB1198@artemis.corp> <20071014071751.GC1198@artemis.corp> <20071014072849.GD1198@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, gitster@pob
X-From: git-owner@vger.kernel.org Sun Oct 14 11:11:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgzVE-0000bA-Sa
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 11:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456AbXJNJLH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2007 05:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754739AbXJNJLH
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 05:11:07 -0400
Received: from mail.op5.se ([193.201.96.20]:41774 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754456AbXJNJLF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 05:11:05 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 4E3A71730666;
	Sun, 14 Oct 2007 11:11:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TpnusazMIBbp; Sun, 14 Oct 2007 11:11:19 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 19A01173065D;
	Sun, 14 Oct 2007 11:11:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071014072849.GD1198@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60817>

Pierre Habouzit wrote:
> On dim, oct 14, 2007 at 07:17:51 +0000, Pierre Habouzit wrote:
>> On dim, oct 14, 2007 at 07:12:39 +0000, Pierre Habouzit wrote:
>>>   The trivial way is to add a __thread keyword to make them TLS
>>> variables, though, it's not really a step in the direction of
>>> portability, and last time I looked at it, mingw didn't had TLS sup=
port,
>>> not sure if msys has. Though, if Msys has, it's worth using, and we
>>   Okay forget it, mingw and msys are one and the same *g*.
>>   So well, maybe threading isn't such a so great idea :/
>=20
>   And again last time I checked it was still a mingw 3.x in debian, n=
ow
> that it's 4.2.1 it seems to support __thread (but not
> __declspec(thread)) and their changelog seems to confirm that fact [0=
].
>=20
>   So the question holds again, do we require pthread-using targets to
> support TLS ? It feels sane and right to me, but =E2=80=A6
>=20

To me it's a sane place to start. As time goes by and people on non-TLS
capable systems come along that need the functionality (or the speedup;
fork() is expensive on some systems), they can probably implement it
themselves or at least give voice to the fact that they need it.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
