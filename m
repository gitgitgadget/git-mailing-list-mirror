From: Kevin Ballard <kevin@sb.org>
Subject: Re: Verilog/ASIC development support is insufficient in git , help!
Date: Sun, 11 May 2008 00:33:48 -0500
Message-ID: <F975216F-9B61-41FF-A7FE-3D7EF09D137B@sb.org>
References: <EB66C79C87CF49E59CB39EA4C286AE05@justinuTop> <BA7F9A3C7EDA4CDD99016093B0DB55C0@justinuTop> <B03D1DC3-7088-41AF-BB8B-9A696E7C5B8E@sb.org> <83EE186A7AF140179C6C73B367471EC7@justinuTop>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <justin0927@hotmail.com>
To: "Justin Leung" <jleung@redback.com>
X-From: git-owner@vger.kernel.org Sun May 11 07:34:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv4Cz-0007VJ-TE
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 07:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbYEKFeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 01:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbYEKFeD
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 01:34:03 -0400
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:37654 "EHLO
	randymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751071AbYEKFeB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 May 2008 01:34:01 -0400
Received: from [192.168.1.106] (ip68-1-99-99.pn.at.cox.net [68.1.99.99])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a12.g.dreamhost.com (Postfix) with ESMTP id D54A1A8A8D;
	Sat, 10 May 2008 22:33:59 -0700 (PDT)
In-Reply-To: <83EE186A7AF140179C6C73B367471EC7@justinuTop>
X-Priority: 3
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81739>

On May 11, 2008, at 12:29 AM, Justin Leung wrote:

> Hi Kevin,
>
> The ability of inter-user (designer-verifier) code sync'ing without  
> letting the incomplete or incompatible RTL code to propagate to the  
> main build stream is going to facilitate the design flow and  
> efficiency .
>
> The ability of local revision control means that no more over  
> writing of design files until commit .
>
> I think these 2 things will really buy us alot .
>
> Justin
>
>> Honestly, it sounds like SVN is actually a good fit here. Just  
>> because git is awesome for many things does not mean it is the end- 
>> all-be-all  of version control systems. SVN still has its place as  
>> the last true centralized system. Given your constraints and  
>> workflow, why do you  think git is better than SVN?
>>
>> -Kevin Ballard

But they come at an expense - no more linear revision numbers, more  
complex commands, etc. You can't have it both ways.

You could always use a main SVN repo and then use git-svn to maintain  
your own private git repos, do all the code syncing you want there,  
and then push it back to SVN when you want to send it back to the main  
build stream. If you go this route, be careful to maintain a linear  
history on the branch that tracks the SVN repo, as SVN cannot handle  
merges the way git can. You'll want to either do rebasing or squashed  
merges (to avoid multiple parents).

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
