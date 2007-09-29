From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Big performance regression with --no-color option in git-log
Date: Sat, 29 Sep 2007 12:02:23 +0200
Message-ID: <e5bfff550709290302h6016c6e8mf9d5dfddce07d985@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 12:02:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbZ9c-0001zt-IM
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 12:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755802AbXI2KC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 06:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755763AbXI2KC0
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 06:02:26 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:8311 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428AbXI2KCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 06:02:25 -0400
Received: by py-out-1112.google.com with SMTP id u77so5789238pyb
        for <git@vger.kernel.org>; Sat, 29 Sep 2007 03:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=C+SdO7gDfApqx17/ZlYwDUMUgQZlcveGgdqIpdaFhu4=;
        b=YfQhWvJcXTK060FO+iO4NkDr4MwRR+R/Z4nxvFX26JtR/BlSphNwDEbHeP1Vci7Bcnd+ylsBoSsxz7OGAgWqp1hEiVgpQvX/ubiNUs9J8kDw6xV++BnBfEvLfxvBrYTXq3FHc9hDAeyQvkG8U/5a44RUE9LBXPk+BQIMoosuwjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tMzdm4aUhZ5gWrFNYbT0Dde3Xgb2Rb5WqACUihDZp1cn2B84Ru3CKOGtyfkeVunL/pAVssm9GWwBmfGj2HytKSdsB9X18kVlSkmHtczEAZyilxmLI1hPsBW/oduhABTAzbURN9hp3Mb+c9p/ztbtKytIBWQK5YspySkv8+koS28=
Received: by 10.65.155.19 with SMTP id h19mr9773790qbo.1191060143975;
        Sat, 29 Sep 2007 03:02:23 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Sat, 29 Sep 2007 03:02:23 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59456>

On today git tree

bash-3.1$ time git log HEAD > /dev/null
1.31user 0.07system 0:01.39elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+2455minor)pagefaults 0swaps

bash-3.1$ time git log --no-color HEAD > /dev/null
5.01user 0.11system 0:05.16elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+6319minor)pagefaults 0swaps

bash-3.1$ git --version
git version 1.5.3.2.124.g648db


Marco
