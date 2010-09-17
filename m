From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] git-rebase--interactive.sh: LF terminate line sent to
 cut
Date: Fri, 17 Sep 2010 13:59:34 -0500
Message-ID: <VzbuextQE2-OASqyG4sJxmg1IuyBq5BWWiDERv0h-YQdVcnL8Enurg@cipher.nrlssc.navy.mil>
References: <60d13fc6a7d5b1b08f35f91b2d90eb7c13922390.1284733059.git.chris_johnsen@pobox.com> <XhMLJaG8mUbh4rzLnU3IrGDXbMd9-p7UFO6kn9Uke7n_H4NNOG6glg@cipher.nrlssc.navy.mil> <7vsk182p2q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Johnsen <chris_johnsen@pobox.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 21:03:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwgDK-0002yw-N1
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 21:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475Ab0IQTDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 15:03:08 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58368 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804Ab0IQTDH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 15:03:07 -0400
Received: by mail.nrlssc.navy.mil id o8HIxY2b019382; Fri, 17 Sep 2010 13:59:35 -0500
In-Reply-To: <7vsk182p2q.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 17 Sep 2010 18:59:34.0556 (UTC) FILETIME=[77D485C0:01CB569A]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156410>

On 09/17/2010 01:38 PM, Junio C Hamano wrote:

> Agreed; the less use of 'cut' we see, the better ;-)

Double agreed.

> As to portability guideline in our shell script:
> 
>     ${param#word} ${param##word} ${param%word} ${param%%word}
> 
> are permissible POSIX constructs (together with more traditional -/=/?/+), and
> their use is encouraged over 'cut', 'expr', etc. [*1*]
> 
>     ${param:ofs} ${param:ofs:len} ${param/pattern/string}
> 
> are bashisms we avoid (unless of course in the bash completion script).

It's been a long while since I've reviewed Documentation/CodingGuidelines,
but these are indeed in there, and have been for a very long time.  Maybe
I should refresh my memory more often. :)

> We do not seem to use ${#param}, not because it is forbidden, but I think
> because it is not very useful without ${param:ofs:len}.

CodingGuidelines does say "No strlen ${#parameter}", so that could be part
of the reason.  But like you say, it's not very useful without ${param:ofs:len}.

-Brandon
