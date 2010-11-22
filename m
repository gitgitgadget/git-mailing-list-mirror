From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] bash completion: add basic support for git-reflog
Date: Mon, 22 Nov 2010 11:20:57 -0600
Message-ID: <20101122172057.GC2084@burratino>
References: <1290274368-3212-1-git-send-email-rctay89@gmail.com>
 <20101122152409.GA7010@neumann>
 <AANLkTinJPQF-khzViED+ROyojEr9nHrcgwKQWsDugD7Y@mail.gmail.com>
 <1290445749-4884-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	SZEDER Gabor <szeder@ira.uka.de>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 18:21:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKa4p-0001q0-9J
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 18:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938Ab0KVRVK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Nov 2010 12:21:10 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57675 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab0KVRVH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 12:21:07 -0500
Received: by vws13 with SMTP id 13so3524070vws.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 09:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/xCWVGAlSg+1uBuH8mPMbqpk+Vhf6KgCw2+/tdsShxg=;
        b=lctei51N0W0fFSyLq2+9GZETA54SzzEumgyVY30A1m3b1MFYJzOVr9Tel8N6OpNf/e
         pjhB+BRLonnPSkZU/raCX7C2L/6CGrnQgMSc88HCEZW5NJ4EWjHLTBP1ECxdcS3M7Ix6
         /XIvrNM5Cw4gMcaAxdxClaM+g5WCs0EYwiC0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hUg4TNIUcS0m5EMd8Y+hm71tHpadRpuipPFD/gbOvB8oh8ct6Ahfgp2ZWV1IeRsBgT
         tgZAhPV9MwkIaP75hseWV04CjSziWlzZalFBeoAd2+njRhHdLditRj++ZHDElb7QQOve
         5VXpCauIwAOlIdFvwJuhgbj5hbrpbVO8GsaSg=
Received: by 10.220.167.148 with SMTP id q20mr1508019vcy.267.1290446466234;
        Mon, 22 Nov 2010 09:21:06 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id c40sm1042117vcs.1.2010.11.22.09.21.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Nov 2010 09:21:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290445749-4884-1-git-send-email-rctay89@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161905>

Tay Ray Chuan wrote:

> G=C3=A1bor: hmm, it really seems that reflog is treated as plumbing -=
 no completion
> is done for it.

Probably because it is listed as such in command-list.txt.  I guess
the user-facing command for reflog expiration is meant to be "git gc"?

> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1632,6 +1631,18 @@ _git_rebase ()
>  	__gitcomp "$(__git_refs)"
>  }
> =20
> +_git_reflog ()
> +{
> +	local subcommands=3D"show delete expire"

People really do seem to use these commands directly, so I'm all for
this.

I wish there were a way to easily point the end user from "git reflog
show" to "git log --walk-reflogs" (to make the list of other accepted
options more obvious) but I can't think of one.

Regards,
Jonathan
