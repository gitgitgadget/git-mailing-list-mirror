From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Rollback of git commands
Date: Tue, 27 Nov 2007 18:23:35 -0500
Message-ID: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 00:24:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix9mv-0003am-Uk
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 00:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764AbXK0XXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 18:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756157AbXK0XXh
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 18:23:37 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:23365 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755764AbXK0XXg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 18:23:36 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1049762rvb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 15:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=HkxwnsqN4P6ZvJCRGbg9F24XMSUYb+Pwpe+BCTwPRfc=;
        b=lsZ99nh5e1PbV1YzoGb1LbXBFX+dQ8F4fuQ+JOFHHJngNGeiVhZLNdOUXICKOa1UuZZIYYiFlzJ685ZfoRn0VgnFrjOpGXeD6TPjoH6TeTZ6soTfLJR4XcLPZEmf8U1tpvQZbxXuIF4CERy/+cBNczMx9MnofY9yddQ3jYfU5YY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=j0xbqD1Fcays46xSKykAmfgsnFUVpsdyR2UOyrT9g6QkesIOHly4FNVmuE/tufUdyZ9lT/JQadOmRJcFPrEI9uCjgTzkbESMNgeTeztEo2p+vTMGF4p81yhHqBon50NX81Atjd0Nu5HiPIqlBrQod4wyQpC8eHkYteY7A7B/XLA=
Received: by 10.115.59.4 with SMTP id m4mr265952wak.1196205815430;
        Tue, 27 Nov 2007 15:23:35 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Tue, 27 Nov 2007 15:23:35 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66273>

Could a rollback log be implemented in git? It would make things way
easier when you screw something up.You'd only roll back things that
impacted the object store, not things like checkout.

stg is also starting to store significant state in the .git directory.
It may be better to move this state into a git object. That would
allow the state history to be tracked and rollback be implemented.

The same logic can be applied to moving all tracking information in
the .git directory into objects. You then just need to track a single
SHA1 pointing to the .git config info in the object db.

Rollback in the object store is simple, just move the SHA1 in the
config files back to where it was before the action was done. What we
are missing is a way to rollback the config files.

-- 
Jon Smirl
jonsmirl@gmail.com
