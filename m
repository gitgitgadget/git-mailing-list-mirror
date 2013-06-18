From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] unpack-trees: don't shift conflicts left and right
Date: Tue, 18 Jun 2013 21:33:25 +0200
Message-ID: <51C0B605.10908@lsrfire.ath.cx>
References: <1371339883-22775-1-git-send-email-rene.scharfe@lsrfire.ath.cx> <7va9mqlvpu.fsf@alter.siamese.dyndns.org> <51BF71D4.402@lsrfire.ath.cx> <7vehc0bh79.fsf@alter.siamese.dyndns.org> <51BF9B35.3010801@lsrfire.ath.cx> <7vsj0g9udh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 21:33:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up1es-0005wC-27
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 21:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700Ab3FRTde convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 15:33:34 -0400
Received: from india601.server4you.de ([85.25.151.105]:43908 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756296Ab3FRTdd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 15:33:33 -0400
Received: from [192.168.2.102] (p4FFD9B62.dip0.t-ipconnect.de [79.253.155.98])
	by india601.server4you.de (Postfix) with ESMTPSA id B8CCA1FC;
	Tue, 18 Jun 2013 21:33:31 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7vsj0g9udh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228307>

Am 18.06.2013 01:42, schrieb Junio C Hamano:
> But the need to go all the way up in the recursive callframes to get
> the union of bitmask to get conflicts looks somewhat ugly.

Yes, that's not pretty.  It's like make_traverse_path in that regard,=20
though, so it fits in somehow.

I suspect the *real* solution is to put something like=20
traverse_trees_recursive into tree-walk.c.  Both callers of=20
traverse_tree recurse into subdirectories in slightly different ways.=20
Providing that functionality in a central place should reduce code=20
duplication.

Ren=C3=A9
