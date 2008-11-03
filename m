From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] t7700: demonstrate mishandling of objects in packs with
 a .keep file
Date: Mon, 03 Nov 2008 21:25:18 +0100
Message-ID: <490F5E2E.2050207@op5.se>
References: <1S3xpaVP1Cy1Rei_ODwlXsBdu64BGiPve-lj_4fN6cA@cipher.nrlssc.navy.mil> <14536526.1225596838300.JavaMail.teamon@b301.teamon.com> <490ED3FE.8040103@op5.se> <RqVk2AkdyUcFTIGofSkQwl1GtBTXMYzMqaOQiAOmBXAyPDuWlQug-w@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: drafnel@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	nico@cam.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Nov 03 21:26:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx60U-0000V0-E6
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 21:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbYKCUZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 15:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753873AbYKCUZY
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 15:25:24 -0500
Received: from mail.op5.se ([193.201.96.20]:59034 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754165AbYKCUZX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 15:25:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 9BEED1B800B1;
	Mon,  3 Nov 2008 21:20:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.449
X-Spam-Level: 
X-Spam-Status: No, score=-3.449 tagged_above=-10 required=6.6
	tests=[AWL=-0.950, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jpIBnwIjZ-vo; Mon,  3 Nov 2008 21:20:19 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id 2B84C1B8004E;
	Mon,  3 Nov 2008 21:20:18 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <RqVk2AkdyUcFTIGofSkQwl1GtBTXMYzMqaOQiAOmBXAyPDuWlQug-w@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99988>

Brandon Casey wrote:
> Andreas Ericsson wrote:
>> drafnel@gmail.com wrote:
>>> From: Brandon Casey <drafnel@gmail.com>
>>>
>>> Objects residing in pack files that have an associated .keep file are not
>>> supposed to be repacked into new pack files, but they are.
>>>
>> I think that's a misconception. Packfiles that are marked with .keep files
>> should never be deleted. There are, afaik, no rules against packing the
>> same objects into other packfiles as well. This is nifty for dumb ref
>> walkers, as they can use a small pack for incremental fetching while using
>> a mega-pack for initial cloning.
> 
> Having no rules against an object residing in more than one pack is different
> from intending for git to produce pack files with redundant objects.
> 
> I think one intention for the .keep mechanism was to allow for a size optimized
> pack to be produced and distributed. Currently, if I am handed such a pack file,
> I can not merely place it into my pack directory (along with the .idx and .keep
> files) and then run git-gc to remove any redundancy. Instead, I would get
> a _new_ pack file which would contain all of the objects in the repository and
> effectively double the size of my objects store. That doesn't seem like
> something a user would expect or should expect.
> 

So long as "git repack -a" still creates a mega-pack, I'm fine with whatever.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
