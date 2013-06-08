From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 17/22] git-remote-mediawiki: Brace file handles for
 print for more clarity
Date: Fri, 7 Jun 2013 20:42:35 -0400
Message-ID: <CAPig+cQwBV5OfxH3-XrMd=J-fzTLmdSmoGOp-5o-Cj9mzJoVrw@mail.gmail.com>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
	<1370641344-4253-18-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 08 02:42:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul7Ev-0000KB-CT
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 02:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647Ab3FHAmh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 20:42:37 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:40623 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab3FHAmg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 20:42:36 -0400
Received: by mail-la0-f49.google.com with SMTP id ea20so704687lab.36
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 17:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TTrbk/QBy/6PWLgL1Kq7M1GaURp1nBim+XQQ7r7EQmg=;
        b=OMeKv84PMTNme8ZpgOyA9/Nt9xDWEnL5DbuXGf7CiFYufvvNHzEDoOWF+BCdL2CrJm
         PCY+KJLhrGj3EiNHwRJssEjjW+EcPuPRabov8yUR0mRVM+eJtmgq3gZPzh3aEIuU7BQa
         H/R8A/ntiKrJk4aasjPI59WHJmzQc9/r59X33CYIoMtoAXPzCE58jmxtZpkYq4QJDtks
         RNHhkrkhRSE8q5eXah5ebwrUBrNoAnYmAgixm416/w+BNKE+FpnjaFn9NKZEivBlLLbx
         HArZlue3tdGJ1CzKYbq9lRxBA62eTl/Ff6UpAk3WjMU1lrBiorWO7Oqb2B4um2zTRgEq
         Iwag==
X-Received: by 10.152.6.228 with SMTP id e4mr462292laa.61.1370652155394; Fri,
 07 Jun 2013 17:42:35 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Fri, 7 Jun 2013 17:42:35 -0700 (PDT)
In-Reply-To: <1370641344-4253-18-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: dzRW27z2uL_DM2sH9rIXiSXX710
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226774>

On Fri, Jun 7, 2013 at 5:42 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> This follows the following rule:
> InputOutput::RequireBracedFileHandleWithPrint (Severity: 1)
>     The `print' and `printf' functions have a unique syntax that supp=
orts an
>     optional file handle argument. Conway suggests wrapping this argu=
ment in
>     braces to make it visually stand out from the other arguments. Wh=
en you
>     put braces around any of the special package-level file handles l=
ike
>     `STDOUT', `STDERR', and `DATA', you must the `'*'' sigil or else =
it
>     won't compile under `use strict 'subs''.
>
>       print $FH   "Mary had a little lamb\n";  #not ok
>       print {$FH} "Mary had a little lamb\n";  #ok
>
>       print   STDERR   $foo, $bar, $baz;  #not ok
>       print  {STDERR}  $foo, $bar, $baz;  #won't compile under 'stric=
t'
>       print {*STDERR}  $foo, $bar, $baz;  #perfect!
>
> Signed-off-by: C=E9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>
> Conflicts:
>
>         contrib/mw-to-git/git-remote-mediawiki.perl

Uninteresting conflict information can be dropped.
