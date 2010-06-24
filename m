From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Leaving large binaries out of the packfile
Date: Thu, 24 Jun 2010 00:32:47 -0600
Message-ID: <4C22FC0F.1060805@workspacewhiz.com>
References: <4C108556.8040102@workspacewhiz.com> <20100610180457.GO14847@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 24 08:32:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORfzc-0007Rs-1V
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 08:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab0FXGcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 02:32:50 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:54131 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab0FXGct (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 02:32:49 -0400
Received: (qmail 1332 invoked by uid 399); 24 Jun 2010 00:32:48 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 24 Jun 2010 00:32:48 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.4) Gecko/20100608 Lightning/1.0b1 Thunderbird/3.1
In-Reply-To: <20100610180457.GO14847@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149563>

  ----- Original Message -----
From: Shawn O. Pearce
Date: 6/10/2010 12:04 PM
> Joshua Jensen<jjensen@workspacewhiz.com>  wrote:
>> Sometimes, 'git gc' runs out of memory.  I have to discover which file
>> is causing the problem, so I can add it to .gitattributes with a
>> '-delta' flag.  Mostly, though, the repacking takes forever, and I dread
>> running the operation.
> If you have the list of big objects, you can put them into their
> own pack file manually.  Feed their SHA-1 names on stdin to git
> pack-objects, and save the resulting pack under .git/objects/pack.
>
> Assuming the pack was called pack-DEADC0FFEE.pack, create a file
> called pack-DEADC0FFEE.keep in the same directory.  This will stop
> Git from trying to repack the contents of that pack file.
>
> Now run `git gc` to remove those huge objects from the pack file
> that contains all of the other stuff
Pardon the late response.

This method can work, but it is a manual process.  I am interested in a 
method where Git can make the determination for me based on a wildcard 
and flag from .gitattributes.

I am still playing with the feature within a multi-gigabyte repository 
with lots of large binaries.  I'll post more about it when some 
additional changes have been made.

Thanks!

Josh
