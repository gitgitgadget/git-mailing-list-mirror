From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git-status and git-diff now very slow in project with a submodule
Date: Fri, 21 May 2010 14:36:14 +0200
Message-ID: <AANLkTineTiY0blcQlTRWl-1Q-be6J-EOll2DMReKcUOF@mail.gmail.com>
References: <ht3194$1vc$1@dough.gmane.org> <ht3sda$cvo$1@dough.gmane.org> 
	<4BF57635.9090409@web.de> <201005201901.49853.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 21 14:36:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFRT0-0006m6-K7
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 14:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566Ab0EUMgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 08:36:37 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54766 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801Ab0EUMgg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 08:36:36 -0400
Received: by fxm5 with SMTP id 5so780505fxm.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 05:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=NlsYHy89sNvObR+XA80xJf3GLJLjO8PcNgSXX4KkXgM=;
        b=iXTSLIxG5gGVKYlzD2fuxoWy5E27Y9sCMx+MQRNWijrYdufnGPj9tTsQf+LcQMwCRI
         ukFZde2ktEjuUlLrsAQJSxObP1P9WPcAJwQCHYU1t4DVbc/KfdftUh+wj2+5o96nr/CT
         6o/auQb1c4JY1BuGCKmD/rBjvMGV+oObweZiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ruaMg3n/MGteE739WJRLwBgFd/Tdh7YzM95MGmrf3rBOQemwF6kFs8lN30F3Gxyhbr
         Kw1kmh6ltjNeS7DISx1LpkfVPBjYCvWCtPC9N06pcR2ArjJJ+7eHMXxwTfEPPfZSkYrZ
         BwADzjGSCYDazo3AnYLvsJGzMaPkRHG5qtc2A=
Received: by 10.204.13.65 with SMTP id b1mr22060bka.188.1274445394582; Fri, 21 
	May 2010 05:36:34 -0700 (PDT)
Received: by 10.204.70.79 with HTTP; Fri, 21 May 2010 05:36:14 -0700 (PDT)
In-Reply-To: <201005201901.49853.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147449>

On Thu, May 20, 2010 at 8:01 PM, Andy Parkins <andyparkins@gmail.com> wrote:
> On Thursday 20 May 2010 18:49:41 Jens Lehmann wrote:
>> Am 20.05.2010 19:45, schrieb Andy Parkins:
>> > (Most of my
>> > personal use of submodule is embedding large projects that I want to be
>> > able to guarantee are at a particular version, but I don't really
>> > change them)
>>
>> But to guarantee they are at a particular version they have to be checked
>> for local modifications (no matter if they happened accidentally or on
>> purpose), no?
>
> A valid point.
>
> Surely though in my own .git/config I can be allowed to tell git that I
> don't care about that risk?
>
> I've got a top level module that used to diff/status instantly; now git
> scans an entire Linux kernel checkout and an entire ffmpeg checkout.
> Painful.  I fully accept that it was my own choice to arrange my repository
> in this way, but in my defence, it was fine last week :-)

Sounds similar to the old "slow lstat" stuff. How about setting
assume-unchanged bit on submodules? I don't know if it works. If it
does not, maybe we could reuse the bit to ignore changes in
submodules.
-- 
Duy
