From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Getting pickaxe to perform looser matches, or regex matching
Date: Thu, 7 Jun 2012 12:43:14 -0400
Message-ID: <CACPiFCKyhZPQR+e27Ah5THiPPJy3akajGN5xMwBumP-Wj6JrKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 18:43:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScfoH-0004ss-6i
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 18:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759664Ab2FGQnh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 12:43:37 -0400
Received: from mail-vb0-f52.google.com ([209.85.212.52]:53913 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759355Ab2FGQnf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 12:43:35 -0400
Received: by vbzb23 with SMTP id b23so496640vbz.11
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=2gPy3JRBlow/ZFyZCuLrq/DEgMO8KycxvwkrHD8pnPE=;
        b=fLTN9QwRMnSkeG0TthzQ7NNfr777wVhDCChVYRoHOpKbayTm8ao71t5veFfez6MTZj
         4aMFODBvSQXCywB5KJqbPf7CbDSrS5I6FIg+fHVspAq1oNP9D4qeUCvAme8VHmquihnf
         5UuRE7zwg0s0+289LmazLyA2RlqUp6F5+TUQy/eWUCisBxlbOQ84ecSh0p+AHHZ9TX3d
         5IJRdYjBJzCN8RZFjz19KYb9cl+kUYzKoUNZyxHs+QPjrspwD96BxJccLBj7ZBa6IJU3
         WwcRIvnXiuFnQepfUZBhw9ctdIVWsHI7aNnn2JDpSXm5tkJwQh+oojNI9DzJca8eXI0r
         3XTQ==
Received: by 10.52.69.237 with SMTP id h13mr2394459vdu.82.1339087414656; Thu,
 07 Jun 2012 09:43:34 -0700 (PDT)
Received: by 10.52.162.34 with HTTP; Thu, 7 Jun 2012 09:43:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199416>

I am a regular user of gitk's nice pickaxe search field. But it will of=
ten
fail to find what I am looking for because the part of the string I can
provide is not the part that changes.

=46or example, I am looking for patches that change any calls to functi=
on
foo(). I want to match on

- foo(1, 0, 1024)
+ foo(0, 1024, 1)

but I don't know the parameters. As the "pickaxe" sections in gitdiffco=
re
and git log manpages indicate, it won't match on -S'foo' because foo it=
self
was not added or removed.

A regex like "foo(.*" would work, but pickaxe doesn't seem to take
regexes, and while I could roll my own wrapper around git-log --patch,
this sounds like an important and useful variant to pickaxe that is
missing.

Or that has a hidden switch I haven't found ;-)



m
--
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
