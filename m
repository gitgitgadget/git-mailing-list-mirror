From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Branch deletion (Re: [RFC] fast-import: note deletion command)
Date: Sun, 18 Sep 2011 23:38:07 +0200
Message-ID: <CAGdFq_gH=u1BU6k3Z23Lo9mOSE4Rq-6nWU0EE91CQNpxksGw5w@mail.gmail.com>
References: <CA+gfSn9sdTzQghqQp6hcO-9kN9mPx2JLRig79Rgx2FqGWXXp=A@mail.gmail.com>
 <20110918203506.GG2308@elie> <CAGdFq_hpA95Kj4eMr4e1duuXTpr+OkkwF4K5bTapXEi9UjWcSA@mail.gmail.com>
 <20110918211836.GI2308@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dmitry Ivankov <divanorama@gmail.com>,
	Git List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Johan Herland <johan@herland.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 23:38:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5P4f-0007Se-RW
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 23:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578Ab1IRVit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 17:38:49 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36659 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255Ab1IRVis (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 17:38:48 -0400
Received: by gyg10 with SMTP id 10so3708204gyg.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 14:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cuK80DeF/ZYEUaUK1XwVrxI4LDdgfBU5Jx7TfMfqlmg=;
        b=RnNwAJIcRot9+gYov+MRn37FNiyvphHq9lcKT3IXP4guz3QwmWuQjExWJB6uiBRVz2
         d7uHBOrsHwPffTvjkgFjO2LhsoEgVthnOmALccIwciHYIJrimM9Sqvakgmi7DjHc0Q0h
         HVXI49Olkb9btE2APmq3amPx946C5Yx8QiCvI=
Received: by 10.68.22.201 with SMTP id g9mr3356414pbf.433.1316381927542; Sun,
 18 Sep 2011 14:38:47 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Sun, 18 Sep 2011 14:38:07 -0700 (PDT)
In-Reply-To: <20110918211836.GI2308@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181645>

Heya,

On Sun, Sep 18, 2011 at 23:18, Jonathan Nieder <jrnieder@gmail.com> wrote:
> In the case of remote helpers, IIRC there was already a need for
> the transport-helper to handle the final ref updates so "git fetch"
> can write a nice notice about them to the console.

That book-keeping is trivial to do. The problem currently is that when
you try to "git push origin :experimental-branch", there is no way for
the transport-helper code to tell the helper to delete the ref.
Something like 'deleteref' sounds sane I suppose, and I agree that
there should be some sort of safety switch :). I think we need a new
feature announcing that we require support for it, and then the
importer can abort right away if the user doesn't want to have their
refs deleted.

-- 
Cheers,

Sverre Rabbelier
