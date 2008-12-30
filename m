From: "Zorba" <cr@altmore.co.uk>
Subject: Re: is there an easier way to do this ? [Scanned]
Date: Tue, 30 Dec 2008 04:29:23 -0000
Message-ID: <gjc83i$juc$4@ger.gmane.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D1B@ALTMORE-SVR.altmore.local> <8c9a060812292017m600ca246pf8660630d49a7067@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 05:31:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHWGQ-0005wW-3X
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 05:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbYL3EaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 23:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbYL3EaI
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 23:30:08 -0500
Received: from main.gmane.org ([80.91.229.2]:37350 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbYL3EaG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 23:30:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LHWF0-0002f4-QL
	for git@vger.kernel.org; Tue, 30 Dec 2008 04:30:02 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 04:30:02 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 04:30:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.2 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.2 PRIORITY_NO_NAME Message has priority, but no X-Mailer/User-Agent
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104157>

(punches air with fist)
yes indeed !

sorry, I didn't follow up on the --update flag first time

$ git add -A .
$ git commit

home in a boat!

"Jacob Helwig" <jacob.helwig@gmail.com> wrote in message 
news:8c9a060812292017m600ca246pf8660630d49a7067@mail.gmail.com...
> On Mon, Dec 29, 2008 at 20:11, Conor Rafferty
> <conor.rafferty@altmore.co.uk> wrote:
>> Ah, but what about the files that have been removed from this version ?
>> - that's the whole point of doing commit -a, so I don't have to spend
>> ages doing diffs to produce a list of files to feed into git-rm
>>
>> Or have I missed another glarer ?
>>
>> -----Original Message-----
>> From: Jacob Helwig [mailto:jacob.helwig@gmail.com]
>> Sent: 30 December 2008 04:01
>> To: git@vger.kernel.org
>> Cc: Conor Rafferty
>> Subject: Re: is there an easier way to do this ? [Scanned]
>>
>> On Mon, Dec 29, 2008 at 19:51, Zorba <cr@altmore.co.uk> wrote:
>>> The manual shows you can SHOW untracked files, but not add them as
>>> part of the commit -a jig
>>>
>>> Seems a bit strange that git-add operates on both exisging and new
>>> files when used standalone, but its behaviour changes when
>>> encapsulated in commit -a...
>>>
>>> So, I thought maybe $ git commit -a, then $ git add .
>>> but then the files tracked have missed the commit boat they were meant
>>
>>> to be on, haven't they,
>>>
>>> hang on -
>>> what about
>>>
>>> $ git add .
>>> $ git commit -a
>>>
>>> I do believe I've cracked it
>>> if so, it seems a bit wasteful, 2x adds (one explicti and one embedded
>>
>>> in -a) ? shame on you linux kernel guys, i'd have expected better :-)
>>>
>>> "Zorba" <cr@altmore.co.uk> wrote in message
>>> news:gjc52u$ehc$4@ger.gmane.org...
>>>> ok, now I'm in this for real, archiving versions of our website
>>>> project (5k files approx)
>>>>
>>>> so here is the workflow:
>>>>
>>>> - copy version 1 files into GIT dir
>>>>
>>>> - open git bash
>>>>
>>>> $ git init
>>>>
>>>> $ git add .
>>>>
>>>> $ git commit -m "version1"
>>>>
>>>> all vanilla ? cool
>>>> next job = store version 2, so delete version 1 files from GIT dir,
>>>> copy in version 2
>>>> version2 has different files from 1 - which ones? Out of 5k files
>>>> could be 1% = 50 new ones, and same amount removed. Why should I
>>>> care, with such a powerful friend as git around, n'est pas?
>>>> THIS TIME we are going to be CLEVER and use "-a" flag on commit to
>>>> pick up any files that have been REMOVED (or "deleted" in git-speak)
>>>>
>>>> $ git commit -a -m "version2"
>>>>
>>>> BUT this does not pick up any new ones that have been added,
>>>>
>>>> and when we run
>>>>
>>>> $ git status > ../git_status.txt
>>>>
>>>> these are referred to as "untracked files"
>>>> only problem there are 50 ish
>>>> is there not another flag on git commit to treat any untracked file
>>>> as a new file ?
>>>> (would save me typing or creating a list out of these untracked ones
>>>> and feeding them into git add)
>>>>
>>>> I know, I realise now I should have looked up git-commit in the
>>>> manual - in case its not there, pls enlighten me !
>>>>
>>>>
>>>>
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in the
>>> body of a message to majordomo@vger.kernel.org More majordomo info at
>>> http://vger.kernel.org/majordomo-info.html
>>>
>>
>> If you do an explicit git add, then you don't need the -a on git commit,
>> since everything you want to commit will already be in the index for git
>> commit to work with.
>>
>
> See the -A flag for git add (and it's reference to --update).  -A will
> remove files that have been removed, add untracked, and update ones
> that have changed, all in one go. 
