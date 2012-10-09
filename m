From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: git checkout error
Date: Tue, 9 Oct 2012 09:41:38 +0200
Message-ID: <CAB9Jk9DUEL_J3MmH_4k7NC82m+crpCf1r3NS3gQBMZy+kvY3-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 09:41:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLURq-0007ef-8i
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 09:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552Ab2JIHlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 03:41:40 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:55491 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab2JIHlj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 03:41:39 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so5938654vcb.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 00:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=y5wS/YfvNcwlBEDFTnK0um3ZG180aIrdRZ+25vwPgjA=;
        b=KDXsQvneuhvBnGfPEEgAIywjKjuelavaoyYKbPjUBonnzFGbPKTXoXDO/Mnngn0Tdv
         m8IrynxetkwCIfxB926SXcniZKrfdJ5iCWBTf99iRcWT077iJEbkJ2Sjg3DzL58yEllc
         5DbGwbyYhpbXk30BsMAC5+ifvwz64xlZT/afM4lX1bt7mqUeDCVb+7YMYyzbQLmwi9F1
         vDfAEDBbpH+GwXWu2Z0zL0MZT+pnVlDNpCA4KCIQOQNL0Ez8ui5P2ZHbL5t3Loy4LHFu
         GLPxuDCaJty0DiD0fXw5XJD5WJlK+P4lyKOcz31HxY9L6M6XwEIHWB+YtBXX6tiJ26Qa
         FF9g==
Received: by 10.220.240.18 with SMTP id ky18mr11132855vcb.54.1349768498754;
 Tue, 09 Oct 2012 00:41:38 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Tue, 9 Oct 2012 00:41:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207307>

Hello,

the man page of git checkout in the synopsis does not mention the
--track and --no-track options.
However, in the description below, it states that they are allowed.
It does not say that there is a specific ordering in which they must
be specified.

If they are specified after -b, the command seems to behave as if -b
was not specified, e.g.:

$ git checkout -b --no-track topic remotes/origin/master
fatal: git checkout: updating paths is incompatible with switching branches.

while if they are specified before -b the command behaves properly, e.g.

$ git checkout --no-track -b topic remotes/origin/master
Switched to a new branch 'topic'

If this is the intended syntax, the synopsis should replace:

     git checkout [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]

by;

     git checkout [-q] [-f] [-m] [[--orphan] <new_branch>] [<start_point>]
     git checkout [-q] [-f] [-m] [ [--track|--no-track](-b|-B)
<new_branch>] [<start_point>]

-Angelo
