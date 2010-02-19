From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Fri, 19 Feb 2010 08:49:44 +0100
Message-ID: <fabb9a1e1002182349h923d4acv55d9a41a249d4f51@mail.gmail.com>
References: <4B7D8358.1080108@gmail.com> <fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com> 
	<4B7E3856.3080609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 08:50:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiNcq-00068j-Gj
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 08:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706Ab0BSHuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 02:50:06 -0500
Received: from mail-px0-f191.google.com ([209.85.216.191]:62782 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754699Ab0BSHuF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 02:50:05 -0500
Received: by pxi29 with SMTP id 29so3965850pxi.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 23:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=FIMb5XDGnkPcTVQjRzxsNlrGRLMv5sVnGpYDG7Jqxu8=;
        b=pqqRVNmpxZWsLWrXCDUFsMpZhEy9FJq+CdDc/ZkUSlqvtlQcFcyIDh8kI000DYRyHm
         BR+EFb8L3jzrbKJjJAIcyp97w8sUvqU2dpRVn8R3WlEqfe/QGLBxOzl6fxSRlnx8ioMX
         94RkBOp8EpIO8Vw+6//LxzoYu6f2IJSn3VNQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=bkn6y1ClG3bSBLxXMIyD8K5GIZiV3Oi+mpy8hWfj4zuhatOjZjfzfPPcf7f76CG9gd
         sRXVVczNottT7wgzGVM/aVRn2mq69vZwrhucPdaNHDz/8wTNDmaMNo5tiKExKtwElyEu
         DqwWGgy71tRM88QUDwuI2TJN0xG8KeM1bigbE=
Received: by 10.142.195.14 with SMTP id s14mr6987309wff.186.1266565804081; 
	Thu, 18 Feb 2010 23:50:04 -0800 (PST)
In-Reply-To: <4B7E3856.3080609@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140428>

Heya,

[please do not cull the cc list, it is considered rude on this list]

On Fri, Feb 19, 2010 at 08:05, Gabriel Filion <lelutin@gmail.com> wrote:
> On 2010-02-18 13:37, Sverre Rabbelier wrote:
>> If you're interested have a look at
>> Documentation/git-remote-helpers.txt, and read the mailing list
>> archives on the subject.
>
> The Documentation/git-remote-helpers.txt file wasn't really of much help
> .. It really only barely scratches the subject, but it does not mention
> how remote-helpers really work internally (e.g. how do they get called:
> based on protocol used in URLs?)

True, I hope to document that better when I submit my git-remote-hg
implementation.

> I'm still trying to dig up information about how to actually build, test
> and use a remote helper. I'll probably be reading code for examples.

Perhaps you could benefit from looking at my git-remote-hg code so
far, I'll put it up on github [0] today as 'remote-hg'. If you're too
soon you'll see commit 21215675c as the head, which isn't that useful,
in that case just look again later :P.

> Another detail hit me: external interaction in git seems like it's
> almost always using librairies. If I'm not mistaken, bzr does not have a
> separate library. So to have access to it's API, you need bzr to be
> installed. This is why the current git-bzr script is using bzr +
> bzr-fastimport plugin to do the job.

That is part of the reason why the remote-helpers are implemented as
separate programs, so that whatever backend they interact with does
not become a dependency of git itself.

> Is it normal / acceptable for a remote helper to have such dependancies?

Yes, git-remote-hg depends on mercurial being installed.

> And for the language used, maybe python could be logical if I can bind
> directly to Bazaar's API. Tell me what you think about this.

Yup, that would make sense, you could put your code in
/git_remote_helpers/bzr/, alongside with the to-be-added
/git_remote_helpers/hg and /git_remote_helpers/cvs.

[0] http://github.com/SRabbelier/git

-- 
Cheers,

Sverre Rabbelier
