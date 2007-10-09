From: Wincent Colaiuta <win@wincent.com>
Subject: Re: bug? - git-checkout treeish paths  ignores deleted files
Date: Tue, 9 Oct 2007 12:20:48 +0200
Message-ID: <766E760C-D3F3-4593-BA95-D547CCAD0E29@wincent.com>
References: <470AD21E.6070906@gmail.com> <3B0685AB-0725-4473-8AE6-359F93851C10@wincent.com> <470AF7F1.2010903@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 12:21:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfCDL-0000ym-6N
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 12:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbXJIKVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2007 06:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbXJIKVM
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 06:21:12 -0400
Received: from wincent.com ([72.3.236.74]:36162 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469AbXJIKVL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Oct 2007 06:21:11 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l99AL49T026472;
	Tue, 9 Oct 2007 05:21:05 -0500
In-Reply-To: <470AF7F1.2010903@gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60380>

El 9/10/2007, a las 5:39, Mark Levedahl escribi=F3:

> I'm not convinced...
>
> "git checkout branch dir" should make dir have the same value it =20
> would get if I just did "git checkout branch".  The latter command =20
> will ignore files only if they are untracked in *both* HEAD and =20
> branch. I fail to see why the path-limited version of git-checkout =20
> should give a different result on the part it is asked to affect =20
> than the non-path limited version. This is very inconsistent and =20
> I'm having a hard time understanding what workflow it will help.

I don't know the historical reasons for the difference but it's =20
explained in the second para of the man page:

    When <paths> are given, this command does not switch branches. It
    updates the named paths in the working tree from the index file =20
(i.e.
    it runs git-checkout-index -f -u), or from a named commit.

So when you supply "." as a path it's not actually switching =20
branches. So that's why you see the different behaviour; it's =20
intentionally different. Like I said, I don't know the reasons why =20
but I imagine it's to make it easy to grab specific files from other =20
branches without actually switching.

Cheers,
Wincent
