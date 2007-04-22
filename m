From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 4/4] Add 'filter' attribute and external filter driver 
  definition.
Date: Sun, 22 Apr 2007 02:20:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704220215540.5946@qynat.qvtvafvgr.pbz>
References: <11771520591529-git-send-email-junkio@cox.net><11771520591703-gi
 t-send-email-junkio@cox.net><Pine.LNX.4.63.0704211821560.5655@qynat.qvtvafv
 gr.pbz> <7v4pn8rk8t.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0704220202550.5946@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 11:53:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfYlN-00065t-GH
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 11:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965583AbXDVJxm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 05:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965606AbXDVJxm
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 05:53:42 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:54227 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S965583AbXDVJxm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 05:53:42 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sun, 22 Apr 2007 02:53:41 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sun, 22 Apr 2007 02:53:39 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.63.0704220202550.5946@qynat.qvtvafvgr.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45232>

On Sun, 22 Apr 2007, David Lang wrote:

> On Sat, 21 Apr 2007, Junio C Hamano wrote:
>
>> David Lang <david.lang@digitalinsight.com> writes:
>> 
>>> 1. it would be useful in many cases for the filter program to know
>>> what file it's working on (and probably some other things), so there
>>> are probably some command-line arguments that should be able to be
>>> passed to the filter.
>> 
>> I can see that you missed the class when Linus talked about how
>> messy things would get once you allow the conversion to be
>> stateful.  I was in the class and remembered it ;-)
>> 
>> Although I initially considered interpolating "%P" with
>> pathname, I ended up deciding against it, to discourage people
>> from abusing the filter for stateful conversion that changes the
>> results depending on time, pathname, commit, branch and stuff.
>
> I didn't miss it, I just don't think that the path in the repository is 
> nessasarily as dangerous as the other things (time, branch, etc)

to clarify a bit more. I have a perl program that I can point at the 
'interesting' files on my systems and have it create a 'generic' version of that 
file. I can then take that generic version of the file to any machine in the 
cluster and with the same program create a version of that generic file that's 
correct for the other system. however to know which substatutions are 
appropriate to do for the file, it needs to know the filename (well, I guess I 
could create a whole bunch of seperate config files, and then define all the 
files with different filters, each filter including the config file to use fo 
rthat specific file, but this seems like a really ugly way to do it)

> one thing that was listed as a possibilty was to use the sha1 of the file, 
> but you would force the filter to calculate that itself. it's already 
> available when extracting and recalcuating it is a waste

ignore this comment, I see you posted an example of this.

David Lang
