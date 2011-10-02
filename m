From: Grant <emailgrant@gmail.com>
Subject: Re: Does git have "Path-Based Authorization"?
Date: Sat, 1 Oct 2011 17:00:56 -0700
Message-ID: <CAN0CFw3kzAgaVBKNHE5ttJgYnc_csjeHjOLq=EBjLizW=RPUkA@mail.gmail.com>
References: <CAN0CFw0QXkNSF8+qGu+pCrv5dgy1OEvtq-53f23GRd4RrZ1GcQ@mail.gmail.com>
	<m3lit4oo9q.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 02 02:01:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA9UY-00010P-Ra
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 02:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492Ab1JBABA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Oct 2011 20:01:00 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58466 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab1JBAA7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2011 20:00:59 -0400
Received: by eya28 with SMTP id 28so1953001eya.19
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 17:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=nmIGM9SMXgu1uDIlcc1Nu2In39i++MrYToXrLRibqaM=;
        b=hdFtpINn4zAOXbY3v9ag1Obk+wVDrPMqyXp7Y5V+KLFrpuR+59CDVNX+CcElGZCbFh
         MtvnqG6be5c4jM7c0kIOSYvlGWINldaC3clSgQawchVNptR9S1GnGelPZgwOd9/moEto
         jAQmz1ikvml0YZfo2g1E7acRicd832cDiSK20=
Received: by 10.213.33.142 with SMTP id h14mr355972ebd.65.1317513656689; Sat,
 01 Oct 2011 17:00:56 -0700 (PDT)
Received: by 10.213.4.136 with HTTP; Sat, 1 Oct 2011 17:00:56 -0700 (PDT)
In-Reply-To: <m3lit4oo9q.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182585>

>> Hello, I'm trying to decide between git and subversion. =A0Subversio=
n
>> has "Path-Based Authorization" so I can give a developer access to
>> only specific files instead of everything. =A0Does git have somethin=
g
>> similar?
>>
>> http://svnbook.red-bean.com/en/1.5/svn.serverconfig.pathbasedauthz.h=
tml
>
> In distributed version control systems each developers gets full copy
> (a clone) of a repository (separate repository instance). =A0This mea=
ns that
> if you want for developer to see only specified subset of repository
> (specific subdirectories) you would have to split repository into
> submodules, and control access on (sub)repository basis.

I do want to prevent reading of all but one or a few specified files
at a time.  I did some reading on the differences between centralized
and distributed version control systems, and I can see how a
distributed system may be better for open source projects, but a
business project like mine may work better with centralized control.
Would you guys agree in general?  Easier read/write control of
individual files in the repository is one benefit of the centralized
model I will put to use.

> However if you want only to prevent developer from making changes out=
side
> specific subdirectory or specified files, you can do that on publish =
time
> via update / pre-receive hook (like contrib/hooks/update-paranoid), o=
r git
> repository management tool such as Gitolite. =A0That would prevent a =
push if
> any of commits being published touches files that it shouldn't.
>
> P.S. Karl Fogel in "Producing Open Source Software" (http://producing=
oss.com)
> writes that social solutions wrt. restricting contributors to given a=
rea
> are better than technical solutions such as (overly-)strict access
> control.

When I started this thread, I didn't realize the fact that my project
is not open-source would help decide which version control system to
use.  Now I see that it does factor into the decision so I apologize
for not mentioning it previously.

- Grant
