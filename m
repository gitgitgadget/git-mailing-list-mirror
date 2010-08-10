From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Black smoke from git rebase -i exec
Date: Tue, 10 Aug 2010 13:57:05 +0000
Message-ID: <AANLkTimgRu=nRFpO+QW758SWbQ+Vs+8gtpAc4N-cNWr6@mail.gmail.com>
References: <AANLkTikCgSNRipTbjiL+uPOqCL3WXwn08_QV=UJ7EwvT@mail.gmail.com>
	<vpqlj8ezizq.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 10 15:57:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OipKN-0004EQ-8r
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 15:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757670Ab0HJN5K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 09:57:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52976 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439Ab0HJN5H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Aug 2010 09:57:07 -0400
Received: by fxm13 with SMTP id 13so664554fxm.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 06:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Y8Q0w5scAIoiXPjGMlUyVfdC8fkryFdsfatlUGgflC0=;
        b=Csm1m4unrB83ADw2L9g817KHRmSAznYzUjD0cFHpj+ko8GbVG3e3e2lKikurBHSjLi
         zDVfoOpW3Gf1L3RDRJHik+EOfmZYnqHJ5y64NtBEI1qsD9FKsyrKd9eFUczjIyFYJdgo
         NIgIP68/WXo0nAsRDgy+HLsUnehdqNYAPwuEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b4J1pgJP7DBZ5uPtO6WcyclT7gtXtBeNKbeP28q3EVSr0sln/+WxBfMWtxHHJIPIhG
         0FJzDsMqvB7UF74Y9xJRPSe8KS472yRUh6hvkkrBVakjl4VmigruqIlJN5rgRNzwvX1W
         0wYoeJsrQYzlXA2AcuRVCtJE44AhyRsWA/yok=
Received: by 10.223.117.194 with SMTP id s2mr18216572faq.57.1281448625466; 
	Tue, 10 Aug 2010 06:57:05 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Tue, 10 Aug 2010 06:57:05 -0700 (PDT)
In-Reply-To: <vpqlj8ezizq.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153107>

On Tue, Aug 10, 2010 at 13:37, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason <avarab@gmail.com> writes:
>
>> There's some black smoke in pu after the git rebase -i series was
>> applied: http://smoke.git.nix.is/app/projects/report_details/14
>
> Strange, I can't reproduce this on my box (tried on RHEL x86_64 and
> Debian i686).

Hi. The issue appears to be that there's some non-POSIX code in your
patch (but I didn't check what). The test works for me with bash, but
fails with dash (which is the Debian testing /bin/sh).

Can you try with dash or some other non-bash POSIX shell and see if it
fails?
