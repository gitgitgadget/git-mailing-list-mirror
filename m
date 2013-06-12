From: Carsten Fuchs <carsten.fuchs@cafu.de>
Subject: Re: Tracking vendor release with Git
Date: Wed, 12 Jun 2013 10:17:18 +0200
Message-ID: <51B82E8E.8010402@cafu.de>
References: <1370970410-7935-1-git-send-email-ydroneaud@opteya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 10:17:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmgFG-0007y2-Mo
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 10:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab3FLIRZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 04:17:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:52655 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab3FLIRW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 04:17:22 -0400
Received: from [192.168.1.74] (dslb-094-219-006-046.pools.arcor-ip.net [94.219.6.46])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0Mefy0-1Uxl0a22US-00OlsM; Wed, 12 Jun 2013 10:17:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1370970410-7935-1-git-send-email-ydroneaud@opteya.com>
X-Provags-ID: V02:K0:Tnwowp94/ErROEexlX0ynFBsWDYQhG0jZ17UX+5U3QQ
 9KNjGTd5l4TdFz+5ECkwTtN6qzVO13cJ0Z2/u2MJceASY0lOzc
 8bQdU/FbkQCYm5SCpN5DgPsx0b2lVOV30QmI8+UtGDCi1sujk3
 qKrsWpfnVjg6KJ3ZVc+a7l+jiUtrscG+S8+tziz6K+p5IRjckw
 kuZ0pe+2nvuRqlwEwZKX+PwIC9ZNFWRcf1rULcMIl8DakU58sJ
 V5rHb78t9tZKgBjnI1QxrUyZjjI4Y8/MLK+rvFUvT/TZdSbZIt
 HQ6c7DXrxDegnbqSg1eWYy0q1WwHqeS2m+4K6fp2ZkNwJFXJij
 WcUrROZrYKC5+nbFiFkU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227593>

Hi Yann,

Am 2013-06-11 19:06, schrieb Yann Droneaud:
> I'm trying to setup a workflow to track vendor releases (upstream).
> Each new release are provided as an archive of source code, data,
> documentation, etc.
>
> For each vendor releases, fixes need to be applied before making them
> available to users (downstream).
>
> Seems to be a rather common use case, applied by most Linux distribut=
ion
> for decades.
>
> In my case, on top of each releases, a common set of patches will be =
applied,
> the biggest, the most intrusive one, being converting CRLF to LF usin=
g dos2unix,
> the others being small portability fixes. In this case, fixes are not=
 going to
> be applied by upstream.


If you did the end-of-line conversion via .gitattributes rather than ex=
plicitly as a=20
patch, maybe the strategy described at=20
http://happygiraffe.net/blog/2008/02/07/vendor-branches-in-git/ is what=
 you're looking for?

If besides the <pristine-vendor> branch you need another <patched-vendo=
r> branch, this=20
should be extensible, inserting another "layer" into the middle.
Copying and modifying Johannes' graph:

   U---V-----W          <-- upstream branch (pristine vendor)
    \   \     \
     C---D-----E        <-- patched vendor
      \   \     \
       K---L--M--N--O   <-- downstream branch ("master" in above linked=
 text)


Best regards,
Carsten



--=20
Dipl.-Inf. Carsten Fuchs

Carsten Fuchs Software
Industriegebiet 3, c/o Rofu, 55768 Hoppst=E4dten-Weiersbach, Germany
Internet: http://www.cafu.de | E-Mail: info@cafu.de

Cafu - the open-source game and graphics engine for multiplayer 3D acti=
on
