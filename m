From: Vincent Legoll <vincent.legoll@gmail.com>
Subject: [BUG, RFC] git stash drop --help
Date: Wed, 20 May 2015 19:14:14 +0200
Message-ID: <CAEwRq=r=iMmnnzS2F_2rr9Tjem9khn1d=os3krjEjOg5iK5bww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 19:14:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv7ZV-0005cP-VA
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 19:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbbETROS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 13:14:18 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36711 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528AbbETROQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 May 2015 13:14:16 -0400
Received: by igbpi8 with SMTP id pi8so107967834igb.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 10:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=u1/Nb90mYPBwf4XrlBWz9OVnzhgpzvOcl3b+U8aYSco=;
        b=CyZgqBLSus8LI+MuX23BIGUjgdP8hpXrok/G+Pb6rreRGBU/wRz2YM7/uY+HTriyDs
         9SXms1GDMDT2daP1bk3h9bpAmvEmjM1EEcE/pDzPVdcdPAN4IJps+5RluF5aevLBKcUY
         4t9aumA14atkLgI47debYVS/e/29rljhoryAi2Qw0PHoJpYjpnby506B8jhWwL4AHItF
         8p/Pve4QzHIgZJjZGn/buoTFk0xs8xUN0ZRh850YkDeDeBuEqgENx9N6LEQmHomNBZ92
         1oSbDFMFgvUiCt2DRPnZA7/2JlWjVeEHzk/AVEpKl0Y0J8HQdoVV9adh1HZQqGSAGEoi
         z9Dw==
X-Received: by 10.42.81.6 with SMTP id x6mr428809ick.89.1432142055009; Wed, 20
 May 2015 10:14:15 -0700 (PDT)
Received: by 10.36.65.102 with HTTP; Wed, 20 May 2015 10:14:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269478>

Hello,

I stumbled upon something that annoyed me a bit, as I was working with

git stash to commit some big pile of modifications in small commits...

I wanted to get help wrt "git stash drop" and did it the following way =
:

[steps to reproduce]

mkdir tmp
cd tmp
git init
touch test.txt
git add test.txt
git commit -a -m "initial version"
echo zorglub > test.txt
git stash
git stash drop --help
refs/stash@{0} supprim=C3=A9 (ff100a8c2f1b7b00b9100b32d2a5dc19a8b0092a)

And that was definitely not what I intended. Fortunately for me I had a
backup of that stashed diff somewhere else, but I was still surprised,

because I was used to:

git $(SOMETHING) --help

to do what I want.

This is probably because "drop" is a subcommand of "stash",
as evidenced by:

git stash --help drop

working as intended (even if as as side effect of --help ignoring
further parameters)

--=20
Vincent Legoll
