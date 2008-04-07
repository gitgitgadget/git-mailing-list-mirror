From: David Brown <git@davidb.org>
Subject: Re: git repo being corrupted?
Date: Mon, 7 Apr 2008 09:15:25 -0700
Message-ID: <20080407161525.GA25894@old.davidb.org>
References: <47F9F1A1.30009@diamand.org> <20080407111740.GA12776@bit.office.eurotux.com> <47FA03C4.9030104@diamand.org> <20080407113921.GA13667@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Luciano Rocha <luciano@lsd.di.uminho.pt>
X-From: git-owner@vger.kernel.org Mon Apr 07 18:16:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jiu1C-0004sX-E1
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 18:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbYDGQPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 12:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbYDGQPg
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 12:15:36 -0400
Received: from mail.davidb.org ([66.93.32.219]:34354 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbYDGQPg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 12:15:36 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1Jiu0D-0006yZ-Q3; Mon, 07 Apr 2008 09:15:25 -0700
Mail-Followup-To: Luciano Rocha <luciano@lsd.di.uminho.pt>,
	Luke Diamand <luke@diamand.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080407113921.GA13667@bit.office.eurotux.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78978>

On Mon, Apr 07, 2008 at 12:39:21PM +0100, Luciano Rocha wrote:

>> > You're using XFS. Did you have a power fail in the recent past?
>> 
>> How did you know?
>
>XFS doesn't order metadata writes with data writes, so if the power
>fails, it can find an update in the journal but the data wasn't written.
>Then it fills the file with zeroes to the new size.

This behavior should be a lot better for recent kernels.

xfs does even better with write barriers.  But any file change that is more
than one write can be corrupted or split by an inopportune powerdown.

David
