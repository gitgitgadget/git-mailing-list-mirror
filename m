From: Mahmoud Asshole <a1209145@drdrb.net>
Subject: Silly time stamps
Date: Wed, 9 Apr 2014 20:50:57 +0000 (UTC)
Message-ID: <loom.20140409T210150-369@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 22:55:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXzWe-00070a-5c
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 22:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbaDIUzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 16:55:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:47712 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965020AbaDIUzH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 16:55:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WXzWR-0006rs-EU
	for git@vger.kernel.org; Wed, 09 Apr 2014 22:55:05 +0200
Received: from tor.nohats.ca ([193.110.157.151])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 22:55:03 +0200
Received: from a1209145 by tor.nohats.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 22:55:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.110.157.151 (Mozilla/5.0 (X11; Linux x86_64; rv:28.0) Gecko/20100101 Firefox/28.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245998>

Hi,

This is an example of timestamps are in git:
    tree c67dc912a777ef6198a5c76890ebf11cd8ccc625
    parent 6e527d8e07a80058bf8ac46180e25a9d4cb745eb
    author my name <m@test.org> 1397073956 +0400
    committer my name <m@test.org> 1397073956 +0400

    testing again

As you can see, it presents the timestamp in UNIX format (I suppose it's UTC)
plus an additional information which is an offset that describes my time zone.

Now, the way UTC works is that every client is supposed to apply his own offset
on it (based on locale stuff) so that the user-interface (let it be CLI or GUI)
can print an pretty time format based on his location. 

The offset that is used is local to each client. E.g. if it's UTC 10:00, it
will look 14:00 (cause +04:00) in my part of the world, while looking as 12:00
in another part of the world (+02:00 time-zone). This time-zone offset is local
to the computer based on locale stuff. The only thing that we need is the UTF
time stamp (and then anyone can make it look pretty based on where he is
living).

Now, the problem is that git shares the UTC time (totally OK) AND my fucking
time-zone! Why would anyone give a damn rat's ass about my time-zone? What
difference could it make if you know that the clock looked like "14:00" on my
part of the world?

This was raised previously[1], but none of the responses are convincing.

One guy was saying here[2] some nonesense like "I'd prefer not to lose the
information. If someone has committed a change at 2am, I like to know that it
was 2am for _them_. It helps me decide where to look first for the cause of
problems. :)"

How about we also modify the time data to augment it with my mood? E.g.
"1397073956 +0400 totally_pissed_off".

The same asshole in [2] gave another retarded example that is just less visible
to non-humans: "It also helps disambiguate certain comments, especially those
involving words or phrases such as 'yesterday' or 'this afternoon'.".

This is equal to say: instead of curing the root cause of the problem (by
educating assholes to not use ambiguous time information like "yesterday"),
let's fuck the software instead (by encoding useless information here and
there).

[1] http://thread.gmane.org/gmane.comp.version-control.git/52
[2] http://article.gmane.org/gmane.comp.version-control.git/114
