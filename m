From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Sun, 18 Mar 2012 23:07:42 +0100
Message-ID: <201203182307.43599.jnareb@gmail.com>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ivan Todoroski <grnch_lists@gmx.net>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 23:07:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9OGL-0006tQ-C2
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 23:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab2CRWHg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Mar 2012 18:07:36 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:57867 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100Ab2CRWHf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 18:07:35 -0400
Received: by wejx9 with SMTP id x9so5379058wej.19
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 15:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=prLv+MOc6JSNO/LeMQ6dE/4d1xMe4hbmJuxTEVjW6b8=;
        b=tDL3PXipWMEXU8iKZHi2ZSNvSOPXRRylzy22b279RZ99VUFzv5xbStzalU1yVBhPl2
         LMDvrtdlGWzcR7MFjQISr9wcdg3SwnNg8GC6qdJXLwxYSo0PVxnq0sAWT6KXv/tGta8T
         YkQbTiMF+fPJYLMebD6LQOXwGp8IEPcp69uPbP0y8yNHVNgUa7dx6Ef2Npp0pTvcqYLg
         BXi0YE05UO+rtTT8UXKWZTCHrfeXwdKTVnNRn6B/S1yJo6yk5yvKrwU24GW7vFqn1P5b
         Ek6Ze6TzTd0/LYQse+nAfDNpgInAurWYGjLvCc2gQnD81+bTX8ImqgabCCQqF74nk68K
         tsFA==
Received: by 10.180.14.230 with SMTP id s6mr14838896wic.2.1332108454735;
        Sun, 18 Mar 2012 15:07:34 -0700 (PDT)
Received: from [192.168.1.13] (abwl141.neoplus.adsl.tpnet.pl. [83.8.235.141])
        by mx.google.com with ESMTPS id 17sm2034858wis.0.2012.03.18.15.07.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Mar 2012 15:07:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120318190659.GA24829@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193393>

Jeff King wrote:
[...]
> I think the only sane solution is to write the values to a temporary
> file, and do something like:
>=20
> =C2=A0 git fetch-pack --stateless-rpc --refs-from=3D$tmpfile
>=20
> Even if you put the tmpfile in $GIT_DIR, I don't think this should ru=
n
> afoul of any read-only repositories, since by definition you are
> fetching into the repository (but you could also just put it in /tmp)=
=2E

Or

   git fetch-pack --stateless-rpc --refs-fd=3D$n

and there would be no need for temporary file.

--=20
Jakub Narebski
Poland
