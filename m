From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: git bisect start on a tag revision fails
Date: Sun, 10 Feb 2008 11:01:33 +0000
Message-ID: <3f4fd2640802100301y436bda41kcca1b1eb8ec0ea10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 12:02:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO9x1-0004dd-L0
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 12:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756660AbYBJLBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 06:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756641AbYBJLBg
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 06:01:36 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:1810 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756638AbYBJLBf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 06:01:35 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3047197rvb.1
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 03:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=W+BQc5wUshj9m0DqSs4t+fCvI/brVzqSgMcLNyKWyB0=;
        b=nSWRWV6utjOmFK8pmCqu0YnOTHUngKnCN6MbMmn0KdT5qX6FH7zqnrGOodYBFEjO9rIV5H/VhTMQFsq41nzbh93cvU8nJgguOUXR+74DEibfaI+im1y9PHbOXwryzxnifWEHr7Di2wHf9QeSu37caADLxkFMvX52DPX+aPRncdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gRCvFKnkFfhcFPLUhJYvafM7hE3dmyu2wcOc5mZ3BbWfdNH0UhiEksObF/v+qO3DAlc+nrLBsQIRMt4XJRhqTBbFgvoLqmX1zBPPsznY1QvWN5AXFxtz3pr07ZlX/5Fe4Uabj+/WemJ1Yf6elI1hEx5bYr90wBYTerVPfA93xcA=
Received: by 10.140.134.15 with SMTP id h15mr9837403rvd.51.1202641293624;
        Sun, 10 Feb 2008 03:01:33 -0800 (PST)
Received: by 10.141.23.10 with HTTP; Sun, 10 Feb 2008 03:01:33 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73336>

Hi,

When hunting bugs with the wine source code
(git://source.winehq.org/git/wine.git), both Dan Kegel and I have
found the following berhaviour with git bisect:

$ git checkout wine-0.9.54
HEAD is now at 8f954cc... Release 0.9.54.
$ git bisect start
fatal: ref HEAD is not a symbolic ref
Bad HEAD - I need a symbolic ref

Whereas doing:

$ git checkout master
$ git bisect start

then:

$ git checkout wine-0.9.54
$ git bisect good

works.

Is it possible to have bisect support non-symbolic refs?

- Reece
