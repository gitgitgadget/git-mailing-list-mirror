From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: How to reorder all commits include the initial commit
Date: Sun, 18 Mar 2012 04:45:15 +0900
Message-ID: <CAFT+Tg9UGdBxj5-DTpxDJRVgvBCnmkmgm6nzVek0KeELgsNneQ@mail.gmail.com>
References: <CAFT+Tg_DmqxiK1qw1YvNZtY07ZaZ89+JWohdWw2fm8f=6hAwiQ@mail.gmail.com>
	<m3k42jl2wn.fsf@localhost.localdomain>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 20:45:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8zZ4-00007A-Ev
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 20:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475Ab2CQTpS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 15:45:18 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45390 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511Ab2CQTpQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 15:45:16 -0400
Received: by iagz16 with SMTP id z16so7239870iag.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 12:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=IJBrXE8wHzi4lduSMowWNV6syYDoaNF4sOAOuGphqs0=;
        b=q1pe1N18J7iKfa8vqunPbrQbQ+nBUdJyl0cfvpCiY7UroMGSZAHlCWFLZ8f0ELLXQF
         ey3a9Lp1XLgD1/3cKaeTZgu2yyib2hV7u3JRaEpA5HxjHFH8HOayT+vyc4D4NQjv3gEh
         yK5szSQXhcbXjjxKQgEME7uiK9oUHVcgmja5J/5Ngwmx/+/NwONkSY0RDD/kBLJ34dAb
         /p0dhIL9c9MP4A2Jp+vnm93QFFKJIRx9CBChjWldvixYrcpO5voutCdydTpOcH387RdZ
         edMZeTBEpYIzUxwXBo59Vy+5izlYUECxJAdVxAz8b9uqvbDXU3ieOq0drQ1n2L3s7yEe
         I2Xg==
Received: by 10.60.2.6 with SMTP id 6mr7918699oeq.21.1332013515528; Sat, 17
 Mar 2012 12:45:15 -0700 (PDT)
Received: by 10.182.53.98 with HTTP; Sat, 17 Mar 2012 12:45:15 -0700 (PDT)
In-Reply-To: <m3k42jl2wn.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193347>

Thanks to David Barr and Jakub Narebski.
=46inally I found the way based on your hints to solve my problem.

$ git checkout -b test --orphan
$ git format-patch <newroot>^..<newroot> | git am
$ git rebase -i --onto test --root master
$ git branch -M test master

Please let me know if there is more simple way.

2012=B3=E2 3=BF=F9 17=C0=CF =BF=C0=C8=C4 11:26, Jakub Narebski <jnareb@=
gmail.com>=B4=D4=C0=C7 =B8=BB:
> semtlenori@gmail.com writes:
>
>> Sometimes, I need to reorder all commits, which include the initial
>> commit, in my branch.
>> So I tried it using git-rebase as follows, but it failed with the fa=
tal error.
>>
>> (supposing the initial commit is 793ea88)
>> $ git rebase -i 793ea88^
>> fatal: Needed a single revision
>> invalid upstream 793ea88^
>>
>> How can I do that?
>
> Use `--root` option.
>
> --
> Jakub Narebski
>
