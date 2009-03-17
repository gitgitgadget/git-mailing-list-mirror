From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 1/5] Check for local changes with "goto"
Date: Tue, 17 Mar 2009 10:51:08 +0000
Message-ID: <b0943d9e0903170351p319bad36icf8252610e5c4f05@mail.gmail.com>
References: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com>
	 <20090312120856.2992.48548.stgit@pc1117.cambridge.arm.com>
	 <20090313015755.GA15393@diana.vm.bytemark.co.uk>
	 <b0943d9e0903160756g79ac3464i4bb6f7f61ba0555a@mail.gmail.com>
	 <20090317070654.GA3716@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 11:52:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjWub-0007X9-33
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 11:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777AbZCQKvO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 06:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754936AbZCQKvN
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 06:51:13 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:54208 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338AbZCQKvM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 06:51:12 -0400
Received: by fk-out-0910.google.com with SMTP id f33so1602417fkf.5
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 03:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vjF2sfGn3sMPnsCxpricsqKeRyOYFFMiztNOBxpKDds=;
        b=nXEwfb9Wl9F7H9JlGrnwDWw18SKic/16aw9TmCnVa4fbd4wL1XyElWGrCuAsRcb/1c
         +1EoGMv2Hbjb59Ffpr92B98Uql/3FLvW8et9cEc8rygBTUR/FVNXlVcI585g57V3g5Fp
         Ni55cJOHDyxJ8zun7L2yS/sQyEe1ncRWeCl9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IArJEM/k5cATb1MrkUh8iR+XesPRuxj33rjZc8afy5Cwy3zKakz662d7FLlkpbQ91d
         9FH18E5LLZSPHxs+bEFwlNY+JlnWpjBIWndmgkl81O965D98zYG2bh9zkyHsidZ43fqI
         l1gxFfI2KpaMuotJe3WtjTNaoEYCvRi4uPFmw=
Received: by 10.204.65.17 with SMTP id g17mr1995262bki.193.1237287068542; Tue, 
	17 Mar 2009 03:51:08 -0700 (PDT)
In-Reply-To: <20090317070654.GA3716@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113457>

2009/3/17 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2009-03-16 14:56:11 +0000, Catalin Marinas wrote:
>> if not iw.worktree_clean():
>> =A0 =A0 self.__halt('Worktree not clean. Use "refresh" or "status --=
reset"')
>> if not iw.index.is_clean(self.stack.head):
>> =A0 =A0 self.__halt('Index not clean. Use "refresh" or "status --res=
et"')
[...]
> Your version doesn't generate the "Your index and worktree are both
> dirty" warning, but I guess that's OK.

The iw.worktree_clean() only checks whether the worktree is clean
relative to the index (I just tried "git update-index --refresh" after
"git add <modified file>" and it returns 0).

--=20
Catalin
