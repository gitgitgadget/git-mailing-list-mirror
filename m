From: "Jacob Helwig" <jacob.helwig@gmail.com>
Subject: Re: is there an easier way to do this ? [Scanned]
Date: Mon, 29 Dec 2008 20:17:30 -0800
Message-ID: <8c9a060812292017m600ca246pf8660630d49a7067@mail.gmail.com>
References: <BB5F02FD3789B54E8964D38D6775E718242D1B@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Conor Rafferty" <conor.rafferty@altmore.co.uk>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 30 05:18:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHW4D-0003o1-Rf
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 05:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbYL3ERd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 23:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbYL3ERc
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 23:17:32 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:28154 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbYL3ERb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 23:17:31 -0500
Received: by qw-out-2122.google.com with SMTP id 3so3986186qwe.37
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 20:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9TpUlM3EenQteMT7j84px5Vn38ZzjBDAVBR+pKeasY0=;
        b=SfdhTj6rXcJfHvmQuhZT4ubppYt851l/FhxSGLI7d3qUWxyliabuvctajQcm/Zic+/
         /Uhfsus2njoepToC7u8PCylRhvLUTNc6pVQEkiKAy/1p08pbQEMGfzgFyDRNy7D3QS+l
         EFqsPHHjZTk5yFhCrYxNpjrHc/GcEqG09eWQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=h+YouCaJGm+GN0wscr3vu/l8lmbl6vxS6mGvKhrs//SB6kI9jw0h/o1fdH/mQPZbFJ
         lRfjaUG+yNsI3oRQ915N/UCEo+MD5nNZw0CU6Byq92m3utZ1Ol5gKRx/GTECUzA0spM2
         L6+YXCZZmrZnxFgdHB+Qu1MGy8UhUx15JE3EY=
Received: by 10.214.10.8 with SMTP id 8mr11947528qaj.293.1230610650297;
        Mon, 29 Dec 2008 20:17:30 -0800 (PST)
Received: by 10.214.216.7 with HTTP; Mon, 29 Dec 2008 20:17:30 -0800 (PST)
In-Reply-To: <BB5F02FD3789B54E8964D38D6775E718242D1B@ALTMORE-SVR.altmore.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104154>

On Mon, Dec 29, 2008 at 20:11, Conor Rafferty
<conor.rafferty@altmore.co.uk> wrote:
> Ah, but what about the files that have been removed from this version ?
> - that's the whole point of doing commit -a, so I don't have to spend
> ages doing diffs to produce a list of files to feed into git-rm
>
> Or have I missed another glarer ?
>
> -----Original Message-----
> From: Jacob Helwig [mailto:jacob.helwig@gmail.com]
> Sent: 30 December 2008 04:01
> To: git@vger.kernel.org
> Cc: Conor Rafferty
> Subject: Re: is there an easier way to do this ? [Scanned]
>
> On Mon, Dec 29, 2008 at 19:51, Zorba <cr@altmore.co.uk> wrote:
>> The manual shows you can SHOW untracked files, but not add them as
>> part of the commit -a jig
>>
>> Seems a bit strange that git-add operates on both exisging and new
>> files when used standalone, but its behaviour changes when
>> encapsulated in commit -a...
>>
>> So, I thought maybe $ git commit -a, then $ git add .
>> but then the files tracked have missed the commit boat they were meant
>
>> to be on, haven't they,
>>
>> hang on -
>> what about
>>
>> $ git add .
>> $ git commit -a
>>
>> I do believe I've cracked it
>> if so, it seems a bit wasteful, 2x adds (one explicti and one embedded
>
>> in -a) ? shame on you linux kernel guys, i'd have expected better :-)
>>
>> "Zorba" <cr@altmore.co.uk> wrote in message
>> news:gjc52u$ehc$4@ger.gmane.org...
>>> ok, now I'm in this for real, archiving versions of our website
>>> project (5k files approx)
>>>
>>> so here is the workflow:
>>>
>>> - copy version 1 files into GIT dir
>>>
>>> - open git bash
>>>
>>> $ git init
>>>
>>> $ git add .
>>>
>>> $ git commit -m "version1"
>>>
>>> all vanilla ? cool
>>> next job = store version 2, so delete version 1 files from GIT dir,
>>> copy in version 2
>>> version2 has different files from 1 - which ones? Out of 5k files
>>> could be 1% = 50 new ones, and same amount removed. Why should I
>>> care, with such a powerful friend as git around, n'est pas?
>>> THIS TIME we are going to be CLEVER and use "-a" flag on commit to
>>> pick up any files that have been REMOVED (or "deleted" in git-speak)
>>>
>>> $ git commit -a -m "version2"
>>>
>>> BUT this does not pick up any new ones that have been added,
>>>
>>> and when we run
>>>
>>> $ git status > ../git_status.txt
>>>
>>> these are referred to as "untracked files"
>>> only problem there are 50 ish
>>> is there not another flag on git commit to treat any untracked file
>>> as a new file ?
>>> (would save me typing or creating a list out of these untracked ones
>>> and feeding them into git add)
>>>
>>> I know, I realise now I should have looked up git-commit in the
>>> manual - in case its not there, pls enlighten me !
>>>
>>>
>>>
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in the
>> body of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
>>
>
> If you do an explicit git add, then you don't need the -a on git commit,
> since everything you want to commit will already be in the index for git
> commit to work with.
>

See the -A flag for git add (and it's reference to --update).  -A will
remove files that have been removed, add untracked, and update ones
that have changed, all in one go.
