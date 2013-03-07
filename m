From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [PATCH 1/2] p4merge: swap LOCAL and REMOTE for mergetool
Date: Thu, 07 Mar 2013 08:16:13 +0200
Message-ID: <513830AD.10302@bracey.fi>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi> <1362601978-16911-2-git-send-email-kevin@bracey.fi> <7vlia0nj0i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 07 07:55:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDUjd-0007Xk-A5
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 07:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798Ab3CGGy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 01:54:59 -0500
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:39702 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751325Ab3CGGy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 01:54:58 -0500
X-Greylist: delayed 1611 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Mar 2013 01:54:58 EST
Received: from mail192.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 14601104D85A
	for <git@vger.kernel.org>; Thu,  7 Mar 2013 07:27:21 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 7 Mar 2013 08:16:15 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 7 Mar 2013 08:16:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
In-Reply-To: <7vlia0nj0i.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 3507741160415793374
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrvdehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.50003/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrvdehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217574>

On 07/03/2013 02:36, Junio C Hamano wrote:
> Kevin Bracey <kevin@bracey.fi> writes:
>
>> Reverse LOCAL and REMOTE when invoking P4Merge as a mergetool, so that
>> the incoming branch is now in the left-hand, blue triangle pane, and the
>> current branch is in the right-hand, green circle pane.
> Given that the ordering of the three variants has been the way it is
> since the very initial version by Scott, I'll sit on this patch
> until hearing from those Cc'ed (who presumably do use p4merge,
> unlike I who don't) that it is a good change.
>
I agree that this is the controversial patch of the two. It's going to 
chuck away 3-4 years of what Git users are used to, albeit in favour of 
a decade of what Perforce users are used to. And it also makes it 
inconsistent with all the other mergetools (at least assuming their 
display matches their command line).

I checked for any historical discussion from when this was added about 
the order, and there was none. So I'm assuming it was just done to match 
the other tools, maybe not realising P4Merge's "theirs/ours" convention. 
There was no explicit recognition at the time that they were breaking 
the Perforce convention, or that the order had an effect.

I've used both Git and Perforce for quite a while, but have only just 
started using P4Merge with Git. It seemed weirdly off and unintuitive to 
me at first, until I suddenly realised that it was just backwards.  I 
would have settled for just having to get used to driving on the other 
side of the road, and matching other mergetools, until I realised that 
it effectively broke display of common changes. That's a problem.

On consistency, personally, I think there's an argument for reversing 
all the mergetools to match this way, as I find this orientation more 
intuitively aligns with difftool. But I'm not bold enough to suggest 
that. Yet.

Kevin
