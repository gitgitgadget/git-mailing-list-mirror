From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 10/10] clone: accept config options on the command line
Date: Thu, 9 Jun 2011 19:10:33 +0200
Message-ID: <BANLkTinBqSVpREg6667Ydf2JjL3r14BgRA@mail.gmail.com>
References: <20110609155001.GA14969@sigill.intra.peff.net>
	<20110609155740.GJ25507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Claire Fousse <claire.fousse@ensimag.imag.fr>, git@vger.kernel.org,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 19:10:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUiki-0006kh-2l
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 19:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212Ab1FIRKf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 13:10:35 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:53745 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab1FIRKe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 13:10:34 -0400
Received: by vxi39 with SMTP id 39so1345984vxi.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 10:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ol5q6HE4L1Czkr9eE40q8CM3KBK1zHO0XgYTHcsKjEE=;
        b=hrIhMRTFq0G343mrg4VBd8yOOD0E0H3Idvfzkseemmo5v3g8AKgeHMn0CYcS7MCBAm
         bw2iccucXhQBlnLV5iQLO5YhyIW82+WToqcu2g/ZCLCrSbkqcSjqn6lqmdKfEgvpMVyC
         +cYnqNYnr18TTDb0P3sMnZ5Os9dVOaXlZK6xY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IO2/jcxhkltGL8KacpHhOH6QaJtGr20TUiSTJ0meqYaf+VsthQNSua6XTjUSIFqlVd
         qJzneCs0HoO+C80SJzxRGT7boguW24PbBTupNyPtVHbbLi4sykSBchxCZvDpVYAp4/y1
         7n5hbUCq7MdzGyCOaM1XfSMFSF8j859+fO+uo=
Received: by 10.52.65.231 with SMTP id a7mr1497572vdt.61.1307639433133; Thu,
 09 Jun 2011 10:10:33 -0700 (PDT)
Received: by 10.52.107.34 with HTTP; Thu, 9 Jun 2011 10:10:33 -0700 (PDT)
In-Reply-To: <20110609155740.GJ25507@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175552>

On Thu, Jun 9, 2011 at 17:57, Jeff King <peff@peff.net> wrote:
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.tx=
t
> index b093e45..3e24064 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -159,6 +159,15 @@ objects from the source repository into a pack i=
n the cloned repository.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify the directory from which templates=
 will be used;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(See the "TEMPLATE DIRECTORY" section of l=
inkgit:git-init[1].)
>
> +--config <key>=3D<value>::
> +-c <key>=3D<value>::
> + =C2=A0 =C2=A0 =C2=A0 Set a configuration variable in the newly-clon=
ed repository. The

Shouldn't this be 'newly-created repository', because the
configuration variables are set before the actual cloning, but after
initializing the new repository.

Bert

> + =C2=A0 =C2=A0 =C2=A0 key is in the same as expected by linkgit:git-=
config[1] (e.g.,
> + =C2=A0 =C2=A0 =C2=A0 `core.eol=3Dtrue`). If multiple values are giv=
en for the same key,
> + =C2=A0 =C2=A0 =C2=A0 each value will be written to the config file.=
 This makes it
> + =C2=A0 =C2=A0 =C2=A0 safe, for example, to add additional fetch ref=
specs to the
> + =C2=A0 =C2=A0 =C2=A0 origin remote.
> +
> =C2=A0--depth <depth>::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Create a 'shallow' clone with a history tr=
uncated to the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0specified number of revisions. =C2=A0A sha=
llow repository has a
