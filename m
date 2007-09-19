From: David Brown <git@davidb.org>
Subject: Re: State of Perforce importing.
Date: Wed, 19 Sep 2007 10:12:43 -0700
Message-ID: <20070919171243.GA23902@old.davidb.org>
References: <20070917193027.GA24282@old.davidb.org> <20070918233749.GA19533@old.davidb.org> <200709190819.12188.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Git <git@vger.kernel.org>
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Wed Sep 19 19:12:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY36Y-0007dt-3v
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 19:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbXISRMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 13:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbXISRMp
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 13:12:45 -0400
Received: from mail.davidb.org ([66.93.32.219]:46323 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045AbXISRMp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 13:12:45 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IY36R-0006V7-JV; Wed, 19 Sep 2007 10:12:43 -0700
Mail-Followup-To: Simon Hausmann <simon@lst.de>, Git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200709190819.12188.simon@lst.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58715>

On Wed, Sep 19, 2007 at 08:19:11AM +0200, Simon Hausmann wrote:

>> An additional problem:
>>
>>    - git-p4 doesn't preserve the execute permission bit from Perforce.
>
>Hmm, can you paste the output of
>
>	p4 fstat //path/in/depot/to/file/that/is/imported/incorrectly
>
>? I'm interested in the type of the file that p4 reports.

   headType kxtext

so the problem is that the git-p4 is only looking for an 'x' at the start.
According to 'p4 help filetypes', we need to use execute for any of:

   cxtext, kxtext, uxbinary,  and the others that start with 'x'.

I think it would be sufficient to check the first or second character for
an 'x'.  I'll make a change and give it a try later today.

David
