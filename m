From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/4] t5002: check if unzip supports symlinks
Date: Mon, 07 Jan 2013 17:50:31 +0100
Message-ID: <50EAFCD7.9090008@lsrfire.ath.cx>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org> <50E9B82D.50005@lsrfire.ath.cx> <50E9BB8B.9020101@lsrfire.ath.cx> <20130107085206.GI27909@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 17:51:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsFuc-0007XS-VV
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 17:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325Ab3AGQuj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2013 11:50:39 -0500
Received: from india601.server4you.de ([85.25.151.105]:37180 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386Ab3AGQui (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 11:50:38 -0500
Received: from [192.168.2.105] (p579BE5C2.dip.t-dialin.net [87.155.229.194])
	by india601.server4you.de (Postfix) with ESMTPSA id AC324B4;
	Mon,  7 Jan 2013 17:50:36 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130107085206.GI27909@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212903>

Am 07.01.2013 09:52, schrieb Jonathan Nieder:
> Ren=C3=A9 Scharfe wrote:
>
>> Only add a symlink to the repository if both the filesystem and
>> unzip support symlinks.  To check the latter, add a ZIP file
>> containing a symlink, created like this with InfoZIP zip 3.0:
>>
>> 	$ echo sample text >textfile
>> 	$ ln -s textfile symlink
>> 	$ zip -y infozip-symlinks.zip textfile symlink
>
> Hm.  Do some implementations of "unzip" not support symlinks, or is
> the problem that some systems build Info-ZIP without the SYMLINKS
> option?

The unzip supplied with NetBSD 6.0.1, which is based on libarchive,=20
doesn't support symlinks.  It creates a file with the link target path=20
as its only content for such entries.

I assume that Info-ZIP is compiled with the SYMLINKS option on all=20
platforms whose default filesystem supports symbolic links.  Except on=20
Windows perhaps, where it's complicated.

=46or the test script there is no difference: If we don't have a tool t=
o=20
verify symlinks in archives, we better skip that part.

Ren=C3=A9
