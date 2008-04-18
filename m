From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Q. regarding subtree merge
Date: Fri, 18 Apr 2008 12:02:58 +0200
Message-ID: <8aa486160804180302m43a7c942la93954401741b264@mail.gmail.com>
References: <loom.20080418T091729-407@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Stefan_N=E4we?=" <stefan.naewe+git@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 17:23:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmnRr-00058V-VN
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 12:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbYDRKDK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Apr 2008 06:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754379AbYDRKDJ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 06:03:09 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:5678 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324AbYDRKDH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Apr 2008 06:03:07 -0400
Received: by yw-out-2324.google.com with SMTP id 5so322022ywb.1
        for <git@vger.kernel.org>; Fri, 18 Apr 2008 03:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2GEGmPO4r+i8HcGTh1Uv/3BKfxTrugFStQiAR24pWko=;
        b=kcrQaI4JfcQBQMkDeMBuDgTUdkZ6VuOha60fRwljZ/GO2YsXNLQ0mb9/4Js8ZPNcezex08t6Qtz34Kp8SJ4WCxMIcRffskQeEYbFFts+e8Q47KX/oWiRViTlYqUQfBy6xEjNw/+cKKC8NIvu++JDIFa8zTLq/dVsNucZJ62a4qw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iW/e5rH0LdVWa/Dfw5WHXttqhzojLPjiFOR5bGqLqrQKWeeGH4PHFdUDmw+zxA8ULyB89npsFuXkjbkATKwdccJOksa26++gQDo25l65wKS3yxcN7fCZhVNwslL6DrlT1qktRKgIfAw0kmwewhEIUM51levFNN4OHj2FcGzjmxU=
Received: by 10.150.137.8 with SMTP id k8mr3364222ybd.61.1208512983653;
        Fri, 18 Apr 2008 03:03:03 -0700 (PDT)
Received: by 10.151.14.14 with HTTP; Fri, 18 Apr 2008 03:02:58 -0700 (PDT)
In-Reply-To: <loom.20080418T091729-407@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79865>

On Fri, Apr 18, 2008 at 11:36 AM, Stefan N=E4we
<stefan.naewe+git@gmail.com> wrote:
> Hi all.
>
>  I tried the scenario described in
>  $GIT_DIR/Documentation/howto/using-merge-subtree.txt and have some p=
roblems
>  with it.
>
>  My setup:
>
>  I use git to track my changes in three different "project directorie=
s", lets
>  say:
>
>  ...../src_root/libfoo
>  ...../src_root/appbar
>  ...../bin_root/installed
>
>  All three git repositories contain a topic branch (lets say 'current=
-work')
>  that I want to track.
>
>  Now I want to setup one git repository containing only the three dir=
ectories
>  'libfoo', 'appbar', and 'installed' that others can clone easily. Re=
ading the
>  above howto document, I think this should be possible.
>
>  I do:
>
>   $ mkdir super-prj
>   $ cd super-prj
>   $ git init
>   $ git add remote -f libfoo ../path/to/src_root/libfoo
>
>  OK. No problem.
>
>  The problem arises after the second step of the howto:
>
>   $ git merge -s ours --no-commit libfoo/current-work
>
>  Now, all files of 'libfoo' are in the current directory. This is not=
 what I
>  want.
>
>  Could someone please tell me what I'm doing wrong?

You are trying to merge libfoo with an empty project, so the merge
just "fast-forward" to the other commit as you do not have an "ours".

Simply skip the merge step.

Santi
