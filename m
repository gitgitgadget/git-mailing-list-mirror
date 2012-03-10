From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Passing commit IDs to git-archive
Date: Sat, 10 Mar 2012 07:40:23 +0100
Message-ID: <4F5AF757.2040000@lsrfire.ath.cx>
References: <8c6d921d-9e8e-4caf-bc04-b1d2cfdd294f@mail> <8fb14091-99dc-4383-9cab-5bf508e0a554@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 07:40:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6Fys-0001sC-25
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 07:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab2CJGkh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Mar 2012 01:40:37 -0500
Received: from india601.server4you.de ([85.25.151.105]:39299 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab2CJGkf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 01:40:35 -0500
Received: from [192.168.2.105] (p4FFD8E16.dip.t-dialin.net [79.253.142.22])
	by india601.server4you.de (Postfix) with ESMTPSA id 1D1AF2F8042;
	Sat, 10 Mar 2012 07:40:34 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <8fb14091-99dc-4383-9cab-5bf508e0a554@mail>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192769>

Am 09.03.2012 23:14, schrieb Stephen Bash:
> Unfortunately I just attempted
>
>    warp:bar bash$ git archive --remote=3Dfile:///Users/bash/Developme=
nt/foo \
>                               --output=3Dtest.tgz 3b9e49b \
>                               path/to/subdir
>    remote: fatal: no such ref: 3b9e49b
>    remote: git upload-archive: archiver died with error
>    fatal: sent error to the client: git upload-archive: archiver died=
 with error

How about something like this instead?

	$ (
		cd /Users/bash/Development/foo &&
		git archive --format=3Dtgz 3b9e49b path/to/subdir
	) >test.tgz

I.e. instead of using the --remote option, going to the target and=20
creating the archive locally.  You could also keep using the --output=20
parameter if you specify the target file using an absolute path, of cou=
rse.

Ren=C3=A9
