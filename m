From: Eugene Sajine <euguess@gmail.com>
Subject: Re: ident hash usage question
Date: Tue, 20 Oct 2009 19:49:48 -0400
Message-ID: <76c5b8580910201649i76d14f8bod9a84afa6ea6bbb0@mail.gmail.com>
References: <76c5b8580910201024x58ffdd3bs6f4cc6932ac31868@mail.gmail.com>
	 <81b0412b0910201116s694d7877rda872b368f1ae09a@mail.gmail.com>
	 <81b0412b0910201119w7583487ag276cf964d0a85e@mail.gmail.com>
	 <76c5b8580910201159i75a90f28pb882e83f0c7c40ae@mail.gmail.com>
	 <81b0412b0910201219q4d16c472n43cab4b5d17cf63c@mail.gmail.com>
	 <76c5b8580910201330r45cf625k3a41b5b9e24b3e01@mail.gmail.com>
	 <7veioxn6ee.fsf@alter.siamese.dyndns.org>
	 <76c5b8580910201514sc44f1cag222cf8a3710c875@mail.gmail.com>
	 <7vbpk1lmvl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Eugene Sajine <euguess@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 01:50:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0OSl-0005I1-K9
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 01:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbZJTXtp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 19:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbZJTXtp
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 19:49:45 -0400
Received: from mail-gx0-f216.google.com ([209.85.217.216]:34926 "EHLO
	mail-gx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbZJTXto convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 19:49:44 -0400
Received: by gxk8 with SMTP id 8so6744087gxk.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 16:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1HHH5nZHDObgugcMmhq6t/HBGEW2Yj5gt6+U2V/HC44=;
        b=kQUi0vMhjENmYtAN/HXnzHhNdooSZkPVJ8dpxlJfwGXdihQeecE4z/VnJfTPyc9fkP
         QaYooaEChqGT2skKDTk79NgDBbvzstqul10eKUFW1BKcMFQ/eA6IZM8bXoWsKWmL/XSv
         2eLLNRgTA/XhA/b5akwXcudRf2tPZoCwcQ1kI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aXlYqd+PTOnfYASiw6UxOO6yNrYk0T56xU/IJ/rAygClBvam9W3I02hNJ5lXJShPlW
         55O/ElfNQlIKiw1hBh6q91EUvCFeDH5T94eiJaMdZpOkAojrsjjKNtG5rBduM3trdiMj
         GrO/vpZ0nbMaWmn8KNKxFouOZSgkRe0oMEMH8=
Received: by 10.90.61.31 with SMTP id j31mr2924251aga.3.1256082588719; Tue, 20 
	Oct 2009 16:49:48 -0700 (PDT)
In-Reply-To: <7vbpk1lmvl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130870>

> I am not sure what you mean by "static linking" anymore. =C2=A0Usuall=
y the word
> means that everything you tell the linker to link to the executable i=
s
> linked, together with objects from libraries. =C2=A0The resulting exe=
cutable is
> usable on its own and it does not change behaviour regardless of whic=
h
> version of dynamic libraries you depend on happen to be installed on =
the
> target system (because by definition a statically linked executable d=
oes
> not depend on dynamic libraries---that is the whole point of static
> linking).
>

There seems to be no misunderstanding in the static linking - i meant
the same thing. But let me put an example:

I have a program.exe

This program.exe is built basing on two statically linked libraries
lib1.lib and lib2.lib

I'm not developing any of those libraries, but only my own code of the
program.exe

Now, somebody changed 2 files in lib1.lib and 5 files in lib2.lib. But
i don't know that they are changed because it is different CVS module
or because I'm building against latest released libs or for whatever
reason...

When i rebuild my program the build supposed to pick up changes from
the libraries I'm using and relink, that will include 7 changed obj
files.

How can i say which exactly files are changed in my new version of
executable comparing to the previous version?

Currently they can take a look at the revision number of every
particular file included into the executable, which is put there by
CVS and compare it with the production. If the version is different,
then you know which files are changed and you can get diffs on them...
They also have file path and date and other stuff expanded...

Please note, my personal goal is *to prove that git can do that
better*, with less intrusion into the code sources, not other way
around.So, while keeping the info they want to have they might get
some benefits of git. Although, i understand that there might be no
cure for this state already, you can tell me that and I will close the
topic, but I just keep hoping;)


Thanks a lot,
Eugene
