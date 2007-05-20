From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] rev-list: '--indent' oneline output
Date: Sun, 20 May 2007 22:38:23 +0200
Message-ID: <CDD390B5-A67E-4510-9DAF-F0CB13AC8A4B@zib.de>
References: <20070518215603.GS15393@fieldses.org> <1179676829751-git-send-email-prohaska@zib.de> <7vveenl4u4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, bfields@fieldses.org,
	torvalds@linux-foundation.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 22:39:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpsBJ-0006Fm-N0
	for gcvg-git@gmane.org; Sun, 20 May 2007 22:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069AbXETUjF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 16:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756123AbXETUjF
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 16:39:05 -0400
Received: from mailer.zib.de ([130.73.108.11]:64051 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756069AbXETUjE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 16:39:04 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l4KKcGnj011477;
	Sun, 20 May 2007 22:38:16 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1bb27.pool.einsundeins.de [77.177.187.39])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l4KKcFVN017785
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 20 May 2007 22:38:15 +0200 (MEST)
In-Reply-To: <7vveenl4u4.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47909>


On May 20, 2007, at 8:36 PM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> Summaries in oneline output are indented to show the location of
>> parents in merge commits. Indentation level is computed as the
>> smallest sum of parent locations along all paths that reach the
>> commit.
>>
>> As a result, the output of
>>     git-rev-list --pretty=oneline --topo-order --indent
>> is formatted in a way that resembles merge summaries. All commits  
>> that
>> were pulled from a branch are indented with one additional space  
>> below
>> the summary of the merge commit.
>
> I would have expected this kind of UI level tweak to be done not
> as a rev-list feature, but the subject of the e-mail to read
> something like "--pretty=oneline: allow indentation levels",
> i.e. wouldn't the feature apply not just rev-list but also
> git-log?

It's only a proof of concept. I do not expect to see it added in
the current form. I'm not yet convinced if it's really a useful feature.

I'm also not sure if changing 'struct commit' is a good idea.
gitk is able to display the commit graph by parsing output of the
existing git-rev-list. It should be possible to do similar for log
formatting without changing 'struct commit'.

- Steffen
