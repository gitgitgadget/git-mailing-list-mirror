From: Geert Bosch <bosch@adacore.com>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Wed, 4 Apr 2007 10:40:46 -0400
Message-ID: <BAFDAA7B-60EC-44FD-8DAA-EB2F9C835F51@adacore.com>
References: <200704041414.14797.andyparkins@gmail.com> <4613A974.60808@dawes.za.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 16:40:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ6fL-0007Uy-BF
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 16:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898AbXDDOks (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 10:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753900AbXDDOks
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 10:40:48 -0400
Received: from nile.gnat.com ([205.232.38.5]:52214 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753898AbXDDOkr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 10:40:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 81EEE48CC45;
	Wed,  4 Apr 2007 10:40:46 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 18628-01-2; Wed,  4 Apr 2007 10:40:46 -0400 (EDT)
Received: from [172.16.1.99] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	by nile.gnat.com (Postfix) with ESMTP id 18DE648CC28;
	Wed,  4 Apr 2007 10:40:46 -0400 (EDT)
In-Reply-To: <4613A974.60808@dawes.za.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43741>


On Apr 4, 2007, at 09:34, Rogan Dawes wrote:

> For binary files, it would be consistent to show the number of  
> bytes added/deleted. I have not investigated the output format for  
> the libxdiff binary patch format, but hopefully it would not be too  
> difficult to calculate the deletions and additions.

For binary files it is impractical to do insert/delete type of  
differences.
For text files, treating lines as indivisible entities to insert/delete
make some sense. For binary files, you'd have to use some arbitrary
context-defined breakpoints and then go from there. The result would
be some very complicated and unclear algorithm that would have no use
in the real world.

Many binary files, such as an images, waveforms or virtually any  
compressed
stream, can change in a way that changes all bytes in the file, while
the changes in the displayed image or the uncompressed stream are
imperceptible or absent. Guessing semantic differences between binary
blobs is hopeless and subjective, while differences in size are fact.

   -Geert
