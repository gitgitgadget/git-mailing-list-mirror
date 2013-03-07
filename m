From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [PATCH 2/2] p4merge: create a virtual base if none available
Date: Thu, 07 Mar 2013 08:28:00 +0200
Message-ID: <51383370.3050806@bracey.fi>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi> <1362601978-16911-3-git-send-email-kevin@bracey.fi> <CAJDDKr6+VRnc-HK52woHHLtAqXau=76Gc+Ag=keiMGffuco64A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 07 11:05:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDXhX-0004Be-VD
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 11:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426Ab3CGKFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 05:05:00 -0500
Received: from 3.mo4.mail-out.ovh.net ([46.105.57.129]:56436 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752314Ab3CGKE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 05:04:59 -0500
X-Greylist: delayed 12000 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Mar 2013 05:04:59 EST
Received: from mail192.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 2218E104DCEE
	for <git@vger.kernel.org>; Thu,  7 Mar 2013 07:39:11 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 7 Mar 2013 08:28:05 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 7 Mar 2013 08:28:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
In-Reply-To: <CAJDDKr6+VRnc-HK52woHHLtAqXau=76Gc+Ag=keiMGffuco64A@mail.gmail.com>
X-Ovh-Tracer-Id: 3707025444615590110
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrvdehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrvdehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217584>

On 07/03/2013 04:23, David Aguilar wrote:
> On Wed, Mar 6, 2013 at 12:32 PM, Kevin Bracey <kevin@bracey.fi> wrote:
>> +make_virtual_base() {
>> +               # Copied from git-merge-one-file.sh.
> I think the reasoning behind these patches is good.
>
> How do we feel about this duplication?
Bad.
> Should we make a common function in the git-sh-setup.sh,
> or is it okay to have a slightly modified version of this
> function in two places?
I'd prefer to have a common function, I just didn't know if there was 
somewhere appropriate to place it, available from both files. And I'm 
going to have to learn a bit more sh to get it right.
> Also, the "@@DIFF@@" string may not work here.
> This is a template string that is replaced by the Makefile.

It does work in git-mergetool--lib.sh, but not in mergetools/p4merge.

> We prefer $(command) instead of `command`.
> These should be adjusted.
>
> Can the same thing be accomplished using "git diff --no-index"
> so that we do not need a dependency on an external "diff" command here?
Do these comments still apply if it's a common function in 
git-sh-setup.sh that git-one-merge-file.sh will use? I'm wary of 
layering violations.

Kevin
