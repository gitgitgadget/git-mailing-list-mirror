From: David Kastrup <dak@gnu.org>
Subject: Re: Something is broken in repack
Date: Fri, 14 Dec 2007 17:45:07 +0100
Message-ID: <85r6hptecs.fsf@lola.goethe.zz>
References: <alpine.LFD.0.9999.0712120826440.25032@woody.linux-foundation.org> 	<20071214161236.3080.qmail@md.dent.med.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@linux-foundation.org,  nico@cam.org,  jonsmirl@gmail.com,  gitster@pobox.com,  gcc@gcc.gnu.org,  git@vger.kernel.org
To: Wolfram Gloger <wmglo@dent.med.uni-muenchen.de>
X-From: gcc-return-142989-gcc=m.gmane.org@gcc.gnu.org Fri Dec 14 17:45:26 2007
Return-path: <gcc-return-142989-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J3Des-0002Z7-0h
	for gcc@gmane.org; Fri, 14 Dec 2007 17:45:06 +0100
Received: (qmail 24042 invoked by alias); 14 Dec 2007 16:44:45 -0000
Received: (qmail 24028 invoked by uid 22791); 14 Dec 2007 16:44:45 -0000
X-Spam-Check-By: sourceware.org
Received: from mail-in-02.arcor-online.net (HELO mail-in-02.arcor-online.net) (151.189.21.42)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 14 Dec 2007 16:44:31 +0000
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net [151.189.8.32]) 	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 5214F346870; 	Fri, 14 Dec 2007 17:44:28 +0100 (CET)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49]) 	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id 3F692724081; 	Fri, 14 Dec 2007 17:44:28 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-018-211.pools.arcor-ip.net [84.61.18.211]) 	by mail-in-09.arcor-online.net (Postfix) with ESMTP id A3E963425E6; 	Fri, 14 Dec 2007 17:44:27 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002) 	id 3FCDF1C4CE33; Fri, 14 Dec 2007 17:45:07 +0100 (CET)
In-Reply-To: <20071214161236.3080.qmail@md.dent.med.uni-muenchen.de> (Wolfram 	Gloger's message of "14 Dec 2007 16:12:36 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Status: Clean
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68318>

Wolfram Gloger <wmglo@dent.med.uni-muenchen.de> writes:

> Hi,
>
>> Note that delta following involves patterns something like
>> 
>>    allocate (small) space for delta
>>    for i in (1..depth) {
>> 	allocate large space for base
>> 	allocate large space for result
>> 	.. apply delta ..
>> 	free large space for base
>> 	free small space for delta
>>    }
>> 
>> so if you have some stupid heap algorithm that doesn't try to merge and 
>> re-use free'd spaces very aggressively (because that takes CPU time!),
>
> ptmalloc2 (in glibc) _per arena_ is basically best-fit.  This is the
> best known general strategy,

Uh what?  Someone crank out his copy of "The Art of Computer
Programming", I think volume 1.  Best fit is known (analyzed and proven
and documented decades ago) to be one of the worst strategies for memory
allocation.  Exactly because it leads to huge fragmentation problems.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
