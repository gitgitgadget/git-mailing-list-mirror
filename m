From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/34] Add t1510 and basic rules that run repo setup
Date: Wed, 27 Oct 2010 11:30:47 -0500
Message-ID: <20101027163047.GA11069@burratino>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
 <1288190977-30875-3-git-send-email-pclouds@gmail.com>
 <AANLkTiknZEp8EoHr6auqUQQsMj+MvLwhUYxzUD9N-6L4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 18:31:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB8tw-0004bz-Fv
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 18:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800Ab0J0Qa4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 12:30:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45103 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab0J0Qaz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 12:30:55 -0400
Received: by iwn10 with SMTP id 10so1046617iwn.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ksms63zkUbsFtR05IUQEvjIn/Mgo+iWS9QcG39xhPW0=;
        b=rpVyRJMTOoMyuEt4t3K0vH4+rJMTwwVtyKszo9ut+4LBdptodtJ3f+FFiUlGzZZW0h
         mirKofl1wFEaWVvGsxXmfBMqz1WjMlEG2VvN9tZlcOhoDQRWLbL47Ee2cpwIZ09Wmunm
         izqArsmSMqgPbLie9F5DF/ETlyY6mS7HjrBUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=W3CXNMNWtd9uDS6tVitvbQaAysdBbRBuMaZ37fHK5LTudJtPkpLNIRxHw9loY8Uv81
         ivnssYbwIVkYJaIfko2bZM3AsLJEuVSmGP98qnPDdnUkNj4gW43soKHzZxbepukY2+ys
         dYofVuK7S4elOHlmAo4ksE0lxQkaNxKtI6p0U=
Received: by 10.231.190.199 with SMTP id dj7mr8985186ibb.182.1288197054325;
        Wed, 27 Oct 2010 09:30:54 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 8sm11557278iba.10.2010.10.27.09.30.52
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 09:30:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTiknZEp8EoHr6auqUQQsMj+MvLwhUYxzUD9N-6L4@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160097>

Nguyen Thai Ngoc Duy wrote:
> 2010/10/27 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>:

>> +# 2. .git file is relative to git_dir. .git file is basically symli=
nk
>> +# =C2=A0 =C2=A0in disguise.
>
> This is not completely followed in my tests. If .git is a true
> symlink, its link is relative to .git itself. When .git is a file, it
> would be more difficult to calculate path relative to .git (you can't
> chdir to a file).

I'm not sure I understand:

 git init repo
 cd repo
 mv .git .git.real
 ln -s .git.real .git

The path ".git.real" is relative to "repo/", not "repo/.git/", no?
=20
In other words, I don't you think you have to worry --- the test

> In my tests, the link is relative to .git's parent
> directory, not .git.

seems right.
