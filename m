From: Kevin Locke <kevin@kevinlocke.name>
Subject: git stash pop --quiet is not always quiet after save -u
Date: Wed, 3 Feb 2016 23:55:32 -0800
Message-ID: <20160204075532.GB25382@kevinolos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 08:55:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRElP-0006EE-Md
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 08:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbcBDHzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 02:55:36 -0500
Received: from praxis.kevinlocke.name ([205.185.125.39]:45924 "EHLO
	praxis.kevinlocke.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbcBDHzf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 02:55:35 -0500
Received: from kevinolos (c-76-121-137-209.hsd1.wa.comcast.net [76.121.137.209])
	(Authenticated sender: kevin@kevinlocke.name)
	by praxis.kevinlocke.name (Postfix) with ESMTPSA id 4E0D73120442
	for <git@vger.kernel.org>; Thu,  4 Feb 2016 00:55:34 -0700 (MST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=kevinlocke.name;
	s=praxis; t=1454572535;
	bh=n2ROsYOTnAhGbrJKJaR+sbWuUuN8Rn+FAKOeSOK4A+o=;
	h=Date:From:To:Subject:From;
	b=TLbbK7IFu9Hwb+Zf+pIaPrIRGkw3rxmI9/NdP9aOJBxBd6umkVH/CsE8sPV0JLpb5
	 kMSB2ireqptgld7gpEYNewpfxRy1OTsi744jgTkjyDINCjqfQAvu4cUhPYT+1ZhgCW
	 bVxz2RpBCvSt4SIS6yq35JsJTvVhALKUUZ8ezXWo=
Received: by kevinolos (Postfix, from userid 1000)
	id BFDD94B0E48; Wed,  3 Feb 2016 23:55:32 -0800 (PST)
Mail-Followup-To: Kevin Locke <kevin@kevinlocke.name>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285406>

Using git 2.7.0 or master (563e3849) apply/pop prints
"Already up-to-date!" if the stash contains only untracked files.  As
an example:

git init
git commit --allow-empty -m init
touch test.txt
git stash -u

Now that the stash contains only untracked files, applying it with
either pop or apply produces the following output:

$ git stash pop --quiet
Already up-to-date!

It's obviously a minor issue, but can be an annoyance for scripting
tasks.

Thanks for considering,
Kevin

P.S.  Please CC me on replies.  Thanks!
