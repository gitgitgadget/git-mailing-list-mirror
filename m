From: "Frawley, Sarah" <sarah.frawley@intel.com>
Subject: FW: Query on git submodules
Date: Wed, 27 May 2015 13:20:11 +0000
Message-ID: <4C328B7D13677A4EAF715D0755A6D7EE25C5AD9E@irsmsx110.ger.corp.intel.com>
References: <4C328B7D13677A4EAF715D0755A6D7EE25C56C89@irsmsx110.ger.corp.intel.com>
 <4C328B7D13677A4EAF715D0755A6D7EE25C589BF@irsmsx110.ger.corp.intel.com>
 <20150526170125.GC31115@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed May 27 15:20:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxbFz-0007OV-E0
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 15:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbbE0NUR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2015 09:20:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:21137 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbbE0NUQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2015 09:20:16 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 27 May 2015 06:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,505,1427785200"; 
   d="scan'208";a="700988662"
Received: from irsmsx105.ger.corp.intel.com ([163.33.3.28])
  by orsmga001.jf.intel.com with ESMTP; 27 May 2015 06:20:15 -0700
Received: from irsmsx155.ger.corp.intel.com (163.33.192.3) by
 irsmsx105.ger.corp.intel.com (163.33.3.28) with Microsoft SMTP Server (TLS)
 id 14.3.224.2; Wed, 27 May 2015 14:20:12 +0100
Received: from irsmsx110.ger.corp.intel.com ([169.254.15.124]) by
 irsmsx155.ger.corp.intel.com ([169.254.14.38]) with mapi id 14.03.0224.002;
 Wed, 27 May 2015 14:20:11 +0100
Thread-Topic: Query on git submodules
Thread-Index: AdCSSWETsB/dvpOtTAu+b+O2ywQWlACTA2hAAM3yN4AAK8NYgAAA4TKw
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.182]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270044>

Thanks Heiko for getting back to me.

Correct when I referred to 10+ layers I meant nested repositories which=
 make up a large hierarchy.=A0 Some repositories are repeated across th=
e hierarchy.=A0 We check-out submodules to tag versions (as opposed to =
master branch).=A0 If we need to roll out a particular change across a =
hierarchy (e.g. 60 repos) then every level in the hierarchy needs to pi=
ck up new submodule tags.

The main 2 issues that we see are:

1. Enforcement of absolute paths in git submodules - I am currently tri=
aling using a pre-commit hook to highlight this issue to users so that =
they can fix their submodule urls to relative paths.

2. Slowness Integrating updates to submodule hierarchy -I have been loo=
king at ways of automating such a roll out - this can be useful for new=
 project setups or for rolling out an update to all repos and quickly i=
ntegrating it into the submodule hierarchy.=A0 The link below shows som=
ething similar however it checks out a master branch of each submodule =
in its hierarchy. https://chrisjean.com/recursively-updating-git-submod=
ules/




Thanks,
Sarah=20
-----Original Message-----
=46rom: Heiko Voigt [mailto:hvoigt@hvoigt.net]=20
Sent: Tuesday, May 26, 2015 6:01 PM
To: Frawley, Sarah
Cc: git@vger.kernel.org
Subject: Re: Query on git submodules

Hi,

On Fri, May 22, 2015 at 01:46:24PM +0000, Frawley, Sarah wrote:
> I am a design automation engineer supporting 200+ designers who use=20
> git for hardware design.=A0 We also use the submodule feature where w=
e=20
> can have quite complex hierarchy's with 10+ layers.

What does this 10+ layers mean? Nested submodule repositories 10 recurs=
ion steps deep?

> We have experience issues with re-use of design projects was we move=20
>from one derivative to another due to the complexity of the hierarchy=20
>along with lack of discipline (using absolute paths in .gitmodule=20
>files). To enforce more discipline I am currently working on a=20
>pre-commit hook to check the integrity of .gitmodule files.=A0 I would=
 be=20
>interested in seeing how other users in the community find submodules=20
>for large scale projects and if there are any best known methods for=20
>using them.

I do not have anything to share here since our projects did not have su=
ch problems (not that large scale). It would be interesting to see what=
 you come up with. Maybe we can add some of that into core git to suppo=
rt such large scale projects better. So maybe you can share exactly wha=
t problems you have (only absolute paths?) or the pre-commit hooks you =
will use.

Cheers Heiko
-------------------------------------------------------------
Intel Ireland Limited (Branch)
Collinstown Industrial Park, Leixlip, County Kildare, Ireland
Registered Number: E902934

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
