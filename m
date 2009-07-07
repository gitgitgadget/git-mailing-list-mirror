From: Tavian Barnes <tavianator@gmail.com>
Subject: "Ambiguous information for ref" error
Date: Mon, 6 Jul 2009 20:28:03 -0600
Message-ID: <add883140907061928v5d3277adyd18371d25affd8ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 04:28:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO0Q4-0005lt-P2
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 04:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461AbZGGC2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 22:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753356AbZGGC2V
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 22:28:21 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:33271 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027AbZGGC2U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 22:28:20 -0400
Received: by fxm18 with SMTP id 18so4574360fxm.37
        for <git@vger.kernel.org>; Mon, 06 Jul 2009 19:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=svvnXLn0KSdTOocK33m08NINYB+y5GyvCU3vFnE9gwI=;
        b=MAFMikiXOSQtCIyIZz6LXtrNA+sMmI6ulNf1N/jL4g1pbT4Sey5ZP05J92R/MaXRuM
         FH1PRnOHEY35HUlJb3KJ4WdBASdWU2mGmPsAsKGbqe13fm/LDytPf60BsPhZC4d9p+0R
         OpwMUfbUf7PkWkRyqxNvnIuog1NuzcUK0qbhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=Bli5i/G1VAbCJxClqm0DvNfUGgViZENU1w3TQk/vRg23YCznxudiF9Yc/RsoA7yevz
         ajO2OwReJLSGLCkNgNilsx2hCCFChABrBwl/OgybHDRM/bDmd9R+I8NNHmAeRtGD4C8+
         um4vgDYDE2uLTIX8rqYddHtwKPLwDj/yCrQDI=
Received: by 10.223.109.198 with SMTP id k6mr2407693fap.46.1246933703179; Mon, 
	06 Jul 2009 19:28:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122817>

So I'm trying to set up a bare repository with a branch that tracks a
remote ref that isn't the one I'm mirroring.  So, I run

git clone --mirror <origin> .
git remote add -f other <remote>
git branch --track other remotes/other/master

But I'm getting the error "error: Not tracking: ambiguous information
for ref refs/remotes/other/master".  Googling this error only gave the
place in the git source code where it is returned, which seems to
indicate that it happens when there is more than one tracking match
(tracking.matches > 1).  But I'm not sure exactly what that means.
Any advice would be appreciated.  Thanks!

-- 
Tavian Barnes
