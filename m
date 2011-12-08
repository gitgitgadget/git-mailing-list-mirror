From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/2] index-pack: a naive attempt to flatten find_unresolved_deltas
Date: Thu, 8 Dec 2011 08:42:24 -0800
Message-ID: <CAJo=hJu35cYkWfBXAoL6OoCLVT4fE-mKjgqyGBN5xRLmiBeRdw@mail.gmail.com>
References: <CAJo=hJvrk3Jzg3dQhQnfbmKAFovLuEtJAP4rakHPFeuZ0T5R7g@mail.gmail.com>
 <4ee0be70.44f2320a.3fe8.632b@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Dec 08 17:42:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYh3b-0002pp-4O
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 17:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912Ab1LHQmq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Dec 2011 11:42:46 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51916 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab1LHQmq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2011 11:42:46 -0500
Received: by iakc1 with SMTP id c1so2794795iak.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 08:42:45 -0800 (PST)
Received: by 10.42.161.9 with SMTP id r9mr3973251icx.49.1323362565171; Thu, 08
 Dec 2011 08:42:45 -0800 (PST)
Received: by 10.50.171.39 with HTTP; Thu, 8 Dec 2011 08:42:24 -0800 (PST)
In-Reply-To: <4ee0be70.44f2320a.3fe8.632b@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186570>

2011/12/8  <pclouds@gmail.com>:
> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> This seems to work for me. But I think this approach uses (much?) mor=
e
> memory because it turns a tree of calls into a flat list of calls and
> keep the list until the end, while the recursive version only has to
> keep one call chain at a time.
>
> Any ideas how to improve it?

Well, fortunately JGit is under a very liberal BSD license and has a
pretty efficient version of a heap based algorithm for delta
resolution. You could look at [1] for ideas. I am told the BSD license
is very compatible with the GPLv2. (Unlike the reverse.)


[1] http://egit.eclipse.org/w/?p=3Djgit.git;a=3Dblob;f=3Dorg.eclipse.jg=
it/src/org/eclipse/jgit/transport/PackParser.java;hb=3DHEAD#l556
