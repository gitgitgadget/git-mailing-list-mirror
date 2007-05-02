From: Dana How <danahow@gmail.com>
Subject: [PATCH 0/5] git-repack --max-pack-size
Date: Tue, 01 May 2007 17:02:59 -0700
Message-ID: <4637D533.8070004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 02 02:03:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj2JK-0006x1-1F
	for gcvg-git@gmane.org; Wed, 02 May 2007 02:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946107AbXEBADG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 20:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946103AbXEBADG
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 20:03:06 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:35048 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946106AbXEBADD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 20:03:03 -0400
Received: by py-out-1112.google.com with SMTP id a29so1696591pyi
        for <git@vger.kernel.org>; Tue, 01 May 2007 17:03:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=o5yXxwEzKq/4hqStEUGIsvTjcqEQp5KtmKIwhiZ9Xfx8ocvxUWrICwOBmHgAetREcYiqosLqVExHFoUANRDyWmU0Ey6stRU276tMfRePqMAphUWUmFPTGwFgotcovZmzZG+iFoQeQVs14f8977vH0hqbdoHeKbGWj+e8tOikFU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=F9/RWrQYvcVBnrx5T3S9cYV9hP6KHMmx5RUSM6Stj/w4G2gdg5+Jw1KWvBQ+ZU93WowBWJEFwYCesJ7ATwYP/VcGbquF4RnjgcgNCmsZPYBuXm34lk0eQTBL8hJtbR5p8vngHSPpWvpGhO1z2el5JjdxO8Tbxd+0z6zXCvX7vwc=
Received: by 10.35.41.14 with SMTP id t14mr95107pyj.1178064181828;
        Tue, 01 May 2007 17:03:01 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id p4sm95066nzc.2007.05.01.17.03.00;
        Tue, 01 May 2007 17:03:01 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45993>


The three most common ways of making large packfiles
are git-fast-import, the first git-repack, or git-repack -a.
The first already supports a "--max-pack-size=N" option,
which limits the resulting packfiles to N megabytes.
This patchset adds the same option, with the same
behavior, to git-repack to handle the other two cases.

This iteration fixes the most recent issues,
including operation without implying -f/--no-reuse-delta.
