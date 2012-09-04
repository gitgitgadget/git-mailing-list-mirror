From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: checkout extra files
Date: Tue, 4 Sep 2012 21:29:46 +0200
Message-ID: <CAB9Jk9DVcG14mS3HaGE4JEY0AwExvjqrnQqzTEZxHLjEQ6UObg@mail.gmail.com>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
	<CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
	<7vsjayew50.fsf@alter.siamese.dyndns.org>
	<CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
	<7vd322ebsz.fsf@alter.siamese.dyndns.org>
	<CACsJy8C36eghwEOYqbnd2z5C5KnynWsvwMDa4e2hns3uW243EQ@mail.gmail.com>
	<CAB9Jk9CNYr6LfWvyVqXvHjh7dzhUAuzkufqO9YMeOXg08D2cJw@mail.gmail.com>
	<CACsJy8AUYigHVKjzE-0NT0hnOrQWdufN+COmkk=2Q8L1Rimytw@mail.gmail.com>
	<CAB9Jk9D0DHBJEpVq=Z=12TV=+Av0oFVZ0yO1svLh1wyuP+9r1Q@mail.gmail.com>
	<7v4nndd98g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 21:36:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8yv5-0006wE-OA
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 21:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757069Ab2IDTgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 15:36:12 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:39794 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099Ab2IDTgL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 15:36:11 -0400
Received: by ghrr11 with SMTP id r11so1405764ghr.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2012 12:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=H673rh86S/6GyYzddTcINGtOIioK8D0oS2bRTUS4HMg=;
        b=geF7vsqldvHGpEun0qEJdP3DPFFMYweUufy2iOhcvU8Z8uYyA1nA3lrGbt3toioKWo
         oWqwIPQbZyxIYKkubK1O2m7AFTFxDwRMJj6WCPkNbNAGm6MrCfz7shdpt1d5hep8I2pC
         kecGEoq06+ZXJQQLePiZGCOZYNR6ArW3kntnH5fZx69pNMvwAQYp6mbOrDexnJA7Y+4M
         3h6vIP/u0pnMcUsaMT8NkZ4MLqzTNoxNudrKdWGdEZjYZg3oQkXI9TuP5cKSl2xXJQEc
         y4cardyP876iVqnuUFkz1Jtrry6prBSsObvjL75HM9vzkAAczcvH2Kt6P7IWTFkXS+uW
         ZypA==
Received: by 10.52.36.76 with SMTP id o12mr13843584vdj.40.1346786986314; Tue,
 04 Sep 2012 12:29:46 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Tue, 4 Sep 2012 12:29:46 -0700 (PDT)
In-Reply-To: <7v4nndd98g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204779>

Hi,

figuring out what the behavior is by guessing how a command is implemented and
what are its interactions with the shell is a bit hard for the user:
s/he should instead
get it from the documentation.
I tried to figure it out from the examples I have done, and as you
see, I did not get it
quite right.

The issue here is that the paths must denote filenames that are
present in the index
or tree-ish, so, wildcards are misleading since they would instead be
interpreted
with respect to the working directory.
A possible way to make this clear is to warn the user to quote paths
that contain
wildcards. Something like, e.g.:

  "Note that <paths> that contain wildcards must be quoted in order to
denote files that
   belong to the index or <tree-ish>. Otherwise, they are interpreted
by the shell with
   respect to the current directory, with a result that may depend on
the shell."

-Angelo
