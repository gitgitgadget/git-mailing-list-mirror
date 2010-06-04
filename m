From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: Installing on AIX fails
Date: Fri, 4 Jun 2010 11:22:11 -0300
Message-ID: <AANLkTikkGtRmbsKD3JnQEWrhXQexH7J6SWEd9Aq3iQU_@mail.gmail.com>
References: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
	<AANLkTik_FI0CETWZZcu8O8MQQx5oV6YAbt5-X0ozbVmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Fri Jun 04 16:22:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKXmt-0005Ak-Co
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 16:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756304Ab0FDOWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 10:22:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37886 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756216Ab0FDOWN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 10:22:13 -0400
Received: by bwz11 with SMTP id 11so368241bwz.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ef5SZiPuYEpA9gsSxpXhQPUl4L0KmSK8I1Ty2acGZMk=;
        b=rmEBdx9TAAX/sIj6h+IhamU3whQMaiR4Cf9VHZ0bWsKpepwyiz6zDDy8PHGbBYKDA7
         THFzFV+JSPI1txRhRaVi56Ut6KTPlGD1wHR+DBTlKCgfT/bvvQaibfhlek3P5YjWhqtQ
         IQfPrySDfCG8yB1s2LDFLFy8Dvz5xglxBMptg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ayTEs1m0r7BNIdVwDfNECR0IGL0H4KusAPPorPyQ8Hn4ZGELJMMftRlkkkGQrD0493
         MuKMKdla0eoHfBCQQD1hUWLuIT924ptDqPjGRlsqMHD1PVtirsWyVSx8C3LK3hErCqat
         3YJ33MGOj0fNoUfpYBGXKb/zlY0mpgeqCChuM=
Received: by 10.204.144.150 with SMTP id z22mr4033896bku.158.1275661331198; 
	Fri, 04 Jun 2010 07:22:11 -0700 (PDT)
Received: by 10.204.18.207 with HTTP; Fri, 4 Jun 2010 07:22:11 -0700 (PDT)
In-Reply-To: <AANLkTik_FI0CETWZZcu8O8MQQx5oV6YAbt5-X0ozbVmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148419>

On Fri, Jun 4, 2010 at 6:13 AM, Tor Arntsen <tor@spacetec.no> wrote:
> Re. building on AIX.
>
> For AIX I've found that it's just better to always rely on the
> freeware toolkit stuff, which comes on a separate toolkit CD and in
> any case can be downloaded from
> ftp://ftp.software.ibm.com:/aix/freeSoftware/aixtoolbox/RPMS/ppc
> These are RPMs that you install via RPM which comes pre-installed on
> AIX (or anyway is part of the standard AIX CDs).
>
> On my own build the make, install, tar (gtar), grep, come from the
> toolkit CD (the /usr/freeware/bin/ path). At least the first two seems
> definitely mandatory.
> Oh, and AIX /bin/sh is not particularly good - it's simpler to rely on
> bash from the toolkit.
>

As I'm not the sysadmin, and git is not the project's tool, and the
server is in other city... I cannot install things from the CD :(

Another thing is that RPM utility is there... but I think I will not
have enough permissions to install software in such way. Development
teams compile utilities when needed (or not) and install in $HOME/bin.

I will need 'install's sources or an alternate way to install GIT...

Anyway, the 'make test' begun yesterday with a lot of failures... so,
I don't know if I'ill be able to use GIT on AIX soon, but may be I can
help to make it work.


> Depending on your AIX and compiler versions you may need some additional changes.

AIX is 5.2(.0.0), PERL is 5.8.0, IBM(R) XL C/C++ Enterprise Edition V7.0

> Gary Vaughan have posted patches which include
> updates that will improve the AIX experience. In addition to that, if
> you have the old XlC 5.0 compiler you will probably be better off at
> this point to use gcc from the toolkit. Otherwise you'll need those
> patches, and also one I posted which removes some C++ comments (I
> should probably re-post that one because it's not against the latest
> git repo version anymore).
>
> All that been said, I build on AIX as follows, using configure (which
> takes care of some other issues at the moment).
>
> SHELL_PATH=/opt/freeware/bin/bash
> PERL_PATH=/usr/local/special/bin/perl ./configure CC=cc
> CFLAGS=-Dinline=""
> and
> make SHELL_PATH=/opt/freeware/bin/bash PERL_PATH=/usr/local/special/bin/perl
> followed by the same, with 'install'
>
> That's with the old compiler and patches applied. Without patches
> you'll either have to rely on GCC (and remove those CC and CFLAGS
> lines, or change CC to gcc), or, with a newer (say, v10) IBM
> compiler), the -Dinline="" may not be needed.
>
> The only problem now is that some stuff (git rebase --interactive
> IIRC) will still not work, if you're on an AIX version with Perl 5.6
> (some things in git needs 5.8). AIX 6.1 has Perl 5.8, but some
> customers will downgrade to 5.6 because of bad performance problems
> with 5.8 on AIX.
>
> -Tor
>

I'ill try compiling 'install' (i don't know where the sources are)

Thank'u man,
Dario
