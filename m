From: Dun Peal <dunpealer@gmail.com>
Subject: Implementation bug with cherry-picking multiple commits
Date: Fri, 1 Oct 2010 11:16:27 -0500
Message-ID: <AANLkTimhwomGnmCEAyPaGj=fST8zkMO1sTyJ2dxRzWMW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 01 18:16:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1iHi-0006Zi-Er
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 18:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284Ab0JAQQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 12:16:29 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35577 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab0JAQQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 12:16:29 -0400
Received: by wyb28 with SMTP id 28so3080739wyb.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=snHCTMIoy0UHtzPMx4cxd/xOQlIX/haQZ3ssUrBcvpg=;
        b=XiBjv7N49Du+CTnQFIYHuMmarlpeug2vyXs2f1MKZBpK8hF8MWeqQuxMV+F25ovuy3
         KCkakqRcu4ZC3hH80tzOOTUax69v7h6RJYTG2BuTIYyBA3ib8j6OHTXAAT7RsoXayzGi
         Y2vNvRfcz6HeqfyUBl7d5aEVYzsSVPrp0wQ1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=l0twaPCQVsDCOK4I9YUhNttVVSHHnZMHniXP9SNlZhc52Jm4sdEcA8O6r9T5tz39AN
         0fvsFZBwFc6M5vgh/oIe7oU4qNugtoVDhtXXc7nX/eeXOoO5vlzAEoO/Mh3B9VwK9sgF
         kwnxxUDuP0S1lakMWVawIeypxWoA6BNDXD2+s=
Received: by 10.227.72.139 with SMTP id m11mr5156782wbj.30.1285949787877; Fri,
 01 Oct 2010 09:16:27 -0700 (PDT)
Received: by 10.220.182.136 with HTTP; Fri, 1 Oct 2010 09:16:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157759>

I tried using the new feature allowing the cherry-picking of multiple
commits at the same time:

  $ git cherry-pick foo~100...foo

I got an error that indicates a potential implementation bug:

  error: cannot fork() for commit: Cannot allocate memory

This is a powerful CentOS server with almost 8GB of free RAM at the
cherry-pick operation runtime.

Thanks, D
