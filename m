From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 0/2] Teach 'git grep' about --open-files-in-pager=[<pager>]
Date: Fri, 26 Mar 2010 12:39:39 +0100
Message-ID: <36ca99e91003260439x3d60b851g15b8652d50f61c06@mail.gmail.com>
References: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 26 12:40:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv7tE-00064Z-KV
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 12:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480Ab0CZLjm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Mar 2010 07:39:42 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:35863 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab0CZLjl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Mar 2010 07:39:41 -0400
Received: by fxm23 with SMTP id 23so2028946fxm.21
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 04:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IvhcBb0K23fwjXtrS0FavSjJ0Z1ulFlc77vjtEvq7K0=;
        b=uevdDwr+I7BO3dY2G8sGJUcya1zl1fOmS71srIe0xM1CM/MiWcRjZv9hKHlJXG7L0y
         Rn5F0IkiMmG2ZcChJ1Kb71cWg2YyWh2L6+qOVUVXqcLBHNHVXcHdbI65tRuEB7gVWw8D
         P3UBmgVsPPL09+j02ImpQj4afGoH/AyFiOLkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g4gRzKMD/gUDyksrqTw/0+9guHatEAF01zqboBVtR/D/6H0zAPnfBS2dqfVZrM8wob
         vxNcdpa8oJ3f9bNl9LX5pRMXsN0OMj19AgXNxZ1nXNyud64o7OFWtxv3yhI/5/LxTE97
         D7I/n0fKc2XCET+CmGVRrwbuiJvL886FUOUWU=
Received: by 10.223.105.137 with HTTP; Fri, 26 Mar 2010 04:39:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
Received: by 10.223.6.153 with SMTP id 25mr730074faz.81.1269603579361; Fri, 26 
	Mar 2010 04:39:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143224>

On Fri, Mar 26, 2010 at 11:48, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> This supports opening the results of a 'git grep' directly in a pager
> (where the pager can be 'vi', too).
>
> This series is purely about convenience, everything the option does c=
an
> be done with a regular script or command line.
>
> But I saw so many people doing their own scripts for that, and in man=
y
> cases, they are subtly broken (e.g.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git grep -z <expr> | xargs -0r vi +/<expr>
>
> would work as long as you do not have to check the exit status of git
> grep from another script) that I finally decided to go for it and sen=
d
> this patch pair.
>
> My most common use case for this is to do something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git grep -Ovi SomeJustRenamedFile
>
> to edit all files I might have forgotten to change after a git mv.
>
> (Actually, to be honest, my use case involves -Pvi, but I will have t=
o
> retrain my hands.)
>
> Johannes Schindelin (2):
> =C2=A0grep: Add the option '--open-files-in-pager'
> =C2=A0grep -P: allow optional argument specifying the pager (or edito=
r)

Your re-training failed miserable ;-)

I like the idea. But could it make sense to get the line number of the
first match to the filename. In the same syntax as on the console
(i.e. <file>:<line>:)?

I have also the feeling that -O potion does not like pager with
arguments, be it from GIT_PAGER, PAGER, or from the command line.

Regards,
Bert
