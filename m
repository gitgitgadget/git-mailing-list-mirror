From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sat, 7 Sep 2013 21:52:16 -0500
Message-ID: <CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<20130904092527.GB22348@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 04:52:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIV71-0000K4-FZ
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 04:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798Ab3IHCwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 22:52:24 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:44623 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770Ab3IHCwS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 22:52:18 -0400
Received: by mail-lb0-f172.google.com with SMTP id x18so3989559lbi.17
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 19:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EtpdlqJ9UWNhFfxf56ZpUbiMMiiAMlxzIA1AfFVdFD4=;
        b=OMYMNfHZFW8B8/ejmvdBt6vCggqBVLXhlm3Uxz8898epSxUPte/wyq9kGNxUXAJuVY
         FSwjtzsSQLRnNLB5YlojxYp5vn43ZzGYDsd4SZ9xzR2ihBv7yyk0n3C0h6m+6xrB1nhB
         uoYoztxhawIIi3C9+Hpw2Gj3eIpdtKPfES7sQHKmrU3B0+3aZFbRDLrFYVM8i/heUnGD
         5rqo7FneFYjEvmL120KVV1WIzBdEDOF0nydxgdi4+pfr8IWSUHbLJJwNy4+lsVYiAd96
         y+3faW66OD/SATO1gp9Dd/Cb2IzmfcVvWIPCmrlouT0lRpAWOU29VOMCgo7PLDkN4jxx
         AbMA==
X-Received: by 10.112.168.35 with SMTP id zt3mr9813259lbb.11.1378608736959;
 Sat, 07 Sep 2013 19:52:16 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 19:52:16 -0700 (PDT)
In-Reply-To: <20130904092527.GB22348@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234166>

On Wed, Sep 4, 2013 at 4:25 AM, Jeff King <peff@peff.net> wrote:

> The patch in jc/pull-training-wheel talks about annoying old timers, but
> I think you may also be annoying clueless new users who simply want an
> svn-like workflow without thinking too hard about it.

How? Subversion would complain if you have local changes when you do
'svn pull', there's no notion of remotes, branches and merges are
rare, and forget about rebases.

>> > I do not think we know what we want is to affect "git pull origin".
>>
>> I consider "git pull $remote" to be an artifact of the way git-pull is
>> implemented on top of git-fetch; perhaps I'm missing something but I
>> can't see a scenario where this is useful.
>
> Imagine a workflow where each topic is in its own repository instead of
> in its own branch inside a repository. Or where each developer has his
> or her own repository, but everybody just works on the master branch of
> their repository (or perhaps uses branches, but keeps master as a stable
> base). Alice is the integration manager; Bob tells her that he has work
> ready to integrate.  She runs "git pull ~bob/project", which will merge
> Bob's HEAD.

These integrators should know what they are doing, so they can do 'git
pull --merge', or better 'git config pull.mode merge', as Linus
himself suggested (or something like that).

The defaults should care most about the clueless users.

-- 
Felipe Contreras
