From: Andreas Ericsson <ae@op5.se>
Subject: Re: pack operation is thrashing my server
Date: Sun, 07 Sep 2008 10:18:44 +0200
Message-ID: <48C38E64.5010204@op5.se>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>  <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>  <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org>  <alpine.LFD.1.10.0808141442150.4352@xanadu.home>  <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org>  <alpine.LFD.1.10.0808141633080.4352@xanadu.home>  <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org>  <alpine.LFD.1.10.0808151729070.3324@nehalem.linux-foundation.org>  <7vk5dorclv.fsf@gitster.siamese.dyndns.org>  <alpine.LFD.1.10.0809061812090.3117@nehalem.linux-foundation.org> <9e4733910809061950g6d9d2cf1g708f8faf0c06108@mail.gmail.com> <alpine.LFD.1.10.0809061957320.3117@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 10:20:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcFVC-0003my-F1
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 10:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbYIGITD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 04:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbYIGITB
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 04:19:01 -0400
Received: from mail.op5.se ([193.201.96.20]:37888 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532AbYIGIS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 04:18:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B3CA71B8007E;
	Sun,  7 Sep 2008 10:24:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x1RW6jUe8HSO; Sun,  7 Sep 2008 10:24:51 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id 68A271B800A7;
	Sun,  7 Sep 2008 10:24:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <alpine.LFD.1.10.0809061957320.3117@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95125>

Linus Torvalds wrote:
> 
> Take a look at that web page you quote, and then sort things by 
> decompression speed. THAT is the issue. 
> 
> And no, LZO isn't even on that list. I haven't tested it, but looking at 
> the code, I do think LZO can be fast exactly because it seems to be 
> byte-based rather than bit-based, so I'd not be surprised if the claims 
> for its uncompression speed are true.
> 

Some lzo vs zlib benchmark figures (for git) are available here:
http://www.gelato.unsw.edu.au/archives/git/0504/1700.html

LZO also ships their "minilzo.[ch]" fileset for easy inclusion in other
projects. I've used it a couple of times with decent results.

As for testing, both have been thoroughly vetted by NASA. LZO is used for
communication with satellites and that spacestation thing they had some
time ago, while zlib is being used for sending data back from Hubble and
other large data gatherers.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
