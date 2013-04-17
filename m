From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git log - crash and core dump
Date: Wed, 17 Apr 2013 21:06:21 +0200
Message-ID: <516EF2AD.9090403@lsrfire.ath.cx>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com> <516D93C4.1000100@lsrfire.ath.cx> <7v61zml0ow.fsf@alter.siamese.dyndns.org> <516DBE2E.4060201@lsrfire.ath.cx> <7vzjwyi0ba.fsf@alter.siamese.dyndns.org> <7vli8hhgmn.fsf@alter.siamese.dyndns.org> <20130417063942.GA27703@sigill.intra.peff.net> <516EE300.7020200@lsrfire.ath.cx> <20130417180248.GA1839@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ivan Lyapunov <dront78@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 17 21:06:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USXgd-0004tg-Nu
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 21:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756966Ab3DQTG0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 15:06:26 -0400
Received: from india601.server4you.de ([85.25.151.105]:48209 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755943Ab3DQTG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 15:06:26 -0400
Received: from [192.168.2.105] (p4FFD858B.dip.t-dialin.net [79.253.133.139])
	by india601.server4you.de (Postfix) with ESMTPSA id EA8071F1;
	Wed, 17 Apr 2013 21:06:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130417180248.GA1839@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221564>

Am 17.04.2013 20:02, schrieb Jeff King:
> I think we also need to do something about "git cat-file -p", which d=
oes
> not use the split_ident_line parser (but has its own problems with th=
e
> home-grown parser).

Ah, while it prints commit object contents verbatim, it formats the dat=
e
of tags.  And it does it without help from tag.c (or ident.c), which in
turn does its own parsing as well.  So it looks like we have two more
candidates for conversion to split_ident_line() here.

Ren=C3=A9
