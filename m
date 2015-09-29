From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/RFC] read-cache: fix file time comparisons with different
 precisions
Date: Tue, 29 Sep 2015 15:42:39 +0200
Organization: gmx
Message-ID: <acb5b10221675dd6cc6b9f3846cbe8c4@dscho.org>
References: <5605D88A.20104@gmail.com> <560918F8.1080905@gmail.com>
 <763be6c1331ac57cf7dee3636d82f994@dscho.org> <560A66A9.2010606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 15:42:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgvB9-0001MU-6a
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 15:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbbI2Nmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2015 09:42:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:60194 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965022AbbI2Nmm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 09:42:42 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LdpcB-1aOXfQ3JIJ-00j0Cd; Tue, 29 Sep 2015 15:42:39
 +0200
In-Reply-To: <560A66A9.2010606@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:1H2/U2Ji6BGOANQ+G3o7S5VpWiXvcWYo9Ik0vhjLe31OPRWl79x
 zmuOsnlAsvysJqTRRbonsctmZNAp8y4OPmiRbTs/4wtrHW+3E6CM+3FthSwlsal3LNwBuCM
 72txQX9R/US2hQ4fjujes/tPsPxnxy8lyvTqFc9Jk6N2M4fKv3TwdXZ/cWYIiKIFKqlP/qs
 xd+Uvqw31aSLdUDdacrYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BgOLtzHaTYA=:R9/Z8azpau2B8rsEeBLHoy
 a2KU7VexhopBRfunllIw9kHxuhEZNgFYpiT4JMviMIifzDBU42UFHMZtPYPSkPBO5U3rreP7I
 n2Hpi//smm35hRjQKkO1/lxmGam4rHdbK4LTb/WnnVtd6+2vywoQ+DkO7cm2K0Zx/UOobWmFZ
 QG00vIqNx38D/zFskoYWw/cFF2StVqK8oaOMfEaB5O2pTO392Fw1eqBOSBJEN/GHr6k6iX/XV
 BZKZ666ZlSn4T5f978MQxE8T/50HD0m3Rufav4vvei5N3fy6AFZWRZHT00RyddGWaK5skVT1R
 TVZmBROe19y77xGZWl39Ysd3++2/f+NMEBeoVZDRequoDcAMEBoXdyFHWlE2txrRWrTAXCgj8
 5Dm4efFV9sNYk6h+Xh7uQEV1YfoY4eSs1OSCxzwObya2COei2OYbEi+7txEECRCmBJByuXlQq
 xsDiMKvrXc436evWlnVR4dP5Ms0NfA3Y8Kv4b5Cz88HcCMfoFwKwBKlURlVN4Os4B7XwuC2SL
 b5fnz6SCcIMjY505ay2lztKjnSkj99m9mLAuZ7D8IKoG6IvGMNTP822FIZub9McI5KKdXk8lK
 eWWBwh2iTdC8dn9+NuEILdiMsm03NrE01+WSWrbsAZo26Ji3Cx2cqT7FjfgdCG+UAZDn/URjG
 yhRQzGprM54Z6lbELtZH1HUiK4ZrwDE0nS9huos+3ggzB771vH/8/e3q/JClXcdRfaRqBO8rK
 gJEeNIA5XBGJ6eAklhYSLpAsBDvYacr8UZLbuA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278819>

Hi Karsten,

On 2015-09-29 12:23, Karsten Blees wrote:
> Am 28.09.2015 um 14:52 schrieb Johannes Schindelin:
>> Otherwise there would be that little loop-hole where (nsec % 1000) == 0 *by chance* and we assume the timestamps to be identical even if they are not.
> 
> Yeah, but in this case the file would be racy, as racy-checks use
> the same comparison now.

True.

> IMO change detection is so fundamental that it should Just Work,
> without having a plethora of config options that we need to explain
> to end users.
> 
> If that means that once in a million cases we need an extra content
> check to revalidate such falsely racy entries, that's fine with me.

You have a good point there. I retract my objections.

Thanks,
Dscho
