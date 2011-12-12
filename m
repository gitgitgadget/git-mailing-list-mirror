From: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Mon, 12 Dec 2011 19:42:12 +0100
Message-ID: <4EE64B04.8080405@ursus.ath.cx>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org> <20111129220854.GB2812@sandbox-rc.fritz.box> <loom.20111210T062013-538@post.gmane.org> <7vborhaqgw.fsf@alter.siamese.dyndns.org> <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com> <4EE61EED.50604@ursus.ath.cx> <CALFF=ZRYB1LkAY5WSC4Eydu-N0KNnWLLM2CfbSXZji18yO82gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Leif Gruenwoldt <leifer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 19:43:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaAqH-00022E-1r
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 19:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855Ab1LLSnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 13:43:08 -0500
Received: from brln-4d0cbd2c.pool.mediaWays.net ([77.12.189.44]:54338 "EHLO
	here" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753783Ab1LLSnH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 13:43:07 -0500
Received: from [192.168.0.14] (unknown [192.168.0.14])
	by here (Postfix) with ESMTP id 208491A1C7B;
	Mon, 12 Dec 2011 19:43:10 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20111110 Icedove/3.0.11
In-Reply-To: <CALFF=ZRYB1LkAY5WSC4Eydu-N0KNnWLLM2CfbSXZji18yO82gw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186930>



On 12.12.2011 19:04 Leif Gruenwoldt wrote:
>  On Mon, Dec 12, 2011 at 10:34 AM, Andreas T.Auer
>  <andreas.t.auer_gtml_37453@ursus.ath.cx> wrote:
>
> > So you don't want to add a new commit to the products A, B and C
> > repos whenever the stable branch of the submodule changes, but on
> > the other hand when you commit changes to the products it would
> > still make sense to update the gitlink to the current commonlib
> > version together with your changes, too, right?
>
>  Hmm I supose that does make sense. If the commonlib version was auto
>  recorded during a commit of the product it would be nice. Then
>  if/when the user reconfigured the submodule from "floating" to
>  "strict" mode it would then have a submodule sha1 reference. I like
>  how this sounds.

The next question is: Wouldn't you like to have the new stable branch 
only pulled in, when the projectX (as the superproject) is currently on 
that new development branch (maybe master)?

But if you checkout that fixed released version 1.2.9.8, wouldn't it be 
better that in that case the gitlinked version of the submodule is 
checked out instead of some unrelated new version? I mean, when the 
gitlinks are tracked with the projectX commits, this should work well.

And what about a maintenance branch, which is not a fixed version but a 
quite stable branch which should only have bugfixes. Shouldn't the 
auto-pull be disabled in that case, too?

I think the "auto-pull" behavior should depend on the currently checked 
out branch. So the configuration options should allow the definition of 
one or more mappings.
