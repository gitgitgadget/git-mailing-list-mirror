From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] sha1_name: use strlcpy() to copy strings
Date: Sun, 22 Feb 2015 23:33:16 +0100
Message-ID: <54EA592C.6040701@web.de>
References: <54E8E2AA.1020300@web.de> <xmqqsidxvhrk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 23:33:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPf62-0003Ey-0h
	for gcvg-git-2@plane.gmane.org; Sun, 22 Feb 2015 23:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbbBVWdu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2015 17:33:50 -0500
Received: from mout.web.de ([212.227.15.3]:65388 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbbBVWdt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2015 17:33:49 -0500
Received: from [192.168.178.27] ([79.253.156.36]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MWRoI-1Y0r5p3m3O-00XbVQ; Sun, 22 Feb 2015 23:33:43
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqsidxvhrk.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:BhNhTIZ8mGjUAyOkslu5ef7AAHaSIbqK6T0TsQGC96saEGgMYz1
 HoJ4ZClaQW/rztb3se4wYzbyYf7l+6Y6uYdaWGEwavhQw3ZhB4AgVIP2uIZYmrsrAUR9pz1
 QuQb2V1oIiNp5AKOKhB7bkd/N9wHxYROnyAwxlt/Ff8pg/eMbezMXGnbnyjcbe4Jc96QxQ/
 WXItoVCrN91O7YivNFmeA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264240>

Am 22.02.2015 um 21:00 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Use strlcpy() instead of calling strncpy() and then setting the last
>> byte of the target buffer to NUL explicitly.  This shortens and
>> simplifies the code a bit.
>
> Thanks.  It makes me wonder if the longer term direction should be
> not to use a bound buffer for oc->path, though.

That's a good idea in general, but a bit more involved since we'd need=20
to introduce a cleanup function that releases the memory allocated by=20
the new version of get_sha1_with_context() first and call it from the=20
appropriate places.

Would that be a good micro-project for GSoC or is it too simple?

Ren=C3=A9
