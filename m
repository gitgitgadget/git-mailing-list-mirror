From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Wed, 21 Jul 2010 19:43:12 +0000
Message-ID: <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com>
References: <4C472B48.8050101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Bryan Larsen <bryan.larsen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 21:43:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObfCL-0001Xo-Ca
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 21:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134Ab0GUTnP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 15:43:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55478 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab0GUTnO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 15:43:14 -0400
Received: by fxm14 with SMTP id 14so3856043fxm.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+3aeJuNIO0Z0S9Au7xq1C8ZELfsPAtFRwELRTriwx58=;
        b=k8DEy0hVG30R4ENsa+e5Vi1nYihmKcI9rAD8lJULrQg3HhFxf4cpKg8ZOZNpQy/UrR
         TCW6Xi6b+8yeCxoeR7xDqyv1csFH48ugmLaIpksOEpjMkDx6ScTjbRTPISDZmWbO50TF
         iUY7L9BmWeyDUiWD1uykGDqwL245sbAaPIEoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Bqbmq2hQCg/C8gz8e//6E6/X7GSsqLMeKvXR5/I3SibGf9ncWs0DKBWgrC6UzzeSCq
         lP+XrKK5E6xCw8H0BGaHSnoUoctwUrBUO++/+KBtSPcaOwPwaIIlgMXx191x95d8Pl8y
         ag6/BfrbVG3y4XE7tw6IWrvpleK5EjuwXwkXI=
Received: by 10.223.117.194 with SMTP id s2mr872969faq.57.1279741392862; Wed, 
	21 Jul 2010 12:43:12 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Wed, 21 Jul 2010 12:43:12 -0700 (PDT)
In-Reply-To: <4C472B48.8050101@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151413>

On Wed, Jul 21, 2010 at 17:15, Bryan Larsen <bryan.larsen@gmail.com> wr=
ote:
> I've been using Avery Pennarun's git-subtree
> (http://github.com/apenwarr/git-subtree) for a while now and have bee=
n
> finding it very useful and problem-free.
>
> Git submodules have been particularly problematic for me on a project=
 which
> contains submodules which contain submodules. =C2=A0git-subtree "just=
 works",
> without any futzing.
>
> We've also had problems with less git savvy users dropping patches be=
cause
> they've occurred inside of a module.

What sort of workflows do you find bad with git-submodule that are
better with git-subtree?

The submodule concept is simple, but a lot of the implementation is
bad IMO. It doesn't integrate well, e.g. you have to remember to do
git clone --recursive, or git clone and git submodule update --init
after that, submodules don't remember what branch you wanted, so git
submodule foreach 'git pull' doesn't DWYM (although I have a hack for
that) etc.

I've also wondered if we couldn't just store all the heads .gitmodules
point to inside the main .git repository, and just git gc them when
submodules are removed.

I'd planned to maybe submit patches to fix some of these UI issues,
knowing about more of them would help. I also haven't tried
git-subtree.
