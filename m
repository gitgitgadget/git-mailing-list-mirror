From: Grant <emailgrant@gmail.com>
Subject: Re: Does git have "Path-Based Authorization"?
Date: Sat, 1 Oct 2011 19:53:23 -0700
Message-ID: <CAN0CFw2gVH7=LdKhseE3zo+Av_=kVdz=tH3s=BKeTK9bDOprcw@mail.gmail.com>
References: <CAN0CFw0QXkNSF8+qGu+pCrv5dgy1OEvtq-53f23GRd4RrZ1GcQ@mail.gmail.com>
	<m3lit4oo9q.fsf@localhost.localdomain>
	<CAN0CFw3kzAgaVBKNHE5ttJgYnc_csjeHjOLq=EBjLizW=RPUkA@mail.gmail.com>
	<CAMK1S_icdpCyA8SBcNu8CbCk3N-h8yEYZ9+6N=JVPAeayuzSPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 02 04:53:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RACBQ-0006Q6-E6
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 04:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720Ab1JBCx1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Oct 2011 22:53:27 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50326 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab1JBCx0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2011 22:53:26 -0400
Received: by eya28 with SMTP id 28so1987923eya.19
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 19:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=8e0llqT3EWpnK9xDv64yBuX48BBg/vwGhD8gIvdSehM=;
        b=EIAq1caFXhnZAF5ZA49gXNFJnY6wKuXE+JHmKzOHfKJLroMhwvUsmtLYR9VqWLIWTE
         0/AOP0xDK2DawT/qb0dxHC7QhpTwFzV2Fl/TarSC9Aq1OTvU/jLLvMSK/SGMBJwsRGI0
         zaigsmYEhuunP8j7nO08GPkL8bfmmvu/3pdsg=
Received: by 10.213.19.20 with SMTP id y20mr378465eba.27.1317524003402; Sat,
 01 Oct 2011 19:53:23 -0700 (PDT)
Received: by 10.213.4.136 with HTTP; Sat, 1 Oct 2011 19:53:23 -0700 (PDT)
In-Reply-To: <CAMK1S_icdpCyA8SBcNu8CbCk3N-h8yEYZ9+6N=JVPAeayuzSPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182588>

>>>> Hello, I'm trying to decide between git and subversion. =A0Subvers=
ion
>>>> has "Path-Based Authorization" so I can give a developer access to
>>>> only specific files instead of everything. =A0Does git have someth=
ing
>>>> similar?
>>>>
>>>> http://svnbook.red-bean.com/en/1.5/svn.serverconfig.pathbasedauthz=
=2Ehtml
>>>
>>> In distributed version control systems each developers gets full co=
py
>>> (a clone) of a repository (separate repository instance). =A0This m=
eans that
>>> if you want for developer to see only specified subset of repositor=
y
>>> (specific subdirectories) you would have to split repository into
>>> submodules, and control access on (sub)repository basis.
>>
>> I do want to prevent reading of all but one or a few specified files
>> at a time. =A0I did some reading on the differences between centrali=
zed
>> and distributed version control systems, and I can see how a
>> distributed system may be better for open source projects, but a
>> business project like mine may work better with centralized control.
>> Would you guys agree in general? =A0Easier read/write control of
>> individual files in the repository is one benefit of the centralized
>> model I will put to use.
>>
>>> However if you want only to prevent developer from making changes o=
utside
>>> specific subdirectory or specified files, you can do that on publis=
h time
>>> via update / pre-receive hook (like contrib/hooks/update-paranoid),=
 or git
>>> repository management tool such as Gitolite. =A0That would prevent =
a push if
>>> any of commits being published touches files that it shouldn't.
>>>
>>> P.S. Karl Fogel in "Producing Open Source Software" (http://produci=
ngoss.com)
>>> writes that social solutions wrt. restricting contributors to given=
 area
>>> are better than technical solutions such as (overly-)strict access
>>> control.
>>
>> When I started this thread, I didn't realize the fact that my projec=
t
>> is not open-source would help decide which version control system to
>> use. =A0Now I see that it does factor into the decision so I apologi=
ze
>> for not mentioning it previously.
>
> I'm afraid I did not follow the full thread, but I can assure you we
> have several "secret secret" type projects at work, both mine as well
> as many others.
>
> There are a few occasions when they need the kind of stuff you seem t=
o
> want more regularly, (the only one I can really recall is one of our
> largest customers has a custom version of one of our product for
> themselves and do not want people working on the generic version to
> see those changes in case they propagate to their competitors). =A0We
> just do that by using a different repo entirely, and making sure
> changes to common code migrate only one way.

How would something like that work in a case like mine where I have a
series of maybe 100 files and I only want to give my developer
read/write access to one or a few files at a time with no read or
write access to any of the other files?  Wouldn't setting up a
different repo for each set of files be difficult to manage?

- Grant


> Git has too many advantages over legacy VCSs like SVN for people to
> throw it over for something as simple as this.
