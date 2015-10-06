From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: git interactive rebase bug?
Date: Tue, 6 Oct 2015 10:41:03 -0700
Message-ID: <CA+P7+xoajj5HL1Tn=CBNg72Po1Jy8yrUBvoD=c=3yYvLCRCGuA@mail.gmail.com>
References: <CA+P7+xqMFFtVPnZ7Pw9B9oYXHe5N=Ectyd-M+_aGb2NKjRvLAg@mail.gmail.com>
 <vpq37xopjwh.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 06 19:41:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjWFG-0007aD-BL
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 19:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbbJFRlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 13:41:42 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:35389 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbbJFRlX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 13:41:23 -0400
Received: by ioiz6 with SMTP id z6so229881239ioi.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 10:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fy/uq29MpujESEuc95zdIlu07p3JD/0ooSRVCtd+oX0=;
        b=a7jypPOa9/247Ua57CcoIqCoP+KUXM1T2XBjnNVVuXubfgWMhe+K2jGseHBg8O2U7K
         LBN/wi8bn2xedesNaBsc5y8pSUFIeY5/rVZ2xnglK/VxO0Y1Z/1aw08xY/QWGZJhxVOu
         nqEOp6+v/3O5fncKsWO2W0Q2T5kcbBfR4DuBWUixJBcPvfhhdIgXxR+FSVrSW8PTRle3
         UUzLmBb3dVClObkjVPp7Tv4Qs7imDOwYuTkkiGQTYi7qwOmJ6M6CO367otZA8ukJ2ALU
         wr31RpCeE/y7GRFu9zAOkjeHN5Ri0+xzUEzlKyhDrxY+CDd1XVZESOGLD8WAXdMvH4vl
         uUDw==
X-Received: by 10.107.133.151 with SMTP id p23mr44697523ioi.71.1444153282773;
 Tue, 06 Oct 2015 10:41:22 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Tue, 6 Oct 2015 10:41:03 -0700 (PDT)
In-Reply-To: <vpq37xopjwh.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279154>

On Mon, Oct 5, 2015 at 11:53 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> I've been experiencing a very annoying bug when performing interactive
>> rebases. The rebase process will stall after I close the editor, and I
>> have to kill the process and then restart the rebase using "git rebase
>> --continue"
>>
>> I am not sure how to debug this further. Suggestions are welcome.
>
> First, I'd try "pstree" ("pstree -p" to get pid) to see if your editor is really dead.
>
> Then, "strace -p" on the git process, to see if it's doing some system
> calls while hanged, or if it's hanged on a particular syscall.
> Hopefully, this will yield some "open" calls and tell you which files
> Git is currently working with.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

And of course now I can't get it to fail at all. It did hang one time
for about 15-20 seconds and then worked, and suddenly no longer has
issues... I'll try to remember these two tricks incase it does hang
again and I'll report what I find.

Thanks,
Jake
