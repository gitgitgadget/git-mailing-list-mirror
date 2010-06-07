From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: branch --set-upstream considered harmful
Date: Mon, 7 Jun 2010 01:19:39 -0400
Message-ID: <AANLkTildT6TRd0sPlv1QbCLO7oOPHM-L1yWNIdhdp0ex@mail.gmail.com>
References: <AANLkTiln_xxnF-e33YA7kkfbBBcBMd40xag8JTW0eqws@mail.gmail.com>
	<AANLkTikUkkWQl7cYuPiKGaJFYL_JlIGFCXXf7En8t0FN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 07:19:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLUkY-0005c0-2e
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 07:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398Ab0FGFTk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jun 2010 01:19:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33718 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab0FGFTj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jun 2010 01:19:39 -0400
Received: by iwn37 with SMTP id 37so3007334iwn.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 22:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ADdQKswsmr9gunRgdnDL2PJCd/HmLUc/ZP6mvGh9Weo=;
        b=ndoGB3avdUUtiiFMvD9IZqS8OUt6k+FhbMA71jsikXmVSSid/CjGwXuoA2S7Yyjvmp
         8Y7VA0m5EBP+OiGtIgqgII0x9Paa4LCsIkKkOHO7bv5eFsgr1EOqhT/qGgEi7CugGIB/
         S6j/CrcwQu5UW5t4B28XLcFq8yNubG52MADgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MTfM+Ky8YUXtPyzjkM2a9p5J7gFs45QWtM81MBB9O2PQbGG3kDF5q+DjMfMG6ls780
         vMWkZupmBX0AtfO72zWtX9BluElDZL8YpNtp5/jynKm9rMsC9HMw1TOVTJ7qz6I9YyVQ
         5r7whDlcrWGitcRmyBsOpTOMbPM3rE/eYSR4I=
Received: by 10.231.178.132 with SMTP id bm4mr1125165ibb.62.1275887979120; 
	Sun, 06 Jun 2010 22:19:39 -0700 (PDT)
Received: by 10.231.16.134 with HTTP; Sun, 6 Jun 2010 22:19:39 -0700 (PDT)
In-Reply-To: <AANLkTikUkkWQl7cYuPiKGaJFYL_JlIGFCXXf7En8t0FN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148572>

On Mon, Jun 7, 2010 at 1:10 AM, Tay Ray Chuan <rctay89@gmail.com> wrote=
:
>> =C2=A0(topic)$ git branch --set-upstream origin/master
>
> Hmm, I can see where the confusion is coming from - you're treating
> git-branch as a "branch modifier", when it really is a "branch
> creator" - unless you use -f, of course.

Given --set-upstream's implementation and documentation, I assume it
is primarily intended to be used with an existing branch:

       --set-upstream
           If specified branch does not exist yet or if --force has bee=
n
           given, acts exactly like --track. Otherwise sets up configur=
ation
           like --track would when creating the branch, except that whe=
re
           branch points to is not changed.

If it isn't, then there's no way to do what it does other than two
magical git config commands.

>> =C2=A0(topic)$ git branch --set-upstream=3Dorigin/master
>> =C2=A0Branch topic set up to track remote branch master from origin.
>
> I was under the impression that long-style options took "=3D".

Git is inconsistent. Some do, some don't. But --set-upstream is
currently an argumentless switch. If I were to proceed as I suggested,
it would be both an argumentless switch and an option which takes an
argument. That means these would be equivalent:

$ git branch --set-upstream=3Dorigin/master master
$ git branch --set-upstream master origin/master

But these WOULD NOT:

$ git branch --set-upstream=3Dorigin/master
$ git branch --set-upstream origin/master

j.
