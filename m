From: Jundong Xue <tomxue0126@gmail.com>
Subject: Re: [PATCH] Can show relative date of the commit with future timestamp
Date: Tue, 21 Aug 2012 17:17:30 +0800
Message-ID: <CA+P7oHt2Vsy+UBMuEvSXeK+bhArRa=NWT1C=NO0qRS5t9gFE6Q@mail.gmail.com>
References: <1341505087-13632-1-git-send-email-tomxue0126@gmail.com>
	<7vy5myqftw.fsf@alter.siamese.dyndns.org>
	<CA+P7oHuCbeJ5shfL5OVhSypgygzmQwn-RGPD8UvFUFuqnoV9fA@mail.gmail.com>
	<CA+P7oHtGsBoRGsUzg4qqm7sZJ=+1Jh06Gmj1uw+k0-S9Gk+DXQ@mail.gmail.com>
	<7vsjbhgotj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 11:17:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3kag-0007dT-9w
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 11:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190Ab2HUJRd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Aug 2012 05:17:33 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48896 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350Ab2HUJRb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2012 05:17:31 -0400
Received: by ialo24 with SMTP id o24so3236345ial.19
        for <git@vger.kernel.org>; Tue, 21 Aug 2012 02:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kilPSKhug6pgNdJi6/N+Bi0TmO8d5eNMk59SPRMk77w=;
        b=X52LVG/w51whBdRyQ696hZ1+vPTIbXMd7Of27aAyuNUbMJ4gy3vP6dGZ70qODU2Zvr
         Z/MJaXnAdXu6n9yV52kC3KXzcCSXgUcVwuemsziymRlGoyDxSXs4E6NXS6/bMB3iM/qI
         8AkeAcvR5XUsaavPhfA9XZ4u43S9PWX0igSsI1EHWS1k1PElZzPcQBJeiA6CUSd7/bEm
         XlLftbN2NRpQVGCbgwi3Wc2EIXheeyXTh3Nk3dH3O4KaUcNXvKjTA7jPdry+4Xd5hrol
         D0kCuyLQShQutRXjQiXC+bpMnVW46OUBZxs/pzittOnP56evSnLXHPWnEdPy5GijN8r/
         ot4w==
Received: by 10.50.17.132 with SMTP id o4mr12561820igd.17.1345540651185; Tue,
 21 Aug 2012 02:17:31 -0700 (PDT)
Received: by 10.42.173.197 with HTTP; Tue, 21 Aug 2012 02:17:30 -0700 (PDT)
In-Reply-To: <7vsjbhgotj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203957>

Thank you for reconsider my patch! As you said, my implementation is
not good while the idea is not bad.
I checked out the latest git source code and patch it with your
replacement, and it looks nice, I like it.

This patch comes from my real need. And I think someone may need it as
well. To be honest, this is my first submitted patch in my life.


On Tue, Aug 21, 2012 at 6:51 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jundong Xue <tomxue0126@gmail.com> writes:
>
>> tomxue@ubuntu:~/mycode/life$ git todo
>> * d768da9 - (in the future: 3 hours later) Meeting with vendor =A1=AA=
 Tom
>> Xue (HEAD, master)
>> * 5fcd556 - (in the future: 12 days later) Take my personal holiday =
=A1=AA Tom Xue
>> * 9dd280b - (in the future: 11 months later) =B6=CB=CE=E7=BD=DA =A1=AA=
 Tom Xue
>> * 4680099 - (in the future: 9 months later) =C7=E5=C3=F7=BD=DA =A1=AA=
 Tom Xue
>> * 59d5266 - (in the future: 8 months later) =D4=AA=CF=FC=BD=DA =A1=AA=
 Tom Xue
>> * b5308da - (in the future: 7 months later) =B3=FD=CF=A6 =A1=AA Tom =
Xue
>> ...
>
> I was re-reading the backlog and after looking at it again, I do not
> think what the patch tries to do is a bad thing.  There are changes
> I want to see _how_ it is done, though.
>
> Especially, the duplication of the exact same logic in the future
> and in the past is an unmaintainable mess.
>
> I have queued a replacement in 'pu'.
