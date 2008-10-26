From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 5/5] blame: use xdi_diff_hunks(), get rid of struct patch
Date: Sun, 26 Oct 2008 23:20:08 +0100
Message-ID: <4904ED18.3070500@lsrfire.ath.cx>
References: <1219360921-28529-1-git-send-email-bdowning@lavos.net> <1219360921-28529-2-git-send-email-bdowning@lavos.net> <48AFC73F.2010100@lsrfire.ath.cx> <20080824081254.GI31114@lavos.net> <48BF0FBF.3010104@lsrfire.ath.cx> <49031FB8.8060003@lsrfire.ath.cx> <7vhc708o1v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Downing <bdowning@lavos.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 23:21:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuDzC-0000S4-TW
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 23:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbYJZWUO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Oct 2008 18:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752472AbYJZWUN
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 18:20:13 -0400
Received: from india601.server4you.de ([85.25.151.105]:43033 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbYJZWUM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 18:20:12 -0400
Received: from [10.0.1.101] (p57B7F906.dip.t-dialin.net [87.183.249.6])
	by india601.server4you.de (Postfix) with ESMTPSA id 1C3012F804C;
	Sun, 26 Oct 2008 23:20:11 +0100 (CET)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <7vhc708o1v.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99190>

Junio C Hamano schrieb:
> Perhaps revision.c in our history would be more interesting than cach=
e.h
> or Makefile, as there are more line migrations from different places =
to
> that file.

Indeed:

   # master
   $ /usr/bin/time $blame revision.c >/dev/null
   2.15user 0.27system 0:02.58elapsed 94%CPU (0avgtext+0avgdata 0maxres=
ident)k
   3544inputs+0outputs (29major+13835minor)pagefaults 0swaps

   # this patch series
   $ /usr/bin/time $blame revision.c >/dev/null
   1.88user 0.14system 0:02.03elapsed 99%CPU (0avgtext+0avgdata 0maxres=
ident)k
   0inputs+0outputs (0major+14068minor)pagefaults 0swaps

Ren=C3=A9
