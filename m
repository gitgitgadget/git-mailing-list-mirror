From: k0001 <gnuk0001@gmail.com>
Subject: [BUG] --pretty=format does not work ok with rev-list
Date: Sat, 12 Apr 2008 17:40:25 -0300
Message-ID: <1208032825.30817.15.camel@k0001>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 22:41:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkmXV-0004RV-TF
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 22:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbYDLUkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 16:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbYDLUkq
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 16:40:46 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:18780 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbYDLUkp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 16:40:45 -0400
Received: by yw-out-2324.google.com with SMTP id 5so410062ywb.1
        for <git@vger.kernel.org>; Sat, 12 Apr 2008 13:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=7D6B63q2wKQbsChMlsIWKg/qw5HmoiwbGtS7e9z7Y8A=;
        b=QpqJdS7UhS+N6gnLepEo4lkGaHIWMmzQvz1WsTfv8YTizQoiFXDdehHgK43DKWUuVqChp+QigtDrCZCbU+GVZm4pp1CeafyR857yu0bPUCOmJMCvfr4QJSZbm+pZ6l09MJrFm6bX0TXX5T/rIQYrx2blEZVBp3/AaICiCTsa3H8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=VgmGu/LodOFq3xQSWLW7KYXJWdMXYrAQVvBJw4hu3BZ3lVjJW9tlxzJoVeXR7kiNq0lQK98dtGWgJLbXPpTq1Oid4sguTeAeaHgxhwdJLHSeWFtJJdu5EpLhufO34aTL/DJ32BeKwaO3faNDHo7g6w5MxE5ON6HOmpUprzmsZoc=
Received: by 10.150.12.5 with SMTP id 5mr4760847ybl.39.1208032835534;
        Sat, 12 Apr 2008 13:40:35 -0700 (PDT)
Received: from ?192.168.0.14? ( [190.31.231.197])
        by mx.google.com with ESMTPS id 8sm7635177ywg.8.2008.04.12.13.40.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Apr 2008 13:40:34 -0700 (PDT)
X-Mailer: Evolution 2.12.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79382>

Hello list, my name is Renzo Carbonara and I'm new here in the git
neighborhood.


Now back to business, when using --pretty=format:some_format with git
rev-list, an additional non-requested line is printed before every
commit ("commit <sha1_id>"). Example:

git rev-list output (BAD):

k@k0001 ~/linux-2.6 $ git rev-list -2 --pretty=format:"%H: %cn" master
commit f4be31ec9690cfe6e94fcbed6ae60a6a38b3c3ed
f4be31ec9690cfe6e94fcbed6ae60a6a38b3c3ed: Linus Torvalds
commit 44cad261025c04327fd7e847a7088fd3031b0c3e
44cad261025c04327fd7e847a7088fd3031b0c3e: Linus Torvalds


git log output (GOOD):

k@k0001 ~/linux-2.6 $ git log -2 --pretty=format:"%H: %cn" master
f4be31ec9690cfe6e94fcbed6ae60a6a38b3c3ed: Linus Torvalds
44cad261025c04327fd7e847a7088fd3031b0c3e: Linus Torvalds



this was tested with versions:
 - 1.5.3.7
 - 4cdda2b895dfb6ba084e3952cbf4274a6a2e0338


Cheers,

Renzo Carbonara
