From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 1/2] Convert "stg refresh" to the new infrastructure
Date: Sun, 29 Jun 2008 10:42:32 +0100
Message-ID: <b0943d9e0806290242q1bc8aa67qb3523221b3db70e2@mail.gmail.com>
References: <20080625042337.6044.53357.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 11:44:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCtS6-0004Vy-Cg
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 11:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbYF2Jmd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2008 05:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbYF2Jmd
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 05:42:33 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:4189 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbYF2Jmc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jun 2008 05:42:32 -0400
Received: by wa-out-1112.google.com with SMTP id j37so841397waf.23
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 02:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ML/Y8FWFrlDPJnahIiRWMUN+NQ0iP6x2XA4Jfhft7kU=;
        b=nPHkeB3aoLAAaZJUqw1yPlTaciGZ3v5wHKVPUtEnxbdvSVwX7VcVvRz6+vxLfg6K0M
         0N0ZuUMoNMUulZjbY56Phwh3dmbY0hjdz5oxfjJ3JomFDs0XH4AcsSCwDSAt6BPycBQR
         PMpIXum0NX83U56TNN6gKOvK80hm2Xi2Runj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qBiGX8zR65NpuXzfV32vg+aZJX7FqeusbFV9wm45igZcCljrgBeiHU8L2+DMpXzDLa
         lbjagYTTZf4f5vwqprneR7mfs+WnjvHTW5TDXWmQHoHak9fybMaYtJcB5WQXmJsZNk7U
         9ZFR7GGGTMZit+XJBQ3BujogtVETJFbiy1XB0=
Received: by 10.114.158.1 with SMTP id g1mr2999825wae.111.1214732552040;
        Sun, 29 Jun 2008 02:42:32 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Sun, 29 Jun 2008 02:42:31 -0700 (PDT)
In-Reply-To: <20080625042337.6044.53357.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86790>

2008/6/25 Karl Hasselstr=F6m <kha@treskal.com>:
> And in the process, make it more powerful: it will now first create a
> temp patch containing the updates, and then try to merge it into the
> patch to be updated. If that patch is applied, this is done by
> popping, pushing, and coalescing; if it is unapplied, it is done with
> an in-index merge.

Does it make sense to refresh an unapplied patch? Maybe adding a new
file to the patch but I don't really see a need for this.

> Also, whenever path limiting is used, we will now use a temporary
> index in order to avoid including all staged updates (since they may
> touch stuff outside the path limiters).

I haven't checked but what is the behaviour in subdirectors? It
currently refreshes everythink unless "." is specified so that it will
only refresh the current subdirectory.

The patch looks fine otherwise.

--=20
Catalin
