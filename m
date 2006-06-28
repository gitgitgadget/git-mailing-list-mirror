From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH] git.c: Re-introduce sane error messages on missing commands.
Date: Wed, 28 Jun 2006 10:59:44 -0400
Message-ID: <20060628145944.GB5567@trixie.casa.cgf.cx>
References: <20060627083508.E912A5BBAB@nox.op5.se> <7vpsgu6wba.fsf@assigned-by-dhcp.cox.net> <44A23A38.3090206@op5.se> <Pine.LNX.4.63.0606281118330.29667@wbgn013.biozentrum.uni-wuerzburg.de> <7vr71938t4.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0606281240480.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060628120044.GA3228@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 28 17:00:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvbW8-0004Kk-MF
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 16:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWF1O7p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 10:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWF1O7p
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 10:59:45 -0400
Received: from pool-71-248-179-197.bstnma.fios.verizon.net ([71.248.179.197]:5531
	"EHLO cgf.cx") by vger.kernel.org with ESMTP id S1750958AbWF1O7o
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 10:59:44 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id 3C21213C01F; Wed, 28 Jun 2006 10:59:44 -0400 (EDT)
To: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Roeland <marco.roeland@xs4all.nl>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060628120044.GA3228@fiberbit.xs4all.nl>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22809>

On Wed, Jun 28, 2006 at 02:00:44PM +0200, Marco Roeland wrote:
>On Wednesday June 28th 2006 Johannes Schindelin wrote:
>
>> [PATCH] save errno in handle_alias()
>> 
>> git.c:main() relies on the value of errno being set by the last attempt to 
>> execute the command. However, if something goes awry in handle_alias(), 
>> that assumption is wrong. So restore errno before returning from 
>> handle_alias().
>
>If we rely on the value of errno we should always immediately store it's
>value anyway. On some neolithic systems like the "MSVCRT.DLL" C runtime
>library on Windows (used by e.g. the Mingw compiler, don't know about
>Cygwin) a lot of runtime functions actually even reset the value of
>errno to 0 on success!

Cygwin does not use MSVCRT.DLL and tries to be careful about spurious
resetting of errno.

cgf
