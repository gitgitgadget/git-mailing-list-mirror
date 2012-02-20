From: =?GB2312?B?0Oy1zw==?= <xudifsd@gmail.com>
Subject: Re: Manually decoding a git object
Date: Mon, 20 Feb 2012 19:39:32 +0800
Message-ID: <CAMocUqQdBH3BhWGfFCiCLXhtw=-tRVdL9RBjma_tdoVdj2-Crw@mail.gmail.com>
References: <1329312140-24089-1-git-send-email-pclouds@gmail.com>
	<1329624946-32173-1-git-send-email-pclouds@gmail.com>
	<A716A27D407F401DAAC373027D5CFF2A@PhilipOakley>
	<87mx8dj4at.fsf@thomas.inf.ethz.ch>
	<5D290031F60941368FB1A36464201DCF@PhilipOakley>
	<871uppbwnu.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 20 12:39:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzRam-0000i6-1n
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 12:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217Ab2BTLje convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 06:39:34 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:32873 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946Ab2BTLje convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2012 06:39:34 -0500
Received: by bkcjm19 with SMTP id jm19so4465506bkc.19
        for <git@vger.kernel.org>; Mon, 20 Feb 2012 03:39:32 -0800 (PST)
Received-SPF: pass (google.com: domain of xudifsd@gmail.com designates 10.204.148.90 as permitted sender) client-ip=10.204.148.90;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of xudifsd@gmail.com designates 10.204.148.90 as permitted sender) smtp.mail=xudifsd@gmail.com; dkim=pass header.i=xudifsd@gmail.com
Received: from mr.google.com ([10.204.148.90])
        by 10.204.148.90 with SMTP id o26mr7563223bkv.121.1329737972888 (num_hops = 1);
        Mon, 20 Feb 2012 03:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=gUDg5pALwhzERYS9Z7yhPhtzY9kvesQsPTMORLgROkw=;
        b=paXRyikW4efNq5k/qHqBlvp8X5fjCaStn/Skgv2S8QZHH/ij3s1x7dXg3RTanCxfCG
         1HbC57oRo2zYXbZKHSE7Vrx2rP51izbxkFczV+ngmNRsdtCOaa4GT9v4g9tV8+Yy4Deb
         6EuYmd7rfmy7ru02aMfLeaJBzfuh3L862ytq0=
Received: by 10.204.148.90 with SMTP id o26mr6058715bkv.121.1329737972811;
 Mon, 20 Feb 2012 03:39:32 -0800 (PST)
Received: by 10.204.64.69 with HTTP; Mon, 20 Feb 2012 03:39:32 -0800 (PST)
In-Reply-To: <871uppbwnu.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191062>

2012/2/20 Thomas Rast <trast@inf.ethz.ch>:
> Philip Oakley <philipoakley@iee.org> writes:
>
>> From: "Thomas Rast" <trast@inf.ethz.ch> Sent: Monday, February 20,
>> 2012 8:29 AM
>>>
>>> The SHA1 is over the decompressed object contents. =A0The file simp=
ly
>>> holds a zlib-compressed stream of those contents. =A0(It's pretty m=
uch
>>> like gzip without the file header.)
>>>
>>> You can use any bindings to zlib and something that does sha1, e.g.=
 in
>>> python:
>>>
>>> =A0$ cd g/.git/objects/aa/ =A0# my git.git
>>> =A0$ ls
>>> =A0592bda986a8380b64acd8cbb3d5bdfcbc0834d
>>> 6322a757bee31919f54edcc127608a3d724c99
>>> =A0$ python
>>> =A0Python 2.7.2 (default, Aug 19 2011, 20:41:43) [GCC] on linux2
>>> =A0Type "help", "copyright", "credits" or "license" for more inform=
ation.
>>> =A0>>> import hashlib
>>> =A0>>>
>>> hashlib.sha1(open('592bda986a8380b64acd8cbb3d5bdfcbc0834d').read().=
decode('zlib')).digest().encode('hex')
>>> =A0'aa592bda986a8380b64acd8cbb3d5bdfcbc0834d'
>>>
>>> Notice that the first byte of the hash goes into the directory name=
=2E
>>>
I think Thomas got the point.

> When I tried it from my home directory (not in a git directory):
> $ git cat-file -p Git-Object
> fatal: Not a git repository (or any of the parent directories): .git

this is because git will first do a git-dir-search, if you're current
work dir is not within git repo, it will die.
I really do not know how you get thing that mess. From the link[1] you
give, i think you just want to clone a repo across computer not by
network, if so this[2] will be helpful.

[1]:http://stackoverflow.com/questions/9343260/what-after-git-unpack-ob=
jects-to-get-the-actual-file
[2]:http://progit.org/2010/03/10/bundles.html
