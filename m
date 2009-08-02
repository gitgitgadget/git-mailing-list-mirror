From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: option directive to fast-import
Date: Sat, 1 Aug 2009 18:29:10 -0700
Message-ID: <fabb9a1e0908011829j3843c132ka5081d994aad973f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 02 03:29:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXPtS-0000by-D6
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 03:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbZHBB3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 21:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbZHBB3a
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 21:29:30 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:6797 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbZHBB3a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 21:29:30 -0400
Received: by ey-out-2122.google.com with SMTP id 9so758465eyd.37
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 18:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=8LyjuA7LVgk6yAhpHaRn6Jo4wuCCoJC2cgkij9Nd4gg=;
        b=H68YIMz+3lX7ij5W8DmiTbzq7bpjKvCyYACK1qcdOCsJphtuTz4jYJS6k2GzI1dDgW
         y5PdZjF4hC682je1KR7RfRVpODUpd8zaSO6gf9sbpgiOBRmSZ8oW9rSf6zs9GLwD50F4
         0/qpybjqKKMawv4EheRqHjU+Yl4iAkOvsZwa0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=HVgp0irtRCMkunD9DzgYAMpsaS4bUPA17Feo8u3o6S6MXsGLXyVhq2QLlykEqccFud
         uctlZD3Oqu88vSOjhUWzDHTVcdlXwdT6vpNoat+kFBbl7B7Ed6gKzdm5r/TbC9TI+f+s
         e8NEEUP45vzXi2fNkb4+ltBGfQxa4YZRz1PXM=
Received: by 10.216.11.138 with SMTP id 10mr901415wex.51.1249176570076; Sat, 
	01 Aug 2009 18:29:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124655>

Heya,

What would you think of a 'option' directive to fast-import?

'option' SP <option> SP <value> LF

Where <option> is:

import-marks
export-marks
force_update
quiet
stats
date-format
depth
active-branches
export-pack-edges

I just checked them all, and as far as I can see, as long as the
option directives come before any data, there should be no negative
side-effects to setting these values 'late'. The upside would be that
the frontend can tell git fast-import it's preferences, so that the
user does not have to type a humongous commandline, but instead can
suffice to just go with 'foo fast-export | git fast-import'. Of
course, the user might want to override these options manually, so the
option directives should only be honored if no commandline flag is
given.

Would you accept such a patch? If yes, I'll whip something up :).

-- 
Cheers,

Sverre Rabbelier
