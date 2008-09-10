From: Mike Hommey <mh@glandium.org>
Subject: Re: git svn segfaults in _Delta.so
Date: Wed, 10 Sep 2008 21:03:22 +0200
Organization: glandium.org
Message-ID: <20080910190322.GA1503@glandium.org>
References: <E7387B42-6A3D-432B-8478-71A5E510D905@gmail.com> <9B7A97D1-7175-4FCC-94CB-21EBE12E4F88@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Harning <harningt@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 07:22:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdedQ-0003id-Uk
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 07:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbYIKFVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 01:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbYIKFVW
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 01:21:22 -0400
Received: from vuizook.err.no ([194.24.252.247]:59130 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbYIKFVU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 01:21:20 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1KdecK-0000pX-3o; Thu, 11 Sep 2008 07:21:22 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KdUyI-0000Qv-MI; Wed, 10 Sep 2008 21:03:22 +0200
Content-Disposition: inline
In-Reply-To: <9B7A97D1-7175-4FCC-94CB-21EBE12E4F88@gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 2.0): Spam detection software, running on the system "vuizook.err.no", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Wed, Sep 10, 2008 at 02:40:31PM -0400, Thomas Harning wrote:
	> On Sep 10, 2008, at 2:21 PM, Thomas Harning wrote: > >> I just recently
	setup a new system and installed subversion 1.5.1 and >> the latest git from
	head. >> >> On an existing repository (copied from the same system but slightly
	>> older software) running git svn rebase will cause it to segfault in >>
	_Delta.so (part of subversion's perl libraries).... even when there is >>
	nothing to do... it even seems to successfully do all the operations. >>
	I've built su 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95581>

On Wed, Sep 10, 2008 at 02:40:31PM -0400, Thomas Harning wrote:
> On Sep 10, 2008, at 2:21 PM, Thomas Harning wrote:
>
>> I just recently setup a new system and installed subversion 1.5.1 and 
>> the latest git from head.
>>
>> On an existing repository (copied from the same system but slightly  
>> older software) running git svn rebase will cause it to segfault in  
>> _Delta.so (part of subversion's perl libraries).... even when there is 
>> nothing to do... it even seems to successfully do all the operations.  
>> I've built subversion and git with debugging enabled and cannot get any 
>> useful stack-trace. the stacktrace is:
>>
>> #0  0x00007fbed7edd3a0 in ?? ()
>> #1  0x00007fbed99fa75d in ?? ()
>> #2  0x0000000000000001 in ?? ()
>> #3  0x00007fbed99fb217 in ?? ()
>> #4  0x00007fbed99e82d8 in ?? ()
>> #5  0x0000000000000001 in ?? ()
>> #6  0x000000000070e250 in cwd.17580 ()
>> #7  0x000000000070d7f8 in buffer.17586 ()
>> #8  0x0000000000f7f408 in ?? ()
>> #9  0x00007fbed99fb205 in ?? ()
>> #10 0x0000000000000000 in ?? ()
>>
>>
>> The only way I know that it is _Delta.so is that in 'dmesg' i get:
>> git-svn[1277]: segfault at 7f64fa7213a0 ip 7f64fa7213a0 sp  
>> 7fff07a9a2b8 error 14 in _Delta.so[7f64fa92c000+22000]
>>
>> In another machine w/ very similar software (slightly older by a month 
>> or so) I do not see these segfaults.  However it is running svn 1.4.6  
>> .. so it might be svn versions...  will report on status after 
>> downgrade
> svn 1.4.6 does not suffer the segfaults...

I would suggest you to try some other stuff that uses the svn perl
library (svk, for example). My guess is that it will crash similarly.

Mike
