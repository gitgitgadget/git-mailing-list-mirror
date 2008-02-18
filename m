From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/5] Add platform-independent .git "symlink"
Date: Mon, 18 Feb 2008 14:34:36 +0100
Organization: At home
Message-ID: <fpc1hd$ror$1@ger.gmane.org>
References: <1203331463-13857-1-git-send-email-hjemli@gmail.com> <1203331463-13857-2-git-send-email-hjemli@gmail.com> <1203331463-13857-3-git-send-email-hjemli@gmail.com> <alpine.LSU.1.00.0802181217580.30505@racer.site> <8c5c35580802180518x5c392bddya21c48ea4db9a7cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 14:35:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR69V-0007sN-Rf
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 14:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbYBRNeu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Feb 2008 08:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbYBRNeu
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 08:34:50 -0500
Received: from main.gmane.org ([80.91.229.2]:58269 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbYBRNet (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 08:34:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JR68s-00014g-Cx
	for git@vger.kernel.org; Mon, 18 Feb 2008 13:34:46 +0000
Received: from abvq240.neoplus.adsl.tpnet.pl ([83.8.214.240])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 13:34:46 +0000
Received: from jnareb by abvq240.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 13:34:46 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvq240.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74286>

Lars Hjemli wrote:
> On Feb 18, 2008 1:34 PM, Johannes Schindelin wrote:
>> On Mon, 18 Feb 2008, Lars Hjemli wrote:
>>
>> > diff --git a/environment.c b/environment.c
>> > index 3527f16..8058e7b 100644
>> > --- a/environment.c
>> > +++ b/environment.c
>> > @@ -49,6 +49,8 @@ static void setup_git_env(void)
>> > =A0{
>> > =A0 =A0 =A0 git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
>> > =A0 =A0 =A0 if (!git_dir)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 git_dir =3D read_gitfile_gently(DEFAULT_=
GIT_DIR_ENVIRONMENT);
>> > + =A0 =A0 if (!git_dir)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 git_dir =3D DEFAULT_GIT_DIR_ENVIRONMEN=
T;
>>
>> I still maintain that the code (maybe not the diff) is easier to rea=
d like
>> this:
>>
>> =A0 =A0 =A0 =A0 if (!git_dir) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git_dir =3D read_gitfile_gently(DEFA=
ULT_GIT_DIR_ENVIRONMENT);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!git_dir)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git_dir =3D DEFAULT_=
GIT_DIR_ENVIRONMENT;
>> =A0 =A0 =A0 =A0 }
>=20
> IMHO such constructs are butt ugly, but if there's consensus for your
> way, I'll abide...

I prefer the original variant. It is IMHO no less, and perhaps even
more readable, and it is not soo deeply nested.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
