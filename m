From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: More on git over HTTP POST
Date: Sun, 03 Aug 2008 04:31:13 -0700
Message-ID: <48959701.5050705@zytor.com>
References: <48938539.9060003@zytor.com> <20080802205702.GA24723@spearce.org> <20080803025602.GB27465@spearce.org> <48952B2E.3030209@zytor.com> <20080803041258.GE27465@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 03 13:33:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPbpm-0002G1-CK
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 13:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbYHCLa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 07:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753676AbYHCLa5
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 07:30:57 -0400
Received: from terminus.zytor.com ([198.137.202.10]:55590 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585AbYHCLa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 07:30:56 -0400
Received: from [10.71.1.72] ([12.197.88.10])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m73BUt56022216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 3 Aug 2008 04:30:55 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080803041258.GE27465@spearce.org>
X-Virus-Scanned: ClamAV 0.93.3/7920/Sun Aug  3 01:44:32 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91227>

Shawn O. Pearce wrote:
> 
> But from the client side perspective the chunked transfer encoding
> is used only to avoid generating in advance and producing the
> content-length header.  I fully expect the encoding to disappear
> (e.g. in a proxy, or in the HTTP client library) before any sort
> of Git code gets its fingers on the data.
> 
> Hence to your other remark, I _do not_ rely upon the encoding
> boundaries to remain intact.  That is why there is Git pkt-line
> encodings inside of the HTTP data stream.  We can rely on the
> pkt-line encoding being present, even if the HTTP chunks were
> moved around (or removed entirely) by a proxy.
> 

Excellent.  I did not mean that as criticism, obviously, I just wanted 
that to be clear.

HTTP/1.1 does chunked encoding, and HTTP/1.0 does terminate on 
connection close; both serve the same purpose.

	-hpa
