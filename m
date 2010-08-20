From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 00/17] unexpected backslashes in man pages
Date: Fri, 20 Aug 2010 05:19:02 -0500
Message-ID: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 12:20:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmOiT-0006Me-Fz
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753Ab0HTKUs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 06:20:48 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43750 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab0HTKUr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 06:20:47 -0400
Received: by gwj17 with SMTP id 17so1155786gwj.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=tkO91t3wSYDQpUqZaWsUXv70iv8fYYSu9+JRdMsiR5w=;
        b=AwzSUEI3e4wys0tfPxven9M1wmtuLSHH/aZUsMeMzB7Yl9asBXWESKmUTYmjq+1gbZ
         psf9s9/mPyuMgNHWTSNGDk1t8Z9+cJjZvlfMV2gQuPnvYRwK/9faoI+uIXsNeHfFDJg6
         /oa3tzqCGfX8EfyRYnkfzmWRfiQHpPTsoGZt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=vettKkcjn55ztID5jvQ8XINi53cVwoHMVkVOGjzDolud3kEtkhUO8WLctrHD+e2+9c
         YLK5xjDBVAmBytxrYjf8hKcqXBJ/wDRpRqfTztFjMQPTebuUR1GgF8pG9tu3haUUH9s4
         Rqa37iQbOirtNzamfBR4wb705MGoyZf7FJNS4=
Received: by 10.150.69.20 with SMTP id r20mr1362606yba.304.1282299646617;
        Fri, 20 Aug 2010 03:20:46 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n20sm2484893ibe.17.2010.08.20.03.20.45
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:20:46 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153995>

(cc: interested parties and documentation experts)

Hi,

This series is longer than I would like, and I am not happy to
impose the review burden.  So if something does not look obviously
correct at a glance, please let me know and I'll try to simplify it.

The topic: as Fr=C3=A9d=C3=A9ric Bri=C3=A8re noticed in
<http://bugs.debian.org/540001>, various man pages have collected
backslashes where they don't belong.

Maybe we should forbid backslashes outside of

--------
literal
--------

sections.  Well, I did not go that far.

Still, maybe the patches can be useful.

Jonathan Nieder (17):
  Documentation: tweak description of log.date
  Documentation: quoting trouble in "git rm" discussion
  Documentation: unbreak regex in show-ref --exclude-existing
    description
  Documentation: clarify quoting in "git add" example
  Documentation: add missing quotes to "git grep" examples
  Documentation: clarify quoting in "git rm" example
  Documentation: clarify quoting in gitignore docs
  Documentation: remove backslashes in manpage synopses
  Documentation/technical: avoid stray backslash in parse-options API
    docs
  Documentation: remove stray backslash from "git bundle" manual
  Documentation: remove backslash before ~ in fast-import manual
  Documentation: remove stray backslashes in rev-parse manual
  Documentation: remove stray backslash in show-branch discussion
  Documentation: avoid stray backslashes in core tutorial
  Documentation: avoid stray backslash in user manual
  Documentation: do not convert ... operator to ellipses
  Documentation: remove stray backslashes from "Fighting regressions"
    article

 Documentation/asciidoc.conf                   |    2 ++
 Documentation/config.txt                      |    9 +++++----
 Documentation/git-add.txt                     |    4 ++--
 Documentation/git-bisect-lk2009.txt           |    2 +-
 Documentation/git-bundle.txt                  |    8 ++++----
 Documentation/git-checkout-index.txt          |    2 +-
 Documentation/git-checkout.txt                |    2 +-
 Documentation/git-commit-tree.txt             |    2 +-
 Documentation/git-fast-export.txt             |    2 +-
 Documentation/git-for-each-ref.txt            |    2 +-
 Documentation/git-grep.txt                    |    4 ++--
 Documentation/git-ls-files.txt                |    6 +++---
 Documentation/git-merge-index.txt             |    2 +-
 Documentation/git-push.txt                    |    2 +-
 Documentation/git-rebase.txt                  |    2 +-
 Documentation/git-relink.txt                  |    2 +-
 Documentation/git-rev-parse.txt               |    9 +++++----
 Documentation/git-rm.txt                      |    9 +++++----
 Documentation/git-show-branch.txt             |    2 +-
 Documentation/git-show-ref.txt                |    4 ++--
 Documentation/git-update-index.txt            |    4 ++--
 Documentation/gitcore-tutorial.txt            |   18 +++++++++--------=
-
 Documentation/gitignore.txt                   |    4 ++--
 Documentation/rev-list-options.txt            |    2 +-
 Documentation/technical/api-parse-options.txt |    8 ++++----
 Documentation/user-manual.txt                 |    4 ++--
 26 files changed, 61 insertions(+), 56 deletions(-)

--=20
1.7.2.2.536.g42dab.dirty
