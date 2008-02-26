From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Fix premature free of ref_lists while writing temporary refs to file
Date: Tue, 26 Feb 2008 18:17:50 +0100
Message-ID: <200802261817.50673.johan@herland.net>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802261635.51407.johan@herland.net> <alpine.LSU.1.00.0802261542080.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Kristian =?iso-8859-1?q?H=F8gsberg?= <krh@redhat.com>,
	Santi =?iso-8859-1?q?B=E9jar?= <sbejar@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 26 18:19:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU3Sc-0005hZ-9O
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 18:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759409AbYBZRSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 12:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758868AbYBZRSp
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 12:18:45 -0500
Received: from sam.opera.com ([213.236.208.81]:43415 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759397AbYBZRSo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 12:18:44 -0500
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m1QHHosp019151
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Feb 2008 17:17:51 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LSU.1.00.0802261542080.22527@racer.site>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.91.1/6003/Tue Feb 26 11:34:31 2008 on smtp.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75153>

On Tuesday 26 February 2008, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 26 Feb 2008, Johan Herland wrote:
> 
> > We cannot call write_ref_sha1() from within a for_each_ref() callback, 
> > since it will free() the ref_list that the for_each_ref() is currently 
> > traversing.
> > 
> > Therefore rewrite setup_tmp_ref() to not call write_ref_sha1(), as 
> > already hinted at in a comment.
> 
> I guess the reason was to use a much of an API as possible.
> 
> If you already avoid that, why not write into .git/packed-refs directly?

That's exactly what I'm planning. ;-)

...just wanted to get the existing code working first.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
