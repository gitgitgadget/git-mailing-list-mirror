From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 1/2] diffcore-rename: support rename cache
Date: Sat, 8 Nov 2008 10:24:10 +0100
Message-ID: <20081108092409.GD4030@nan92-1-81-57-214-146.fbx.proxad.net>
References: <1226068533-10152-1-git-send-email-pclouds@gmail.com> <20081107222128.GB4030@nan92-1-81-57-214-146.fbx.proxad.net> <7vy6zvdt25.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0811072001o6df7ae00k1b1bffaadf75d3a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 10:25:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyk4r-0003jK-Jt
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 10:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbYKHJYg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2008 04:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbYKHJYf
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 04:24:35 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:38184 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753403AbYKHJYe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 04:24:34 -0500
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id AE79619750;
	Sat,  8 Nov 2008 10:24:32 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id EFB3617225;
	Sat,  8 Nov 2008 10:24:31 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 3F539A003; Sat,  8 Nov 2008 10:24:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0811072001o6df7ae00k1b1bffaadf75d3a1@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100390>

On Sat, Nov 08, 2008 at 11:01:20AM +0700, Nguyen Thai Ngoc Duy wrote:
> On 11/8/08, Junio C Hamano <gitster@pobox.com> wrote:
> > Yann Dirson <ydirson@altern.org> writes:
> >
> >  > On Fri, Nov 07, 2008 at 09:35:32PM +0700, Nguy???n Th=E1i Ng???c=
 Duy wrote:
> >  >> This patch teaches diffcore_rename() to look into
> >  >> $GIT_DIR/rename-cache and make use of it to recreate diff_filep=
air.
> >  >> With proper cache, there should be no available entry for estim=
ation
> >  >> after exact matching.
> >  >
> >  > This is something I have thought about in the past, good to see =
that
> >  > implemented :)
> >  >
> >  >> Rename caching is per commit. I don't think abitrary tree-tree =
caching
> >  >> is worth it.
> >  >
> >  > That could be a nice complement to my directory-rename patch.
> >
> >
> > Has anybody thought about interaction between that caching and path=
spec
> >  limited operation?
> >
>=20
> I didn't. But I think all out-of-pathspec diff pairs are removed
> before it reaches diffcore_rename() so the cache has nothing to do
> with it (except it still loads full cache for a commit).

Well, it could be that an out-of-pathspec pair would have a better
score than an in-pathspec one.  Maybe cache recording should be turned
off when doing pathspec limitation ?
