From: martin <martin@siamect.com>
Subject: Re: is gitosis secure?
Date: Sun, 14 Dec 2008 16:42:15 +0700
Message-ID: <4944D4F7.7050501@siamect.com>
References: <200812090956.48613.thomas@koch.ro> <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com> <87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org> <alpine.DEB.1.10.0812132126470.17688@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Dec 14 10:54:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBnfk-0002YT-QD
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 10:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbYLNJw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 04:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752293AbYLNJw1
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 04:52:27 -0500
Received: from smtp4.ksc.net.th ([203.107.129.14]:15492 "EHLO smtp4.ksc.net.th"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858AbYLNJw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 04:52:26 -0500
X-Greylist: delayed 606 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Dec 2008 04:52:25 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApcBAPhjREl8eO3f/2dsb2JhbAAIjB6GB7wIgn4
X-IronPort-AV: E=Sophos;i="4.36,218,1228064400"; 
   d="scan'208";a="94532381"
Received: from ppp-124-120-237-223.revip2.asianet.co.th (HELO [192.168.0.200]) ([124.120.237.223])
  by smtp4.ksc.net.th with ESMTP; 14 Dec 2008 16:42:16 +0700
User-Agent: Thunderbird 2.0.0.17 (X11/20081017)
In-Reply-To: <alpine.DEB.1.10.0812132126470.17688@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103055>

Dear David.
Why do you trust VPN more than the SSH?
I ask because I have just removed the "first VPN then SSH" solution in 
favor for a SSH only solution using Gitosis just to get rid of the VPN 
which I believe is less secure than SSH (well until I read you comments 
below).
I thought I was doing something right for once but maybe I'm not?
Thanks and best regards
Martin

david@lang.hm wrote:
> this is really a reply to an earlier message that I deleted.
>
> the question was asked 'what would the security people like instead of 
> SSH'
>
> as a security person who doesn't like how ssh is used for everything, 
> let me list a couple of concerns.
>
> ssh is default allow (it lets you run any commands), you can lock it 
> down with effort.
>
> ssh defaults to establishing a tunnel between machines that other 
> network traffic can use to bypass your system. yes I know that with 
> enough effort and control of both systems you can tunnel over 
> anything, the point is that ssh is eager to do this for you (overly 
> eager IMHO)
>
> ssh depends primarily on certificates that reside on untrusted 
> machines. it can be made to work with tokens or such, but it takes a 
> fair bit of effort.
>
> sshd runs as root on just about every system
>
> people trust ssh too much. they tend to think that anything is 
> acceptable if it's done over ssh (this isn't a technical issue, but it 
> is a social issue)
>
>
> what would I like to see in an ideal world?
>
> something that runs as the git user, does not enable tunneling, and 
> only does the data transfer functions needed for a push. it should use 
> off-the-shelf libraries for certificate authentication and tie into 
> PAM for additional authentication.
>
> the authentication would not be any better than with SSH, but the rest 
> would be better. I was very pleased to watch the git-daemon 
> development, and the emphisis on it running with minimum privilages 
> and provide just the functionality that was needed, and appropriately 
> assuming that any connection from the outside is hostile until proven 
> otherwise.
>
>
> what would I do with current tools?
>
> I would say that developers working from outside should VPN into the 
> company network before doing the push with SSH rather than exposing 
> the SSH daemon to the entire Internet.
>
> in the medium term, if the git-over-http gets finished, I would like 
> to see a seperate cgi created to allow push as well. http is overused 
> as a tunneling protocol, but it's easy to setup a server that can't do 
> anything except what you want, so this tunneling is generally not a 
> threat to servers (it's a horrible threat to client systems)
>
> David Lang
> -- 
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
