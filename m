From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: How to "git add ." when some files are not accessible (permission
 denied)?
Date: Mon, 03 Mar 2008 20:17:00 +0100
Message-ID: <47CC4EAC.1050905@dirk.my1.cc>
References: <47C95E34.1050306@dirk.my1.cc> <20080302011900.GC22843@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:17:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWGAT-0007aW-ED
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 20:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080AbYCCTRG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2008 14:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbYCCTRF
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 14:17:05 -0500
Received: from smtprelay10.ispgateway.de ([80.67.29.24]:41831 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbYCCTRE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 14:17:04 -0500
Received: from [84.176.72.199] (helo=[192.168.2.100])
	by smtprelay10.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1JWG9k-0001Ky-H2
	for git@vger.kernel.org; Mon, 03 Mar 2008 20:17:00 +0100
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <20080302011900.GC22843@coredump.intra.peff.net>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75972>

Jeff King schrieb:
> On Sat, Mar 01, 2008 at 02:46:28PM +0100, Dirk S=C3=BCsserott wrote:
>
>  =20
>> The question is: is there a way to tell "git add ." to add all files=
 but
>> ignore those that cannot be added due to lack of authorization?
>>    =20
>
> No, there isn't. Under Linux, I would come up with a list of files I =
was
> interested in and then pipe it to "xargs git-add", which is probably
> unhelpful for Windows.
>
>  =20
Not quite. I'm using the msysGit package from=20
http://code.google.com/p/msysgit/downloads/list and that comes with som=
e=20
fundamental unix tools like a sound shell, find, xargs, and many more.=20
Very good!
This way prepared, I used "git ls-files -o | xargs git add -v" until=20
most of my files were added.
=46or the rest I did "xargs -l" (ell) so that the files got added one b=
y one.
The files that still refused to be added are finally ignored by "git=20
ls-files -o >> .gitignore".

Caveat: filenames containing blanks are not handled properly as they ar=
e=20
not surrounded by quotes. "git add" thinks of them as two or more files=
=20
and fails.
I figure xargs has some cool switches to sourround the parameters with=20
quotes, but I didn't find them. An option was to write a script or shel=
l=20
function that does it and pipe the filenames through that function or -=
-=20
as filenames with blanks aren't so numerous -- to add them manually wit=
h=20
"git gui".

Eventually, I solved the problem. Thanks for and to your pointers. :-)

  -- Dirk

