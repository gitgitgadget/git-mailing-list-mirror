From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Re: [PATCH bc/connect-plink] t5601-clone: remove broken
 and pointless check for plink.exe
Date: Thu, 13 Aug 2015 10:56:51 +0200
Message-ID: <CABPQNSaAt1x6gBsHjNZ9CUv1x6qCLn-JD_Jf-3X5_ykTzs-23w@mail.gmail.com>
References: <55CA6066.5070500@kdbg.org> <866a41f50ef9b4807da72576a4bca717@www.dscho.org>
 <CABPQNSZHtAKbe6JwxRoK3LpCabfp6r2_kTmF1qokObt_yKnSDg@mail.gmail.com> <77beda92482eca76cdb0c7ee3743945f@www.dscho.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 13 10:57:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPoKQ-0001A2-1X
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 10:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbbHMI5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 04:57:33 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:36195 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbbHMI5b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2015 04:57:31 -0400
Received: by iodv127 with SMTP id v127so29845589iod.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 01:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=qg4sw4s7rOKy49ik/iGaMsMhhyvwIea8kPDmQ0luaKI=;
        b=RQJrisIZm+210ffCzs91hQpI62Do/+AbONzaU3HEPTZi7HfdO1Dv+N8tAKB/S4Qhqq
         p31yPGkpJzJwrBd1VFAtFixJ/Qaj7UyQk5geSQBkogB+KHf2Y8xaTSMaqSbbXoZwPyJU
         gVWiw0wh+gTrTa/JAMZeabM6lXrIAt3i9Og4yvBDnL8j8XBBx+cXpJU9JgNWT+Vk/y6u
         Va7q+baEpGoWNvJPZwK4PKD73EKj4bVW00tPTkNZL9d8MH2BC0j6ybM8K6dkxJw7l9gH
         vtIVOEI0JPIohpGSM9XJpzPWjXW2nkIr6lQwmgWv7AsyYLXrMHEOGWSpk1t8Xr/H0saZ
         5cNA==
X-Received: by 10.107.34.81 with SMTP id i78mr38209103ioi.40.1439456250782;
 Thu, 13 Aug 2015 01:57:30 -0700 (PDT)
Received: by 10.64.227.110 with HTTP; Thu, 13 Aug 2015 01:56:51 -0700 (PDT)
In-Reply-To: <77beda92482eca76cdb0c7ee3743945f@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275839>

On Thu, Aug 13, 2015 at 10:37 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi kusma,
>
> On 2015-08-12 13:58, Erik Faye-Lund wrote:
>> On Wed, Aug 12, 2015 at 1:07 PM, Johannes Schindelin
>> <johannes.schindelin@gmx.de> wrote:
>>>
>>> On 2015-08-11 22:51, Johannes Sixt wrote:
>>>> Invoking plink requires special treatment, and we have support and even
>>>> test cases for the commands 'plink' and 'tortoiseplink'. We also support
>>>> .exe variants for these two and there is a test for 'plink.exe'.
>>>>
>>>> On Windows, however, where support for plink.exe would be relevant, the
>>>> test case fails because it is not possible to execute a file with a .exe
>>>> extension that is actually not a binary executable---it is a shell
>>>> script in our test. We have to disable the test case on Windows.
>>>
>>> Oh how would I wish you were working on Git for Windows even *just* a bit *with* me. At least I would wish for a more specific description of the development environment, because it sure as hell is not anything anybody can download and install as easily as Git for Windows' SDK.
>>>
>>> FWIW Git for Windows has this patch (that I wanted to contribute in due time, what with being busy with all those tickets) to solve the problem mentioned in your patch in a different way:
>>>
>>> https://github.com/git-for-windows/git/commit/2fff4b54a0d4e5c5e2e4638c9b0739d3c1ff1e45
>>
>> Yuck. On Windows, it's the extension of a file that dictates what kind
>> of file it is (and if it's executable or not), not the contents.
>
> Careful. If you continue along those lines, interactive rebase, `git add -p` and all those wonderful scripts Git has will have to stop working.
>
> Because those scripts completely disagree with what you just said about Windows if you think about it: *none* of them has an extension.
>
> I know that you do not mean this, of course, but that is the argument you were making... ;-)
>

You should know better than to straw-man like that.

I was not arguing to break any current functionality, but to not move
further away from Windows' semantics.

But if I would have, there's nothing that would stop us from renaming
those scrips to *.sh, and let the filename dictate how to execute
them. Or provide batch-files to wrap them.

>> If we get a shell script written with the ".exe"-prefix, it's considered as
>> an invalid executable by the system.
>
> And if we get a shell script without any `.exe` suffix, it is still considered as an invalid executable by the system.

Nope, it's considered an unknown file, not an executable at all.

> And even if we tack on an `.sh` suffix (which is *not* in line with the way Git works), it is *still* considered as an invalid executable by the system.

That's not necessarily true; the Git for Windows installer
(optionally, but on by default) registers /bin/sh as a file-handler
for .sh files. Windows knows just fine how to execute them, unless the
user opts out.

But again, I was not arguing to patch git to not parse the shebang.
