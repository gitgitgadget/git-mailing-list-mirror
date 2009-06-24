From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 0/3] gitweb: gravatar support
Date: Wed, 24 Jun 2009 23:16:20 +0200
Message-ID: <1245878183-2967-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 23:16:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJZph-0000It-9Z
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 23:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbZFXVQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 17:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752147AbZFXVQ3
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 17:16:29 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:46512 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbZFXVQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 17:16:28 -0400
Received: by fxm9 with SMTP id 9so1056667fxm.37
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 14:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=MljB4TOe9GvSfS36x5vgiDpGHwFx7/wUPsZYS+Ohs2s=;
        b=POlBuvRY5zUfnUGrjn8Q0nsOXGTcmXNnWGEvuNf+1UOQDgjiEvC7aLtil3EwyEfu58
         p9AokyXxA993yQGZTMZm39K/jUh8qYYPG73au/WFsSnitt4Jga0M2KWa+WZU+zLJVcJ0
         2+c8FeSgzKECRKezyitaNKaWa4pIcwHlzlpRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ws4KejTqfXfdfEHKsMqOA/5KCxX9Rr3SrLYhQq7y4b3goqmd7+G/5h7N7PoQ2DPkAY
         gKUj8I4oIx6neBEo5l25WZlTrL0YdWhs8eD/rdPkTHENZgDOHrHwLFpXTmOIvGdQBbi5
         zcuqsjG8QcS/yFQTbhbyKQadY5AP12yK4eZt4=
Received: by 10.103.172.9 with SMTP id z9mr1059105muo.58.1245878189879;
        Wed, 24 Jun 2009 14:16:29 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-13-28.clienti.tiscali.it [94.37.13.28])
        by mx.google.com with ESMTPS id 12sm7486740muq.23.2009.06.24.14.16.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Jun 2009 14:16:29 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122157>

Fifth iteration of the implementation of gravatar support in gitweb.

Hopefully, this time I didn't forget any of the recommended suggestions.
It surely looks much more flexible and extensible to my eyes 8-). I also
found the time to implement the url cache for gravatar; I didn't benchmark
its effects, but it does feel faster when loading shortlog pages.

Giuseppe Bilotta (3):
  gitweb: refactor author name insertion
  gitweb: gravatar support
  gitweb: gravatar url cache

 gitweb/gitweb.css  |    9 +++-
 gitweb/gitweb.perl |  141 ++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 117 insertions(+), 33 deletions(-)
