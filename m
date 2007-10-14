From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 2/6] add get_sha1_with_real_ref() returning full name of ref on demand
Date: Sun, 14 Oct 2007 23:37:21 +0200
Message-ID: <5F1A8BAA-108D-4D55-9AEE-7ECDFA3DEB03@zib.de>
References: <11923520851713-git-send-email-prohaska@zib.de> <1192352085653-git-send-email-prohaska@zib.de> <11923520852991-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0710141819490.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 23:36:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhB7y-0007Py-B1
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 23:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbXJNVfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 17:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754176AbXJNVfw
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 17:35:52 -0400
Received: from mailer.zib.de ([130.73.108.11]:40458 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753668AbXJNVfw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 17:35:52 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9ELZoRh012955;
	Sun, 14 Oct 2007 23:35:50 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1a406.pool.einsundeins.de [77.177.164.6])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9ELZnKk007506
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 14 Oct 2007 23:35:49 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710141819490.25221@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60908>


On Oct 14, 2007, at 7:21 PM, Johannes Schindelin wrote:

> Hi,
>
> On Sun, 14 Oct 2007, Steffen Prohaska wrote:
>
>> Deep inside get_sha1() the name of the requested ref is matched
>> according to the rules documented in git-rev-parse. This patch
>> introduces a function that returns the full name of the matched
>> ref to the outside.
>>
>> For example 'master' is typically returned as 'refs/heads/master'.
>>
>> The new function can be used by "git rev-parse" to print the full
>> name of the matched ref and can be used by "git send-pack" to expand
>> a local ref to its full name.
>
> I have not really studies your patch, but from your description it  
> sounds
> as if dwim_ref() does what you want.

Without my patch get_sha1_with_mode() calls get_sha1_1() calls  
get_sha1_basic()
calls dwim_ref(). I didn't analyze in detail what the *sha1*  
functions add
to what dwim_ref() provides.

The patch passes the information from dwim_ref() up the callstack.  
Maybe this
is not needed and I could directly call dwim_ref(). But I don't know.

	Steffen
