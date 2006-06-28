From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [PATCH] git.c: Re-introduce sane error messages on missing commands.
Date: Wed, 28 Jun 2006 14:00:44 +0200
Message-ID: <20060628120044.GA3228@fiberbit.xs4all.nl>
References: <20060627083508.E912A5BBAB@nox.op5.se> <7vpsgu6wba.fsf@assigned-by-dhcp.cox.net> <44A23A38.3090206@op5.se> <Pine.LNX.4.63.0606281118330.29667@wbgn013.biozentrum.uni-wuerzburg.de> <7vr71938t4.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0606281240480.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <junkio@cox.net>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 14:01:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvYjB-0003le-Ju
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 14:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423296AbWF1MAu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 08:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423297AbWF1MAu
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 08:00:50 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:47810 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1423296AbWF1MAt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 08:00:49 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.62)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1FvYir-0000yB-0E; Wed, 28 Jun 2006 14:00:45 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606281240480.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22806>

On Wednesday June 28th 2006 Johannes Schindelin wrote:

> [PATCH] save errno in handle_alias()
> 
> git.c:main() relies on the value of errno being set by the last attempt to 
> execute the command. However, if something goes awry in handle_alias(), 
> that assumption is wrong. So restore errno before returning from 
> handle_alias().

If we rely on the value of errno we should always immediately store it's
value anyway. On some neolithic systems like the "MSVCRT.DLL" C runtime
library on Windows (used by e.g. the Mingw compiler, don't know about
Cygwin) a lot of runtime functions actually even reset the value of
errno to 0 on success!
-- 
Marco Roeland
