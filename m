From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] gitweb: Allow for href() to be used for projectless links
Date: Fri, 15 Sep 2006 09:21:37 +0200
Organization: At home
Message-ID: <eedk96$tja$2@sea.gmane.org>
References: <200609150453.42231.jnareb@gmail.com> <200609150457.16924.jnareb@gmail.com> <7vzmd1zma7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Sep 15 09:21:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO80s-0001yo-80
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 09:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWIOHVX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 03:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWIOHVX
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 03:21:23 -0400
Received: from main.gmane.org ([80.91.229.2]:5847 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750991AbWIOHVX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Sep 2006 03:21:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GO80m-0001x8-BF
	for git@vger.kernel.org; Fri, 15 Sep 2006 09:21:20 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 09:21:20 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 09:21:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27064>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Change adding project to params if $params{"project"} is false
>> to adding project to params if it not exist. It allows for href()
>> to be used for projectless links by using "project=>undef" as
>> argument, while still adding project to params by default
>> in the most common case.
> 
> This did not parse very well, at least for me.

O.K. let me rephrase it. Before this patch href() ensured that we had
p=<project> among CGI params, by adding it if it was not provided. Some
actions don't need project parameter, namely "project_list",
"project_index" and "opml". Moreover "project_list" view was sed as a
_home_ link, i.e. default action when project was not provided (just like
summary is default action when project is provided).

The change introduced by this patch allow to use href() to generate links
also for "project_list" and "opml" views. The only links which do not use
href() are anchor links, and $home_link link.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
