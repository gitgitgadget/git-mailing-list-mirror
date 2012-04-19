From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC] Git to SVN bridge
Date: Thu, 19 Apr 2012 09:25:21 +0530
Message-ID: <CALkWK0=7SPR-4Km5TUwg+rHm30aC7Uru9GJkkfYnL3OORV7nfg@mail.gmail.com>
References: <CALkWK0=Mqo=PMv7+_sr22Dnm6xxzxzaXL=Zh+2LsvT=usC7csw@mail.gmail.com>
 <20120418201050.GB30625@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 05:55:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKiTF-0004g4-0X
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 05:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108Ab2DSDzn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Apr 2012 23:55:43 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34432 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020Ab2DSDzn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2012 23:55:43 -0400
Received: by wibhr17 with SMTP id hr17so1158289wib.1
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 20:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gS1RExf3Poa8A8wj0Q4FiAix8lXojV33M3z3ctexQ80=;
        b=JLaZwPMm3dnsmqKQ4uGtVj0XtCVPq8YkZnROe0sTwWIT8+eU4FhFpvS8X5a7MQhJiH
         Rbb0keR8qo9VwKGzAMVdNYHTW3ZbVueDimALM46GNlvRjZjgPwEMgtoqWhIPbz8Kr2bj
         OV22cNPGVqtRidJLy6Ze62wYELxel/u1SR620UiqbeAsyFZ1o6G6G4bL00M06yzboH60
         UJ3/MfymhMUBy9425KDgbC71fE1FHMrn+heYP+ZhXTRBwI7mx3BzxDK5Wlkx4EkqHXM1
         05ggfl8w50B4yibnfuc5Koc5SxkN0HQxpy7EAF2soXNFi0GSwJsb+2ZlsxZB0o+3n/uq
         NBEw==
Received: by 10.180.103.35 with SMTP id ft3mr1381600wib.0.1334807742036; Wed,
 18 Apr 2012 20:55:42 -0700 (PDT)
Received: by 10.216.53.136 with HTTP; Wed, 18 Apr 2012 20:55:21 -0700 (PDT)
In-Reply-To: <20120418201050.GB30625@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195920>

Hi Jonathan,

Jonathan Nieder wrote:
> For what it's worth, if you'd like to propose a plan for getting push
> support in the svn remote helper to work (what the architecture would
> be like, what milestones would be involved along the way, and so on),
> then I would be happy to help flesh it out. =C2=A0Even forgetting abo=
ut the
> summer of code and setting a good example, I imagine such design
> documents could be useful for developers and reviewers working on the
> project to avoid getting lost.

Sure.  Briefly:
Give 'vcs-svn/' the ability to spit out a Subversion dumpfile.  If you
remember, we hit a brick wall last time when we needed a way to
persist mark-referenced-blobs in the fast-import stream.  Once we get
svn-fi (the reverse of svn-fe) merged, the next step is in getting a
reverse-branch-mapper to work.  The mapper will have to sit between
the repository and svn-fi, because we can't really do much with the
history on the svn end.

    Ram
