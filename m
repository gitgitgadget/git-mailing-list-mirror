From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: filter-branch --env-filter GIT_AUTHOR_DATE
Date: Tue, 18 Jan 2011 17:43:40 +0100
Message-ID: <AANLkTinx7cs6YTvSTTv-njHA+vk264u1EaJettSdBF9U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 18 17:44:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfEfS-0006Fz-FA
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 17:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530Ab1ARQoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 11:44:21 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37539 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867Ab1ARQoU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 11:44:20 -0500
Received: by pwj3 with SMTP id 3so1089660pwj.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 08:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=dTkerEt1ysIUjTOH1Wwobhqu2zlBPvK/FF521V2lMpo=;
        b=mWa2i13/OE/7B2fUep2dWh71YFkJcb/Fz95KpIjVNW+mQmSWBImdXnfk45T8F0uMKf
         4oYwYmJP+PPsPFZ6gOXoLYDwPPDI4HNPbhxiT+bxvutGGto1qDkSFgYi0MOtlO4/czsz
         CuQVzCMf9L/YprrUMT617MK9C76PYoH3Hquq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=JoQaZv9BOVPVyLIR47pRZyiz0oAHtg2bSO8XuKmAFhle8D4Kx5URnnB0b2GYcbCFia
         QCs04rZlfaF893WnnK4UJs03QvydC3E364yJlLGOTihZHR1Be/t1AlO9tLZYDfuRPcZ+
         C70asQ0lOrSsL4NHo3+Z50BhxULB7lTuTe1fE=
Received: by 10.142.226.2 with SMTP id y2mr5355000wfg.136.1295369060371; Tue,
 18 Jan 2011 08:44:20 -0800 (PST)
Received: by 10.142.76.11 with HTTP; Tue, 18 Jan 2011 08:43:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165206>

To fix invalid timezone info in a repo I ran
git filter-branch --env-filter '
  GIT_AUTHOR_DATE=`echo ${GIT_AUTHOR_DATE}|sed s/+0000/-0800/`' HEAD

This fixed the invalid entries but the new timezone is -0700
instead of -0800. Is this expected?

git version 1.7.4.rc2
