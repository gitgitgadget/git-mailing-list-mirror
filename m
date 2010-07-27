From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/3] archive: abbreviate substituted commit ids again
Date: Tue, 27 Jul 2010 13:29:42 -0500
Message-ID: <20100727182942.GB5578@burratino>
References: <19531.65276.394443.190317@winooski.ccs.neu.edu>
 <20100725130935.GA22083@LK-Perkele-V2.elisa-laajakaista.fi>
 <20100725221539.GA21813@burratino>
 <7vbp9uaii2.fsf@alter.siamese.dyndns.org>
 <20100726190448.GA32367@burratino>
 <7vzkxc7rpn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org,
	Will Palmer <wmpalmer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 20:30:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odovb-0001pr-G3
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 20:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299Ab0G0Saz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 14:30:55 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43387 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575Ab0G0Say (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 14:30:54 -0400
Received: by ewy23 with SMTP id 23so1422174ewy.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=gL8LMYqJKLHjlYwMv9DUMZTKvvEG9QhNxYqaA/tFpzc=;
        b=hVF3Bh1f4yXRjFLFGaXr6fXbeLUdBcLxn7/uinDpGEzkekX7HH+Uwv18/T7wYkUCLP
         Q7OYkKsFE3Oy+tIT/uG1iv4h0lv/J7WyrWJweW5x2y7dErNOJRLLE8Fi0p5faZ2zBeRo
         hJQlDgtvWZO+qi8zRhuj3AVn30VWpawU+IvJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=IYzcytX6oUsE360UkzN3rOFO4rTcLTb5hqaFHlgRn1ggzRemf8oNonscW134odvcjC
         ABRdLbcGn7mmSyopSK/LvD3LxMGYbXlXREhjKgOfCw+OCA4OLb0OO7T7o/8WnySulVNd
         igv7e+y++2Ht9TEqkjLEMjRpSO6x1SICOyP/0=
Received: by 10.213.4.146 with SMTP id 18mr5142793ebr.24.1280255452183;
        Tue, 27 Jul 2010 11:30:52 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v59sm8002241eeh.10.2010.07.27.11.30.49
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 11:30:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzkxc7rpn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151967>

Junio C Hamano wrote:

> isn't
> this one in builtin/commit.c also a confusing no-op?

I see.  When setup_revisions is called (which initializes diffopt),
rev.abbrev still equals DEFAULT_ABBREV.

I missed v1.7.1.1~17^2 (commit::print_summary(): don't use
format_commit_message(), 2010-06-12) and did not notice that the bug ha=
d
gone away.  Sorry for the confusion.

Here=E2=80=99s a rerolled series.

Jonathan Nieder (3):
  archive: abbreviate substituted commit ids again
  checkout, commit: remove confusing assignments to rev.abbrev
  examples/commit: use --abbrev for commit summary

 archive.c                      |    1 +
 builtin/checkout.c             |    1 -
 builtin/commit.c               |    1 -
 contrib/examples/git-commit.sh |    2 +-
 t/t5001-archive-attr.sh        |    2 +-
 5 files changed, 3 insertions(+), 4 deletions(-)

--=20
1.7.2.21.g04ff
