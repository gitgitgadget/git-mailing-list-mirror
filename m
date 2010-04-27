From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 0/2] gitweb: Syntax highlighting support
Date: Tue, 27 Apr 2010 21:34:43 +0200
Message-ID: <1272396885-30609-1-git-send-email-jnareb@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 21:35:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6qZF-0003lB-Jg
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 21:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756708Ab0D0TfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 15:35:08 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62093 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756694Ab0D0TfE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 15:35:04 -0400
Received: by pvg2 with SMTP id 2so1650172pvg.19
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 12:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=s7vPTnUl5Ha+v8ZC3wb0ZoxovT85YTW7SSc/TV1sH88=;
        b=XPzQkZxbsfYsnX3DXPtJ2cnV17iE0eaKpJOuDXnou6je/bKO5Zpfh8dV0TGpxd3Sb6
         RWFprg+gKxIWIT7ENcL6jOx5NzEgL3eDY4K6vTG8QPZeKW3/sXP1DA8bdCm1kkEtWgao
         UxzIb9Ois1z9m05S5eiNVKljzBZUiYZqe4oVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BcUZw2/CGZQatNRRrVVuM4/Kkv9QYmoJv/mHG7EOnjpCtEi69gTq0QNvCJV9Y7Qc9k
         BaekHFzX2LADCohMwuFAuu+qa74GUdwxDsfjtg1zVmOMPnhQ5/i2BAxxCprTLmUV4Wu/
         ck3QF+TJaCpcq2fCBhP7fCZ63k4IBCz+IIiNw=
Received: by 10.143.153.23 with SMTP id f23mr3272438wfo.64.1272396903687;
        Tue, 27 Apr 2010 12:35:03 -0700 (PDT)
Received: from localhost.localdomain ([72.14.241.6])
        by mx.google.com with ESMTPS id s21sm832756wff.0.2010.04.27.12.34.59
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Apr 2010 12:35:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145935>

This series of patches is based originally on on Daniel Svensson's and
Sham Chukoury's work in gitweb-xmms2.git

Currently only 'highlight' standalone syntax highlighter from
http://www.andre-simon.de/ is supported.  Second patch in the series
reorganizes syntax highlighting code to make it easier to add (in the
future) support for other syntax highlighters, like source-highlight from
http://www.gnu.org/software/src-highlite, or some syntax higlighting Perl
module from CPAN like Text::Highlight or Syntax::Highlight::* modules.
Unfortunately the name of syntax to be used as parameter to syntax
highlighter (syntax highlighting engine) depends on highlighter, which would
complicate code a bit.

The list of currently supported file types do not cover all types that
'highlight' supports, but it is selected a bit, with syntax highlight for
git.git taking precedence.

Table of contents:
~~~~~~~~~~~~~~~~~~
 [PATCH 1/2] gitweb: Syntax highlighting support
 [PATCH 2/2] gitweb: Refactor syntax highlighting support

Shortlog:
~~~~~~~~~
Jakub Narebski (1):
  gitweb: Refactor syntax highlighting support

Johannes Schindelin (1):
  gitweb: Syntax highlighting support

Diffstat:
~~~~~~~~~
 gitweb/gitweb.css                      |   18 +++++++
 gitweb/gitweb.perl                     |   79 ++++++++++++++++++++++++++++++-
 t/t9500-gitweb-standalone-no-errors.sh |   29 ++++++++++++
 3 files changed, 123 insertions(+), 3 deletions(-)

-- 
Jakub Narebski
