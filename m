From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git archive --format zip utf-8 issues
Date: Sat, 11 Aug 2012 22:53:37 +0200
Message-ID: <5026C651.8050705@lsrfire.ath.cx>
References: <502583F4.8030308@tu-clausthal.de> <7vtxwagy9f.fsf@alter.siamese.dyndns.org> <50259EEC.2020701@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Sat Aug 11 22:54:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0Igt-0006Hd-AK
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 22:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506Ab2HKUxo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Aug 2012 16:53:44 -0400
Received: from india601.server4you.de ([85.25.151.105]:39094 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab2HKUxm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 16:53:42 -0400
Received: from [192.168.2.105] (p4FFD986C.dip.t-dialin.net [79.253.152.108])
	by india601.server4you.de (Postfix) with ESMTPSA id CD2632F8123;
	Sat, 11 Aug 2012 22:53:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <50259EEC.2020701@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203298>

Am 11.08.2012 01:53, schrieb Sven Strickroth:
> Am 11.08.2012 00:47 schrieb Junio C Hamano:
>> Do you know in what encoding the pathnames are _expected_ to be
>> stored in zip archives?
>
> re-encoding to latin1 does not always work and may break double byte
> totally (e.g. chinese or japanese).
>
> PKZIP APPNOTE seems to be the zip standard and it specifies a utf-8
> flag: http://www.pkware.com/documents/casestudies/APPNOTE.TXT
>> A.  Local file header:
>> general purpose bit flag: (2 bytes)
>> Bit 11: Language encoding flag (EFS).  If this bit is
>> set, the filename and comment fields for this file
>> must be encoded using UTF-8. (see APPENDIX D)

Yes, that's one of the two methods for supporting UTF-8 filenames=20
described there.

The other method involves writing extra ZIP header fields and was=20
invented by Info-ZIP. They don't use it consistently anymore, though=20
(from zip -h2):

  "Zip now stores UTF-8 in entry path and comment fields on systems
   where UTF-8 char set is default, such as most modern Unix, and
   and on other systems in new extra fields with escaped versions in
   entry path and comment fields for backward compatibility."

Ren=C3=A9
