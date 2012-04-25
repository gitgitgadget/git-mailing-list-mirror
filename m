From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2012, #08; Fri, 20)
Date: Wed, 25 Apr 2012 14:14:32 -0400
Message-ID: <CAFouetg1L3qsUQfNNnNKE43AkKGBQcypTw=w8dZKRJBM7LkQoA@mail.gmail.com>
References: <xmqqobqmkkxv.fsf@junio.mtv.corp.google.com>
	<4F941EA3.7080200@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 20:14:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN6jn-0008LE-Cn
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 20:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757412Ab2DYSOo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Apr 2012 14:14:44 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35353 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946Ab2DYSOd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2012 14:14:33 -0400
Received: by iadi9 with SMTP id i9so385750iad.19
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=qtQZLcMcZ2aGJp9Hvs7DhuZnjWTFpX7zbj9iRAJQ7wM=;
        b=ZflIWGa8cSXUUVAKhlxMMzakUGQtOx8yC6O6b/XSFgXtG5SKGskAql1srsWL4LCw8R
         rKTR/mGswug+pmdFPVbJH5oy1lcuFCgKkJ2E7j8JFVNBEuB0Dx8lwFNsH+NuH62BvQ/t
         t53zehkYG6N0DSC1On2EzTKXF643JpIgSyM17xLwlSJlctZ/H6kRo3q4Dyqpnct637Ix
         dINvObqFN+c2+AvqCzy7nitqfrXLTLv98KOjTNYLowP0MaQq7G2qMDH1L9n8x3zQlOwR
         DvjnD8ql663rKtdpgzoBrxtUo8yDFvuQFw6cCsitwKxnggoydvnHAqCQjPo5JWDBNc+k
         9Kfw==
Received: by 10.50.104.133 with SMTP id ge5mr3755876igb.21.1335377672946; Wed,
 25 Apr 2012 11:14:32 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Wed, 25 Apr 2012 11:14:32 -0700 (PDT)
In-Reply-To: <4F941EA3.7080200@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196327>

On Sun, Apr 22, 2012 at 11:07 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 21.04.2012 02:06, schrieb Junio C Hamano:
>> * th/difftool-diffall (2012-04-14) 8 commits
>> =C2=A0 - difftool: print list of valid tools with '--tool-help'
>> =C2=A0 - difftool: teach difftool to handle directory diffs
>> =C2=A0 - difftool: eliminate setup_environment function
>> =C2=A0 - difftool: stop appending '.exe' to git
>> =C2=A0 - difftool: remove explicit change of PATH
>> =C2=A0 - difftool: exit(0) when usage is printed
>> =C2=A0 - difftool: add '--no-gui' option
>> =C2=A0 - difftool: parse options using Getopt::Long
>>
>> Rolls the two-directory-diff logic from diffall script (in contrib/)=
 into
>> "git difftool" framework.
>
> This does not pass test 33 (the last one) on Windows:

I now have a working test environment using msysgit on Windows 7
32-bit.  I updated to the tip of 'pu' (on my clone this is commit
5224ba8) and was able to run all 33 tests in t7800 without error.


> +++ git difftool --dir-diff --extcmd ls branch
> Use of uninitialized value in length at d:/Src/mingw-git/git-difftool=
 line 55.
> Use of uninitialized value in length at d:/Src/mingw-git/git-difftool=
 line 55.

The above 2 warnings were fixed in a later version of patch series.


> exiting now at d:/Src/mingw-git/git-difftool line 120.
> usage: git diff [--no-index] <path> <path>
> diff --raw --no-abbrev -z branch: command returned error: 129
>
> ("exiting now" is a debugging "warn" call that I inserted)
>
> I don't know what's going on. One possibility is that an old Git.pm i=
s
> being used, because I haven't 'make install' yet.
>
> I'm not going to look into this, but I can run tests if you tell me w=
hat
> to do.

I have run into issues in the past on Linux where testing without
running 'make install' causes trouble, but never had time to track it
down.

Would it be possible for you to update to the latest tip of 'pu' and
then 'make install && (cd t && sh t7800-difftool.sh)'?
