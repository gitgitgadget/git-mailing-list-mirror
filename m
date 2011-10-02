From: Grant <emailgrant@gmail.com>
Subject: Re: Does git have "Path-Based Authorization"?
Date: Sat, 1 Oct 2011 20:34:43 -0700
Message-ID: <CAN0CFw3ZDcXtD7WChjkT1Vg0cU_u==4KCHo8ff-ccbyxZ8xWjg@mail.gmail.com>
References: <CAN0CFw0QXkNSF8+qGu+pCrv5dgy1OEvtq-53f23GRd4RrZ1GcQ@mail.gmail.com>
	<m3lit4oo9q.fsf@localhost.localdomain>
	<CAN0CFw3kzAgaVBKNHE5ttJgYnc_csjeHjOLq=EBjLizW=RPUkA@mail.gmail.com>
	<CAMK1S_icdpCyA8SBcNu8CbCk3N-h8yEYZ9+6N=JVPAeayuzSPw@mail.gmail.com>
	<CAN0CFw2gVH7=LdKhseE3zo+Av_=kVdz=tH3s=BKeTK9bDOprcw@mail.gmail.com>
	<CACsJy8B2rhXvGKUsu10Po8cCi7p8uqWXWE5ZHB2Z6hH-aMyR2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 02 05:34:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RACpF-0004Wy-9o
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 05:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618Ab1JBDep convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Oct 2011 23:34:45 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40775 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab1JBDeo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2011 23:34:44 -0400
Received: by eya28 with SMTP id 28so1996843eya.19
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 20:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=UkniQ8Icy/WbAYyiF+IoaBIdzfmv3E/S9dahwzDcyTs=;
        b=OgBG76AFXUGkM0KnnhvaN02eetOfFNyj/UbAtcqSlz+MuMnMKPYzdjLvXhcigFtVUF
         Nnm44RWp/W+3Y0g7WQkiWKv1bl2Iw0KME6t7pPpBIWFBfCIlY/xrmMP1VHFI/FZ2jHud
         uDFvXTsm/ZRMGeXVhKr9vWks0EosnlWyAKKBQ=
Received: by 10.213.19.20 with SMTP id y20mr384667eba.27.1317526483367; Sat,
 01 Oct 2011 20:34:43 -0700 (PDT)
Received: by 10.213.4.136 with HTTP; Sat, 1 Oct 2011 20:34:43 -0700 (PDT)
In-Reply-To: <CACsJy8B2rhXvGKUsu10Po8cCi7p8uqWXWE5ZHB2Z6hH-aMyR2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182590>

>> How would something like that work in a case like mine where I have =
a
>> series of maybe 100 files and I only want to give my developer
>> read/write access to one or a few files at a time with no read or
>> write access to any of the other files? =A0Wouldn't setting up a
>> different repo for each set of files be difficult to manage?
>
> The write part is easy. Just setup hooks to reject updates on those
> files (however, notice the offline nature of git, people may commit
> locally and the push later, you may need to check commit time on your
> hooks).
>
> The reading part is hard, especially the way you put it ("at a time")=
=2E
> The only way I can think of is to not download those objects and try
> to fetch from central repo every time the objects are read,
> essentially turn git into a central scm again. Git does not support
> this and may never do unless there's an reasonable use case.
>
> So I have to ask, why do you do it this way? Once you give read-acces=
s
> to a developer, he/she can always save the files somewhere, revoking
> read access later on would be useless.

That's true.  I hope to be able to give different developers access to
different parts of the code.  I really don't know if this will work.
I just don't want my code to be stolen and I'm trying to find some way
to prevent that from happening.

- Grant
