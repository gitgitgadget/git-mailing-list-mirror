From: Brian Foster <brian.foster@innova-card.com>
Subject: [Q] "status" of files in (a part of) the working tree
Date: Wed, 15 Oct 2008 09:53:42 +0200
Message-ID: <200810150953.42279.brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 09:54:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq1DZ-0003oB-Or
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 09:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbYJOHxl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Oct 2008 03:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbYJOHxl
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 03:53:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:53790 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbYJOHxk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 03:53:40 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1939046fgg.17
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 00:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        bh=UGnVFcA/yzE75ffNZSbK5cRjUYgwO/2yJRsAvhVJep0=;
        b=DFhP10ciMXutFaU+68a/atmM6V8cjdhtdactgSeYwKoJ9NyO+BrtlVBptYSDLLQEow
         Q4Fq3o9+QnOqqd48ZMqOisrHUimezPCQ2fHXKEGnlIMiEWoLijx/Y08gybCIfJVadFky
         CkwyOIYo2SXgASLZskwvtjZEE04EsqA0+hJC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        b=SsYwvm1+ZiCIpT2BxR2t0z+B2JjW/vGfp7nQEJgkvP0Md4/FvlvLsGe9yrP+ETJeuC
         0vSVKE2UNsNXGoyogAOC1rWIhYmrILxQCjr35vtXN9/dokowe+nCpMPmyZyKFTlNhEoz
         mlg0WNT8EEB4uNSz0cou7osoisolVOjXmxnd8=
Received: by 10.86.83.2 with SMTP id g2mr950137fgb.54.1224057219049;
        Wed, 15 Oct 2008 00:53:39 -0700 (PDT)
Received: from innova-card.com (1-61.252-81.static-ip.oleane.fr [81.252.61.1])
        by mx.google.com with ESMTPS id e20sm10409789fga.1.2008.10.15.00.53.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Oct 2008 00:53:36 -0700 (PDT)
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98255>


Hello,

 For every file in a directory of my working tree,
 I want to obtain a quick "status" summary (ideally,
 recursively, i.e. descending into each sub-directory):
 E.g., not-tracked, latest modification is not in
 the index, latest modification is in the index,
 not-modified, and so on.  As a hypothetical example
 (`# comments' added to explain what the line means):

    $ git some-cmd
    ? foo      # not-tracked
    - bar      # tracked, not-modified
    M xyzzy    # tracked, last modification not-in-index
    I plover   # tracked, last modification in-the-index
     ...
    $=20

 The `git ls-files' command sort-of seems to almost do
 what I want, but not exactly.  For instance (this is
 written by hand but based on actual results):

    $ git version
    git version 1.6.0.2
    $ git ls-files --exclude-standard --others --modified --cached -t
    ? foo
    H bar
    H xyzzy
    C xyzzy
    ...
    $=20

 However, note that some files are listed twice (which
 is confusing for my purposes), and I'm uncertain I've
 specified all the magic to see all non-excluded files
 regardless of their "status".  Obviously, once I know
 the appropriate set of magic I should be able to write
 a filter to process the output and remove the unwanted
 duplicates, but I'm wondering if someone has a better
 suggestion?  Generalissimo Goggle didn't find any clews.

cheers!
	-blf-

--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
