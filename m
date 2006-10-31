X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Allow pack header preprocessing before unpack-objects/index-pack.
Date: Tue, 31 Oct 2006 15:51:21 -0800
Message-ID: <7vwt6goxhi.fsf@assigned-by-dhcp.cox.net>
References: <20061031075629.GA7691@spearce.org>
	<Pine.LNX.4.64.0610311400180.11384@xanadu.home>
	<20061031200841.GC23671@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 23:51:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061031200841.GC23671@spearce.org> (Shawn Pearce's message of
	"Tue, 31 Oct 2006 15:08:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30607>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gf3OB-0003pU-Jh for gcvg-git@gmane.org; Wed, 01 Nov
 2006 00:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946165AbWJaXvY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 18:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946166AbWJaXvY
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 18:51:24 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:12004 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1946165AbWJaXvX
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 18:51:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061031235122.JHJO2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Tue, 31
 Oct 2006 18:51:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hBrS1V00e1kojtg0000000 Tue, 31 Oct 2006
 18:51:27 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Nicolas Pitre <nico@cam.org> wrote:
>> On Tue, 31 Oct 2006, Shawn Pearce wrote:
>> 
>> > However if the caller consumes the pack header from the input stream
>> > then its no longer available for unpack-objects or index-pack --stdin,
>> > both of which need the version and object count to process the stream.
>> > 
>> > This change introduces --pack_header=ver,cnt as a command line option
>> > that the caller can supply to indicate it has already consumed the
>> > pack header and what version and object count were found in that
>> > header.  As this option is only meant for low level applications
>> > such as receive-pack we are not documenting it at this time.
>> 
>> This breaks index-pack, and unpack-objects with OBJ_OFS_DELTA, if 
>> --pack-header is used.  The header is not accounted in the pack's offset 
>> and therefore every object's offset is wrong.
>> 
>> What about this patch instead?  This makes things much simpler IMHO.
>
> Agreed.  The idea you are using here came to me in my sleep last
> night; I didn't have time to look at it until now however.  You just
> beat me to posting it.  :-)

Will replace your [1/2] still in "pu".
