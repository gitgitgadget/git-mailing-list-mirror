X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-fetch fails with error code 128
Date: Thu, 14 Dec 2006 21:25:06 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612142120260.18171@xanadu.home>
References: <200612142308.45376.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 15 Dec 2006 02:25:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <200612142308.45376.andyparkins@gmail.com>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34461>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv2lD-00032o-5s for gcvg-git@gmane.org; Fri, 15 Dec
 2006 03:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965014AbWLOCZK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 21:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWLOCZK
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 21:25:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:51365 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965014AbWLOCZI (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 21:25:08 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAA00AAKMPUSP80@VL-MO-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 14 Dec 2006 21:25:07 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Thu, 14 Dec 2006, Andy Parkins wrote:

> Hello,
> 
> This is with my big "every linux patch" repository that I talked about in 
> another thread.  To bring you up to speed:
> 
>  1. Made repository
>  2. Made a zip of the .git directory
>  3. Copied the zip elsewhere
>  4. Extracted it into a temporary directory
>  5. Went to an out-of-date version of this repository
>  6. Used git-fetch to update it.
> 
> This gave me the following output:
> 
> $ git fetch
> remote: Generating pack...
> remote: Done counting 189146 objects.
> remote: Result has 186566 objects.
> remote: Deltifying 186566 objects.
> remote:  100% (186566/186566) done
> Unpacking 186566 objects
> fatal: failed to apply delta
> fatal: unpack-objects died with error code 128
> Fetch failure: /home/andyp/projects/temp/.git
> 
> What does that mean?  I ran fsck --full on the source repository, but it's 
> made no difference.

Could you please instrument patch-delta.c to determine which of the
"return NULL" is executed?


