From: "David Symonds" <dsymonds@gmail.com>
Subject: git-browser and branch names
Date: Mon, 1 Oct 2007 21:24:31 +1000
Message-ID: <ee77f5c20710010424x1f83aa10kcde7033711b02093@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 01 13:24:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcJOE-0004VC-AF
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 13:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbXJALYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 07:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbXJALYc
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 07:24:32 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:18136 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbXJALYc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 07:24:32 -0400
Received: by wa-out-1112.google.com with SMTP id v27so4516351wah
        for <git@vger.kernel.org>; Mon, 01 Oct 2007 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=8ATaBKbfcQeVqaLtFSooTiemWzDfFsRMH1hDJ26xnxI=;
        b=mh2NH0WR3FmNy+kLdgdO6V0U8S12yvjnyCkywYih4mUyGZ+2EWCEcS/ul1ZpHNijiAkPuqCDkpkEz/86DI5UweixWm4j8GXZG0whi7Uwvy/aDUiLhDJM1arKVbtBd3ItCTAFRBExPeenVxe5HCok4RweQOfQCcV0mHIhx8f5sSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OZnKYw/nZ8jKDBneNRLxrbqr+Y3UQzeJHN+r3soAtNv6IhGMY3ovBRsMh0ng6YCpQ6hwfcDrYHueSxEYYnxMzUzzQ82iO4c7hbQl/P6iYQgWuvtp4R897pNK6Rr0cd4Cnpv3IuyHE7Vcc3GPfLtxK2TZHtkN/Vna++tMEgzl2Wo=
Received: by 10.114.209.1 with SMTP id h1mr476912wag.1191237871343;
        Mon, 01 Oct 2007 04:24:31 -0700 (PDT)
Received: by 10.141.153.4 with HTTP; Mon, 1 Oct 2007 04:24:31 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59601>

Hi,

I've been using git-browser hooked up to gitweb for several weeks now
(git 1.5.2.1), and it's going great. However, I've hit my first bug:
it seems that certain branch head names cause the whole diagram (and
log lines, etc.) to fail to render, only displaying the "Starting
from: all <repo>.git heads" stuff down the bottom. As to the various
names I've tested:

okay: master, 2.5j, 2.5-dev, a.b, 2-5, 2.b, b.2, 2.5.0
fails: 2.5, 2.6

I've experimented by just using 'git branch -m <old> <new>' to rename
a branch that I'd prefer to just call '2.5', so I'm pretty sure that
I'm not causing things to break myself.

It seems that it's when the branch name looks like a decimal number,
but there's nothing that appears in Apache's error_log. This leads me
to believe it's a Javascript bug.

Can anyone give me pointers or suggestions as to where to start
debugging this? Anyone else encountered this?


Thanks,

Dave.
