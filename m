From: Kevin Bracey <kevin@bracey.fi>
Subject: --simplify-merges breakage
Date: Mon, 08 Apr 2013 22:00:35 +0300
Message-ID: <516313D3.2050309@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 21:06:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPHOP-0003cP-7Q
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 21:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935682Ab3DHTGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 15:06:09 -0400
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:50513 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934741Ab3DHTGG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 15:06:06 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Apr 2013 15:06:06 EDT
Received: from mail433.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 63CDD104E61C
	for <git@vger.kernel.org>; Mon,  8 Apr 2013 21:12:45 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 8 Apr 2013 21:01:01 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 8 Apr 2013 21:00:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Ovh-Tracer-Id: 1435240906503786718
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrtddtucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.50661/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrledvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220496>

Commit 4b7f53d ("simplify-merges: drop merge from irrelevant side 
branch") appears to have broken simplify-merges.

[Credit to "git bisect run" - and now I see the "report problems 
immediately" message on the recent merge of that change.]

I was trying to get my head around history simplification, by creating a 
repo with the example shown in the manual.The result of "gitk 
--simplify-merges foo" was far from pretty.

With the example in the manual, you should get this:

           .-A---M---N---O
          /     /       /
         I     B       D
          \   /       /
           `---------'

After 4b7f53 you instead get:

           .-A---M   N---O
         /     /   /   /
         I     B   /   D
          \   /   /   /
           `---------'

Kevin
