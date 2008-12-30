From: "Conor Rafferty" <conor.rafferty@altmore.co.uk>
Subject: RE: is there an easier way to do this ? [Scanned]
Date: Tue, 30 Dec 2008 04:11:37 -0000
Message-ID: <BB5F02FD3789B54E8964D38D6775E718242D1B@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Jacob Helwig" <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 05:13:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHVzA-0002v8-6u
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 05:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbYL3ELm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 23:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbYL3ELl
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 23:11:41 -0500
Received: from sbs.altmore.co.uk ([217.39.150.193]:14293 "HELO
	sbs.altmore.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751479AbYL3ELk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2008 23:11:40 -0500
X-PMWin-Version: 3.0.0.0, Antivirus-Engine: 2.82.1, Antivirus-Data: 4.37E
Content-Class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4133
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: is there an easier way to do this ? [Scanned]
thread-index: AclqMzpzBwISM/41TzGAhwoDVEdwTQAAC9EgAABNv+A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104153>

Ah, but what about the files that have been removed from this version ?
- that's the whole point of doing commit -a, so I don't have to spend
ages doing diffs to produce a list of files to feed into git-rm

Or have I missed another glarer ?

-----Original Message-----
From: Jacob Helwig [mailto:jacob.helwig@gmail.com]
Sent: 30 December 2008 04:01
To: git@vger.kernel.org
Cc: Conor Rafferty
Subject: Re: is there an easier way to do this ? [Scanned]

On Mon, Dec 29, 2008 at 19:51, Zorba <cr@altmore.co.uk> wrote:
> The manual shows you can SHOW untracked files, but not add them as 
> part of the commit -a jig
>
> Seems a bit strange that git-add operates on both exisging and new 
> files when used standalone, but its behaviour changes when 
> encapsulated in commit -a...
>
> So, I thought maybe $ git commit -a, then $ git add .
> but then the files tracked have missed the commit boat they were meant

> to be on, haven't they,
>
> hang on -
> what about
>
> $ git add .
> $ git commit -a
>
> I do believe I've cracked it
> if so, it seems a bit wasteful, 2x adds (one explicti and one embedded

> in -a) ? shame on you linux kernel guys, i'd have expected better :-)
>
> "Zorba" <cr@altmore.co.uk> wrote in message 
> news:gjc52u$ehc$4@ger.gmane.org...
>> ok, now I'm in this for real, archiving versions of our website 
>> project (5k files approx)
>>
>> so here is the workflow:
>>
>> - copy version 1 files into GIT dir
>>
>> - open git bash
>>
>> $ git init
>>
>> $ git add .
>>
>> $ git commit -m "version1"
>>
>> all vanilla ? cool
>> next job = store version 2, so delete version 1 files from GIT dir, 
>> copy in version 2
>> version2 has different files from 1 - which ones? Out of 5k files 
>> could be 1% = 50 new ones, and same amount removed. Why should I 
>> care, with such a powerful friend as git around, n'est pas?
>> THIS TIME we are going to be CLEVER and use "-a" flag on commit to 
>> pick up any files that have been REMOVED (or "deleted" in git-speak)
>>
>> $ git commit -a -m "version2"
>>
>> BUT this does not pick up any new ones that have been added,
>>
>> and when we run
>>
>> $ git status > ../git_status.txt
>>
>> these are referred to as "untracked files"
>> only problem there are 50 ish
>> is there not another flag on git commit to treat any untracked file 
>> as a new file ?
>> (would save me typing or creating a list out of these untracked ones 
>> and feeding them into git add)
>>
>> I know, I realise now I should have looked up git-commit in the 
>> manual - in case its not there, pls enlighten me !
>>
>>
>>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in the 
> body of a message to majordomo@vger.kernel.org More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
>

If you do an explicit git add, then you don't need the -a on git commit,
since everything you want to commit will already be in the index for git
commit to work with.
