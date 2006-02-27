From: Sam Vilain <sam@vilain.net>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Tue, 28 Feb 2006 10:45:34 +1300
Message-ID: <440372FE.2000301@vilain.net>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 22:46:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDqBg-0006Yx-Ik
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 22:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWB0Vpp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 27 Feb 2006 16:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWB0Vpp
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 16:45:45 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:936 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932091AbWB0Vpp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 16:45:45 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id E7D9F5ECB; Tue, 28 Feb 2006 10:45:41 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id CC7461349;
	Tue, 28 Feb 2006 10:45:35 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20060227204252.GA31836@diana.vm.bytemark.co.uk>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16885>

Karl Hasselstr=F6m wrote:
> If I make a patch series where more than one patch touches the same
> line, I get a lot of merge errors when upstream has accepted them and
> I try to merge them back.
>=20
> Suppose a line contained the string "0". Patch p1 changes that to "1"=
,
> patch p2 further changes that to "2". Upstream accept the patches, an=
d
> I later "stg pull" them. When reapplying p1 after the pull, stg
> generates a merge conflict since upstream changed the "0" to "2" and
> p1 changes the "0" to "1".
>=20
> This situation arises for every line that's modified in more than one
> patch, and for every such patch except the last one. And it's really
> annoying, since it's intuitively obvious that there aren't actually
> any conflicts, since upstream accepted my patches verbatim.
>=20
> I suppose one way to fix it manually would be to first fetch, glance
> at the new upstream commits and try to find any accepted patches, and
> then "stg pull" the commit corresponding to the earliest patch in my
> series; repeat for every patch in the series. The queston is, how can
> we automate it?

I don't seem to suffer from this, using my "diff3 ||=20
ediff-merge-files-with-ancestor" script as a merge tool.  The diff3, or=
=20
ediff, seem to DTRT so long as the change is cleanly applied.  Otherwis=
e=20
I just get a merge conflict difference and I just press A/B to pick=20
which one I want.

Sam.
