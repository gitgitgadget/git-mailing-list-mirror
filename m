From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/7] guilt patches, including git 1.8 support
Date: Tue, 15 Jan 2013 18:26:06 -0800
Message-ID: <20130116022606.GI12524@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>,
	Theodore Ts'o <tytso@mit.edu>, Iulian Udrea <iulian@linux.com>,
	Axel Beckert <abe@deuxchevaux.org>
To: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:26:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvIhz-0006Nl-Ub
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 03:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757423Ab3APC0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 21:26:12 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:32975 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756779Ab3APC0L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 21:26:11 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so329147dak.34
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 18:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=6ZYfNxjL+ghfe9RNQNaPSFCjvIILZOUHeYAyKIPdJQ0=;
        b=hVtgU1grUSBSKd4yXHi6KEnTN+2NzaK/6fSUainlGsgKVQfP/kUdQYWMm10kLr1tOe
         RBAXFE12eW/iw2JHM2ZpcMuxxF63lQ2STARVX+/il1B2tfubHFoSurhwWYVPRXmP4a9p
         UMt8GAtjdzA8V4ZXBhGQiUYRIA0b2PXl/MVzmDXGdU6NO9t/x1SH88366OYQolsEWtwM
         tvT34+LdU8uovWcIWQWKUvqKklSJ/rnMUC9eUE9kH2908sN9iuq9/DMs/b162SPOeRuL
         OKzo+Rbr3ir0l6qhl8zc0+dhZGQuIB3cUs6qVs3ws/ANBZUhBhs3uU/Mx08yE2YVAx1H
         QGjA==
X-Received: by 10.68.245.67 with SMTP id xm3mr269918984pbc.152.1358303170507;
        Tue, 15 Jan 2013 18:26:10 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id rk6sm11288917pbc.20.2013.01.15.18.26.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 18:26:09 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213708>

Hi Jeff and other guilty parties,

I collected all the guilt patches I could find on-list and added one
of my own.  Completely untested, except for running the regression
tests.  These are also available via git protocol from

  git://repo.or.cz/guilt/mob.git mob

Thoughts?

Jonathan Nieder (1):
  Drop unneeded git version check.

Per Cederqvist (6):
  get rid of "cat: write error: Broken pipe" error message
  The tests should not fail if log.date or log.decorate are set.
  Testsuite: get rid of "Broken pipe" errors from yes.
  Handle empty patches and patches with only a header.
  Fix fatal "guilt graph" error in sha1sum invocation.
  Change git branch when patches are applied.

 Documentation/guilt.7 |   4 +
 guilt                 |  73 +++++---
 guilt-branch          |  12 +-
 guilt-commit          |   7 +
 guilt-import-commit   |   4 +-
 guilt-repair          |   7 +-
 os.Darwin             |   7 +-
 os.Linux              |   7 +-
 os.SunOS              |   7 +-
 regression/scaffold   |   7 +-
 regression/t-029.sh   |   6 +-
 regression/t-052.out  |  24 +--
 regression/t-052.sh   |   7 +-
 regression/t-061.out  | 468 ++++++++++++++++++++++++++++++++++++++++++++++++++
 regression/t-061.sh   | 148 ++++++++++++++++
 15 files changed, 743 insertions(+), 45 deletions(-)
 create mode 100644 regression/t-061.out
 create mode 100755 regression/t-061.sh
