From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: cloning a namespace downloads all the objects
Date: Fri, 16 Nov 2012 22:04:41 +0530
Message-ID: <CAMK1S_hdsgXoPcSn__htpGCpmCsAGb9j+m+SvxtO_69eqC92gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 16 17:35:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZOsd-00074g-O0
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 17:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab2KPQeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 11:34:44 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:49712 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab2KPQen (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 11:34:43 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so2252812lag.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 08:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=hb/W9kn0vvEYrRqzFUJhcSy5Gw2KsMSw2ktPOZT2DQQ=;
        b=ehIeaFi9VkSxgqhB3xNy4kgDhTX7TPV6RKAutSjMCIjrJ3e31JJxgdqhCau+mJ6fCv
         Oid62GN5qcmIhQszJP+lzE0xnag2grr8QQwZz6aDq7XBm6/WaGtPl03VHonCLVFiEJcB
         9C+z3Aw39RO7jpAk5wNPF/BMdQ9Lr+/lKREixa5eeYLojwjolnJ0w/jSXS7M3sp6/BUY
         GQ5YBTevL05xRjiD+6s2+JujqHuktvZEdVnL6KV2u0dpsdA1KubSLoKF+y4hewwZSUnU
         8+iEgtRO/fSUPmIKSr6S3+1ka8Qsqk4fGEhnTdb2czOgBOqHA9dmYSHFo5J/7vQOl64T
         NY6w==
Received: by 10.112.82.8 with SMTP id e8mr2184135lby.19.1353083682023; Fri, 16
 Nov 2012 08:34:42 -0800 (PST)
Received: by 10.112.113.103 with HTTP; Fri, 16 Nov 2012 08:34:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209883>

Hi,

I have a repo on a server, which contains, as namespaces, the contents
of several different repos of varying sizes.  When I run a clone
command for the smallest of the namespaces (I have a script that
intercepts the clone and sets GIT_NAMESPACE appropriately), I get the
correct set of refs, but *all* the objects from *all* the namespaces.

And since no refs from the other namespaces have come down, a 'git gc
--prune=now', run immediately after, reduces the size of
".git/objects" to the size I would expect for just that small
namespace.

In effect, it is bringing down data that is not reachable and will be
wiped out on the next gc.

Is this expected?

-- 
Sitaram
