X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.5 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>
Subject: Re: [RFC] A unique way to express "all" (vs "add vs "update") ?
Date: Mon, 18 Dec 2006 12:48:19 +0100
Message-ID: <45868003.3010803@brefemail.com>
References: <elu1cn$k3$1@sea.gmane.org> <4582906A.7020204@op5.se>
Reply-To: t2a2e9z8ncbs9qg@brefemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 18 Dec 2006 11:47:04 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 115
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212.11.48.246
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <4582906A.7020204@op5.se>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34738>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwGxT-0004bG-OP for gcvg-git@gmane.org; Mon, 18 Dec
 2006 12:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753879AbWLRLrA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 06:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753880AbWLRLrA
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 06:47:00 -0500
Received: from main.gmane.org ([80.91.229.2]:34528 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1753879AbWLRLq7
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006 06:46:59 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GwGx6-0006oW-EW for git@vger.kernel.org; Mon, 18 Dec 2006 12:46:41 +0100
Received: from 212.11.48.246 ([212.11.48.246]) by main.gmane.org with esmtp
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 18
 Dec 2006 12:46:40 +0100
Received: from t2a2e9z8ncbs9qg by 212.11.48.246 with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 18 Dec 2006
 12:46:40 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

Andreas Ericsson wrote:
> Jerome Lovy wrote:
>> While I am very happy with the refactorings undertaken with regard to
>> "git add/git commit" (both for UI and documentation), I am still a
>> little confused by the different ways I seem to find to express the idea
>> "I want to add (sort of) all file contents".
>>
>> To be more specific, I find the following in the current documentation:
>>
>> git add <dir>
>>     "adds content from all files under <dir>  directory and its
>>     subdirectories."
>>     (as interpreted from the "EXAMPLES" section of the git-add
>>     man-page)
>>     (BTW, could this <dir> usage be documented in the SYNOPSIS and
>>     DESCRIPTION sections (admittedly at a 2nd rank after the
>>     currently documented usage)  as well as in the EXAMPLES ?
>>     Besides this reference sections would probably include the
>>     <dir>/<regexp> usage that I've not mentioned here for the sake
>>     of simplicity.)
>>         Moreover, the tutorial documents the typical usage "git add ."
>>
>> git commit -a|--all
>>     "automatically stage files that have been modified and deleted,
>>     but new files you have not told git about are not affected."
>>
>> Granted, the latter semantics for "all" is not exactly the same as the
>> former. Nonetheless, I think it would be very nice to only have to 
>> memorize one way to express "all".
>>
> 
> But the former isn't "all"; It's a specific directory, although "." 
> happens to *look* like "all", you can run "git add ." in a subdirectory 
> inside the repository and it won't mean "all" anymore. Likewise, you can 
> say "git commit ." from a subdirectory and have it commit all changes to 
> all tracked files under that directory.
OK. For my information, are the following commands completely
equivalent ?
1)	git commit -a
2)	(cd `git-rev-parse --git-dir`/..; git commit .)

> 
>> To this end, I would be very happy with the following:
>> (X-mas is coming soon, isn't it ;-)  )
>>
>> git add <dir>
>>     same semantics
>>
>> git commit -a|--add <files>
>>     "adds content from the specified files before committing
>>     (files that are already tracked have their current content
>>     staged)"
>>
>> git commit -a|--add <dir>
>>     "adds content from all files under <dir>  directory and its
>>     subdirectories before committing"
>>     (once again, for simplification of my explanations, I omit the
>>     <dir>/<regexp> usage here)
>>
>> git commit -u|--update <dir>
>>     "automatically stage files that have been modified and deleted
>>     under <dir>  directory and its subdirectories, but new files you
>>     have not told git about are not affected."
>>     (once again, for simplification of my explanations, I omit the
>>     <dir>/<regexp> usage here)
>>
> 
> But this isn't "commit" at all. It's "git add".
OK. To faithfully follow the current existing description of
'git commit -a', I should have indeed written:
git commit -u|--update <dir>
     "_Tell the command to_ automatically stage files that have been
     modified and deleted under <dir>  directory and its subdirectories,
     but new files you have not told git about are not affected."

> 
>>     (This would allow the typical usage "git commit -u ." which is
>>     barely longer than the current "git commit -a")
>>
>> For interface completeness, "git commit -u|--update <files>" could also
>> exist but would probably be of no use.
>>
>> To sum up, "all" would be consistently expressed with the <dir> syntax.
>> "git commit -a" would not mean "--all" anymore. Lastly, a distinction
>> would be made between "--add" and "--update":
>> - "git commit -add" would have the same semantics as "git add"
> 
> This is bollocks. git commit should commit things. We'll be in some 
> serious trouble if "git commit -a" stops working the way it has and 
> starts just adding things to index.
OK. I obviously wasn't precise enough. Let me restate:
- "git commit -add" would allow the same <file>/<dir> parameter usage as 
"git add"

> 
>> - "git commit --update" on the other hand would only affect the files
>>   already tracked
>>
> 
> I fail to see what you're after with the changes propsed in this mail.
> Is there a use-case you've encountered where you wanted to do something 
> that wasn't possible, or easy enough, that made you post this?
My case is not that I've encountered something that wasn't possible or 
easy enough (everything is indeed possible with the right combination of 
"git add" and "git commit"), but rather that I candidly felt that 
"--all" is more difficult to understand/learn/memorize/teach than 
expected since it doesn't really mean "all" (because it excludes "new 
files you have not told git about").

> 
> Unless it's a very, very good reason I most urgently think we're better 
> off keeping the current "git commit -a" behaviour.
> 
