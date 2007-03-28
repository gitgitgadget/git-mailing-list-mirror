From: Xavier Maillard <zedek@gnu.org>
Subject: Re: [PATCH] git-blame.el: pick a set of random colors for each git-blame turn
Date: Wed, 28 Mar 2007 12:29:16 +0200
Organization: GNU's Not UNIX!
Message-ID: <200703281029.l2SATGlZ004563@localhost.localdomain>
References: <87bqifrs7r.fsf@morpheus.local>
	<200703272151.l2RLpqD7012317@localhost.localdomain> <874po54tle.fsf@morpheus.local>
Reply-To: Xavier Maillard <zedek@gnu.org>
Cc: git@vger.kernel.org
To: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed Mar 28 13:32:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWWO8-0005Lz-Kk
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 13:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965522AbXC1LcQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 07:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965526AbXC1LcQ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 07:32:16 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:52449 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965522AbXC1LcN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 07:32:13 -0400
Received: from localhost.localdomain (cha51-2-82-244-211-40.fbx.proxad.net [82.244.211.40])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 072C38DE39;
	Wed, 28 Mar 2007 13:32:11 +0200 (CEST)
Received: from localhost.localdomain (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l2SATGeK004566;
	Wed, 28 Mar 2007 12:29:16 +0200
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l2SATGlZ004563;
	Wed, 28 Mar 2007 12:29:16 +0200
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
In-reply-to: <874po54tle.fsf@morpheus.local> (davidk@lysator.liu.se)
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Jabber-ID: zedek@im.lolica.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43368>

Hi David,

   I have a few questions here.  Why do you make a local reference
   (color) to git-blame-colors, but you are still destructively updating
   the list (using delete), possibly making git-blame-colors point to a
   partial ruin of the original list?  My original version may look
   similar, but pop is only destructive on the variable it is popping
   from.  Any other references to the original list will be intact.

   Remember that git-blame-colors is a buffer-local variable, but if it
   points to a global list, any destructive changes will mess up the
   global list.

You are damned right ! I did not check this before.

   I'd prefer something like this:

       (let ((color (if colors
		      (elt colors (random (length colors)))
		     git-blame-ancient-color)))

I agree too.

I hope the next patch will be the last for this "feature" :)
Thank you very much for all your comments.

Xavier
