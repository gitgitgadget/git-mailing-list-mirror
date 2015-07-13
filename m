From: X H <music_is_live_lg@hotmail.com>
Subject: Re: [PATCH] check_and_freshen_file: fix reversed success-check
Date: Mon, 13 Jul 2015 21:58:21 +0200
Message-ID: <BLU437-SMTP9300461B7BF5F0DBDBE51BF69C0@phx.gbl>
References: <20150707141305.GA629@peff.net>
 <DUB120-W36B78FEE6DC80BDCB05D7FF6920@phx.gbl>
 <20150707194956.GA13792@peff.net> <559D60DC.4010304@kdbg.org>
 <20150708180539.GA12353@peff.net> <20150708183331.GA16138@peff.net>
 <559D9006.20102@kdbg.org> <559EDEE6.1040807@kdbg.org>
 <20150709224830.GA24998@peff.net>
 <BLU437-SMTP311678316C434857657D6BF69E0@phx.gbl>
 <20150713035224.GA3315@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 13 21:59:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEjsw-0000eG-Au
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 21:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbbGMT7S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jul 2015 15:59:18 -0400
Received: from blu004-omc3s3.hotmail.com ([65.55.116.78]:53939 "EHLO
	BLU004-OMC3S3.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbbGMT61 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jul 2015 15:58:27 -0400
Received: from BLU437-SMTP93 ([65.55.116.73]) by BLU004-OMC3S3.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Mon, 13 Jul 2015 12:58:26 -0700
X-TMN: [yhCGMYDGv4oAu53C+c9UI2UWssazYQSI]
X-Originating-Email: [music_is_live_lg@hotmail.com]
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
In-Reply-To: <20150713035224.GA3315@peff.net>
X-OriginalArrivalTime: 13 Jul 2015 19:58:25.0292 (UTC) FILETIME=[475814C0:01D0BDA6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273923>

Le 13/07/2015 5:52, Jeff King a =C3=A9crit :
> On Sun, Jul 12, 2015 at 12:21:33AM +0200, X H wrote:
>
>> How are the permission handled, is it git that is asking to create a=
 file
>> read only or rw on the remote or is it the environment with umask an=
s so on
>> that decides it, or Windows when the drive is mounted with noacl?
>
> Generally, git follows the umask when creating most files. However, f=
or
> the object files in the object database, it does drop the "w" bit, as
> once written, they should never be changed (after all, the filename i=
s a
> hash of the contents). We don't ever open those files for writing, bu=
t
> we may try to rename another file over them; that might behave
> differently on Unix versus Windows (or even differently on Windows
> between local and remote-mounted filesystems).
>
> -Peff
>

Hi,

When mounted on Linux the object files were created rw on the share, bu=
t=20
when mounted on Windows the temporary files are created with read-only=20
attributes.

Thank you for your patch, forced push are now working from=20
git-on-windows to smb folders shared from another Windows machine. I've=
=20
not yet tested to push to the share with another user, but I think it=20
should makes no diff.
