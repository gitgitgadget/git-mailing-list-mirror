From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGIT PATCH] Don't use patches/<branch>/current
Date: Tue, 15 May 2007 23:08:01 +0200
Message-ID: <20070515210801.GO19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070506150852.8985.98091.stgit@yoghurt> <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 23:09:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho4H1-0001uW-Dz
	for gcvg-git@gmane.org; Tue, 15 May 2007 23:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbXEOVJV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 17:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbXEOVJV
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 17:09:21 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:55288 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743AbXEOVJV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 17:09:21 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id CF6735E3D4;
	Tue, 15 May 2007 23:09:18 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id AA9821F161; Tue, 15 May 2007 23:08:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47373>

On Tue, May 15, 2007 at 04:56:33PM +0100, Catalin Marinas wrote:
> On 06/05/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> >The name of the current patch, if any, is always the last line of
> >patches/<branch>/applied (and there is no current patch if and only =
if
> >the "applied" file is empty). So use that instead, and stop having t=
o
> >worry about keeping the redundant "current" file up-to-date.
>=20
> I applied this patch. Could you also send me a patch for the
> bash-completion script as it uses this file?
>=20
> I think the self.__current_file (same for the base file removed in a
> different patch) should still be available in the Series object and
> removed when deleting a branch, otherwise you get a "Series directory
> .. is not empty" exception.

Shouldn't we also migrate to new format as soon as we need to touch a
data - in this case, whenever we push/pop ?

Or maybe declare a new "stgit stack format version" ?  Currently we
have "stg branch --convert", which switches between a "new" and an
"old" format which noone probably uses any more.  What about
versionning the on-disk format, and possibly provide the "convert"
functionnality back and forth between one format and the next, with
formal documentation about which version works with which stack
format ?

Best regards,
--=20
Yann.
