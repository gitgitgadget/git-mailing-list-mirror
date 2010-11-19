From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH/RFC/WIP/POC] git-gui: grep prototype
Date: Fri, 19 Nov 2010 21:16:21 +0100
Message-ID: <AANLkTi=-OGvTT+yVqQWUyGn0PmODr=dv1DE9fZkaEDBB@mail.gmail.com>
References: <1289770869-11665-1-git-send-email-bert.wesarg@googlemail.com>
	<20101114215442.GC16413@burratino>
	<AANLkTiktg4aZ7VfdXUT9XF4RK7MuCvzevB5jSRaNiE1L@mail.gmail.com>
	<20101114220932.GE16413@burratino>
	<AANLkTi=JR3vVnZ4Yz8o9MpZKiQ2_ASYxahbPNv8QACir@mail.gmail.com>
	<20101114234848.GB26104@burratino>
	<AANLkTimWyjrRD951AGeEayMoTNd-N2OXRd_wQ0RBFegN@mail.gmail.com>
	<20101119194907.GG26187@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	"Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 21:16:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJXNk-0002vm-U6
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 21:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088Ab0KSUQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 15:16:23 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48930 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756633Ab0KSUQX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 15:16:23 -0500
Received: by iwn7 with SMTP id 7so184354iwn.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 12:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ObCEpmOsTdyzU4rEsOmAKo9F34vv6fIPS3CEZj/Wx8w=;
        b=uB7u/sHjUiM2nmKM/7RwUyDbTEH1gjpEEB882salQbV4WlgEfyrCUz+u4NOu7wTl5o
         4R9Y24JCf5AXA3rbFug65YE4cNrwDqJ0btS2smIcrl1zicOF9nErF5zS6EcYGGUmfiLk
         KGt+s38YbJQAaOHnLCLmZXPfOOxQzplyXJ2Uk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nShVch1hP6PxKME6S9W8Rm1sJyMl9ZRcU+vJf+CpbGvkbOyzPthPcmm8MOAclzIHO5
         OLbdMBfD6nA1xJg7dS03Y3k6d0v+4nUtBaxBTlYNn4WFf6dVHHwTUV4B2OZZTkHzTALQ
         jN01QNAIwDuSZebaDJEB0zCxxOge8SqoTsgHQ=
Received: by 10.231.15.137 with SMTP id k9mr2619830iba.58.1290197781847; Fri,
 19 Nov 2010 12:16:21 -0800 (PST)
Received: by 10.42.14.70 with HTTP; Fri, 19 Nov 2010 12:16:21 -0800 (PST)
In-Reply-To: <20101119194907.GG26187@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161780>

On Fri, Nov 19, 2010 at 20:49, Jonathan Nieder <jrnieder@gmail.com> wrote:
> [resending to list; sorry for the noise]

No problem.

>
> Bert Wesarg wrote:
>
>> Could we settle on a name space for such variables? GIT_EDITOR_* makes
>> it obvious that it is for the editor started from git.
>
> Sounds good to me.
>
> If the choice of variables ends up looking especially good, maybe
> we can pass it along to the Portland group and call it xdg-editor for
> use by other apps, too. :)
>

Interesting idea.

There is one more thing to discuss before starting collecting the
variables. Has each flag its own env-variable, or do we put flags into
one variable named GIT_EDITOR_FLAGS? They could be space or comma
separated.

The second option sounds a little bit more future prove to me.

For non-flag arguments, there is the obvious LINENUMBER. But how do we
pass columns or even a character range to the editor. They would be
good for compiler output. Sure its out of score for git, but a little
future-thinking will not hurt. We could add it to the LINENUMBER with
a syntax like:

    <line>[:<column-start[-<column-end>]]

Bert
