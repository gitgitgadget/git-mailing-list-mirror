From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Symbolic refs and the git protocol?
Date: Mon, 26 Sep 2011 19:53:24 +0530
Message-ID: <CAMK1S_gfw4WUdhdCzFMNbJXJP7762tp62fpmQ_-qJLwvD1hR-A@mail.gmail.com>
References: <4E7F29EB.8000800@redhat.com>
	<CAMK1S_joYUKPXDKyomFdbDP4H0UhcwtNQbC89gvNZOTHowYrLw@mail.gmail.com>
	<4E7F313A.2050103@redhat.com>
	<CAMK1S_g1Co8vogBuObQVsr+nT09urYs+qifJn1X+eGrkgUQZCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	John Hawley <warthog19@gmail.com>
To: Avi Kivity <avi@redhat.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 16:23:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8C5i-0000DW-7a
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 16:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327Ab1IZOX0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 10:23:26 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39762 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab1IZOXZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 10:23:25 -0400
Received: by vcbfk10 with SMTP id fk10so2820342vcb.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 07:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=o9VULV019+zSl+DT1Vf38ivrh8STZCyb4nnP1SAA+yU=;
        b=pcBO/ird3O3LLeG2Im2CknedHUX7YRlu7BBm4AJo3mIeFrXhePq/ym9p4YT2F6WlpE
         pkqFGlhSOuLPgTWSLcNESuyJnj+quw4xBA0e3bZXGknxLBRjurdsPdeGJG0fRuCGG66K
         UPqM35cVhKpQ7UYUIhMECD4mZUjkX1EmMFEAg=
Received: by 10.52.26.226 with SMTP id o2mr6269389vdg.474.1317047004794; Mon,
 26 Sep 2011 07:23:24 -0700 (PDT)
Received: by 10.52.160.161 with HTTP; Mon, 26 Sep 2011 07:23:24 -0700 (PDT)
In-Reply-To: <CAMK1S_g1Co8vogBuObQVsr+nT09urYs+qifJn1X+eGrkgUQZCA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182115>

On Sun, Sep 25, 2011 at 7:40 PM, Sitaram Chamarty <sitaramc@gmail.com> =
wrote:
> On Sun, Sep 25, 2011 at 7:18 PM, Avi Kivity <avi@redhat.com> wrote:
>> On 09/25/2011 04:42 PM, Sitaram Chamarty wrote:
>>>
>>> On Sun, Sep 25, 2011 at 6:47 PM, Avi Kivity<avi@redhat.com> =C2=A0w=
rote:
>>> > =C2=A0With the old kernel.org setup, practically the only think I=
 needed to
>>> > do on
>>> > =C2=A0the server itself is the 'git symbolic-ref' command (used t=
o point
>>> > =C2=A0refs/heads/linux-next at the correct stream).
>>> >
>>> > =C2=A0Now it looks like kernel.org will no longer offer shell acc=
ess. =C2=A0Is it
>>> > =C2=A0possible to support symbolic-ref via 'git push'?
>>>
>>> Can I assume you mean specifically for HEAD, as in 'git symbolic-re=
f
>>> HEAD refs/heads/some-branch'?
>>
>> No, I use them for ordinary branches, for example
>>
>> =C2=A0git symbolic-ref refs/heads/linux-next refs/heads/kvm-updates/=
3.2
>>
>> from this point on, any update to kvm-updates/3.2 will be reflected =
in the
>> linux-next ref.
>>
>>> Although gitolite disables shell access by design, it provides seve=
ral
>>> (optionally installed) features to allow specific shell commands to=
 be
>>> executed. =C2=A0One such command is "set-head", which does exactly =
what you
>>> ask. =C2=A0You run it like 'ssh git@server set-head reponame.git
>>> refs/heads/foo' and it ends up running 'git symbolic-ref HEAD
>>> refs/heads/foo' in the repo.
>>>
>>> I realise that does not answer "can it be done via git push" but I
>>> thought it might help...
>>
>> Well, if set-head can be extended a bit, it would suit me perfectly.
>
> no reason it can't; shorn of all the argument/access checking, it's a
> very simple shell script

Done.

https://github.com/sitaramc/gitolite/commit/a2fd597c51a086a0f7298c16413=
37faa0f296a62

I like this much better actually, so thanks for the idea.
