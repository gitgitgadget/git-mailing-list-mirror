From: Jens Brejner <jens@kaabrejner.dk>
Subject: How can I ignore insignificant change during merge ?
Date: Mon, 5 Oct 2015 22:13:00 +0200
Message-ID: <CA+aSyzqxjoUbGbPvLMNcrYyE3ZAqwGYiXtSrUgg8O29MZLJWrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 22:13:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjC8F-0001VJ-Sd
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbbJEUNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 16:13:05 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38506 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbbJEUNB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 16:13:01 -0400
Received: by igxx6 with SMTP id x6so65934830igx.1
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 13:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=2mIkvOMG6lyucqs8ER6gPK1I5A7RQNClejwY7T1UZH0=;
        b=Ly24ln7mtxqYDcjhs8Zv4lF3SFSSyAegekzdyRCZVeKBuMjC5nxCVhKZxmh3znqcyL
         0K6OmwKAmtQtoVDWXpzNnwujjw10PkO09aPMts30rATB+f6L2M4BdkGu3w8on8zPtuj3
         /+0J2NTv3RSw8V8Zf1Ywq9j0DMcuISPaQr/PfEtVeeJ8c6DS5JY1AQVWDnDySPe3kTa3
         szaygmb0W2nASOhGps3j5GD9kbXd0/2pm7cuHyCtf1wY13cdKYh6VDNoVN3lBKroGta2
         w3IRrUvZ3M9o9dOaaP1Rhafg48sO0uxQ2qW7RRZrXIZ+9R9B6z3BRpbQ4VNH/VJEtO5W
         ouZA==
X-Gm-Message-State: ALoCoQm8spZcfRSwZ+N3lFS3JdAZDhAdK5nl2jdrOwMNDuJgwJ6UPiqDcNdeL9DH2/Eitd4dsEwj
X-Received: by 10.50.83.65 with SMTP id o1mr11265362igy.50.1444075980818; Mon,
 05 Oct 2015 13:13:00 -0700 (PDT)
Received: by 10.50.250.180 with HTTP; Mon, 5 Oct 2015 13:13:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279074>

I need to merge a branch, +100k changes. The vast majority of changes
are insignificant, because they only represent a screen position in
the editor, so these changes should never have been in git - but but
MadCap Flare already put them there.

The files in question are xml, and the difference can be exemplifed like this:

Original (when branches were created):
html xmlns:MadCap="http://www.madcapsoftware.com/Schemas/MadCap.xsd"
MadCap:lastBlockDepth="5" MadCap:lastHeight="32"
MadCap:lastWidth="400"
Branch1:
html xmlns:MadCap="http://www.madcapsoftware.com/Schemas/MadCap.xsd"
MadCap:lastBlockDepth="5" MadCap:lastHeight="24"
MadCap:lastWidth="500"
Branch2:
html xmlns:MadCap="http://www.madcapsoftware.com/Schemas/MadCap.xsd"
MadCap:lastBlockDepth="5" MadCap:lastHeight="41"
MadCap:lastWidth="300"

How can git help me so files where the only difference matches
something like this regex:
/html xmlns:.* MadCap:lastHeight="\d+" MadCap:lastWidth="\d+"/

for the files that qualify, I want git to ignore the change, and
therefore the merge-conflict, and then just accept "my" file for the
merged changeset.

Any suggestions on how to I can have git help me with that ?

Best regards
Jens Brejner
