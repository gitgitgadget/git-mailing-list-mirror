From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: t3702-add-edit.sh failure in next
Date: Mon, 27 Apr 2009 16:12:15 +0100
Message-ID: <e2b179460904270812t3fa159f1ja3b06905d9effebe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 27 17:13:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LySW6-0006em-0q
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 17:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757565AbZD0PMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 11:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758738AbZD0PMT
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 11:12:19 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:26845 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758816AbZD0PMR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 11:12:17 -0400
Received: by ey-out-2122.google.com with SMTP id 9so577828eyd.37
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=CVwR03L9pu388/a2X7eor1rAn2EtxqGKJLjFKi5bXUU=;
        b=Uebop9/Q2TeNBq9E1tyk/d713gO/hODt94pxZ1mmEtibASNK2IAhme1hOUlwxxlBZD
         rVZYEAtqpY5ooqs4e0YGGFDKh58jYaIFaCrXby2n9IowEqhimhtNi4RrZmz+ft3NKW/K
         G2f8Gt6jWTYreavadhlTlV2FWBm+oiE1JOVqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=FQrePAEkjS0Bz5qS1CgF07SdQe7t3DAzDaSzgUrYsyEwDyRbaOlvNVT5HG/G/t5xdC
         Gw4/lPlYU4+pRNxwRK2cPkGuCoqn+ADNpmP94H7jmKrIUuI+e7ql48qlGKxwuZDCjScX
         MIkpSztotm6No4d511DYMHZlBv1JtXtCns4VY=
Received: by 10.216.13.75 with SMTP id a53mr534168wea.22.1240845135823; Mon, 
	27 Apr 2009 08:12:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117676>

I'm seeing a reproducible failure in t3702 on AIX 5.3, shell set to
bash (v2.05b)

The 'test_cmp orig-patch expected-patch' is seeing this diff:

2c2
< index b9834b5..52aff4c 100644
---
> index b9834b5..0b8f197 100644

The index seems to contain the expected content.

I've tried to eliminate GIT* environment variables which might be
affecting the commit id, and tried adding extra test_ticks, but I'm
afraid I can't work out what's up here.

Normally all tests pass fine with the exception of some skipped
because of known iconv issues on this platform.

Mike
