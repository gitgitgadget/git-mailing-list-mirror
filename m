From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] Packing large repositories
Date: Mon, 02 Apr 2007 13:39:20 +1200
Message-ID: <46105EC8.90407@vilain.net>
References: <56b7f5510703280005o7998d65pcbcd4636b46d8d23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 03:39:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYBWS-00020V-Iz
	for gcvg-git@gmane.org; Mon, 02 Apr 2007 03:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbXDBBjb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Apr 2007 21:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbXDBBjb
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Apr 2007 21:39:31 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:34656 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbXDBBja (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2007 21:39:30 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 8B500156AF8; Mon,  2 Apr 2007 13:39:26 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id C251A156A8D;
	Mon,  2 Apr 2007 13:39:22 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <56b7f5510703280005o7998d65pcbcd4636b46d8d23@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43596>

Dana How wrote:
> Hi,
>
> I just started experimenting with using git on
> a large engineering project which has used p4 so far.
> Part of a checkout is about 55GB;
> after an initial commit and packing I have a 20GB+ packfile.
> Of course this is unusable, since object_entry's in an .idx

Another idea to consider is that if you are storing changes of files
which have a compressed file format, you will almost certainly save a
huge amount by storing the uncompressed version in the git repository -
as then delta compression stands a chance of working.

Sam.
