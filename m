From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor
  with no changes written
Date: Wed, 03 Feb 2010 10:46:27 +0100
Message-ID: <hkbgli$tqt$1@ger.gmane.org>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>	 <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>	 <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>	 <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>	 <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>	 <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>	 <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>	 <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>	 <76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>	 <alpine.DEB.1.00.1002030056480.4985@pacific.mpi-cbg.de> <76c5b8581002021609i4c05d039k35979757fbb74676@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:46:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncbp4-0004Nj-Dq
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 10:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972Ab0BCJqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 04:46:52 -0500
Received: from lo.gmane.org ([80.91.229.12]:58549 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756932Ab0BCJqv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 04:46:51 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ncbov-0004Gl-4m
	for git@vger.kernel.org; Wed, 03 Feb 2010 10:46:49 +0100
Received: from 93-34-208-53.ip51.fastwebnet.it ([93.34.208.53])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 10:46:49 +0100
Received: from bonzini by 93-34-208-53.ip51.fastwebnet.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 10:46:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 93-34-208-53.ip51.fastwebnet.it
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <76c5b8581002021609i4c05d039k35979757fbb74676@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138820>

On 02/03/2010 01:09 AM, Eugene Sajine wrote:
>> Sorry, your "if message was not saved, abort" is so out of line with any
>> program I use that this would be highly confusing (maybe "complicated" was
>> the wrong choice of words).
>
> Frankly, i think it is in line with "git commit"

The fundamental problem is this.  The behavior of "git commit" can be 
explained in two ways: a) abort if not saved; b) abort if empty.  (a) 
may be an easier guess from experience (you type ":q!" at the vi 
prompt), but (b) is clear from the error message ("commit has empty 
message--aborting").  All this is irrefutable.

Now, the scientific method to see which one is correct, would be to try 
other commands including "git commit --amend" and see which of the two 
hypotheses was right.  It turns out to be that (b) is correct and 
consistent across various commands; instead you insist that everything 
else should be modified to conform to (a).  Since git is already 
consistent, and since nobody can think of a way to implement your 
proposal, there is obvious resistence to any change in this area.

Paolo
