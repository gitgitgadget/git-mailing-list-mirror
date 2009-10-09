From: Eugene Sajine <euguess@gmail.com>
Subject: gitweb - bare repos integration - owner info in description file
Date: Fri, 9 Oct 2009 16:50:00 -0400
Message-ID: <76c5b8580910091350o5cd90d3dobe2a21c18fa56dfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 22:51:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwMRC-0006uo-Hf
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 22:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932883AbZJIUui convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 16:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761344AbZJIUui
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 16:50:38 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:36587 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761399AbZJIUuh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 16:50:37 -0400
Received: by ywh6 with SMTP id 6so6532250ywh.4
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 13:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=13AYMZFkCMQ9aJnBT/UU3Wf6khMzfTjm8cq0SzLO4sg=;
        b=bM5VyQVQBl90p50TaXSAGbvoSyjuA1kuBg2W6y2esfx00VfBNK10Kw/0t4UyG9aUMZ
         LbPqdpXMFBOAkX2ywqxJjgXWIegvsOHym7OeyUkRF3gYANEiNQnUYuqYFfh0+CcwjgLe
         mdXC4R6jjk3aiHb1KX5jMunMTRJHwBdsLHDXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=TI7sz1Q2ZjfdYqnvbDvZW/MVvYnk1oYk3+/czNlaysFrJOHP/dnZIii4GY51LMcFfO
         Ct6BEsmQ1Ov43Yrm/bKLZDfbABGKH89OqKdb+tMTR2HGu02J6WMMhqMTgQtdA8Ekby6t
         5xPlpqBlBBgmrhASYk1i3ZidtyBUu7VG3e7MI=
Received: by 10.90.42.27 with SMTP id p27mr1111463agp.9.1255121400682; Fri, 09 
	Oct 2009 13:50:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129841>

Hi,

Here is another issue with gitweb integration which i think might be
considered as a feature proposal:

I have a central place where bare repos are. They're owned by the user
under which we are serving them, let's say =E2=80=9Cgit=E2=80=9D. So, g=
itweb is going
to show me

Repo1 owner git etc=E2=80=A6

In order to show a real owner I have to rebuild gitweb.cgi, to tell it
to use the file for GITWEB_LIST and edit the file=E2=80=A6 In fact I th=
ink
gitweb shouldn=E2=80=99t carry this info, but bare repos should.

So my idea is:

Either provide a key to
$ git clone =E2=80=93bare =E2=80=93u =E2=80=9Cowner/email=E2=80=9D

or take the user.email parameter from .gitconfig.

in both cases the info can go to description file of bare repo, so it
can look like:

$owner=3Downer@server.com

$description=3D=E2=80=9Dvery long description=E2=80=9D

Or in xml form=E2=80=A6


Yes, description file might become a bit more complicated in its
layout. But, the benefits are obvious:

- No need to support multiple lists/files
- Bare repo carries all info about itself (together with =E2=80=93d fea=
ture I
described earlier).

I this circumstances gitweb=E2=80=99s GITWEB_LIST will be only filter (=
only
repo path is necessary to show/not show), and it seems that narrowed
functionality here is a good thing...

Your thoughts?

Thanks,
Eugene
