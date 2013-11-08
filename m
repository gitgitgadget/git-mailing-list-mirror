From: Thomas Manson <dev.mansonthomas@gmail.com>
Subject: Re: Selectively commit/publish files to GIT
Date: Sat, 9 Nov 2013 00:01:31 +0100
Message-ID: <CA+PenvHDUSBUBAQB3Lxoh7sTVfq_s=D2n2FqxnEu1_uUSvOYrw@mail.gmail.com>
References: <CA+PenvEDY6mc+DyjXy4ebZKdK4R=ucM28MDXGC42XKxvJ=a-pQ@mail.gmail.com>
 <20131108141329.GA26790@google.com> <CA+PenvG7CnkvN-XZE-uYBh42Yyqq23G5fOFRNhCU83m3V5f8sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?TWFnbnVzIELDpGNr?= <baeck@google.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 00:02:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vev3u-0004kD-6T
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 00:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758462Ab3KHXBx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Nov 2013 18:01:53 -0500
Received: from mail-we0-f175.google.com ([74.125.82.175]:50324 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758083Ab3KHXBw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Nov 2013 18:01:52 -0500
Received: by mail-we0-f175.google.com with SMTP id p61so5978wes.6
        for <git@vger.kernel.org>; Fri, 08 Nov 2013 15:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Tr221SLLwJIDjWRuOWCAHRRl7lQ5RulZN50bq9sWiUA=;
        b=iOtuHtWMhj01Za7/mHXEEyFVjT12Q/KuZhMWzhRkg6mfobiiT0SjhbsKpz07iq9wAE
         qBlQ1idolZFj8DRTDYBh3jCr1JVvvKuqjn0nBXljIOYw3bf2LedYR11LXg1WyjOxV5cO
         AntH/0TM56VaelaPRP70XFSCBJ4UK6tgE9U+RIzxJbStFQXAsD907hWDWgoyhJ80eXU1
         z7bJlsJbSYqGlbRL8v7Zo8DZNi9mf6Nhi3QYgEQKmyBF2A4wUjXjApffkybtEABnLNZj
         jGgkQMYhMB/hlckwksRbFxbybyfG7/xhJPyvnN8vCl+llgIAaWUD/JbOoerY61ZTmM8I
         QbGQ==
X-Received: by 10.194.175.202 with SMTP id cc10mr2798wjc.48.1383951711608;
 Fri, 08 Nov 2013 15:01:51 -0800 (PST)
Received: by 10.180.21.162 with HTTP; Fri, 8 Nov 2013 15:01:31 -0800 (PST)
In-Reply-To: <CA+PenvG7CnkvN-XZE-uYBh42Yyqq23G5fOFRNhCU83m3V5f8sQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237472>

Thanks Magnus, it did solve my issue.

I've noticed by the way that i've accidentally commited the whole .bzr
directory (that hold all my commit in Bazaar style).

I've deleted this folder as well using -r

git filter-branch --force --index-filter   'git rm -r --cached
--ignore-unmatch .bzr'   --prune-empty --tag-name-filter cat -- --all




for reference, an example of working run :

Thomass-MacBook-Pro:crf-rdp tmanson$ git filter-branch --force
--index-filter   'git rm --cached --ignore-unmatch
Ressources/dwr/dwr-3.0.0.110.dev-src.zip'   --prune-empty
--tag-name-filter cat -- --all
Rewrite 58952de4e10bc1df2f8c324e94d249a0366f7512 (65/158)rm
'Ressources/dwr/dwr-3.0.0.110.dev-src.zip'
Rewrite e661d08f1c33d7bd53e2c2231a3296b2ade5a2dd (66/158)rm
'Ressources/dwr/dwr-3.0.0.110.dev-src.zip'
Rewrite 8ff3f3f9ffb901b7cdc1dba220a121bab0698121 (67/158)rm
'Ressources/dwr/dwr-3.0.0.110.dev-src.zip'
Rewrite cfec6341565c35c410f248e5861543ac01b84f40 (158/158)
Ref 'refs/heads/master' was rewritten
Ref 'refs/tags/version-0-1_20081120' was rewritten
Ref 'refs/tags/version-0-5-1_20120512' was rewritten


On Fri, Nov 8, 2013 at 11:51 PM, Thomas Manson
<dev.mansonthomas@gmail.com> wrote:
> Hi Magnus,
>
>  thanks for pointing that out. I must have overlooked the webpage,
> when I saw that I thought it was some kind of alias that designated
> files greater than a specific files (server side configurated as the
> 100MB limit)
>
>   I'll try again ;)
>
> Thomas.
>
> On Fri, Nov 8, 2013 at 3:13 PM, Magnus B=C3=A4ck <baeck@google.com> w=
rote:
>> On Friday, November 08, 2013 at 05:52 EST,
>>      Thomas Manson <dev.mansonthomas@gmail.com> wrote:
>>
>> [...]
>>
>>>   How can I search git history for big files and remove them, or ma=
rk
>>> them to be not published ?
>>>
>>> I've tryed this solution found on the link in the error:
>>>
>>> git filter-branch --force --index-filter   'git rm --cached
>>> --ignore-unmatch giant_file'   --prune-empty --tag-name-filter cat =
--
>>> --all
>>> git commit --amend -CHEAD
>>
>> [...]
>>
>>> here is the error I have using the GitHub application on Mac :
>>> (after that I intend to use Eclipse)
>>>
>>> File Ressources/dwr/dwr-3.0.0.110.dev-src.zip is 67.69 MB; this is
>>> larger than GitHub's recommended maximum file size of 50 MB
>>> GH001: Large files detected.
>>> Trace: 8f0259b29260f0c4d7ae4d4ae70e0306
>>> See http://git.io/iEPt8g for more information.
>>> File .bzr/repository/packs/a7bcd6ba235114ab88c80fe8a97adcfa.pack is
>>> 178.76 MB; this exceeds GitHub's file size limit of 100 MB
>>
>> Did you actually replace the 'giant_file' placeholder with the path =
to
>> *your* giant file? The error message indicates that you didn't, or t=
hat
>> something else went wrong during the filtering.
>>
>> You can use 'git log' to look for commits touching particular pathna=
mes,
>> making it easy to verify that a file has been eradicated.
>>
>> git log --all -- path/to/big-honking-file.zip
>>
>> --
>> Magnus B=C3=A4ck
>> baeck@google.com
