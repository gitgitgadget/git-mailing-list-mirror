From: Henning Moll <newsScott@gmx.de>
Subject: Re: flatten-merge history
Date: Mon, 27 Oct 2014 00:45:17 +0100
Message-ID: <544D878D.6020809@gmx.de>
References: <544B9839.7000302@gmx.de>	<CAP8UFD3jyZ+7bk-xrE=TghzFj9UL=+Mtz-CvFWK9azNrRcOU5Q@mail.gmail.com>	<544D0702.1050907@gmx.de>	<8761f65060.fsf@igel.home> <CAP8UFD2yjXC6ffCQyTvYNZZ00Ou=YmNgyWxGhbO29nbTHXRD5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 27 00:45:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiXV6-0006lH-Gx
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 00:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbaJZXpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 19:45:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:50235 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbaJZXpU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 19:45:20 -0400
Received: from [192.168.178.33] ([88.217.115.1]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0Mcxtm-1XRYbt0SSA-00IBVj; Mon, 27 Oct 2014 00:45:19
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CAP8UFD2yjXC6ffCQyTvYNZZ00Ou=YmNgyWxGhbO29nbTHXRD5w@mail.gmail.com>
X-Provags-ID: V03:K0:tWSEJ+7fbwGqBusGVF91X6igfikxwNxcQIQnlj8kT44Wt2eyMLO
 pTgHonbDW3KKGnnnZ3rfyZWVyns0SSTHXtO5l3DTptCHrv4YTzDqKcpEYLQEjNfp1FHOfpW
 kSbLFz/MC/Gy05JhRsOzwHO/EEgvaGbsOsXnqZD25rnsE3OfKljGR4MlUSkgtENVUpPbiAs
 zSpz3GQQUOOL3Z091vAwg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.10.2014 um 20:02 schrieb Christian Couder:
> Yeah. Henning, when interactively rebasing, in our editor, you should 
> have something like: pick A pick P pick B pick Q pick C pick D pick R 
> pick E which should work without any conflict. And then you can rebase 
> the b1 and b2 branches on the resulting branch.

Thank you all very much. It worked!

I didn't know that i could also introduce new commits in the interactive 
rebase list. Just for the record, in case others need to do such a task:

intial situation:

     P - - - Q - - - - - R       <-extern

A - - - B - - - C - D - - - E   <-master
          \           \
           M ...       \         <-b1
                        \
                         W ...   <-b2

On master:
$ git rebase -i --root

(editor opens showing

pick A
pick B
pick C
pick D
pick E

modify this to

pick A
pick P
pick B
pick Q
pick C
pick D
pick R
pick E

save, quit. Now, master is already fixed. Now fix the branches:

$ git rebase --onto B' B b1
$ git rebase --onto D' D b2

Just a final question: Is it possible to keep the GIT_COMMITTER_DATE in 
all those rebases?

Thanks again
Henning
