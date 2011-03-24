From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Trailing spaces in branchname (git-svn)
Date: Thu, 24 Mar 2011 22:26:42 +0100
Message-ID: <AANLkTinZnd0R8Rnv4kaiJAGP0qKEwgbU+nP=donmbEbp@mail.gmail.com>
References: <0014af8a-3b24-4398-88aa-7a3e460f2283@s11g2000yqh.googlegroups.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Barthus <magnus.kallstrom@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 22:28:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2s4d-0003Of-W2
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 22:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213Ab1CXV1s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2011 17:27:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65338 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756400Ab1CXV1n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2011 17:27:43 -0400
Received: by fxm17 with SMTP id 17so457250fxm.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 14:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ubGI2bRdQ+xlKROiwdfvWZCbjyxuzmPLb59J8wnig/8=;
        b=TTkYqT7j1YwaaYFO9Giy47ILhUCuiR1Bxq2Ge19hmvvZ+NZ8dGy6dXH1UWXgLBwRDn
         C6/W5VHu40pGk42kChOhfjOmdhjYQCgIM/HlSNomWimKewMJZ04QW6+EYxuSrppFNxBj
         HoD1HnzYbMXoVZ55UXKhRiFD9J7zLMBdOLgmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Q0yap4G2qw5g7RqguxAqHG2Us9bXkWjc2h/9aKLwVFATUe8mS6aXQcOUwpVxF3bHOO
         mdPhDQ0WoWdpfmgzWkEvaIcJ6Tj33DkBLUsVzGH4d8GVYhHXbVTrVF+6OcDji6yvAVG3
         0tz+CcjbSqSTUmrSAnpmnpZgLUvzdMpUeZGnI=
Received: by 10.223.56.220 with SMTP id z28mr1801325fag.11.1301002062311; Thu,
 24 Mar 2011 14:27:42 -0700 (PDT)
Received: by 10.223.117.78 with HTTP; Thu, 24 Mar 2011 14:26:42 -0700 (PDT)
In-Reply-To: <0014af8a-3b24-4398-88aa-7a3e460f2283@s11g2000yqh.googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169946>

On Thu, Mar 24, 2011 at 9:16 PM, Barthus <magnus.kallstrom@gmail.com> w=
rote:
> I am trying to clone a subversion repository that has a branchname
> with a trailing space. Since I can't find a solution I downloaded the
> code to try to understand the problem. Since I am not familiar with
> perl it is a bit hard for me. This is what I have found out so far:
>
> In git-svn.perl:
> tmp_index_do is called and tries to create the folder with the
> trailing space (under svn/refs/remotes) with the following line of
> code:
> mkpath([$dir]) unless -d $dir;
> reading the solution above, I figured that I should be able to
> "sanitize" the path -reusing som code already existing in the script:
> =A0 =A0 =A0 =A0sub refname
> I then tried to:
> git svn fetch
>
> Now the folder gets created, but then some lockfile is supposed to be
> created (with the trailing space in the path), and it fails again.
>
> I have not been able to locate the call that tries to create the
> lockfile (yet), and I guess there will be more fileoperations made to
> the folder. If I manage to figure out the code my theory now is to
> "sanitize" the branchname in the structure where it is contained when
> it comes from subversion (possibly adding a "sanitized" storage to no=
t
> destroy the original name if it is needed), and see if the clone/fetc=
h
> can continue.
>
> My hope is though, that someone who understands this maybe can fix it=
,
> or maybe point me in the right direction.

This kind of question is usually better to ask on the main Git mailing
list, as it's not really Windows specific.
