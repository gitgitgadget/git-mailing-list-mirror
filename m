From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: done feature in remote-helpers (was Re: [PATCH 2/2] Add a remote
 helper to interact with mediawiki (fetch & push))
Date: Wed, 31 Aug 2011 14:17:59 +0200
Message-ID: <CAGdFq_jyVK3_THYXzCOLDpNww0Npn2qzZ1qv-BMuLbg1vgVjZw@mail.gmail.com>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
 <1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr> <7v4o14dppz.fsf@alter.siamese.dyndns.org>
 <CAGdFq_iYRkfnTbYAgmX1g4uOxWb_ZYxr+TNinVfWRV-zXrnzAg@mail.gmail.com>
 <7v4o1092hn.fsf@alter.siamese.dyndns.org> <CAGdFq_jwLGZ+tLKramRrLJmwyY_uDtj7JXUwYBO9pSqOmZ20xQ@mail.gmail.com>
 <vpq1uw13hx3.fsf_-_@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 31 14:18:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qyjkj-0002tr-W0
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 14:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304Ab1HaMSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 08:18:40 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33486 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302Ab1HaMSk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 08:18:40 -0400
Received: by vws1 with SMTP id 1so481943vws.19
        for <git@vger.kernel.org>; Wed, 31 Aug 2011 05:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rMhmfeDa3ax7sbcjU4q+ZeBym4W9XBBC6MW6c3/OY4A=;
        b=fA94oIR4Rl6rdYamewVZAni+zLnHdm8dQesdWwstL1ZMLPAPPeiFzT2mZcO1XZRgPk
         2KepSyCKNm01iePgOEJqVFSMvChnd1cyNYVbHlMkXHk4Hq7pzAp7UJVOadcs2T5UZNCG
         7JkG5ithZJPMlfSWFlgL8pw1SW+7FyGnnxJ20=
Received: by 10.52.91.142 with SMTP id ce14mr279425vdb.167.1314793119203; Wed,
 31 Aug 2011 05:18:39 -0700 (PDT)
Received: by 10.52.161.201 with HTTP; Wed, 31 Aug 2011 05:17:59 -0700 (PDT)
In-Reply-To: <vpq1uw13hx3.fsf_-_@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180462>

Heya,

On Wed, Aug 31, 2011 at 14:05, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> So, is this the expected behavior? Wouldn't it be more sensible to allow
> the remote-helper to issue a "done" after each "import" command? Right
> now, my understanding is that after an "import" command is issued, it's
> no longer possible to output anything other than fast-import stream on
> stdout, and I guess it'd be more future-proof to allow closing the
> fast-import with a "done", and allow any dialog between git and the
> remote helper afterwards.

Wow, no that's not the intended behavior. We meant to make it exactly
as you describe, after each import command you end with a done. This
is (should) also be what the testgit implementation does currently,
and it's what my remote-hg helper does as well. I'm not sure why it's
not working for you, but if it's not then that is definitely a bug,
and not intended behavior.

-- 
Cheers,

Sverre Rabbelier
