From: Alex Bennee <alex.bennee@transitive.com>
Subject: Re: git-cvsexportcommit getting out of sync with CVS status
	requests
Date: Wed, 15 Aug 2007 13:58:46 +0100
Organization: Transitive
Message-ID: <1187182726.13096.50.camel@murta.transitives.com>
References: <1187178510.13096.46.camel@murta.transitives.com>
Reply-To: alex.bennee@transitive.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 15:53:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILJJ2-0000dc-N5
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 15:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757861AbXHONwp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 09:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757521AbXHONwp
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 09:52:45 -0400
Received: from mx.transitive.com ([217.207.128.220]:48717 "EHLO
	pennyblack.transitives.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756722AbXHONwo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Aug 2007 09:52:44 -0400
X-Greylist: delayed 3280 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Aug 2007 09:52:44 EDT
Received: from [192.168.2.164] (helo=[192.168.2.164])
	by pennyblack.transitives.com with esmtp (Exim 4.50)
	id 1ILIIf-0003Vg-VH
	for git@vger.kernel.org; Wed, 15 Aug 2007 12:48:38 +0000
In-Reply-To: <1187178510.13096.46.camel@murta.transitives.com>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55903>

On Wed, 2007-08-15 at 12:48 +0100, Alex Bennee wrote:
> Hi,
> 
> Occasionally (usually when a lot of files have been added or moved in my
> git tree) git-cvsexportcommit gets confused when I'm exporting. I'll get
> the error like:

So I have figured out the reason it goes out of sync. CVS doesn't seem
to always report status in the order you give it on the command line
(which is rather crucial to the functioning of the script).

e.g. cvs status path/to/filea path/to/filev path/to/filec can return the
status in order 

fileb
filea
filec

It looks like running a single CVS query for each file is the only
solution.

-- 
Alex Bennee - Alex.Bennee@transitive.com
Behind every great computer sits a skinny little geek.
