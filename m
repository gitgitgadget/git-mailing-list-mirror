From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v5 02/12] ctype: support iscntrl, ispunct, isxdigit and
 isprint
Date: Sun, 14 Oct 2012 15:59:31 +0200
Message-ID: <507AC543.2020402@lsrfire.ath.cx>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com> <1350182110-25936-3-git-send-email-pclouds@gmail.com> <507AB73D.8010406@lsrfire.ath.cx> <CACsJy8B+6OPkP6ijMDzm+n0eHnDZ4Pj8UO_KasdfEP4wF+_hww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 15:59:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNOjN-0002hF-3i
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 15:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272Ab2JNN7d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 09:59:33 -0400
Received: from india601.server4you.de ([85.25.151.105]:44416 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262Ab2JNN7c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 09:59:32 -0400
Received: from [192.168.2.105] (p4FFDAF97.dip.t-dialin.net [79.253.175.151])
	by india601.server4you.de (Postfix) with ESMTPSA id 3BAC412F;
	Sun, 14 Oct 2012 15:59:31 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121005 Thunderbird/16.0
In-Reply-To: <CACsJy8B+6OPkP6ijMDzm+n0eHnDZ4Pj8UO_KasdfEP4wF+_hww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207665>

Am 14.10.2012 15:25, schrieb Nguyen Thai Ngoc Duy:
> On Sun, Oct 14, 2012 at 7:59 PM, Ren=C3=A9 Scharfe
> <rene.scharfe@lsrfire.ath.cx> wrote:
>> With that, couldn't you squeeze the other two classes into the exist=
ing
>> sane_type?
>
> No there are still conflicts: 9, 10 and 13 as spaces (vs controls) an=
d
> 123, 124 and 126 as regex/pathspec special (vs punctuation).

That's not a problem, an entry in the table can have more than one bit=20
set -- just OR them together in ctype.c.  It may not look as nice, but=20
that's OK.  You could also define a character for GIT_SPACE | GIT_CNTRL=
=20
etc. for cosmetic reasons.

Ren=C3=A9
