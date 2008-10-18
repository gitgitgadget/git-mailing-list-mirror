From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/3] add alloc_ref_with_prefix()
Date: Sat, 18 Oct 2008 11:39:22 +0200
Message-ID: <48F9AECA.3020606@lsrfire.ath.cx>
References: <48F9A054.4010703@lsrfire.ath.cx> <36ca99e90810180227u367783f6vc3b7af0176f6df06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 11:40:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr8IZ-0005Q2-Lk
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 11:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbYJRJj1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Oct 2008 05:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbYJRJj1
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 05:39:27 -0400
Received: from india601.server4you.de ([85.25.151.105]:39224 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbYJRJj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 05:39:27 -0400
Received: from [10.0.1.101] (p57B7E475.dip.t-dialin.net [87.183.228.117])
	by india601.server4you.de (Postfix) with ESMTPSA id 35E222F8058;
	Sat, 18 Oct 2008 11:39:25 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <36ca99e90810180227u367783f6vc3b7af0176f6df06@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98535>

>> +static struct ref *alloc_ref_with_prefix(const char *prefix, size_t=
 prefixlen,
>> +               const char *name)
>> +{
>> +       size_t len =3D strlen(name);
>> +       struct ref *ref =3D xcalloc(1, sizeof(struct ref) + prefixle=
n + len + 1);
>> +       memcpy(ref->name, prefix, prefixlen);
>> +       memcpy(ref->name + prefixlen, name, len);
> Where does you \0-terminate the string?

xcalloc() calls calloc(), which zeroes the memory.

Ren=C3=A9
