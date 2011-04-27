From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 13:38:40 +0200
Message-ID: <20110427113840.GF31730@paksenarrion.iveqy.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
 <7vwrig9ta7.fsf@alter.siamese.dyndns.org>
 <BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com>
 <7vsjt49stq.fsf@alter.siamese.dyndns.org>
 <BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 13:23:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF2q8-0007BF-Qc
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 13:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758627Ab1D0LXX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 07:23:23 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61630 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756125Ab1D0LXW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 07:23:22 -0400
Received: by ewy4 with SMTP id 4so475164ewy.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 04:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fAa9l7JOsRfi1JGZRvQFhdvRmca6SQU/kh0KKcl3tbE=;
        b=NLITwZgqJV8tSvDhpOjEu63rZmq4hybLnLathS5iEPcbEyq79Zh1lNg886bRr8l0Q/
         GhqxfR92gGYPBNkT4DEtwYJQgNwF2S7A9DpHm/ltzL1ufnwiJ/Fa9cAEdiEdUJSAYrO/
         l0YxwIJodKPta1BMuopUTKM4PeUUynzQ6SM6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=E323Un7iaAbYG+kRNvl2n61qd2rvt/LVAI4zCQpuRNuRW97t+Pm3Mrieq9tlgoyGh+
         M5cskZce/VB8wQna8Q36D3CfvtMmIMz3vUqEBVCqQ8mrQThN7FOaKv2SO/bmFVq04WM3
         4FCh1IDZJDnm2n06H5vv/FsbdX662P5MucJbo=
Received: by 10.14.4.157 with SMTP id 29mr854250eej.135.1303903401566;
        Wed, 27 Apr 2011 04:23:21 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id s49sm481129eei.12.2011.04.27.04.23.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 04:23:19 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1QF34q-0003Wd-Oe; Wed, 27 Apr 2011 13:38:40 +0200
Content-Disposition: inline
In-Reply-To: <BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172219>

On Wed, Apr 27, 2011 at 03:33:57PM +1000, Jon Seymour wrote:
> So, I think at a very minimum, a plugin architecture should specify
> the file system layout of packages to be managed by a plugin/package
> manager.

As I recall, Junios initial plan was to have gitk-git as a submodule at
some point. I still thinks this is a good idea.

If we extends the submodule concept, of not only having a list of
submodules, but also state weather a submodule is 'active' or 'inactive=
'
we could easily get a _very_ customable git.git.

Imagine git.git only containing git. A 'git submodule init' would load
the default 'active' submodules (for example git-gui, gitk-gui and
gitweb), everything in contrib is 'inactive'. The point here is to be
able to ship references to nice things to have (contrib) but not force
the use (download, diskspace, etc.) of it.

If a user finds an other awesome "plugin" to use with git, it's easy to
add it to h{er,i}s repository with 'git submodule add'.

Once the code is downloaded to the git-workspace (via 'git submodule
update') the git build system ('make') would take care of building and
installation, just as it does today.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
