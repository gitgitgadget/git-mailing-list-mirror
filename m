From: sf <sf-gmane@stephan-feder.de>
Subject: Re: [RFC]: Pack-file object format for individual objects (Was: 
  Revisiting large binary files issue.)
Date: Tue, 11 Jul 2006 23:45:33 +0200
Message-ID: <44B41BFD.8010808@stephan-feder.de>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <44B371FB.2070800@b-i-t.de> <Pine.LNX.4.64.0607111053270.5623@g5.osdl.org>
Reply-To: sf-gmane@stephan-feder.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jul 11 23:47:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Q4E-000864-VL
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 23:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWGKVqV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 17:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWGKVqU
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 17:46:20 -0400
Received: from main.gmane.org ([80.91.229.2]:13989 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932132AbWGKVqQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 17:46:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G0Q3J-0007x9-69
	for git@vger.kernel.org; Tue, 11 Jul 2006 23:45:57 +0200
Received: from ip-213157024137.dialin.heagmedianet.de ([213.157.24.137])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Jul 2006 23:45:57 +0200
Received: from sf-gmane by ip-213157024137.dialin.heagmedianet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Jul 2006 23:45:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157024137.dialin.heagmedianet.de
User-Agent: Thunderbird 1.5.0.4 (X11/20060606)
In-Reply-To: <Pine.LNX.4.64.0607111053270.5623@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23738>

Linus Torvalds wrote:
...
> On Tue, 11 Jul 2006, sf wrote:
...
>> Step 1. When reading individual objects from disk check the first nibble
>> and decode accordingly (see above).
> 
> Check more than that, but yes, this should be tightened up in my 
> series.

Just look at the first byte of the object file _without doing any
decompression_. It is 0x78 _if and only if_ the object file is in the
traditional format.

>> Step 3. Remove code for (old) individual object disk format.
> 
> Well, I'm not sure how necessary that even is. We actually do have to 
> generate the old header regardless, if for no other reason than the fact 
> that we generate the SHA1 names based on it (even if we then write a 
> new-style dense binary header to disk and discard the ASCII header).
> 
> Having it there means that you can always just get a new version of git, 
> and never worry about how old the archive you're working with is.
> 
> (And then doing a "git repack -a -d" will make any archive also work with 
> an old-style git, since the pack-file format didn't change, and a "git 
> repack" thus ends up always creating something that is readable by 
> anybody, including old clients).

Agreed.

Regards
	Stephan
