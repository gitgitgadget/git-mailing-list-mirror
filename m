From: Yuri D'Elia <wavexx@users.sf.net>
Subject: Re: rename tracking and file-name swapping
Date: Sun, 13 Sep 2009 23:13:52 +0200
Message-ID: <1248088D-85CB-4335-AD8A-07DB5BAD1AAA@users.sf.net>
References: <wavexx-2ECE7F.13171313092009@ger.gmane.org> <7viqfmsoej.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Bernardo Innocenti <bernie@codewiz.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 23:32:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmwgM-0001mM-PI
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 23:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156AbZIMVcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 17:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755173AbZIMVcR
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 17:32:17 -0400
Received: from e.thregr.org ([80.68.88.20]:52721 "EHLO e.thregr.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755176AbZIMVcR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 17:32:17 -0400
X-Greylist: delayed 1103 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Sep 2009 17:32:17 EDT
Received: from 88-149-143-162.dynamic.ngi.it ([88.149.143.162] helo=[192.168.1.99])
	by e.thregr.org with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <wavexx@users.sf.net>)
	id 1MmwOQ-0007gI-Ao; Sun, 13 Sep 2009 23:13:54 +0200
In-Reply-To: <7viqfmsoej.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128419>

On 13 Sep 2009, at 20:14, Junio C Hamano wrote:

>> % mv file1.txt file3.txt
>> % mv file2.txt file1.txt
>> % mv file3.txt file2.txt
>> % git add file1.txt file2.txt
>> % git diff -M --stat --cached
>>  file1.txt |  150 ++++++++++++++++++++++ 
>> +-------------------------------------
>>  file2.txt |  150 ++++++++++++++++++++++++++++++++++++ 
>> +-----------------------
>>  2 files changed, 150 insertions(+), 150 deletions(-)
>
> By default, if the pathname that was present in the old version still
> appears in the new version, that path is not considered as a candiate
> for rename detection.  Only "X used to be there but is gone" and "Y  
> did
> not exist but appeared" are paired up and checked if they are similar.
>
> Give the command -B option, too, to break the filepair that does not
> disappear.

That does the trick. I'm curious, is there any other use for -B  
besides rename handling?
Any reason of why it isn't a default when --find-copies-harder is in  
effect?
