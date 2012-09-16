From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Remove all files except a few files, using filter-branch
Date: Mon, 17 Sep 2012 01:28:31 +0900
Message-ID: <CAFT+Tg_ipyPgNQxx8XsXySzmA3YM3mKe1gB5GyTNqN++gdphnQ@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 18:29:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDHic-0002fX-W0
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 18:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521Ab2IPQ2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 12:28:32 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45378 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab2IPQ2b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 12:28:31 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so8126856obb.19
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=W3h4VC9UCdjegOOtnJjCFZaxGtLe8CH8Vpr+BU1HLrQ=;
        b=pWMxT24rAW3brsFL8NNw2g68QgUhQOinPq738vvv+ABoRehgrOOA4yxyf41FBGtpa9
         AwtMVF+gS4JQCRnVfk4c/ZOrczNN1Q3zciFRWw36bVj2IcKDYGxRaMGUWNejEYdmQp+p
         /nUubkalg5pEKQajvcWPLN27r/M8m6xI8MnbuAwMLvuNBNlio7SH4ZjjIq2s+CJA/u+k
         Cc4HNecaR9etTCbL6b8pZgftP21woN5KlD6qCRwv//GVB8lGVR78J35H0ugH53TXgm9U
         u0FWH5CO2l17xscbGAcc9Kz0YJzRYnSbmei7jywDCejv7U1w6sLptmXhCr1EJZwZyIFa
         AVTw==
Received: by 10.60.172.19 with SMTP id ay19mr9155853oec.68.1347812911282; Sun,
 16 Sep 2012 09:28:31 -0700 (PDT)
Received: by 10.182.41.97 with HTTP; Sun, 16 Sep 2012 09:28:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205631>

Hi, all.

I want to remove all files except a few files, in the history of my
git repository.

I tried to do that as follows:

    git filter-branch --index-filter "git rm --cached --ignore-unmatch
$(git ls-files | grep -v '^filename$' | tr '\n' ' ')"

But this does not work well if there is a file whose name is not
encoded in us-ascii or includes parenthesis. git-filter-branch is
great to remove some files in my repository, but not good enough to
remove all except only a few.

Does anyone know the better way?
