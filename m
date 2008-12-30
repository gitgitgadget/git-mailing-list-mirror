From: "Zorba" <cr@altmore.co.uk>
Subject: Re: turn off "LF will be replaced by CRLF" thingy
Date: Tue, 30 Dec 2008 00:48:33 -0000
Message-ID: <gjbr5k$r89$4@ger.gmane.org>
References: <gjaqta$tg7$4@ger.gmane.org> <37fcd2780812290758q3ef989c0w5156da3098d06068@mail.gmail.com> <gjat90$5la$4@ger.gmane.org> <alpine.DEB.1.10.0812290928370.15026@asgard.lang.hm>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 01:50:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHSox-0005Lr-VR
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 01:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbYL3AtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 19:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752909AbYL3AtI
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 19:49:08 -0500
Received: from main.gmane.org ([80.91.229.2]:49338 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752699AbYL3AtH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 19:49:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHSn5-0004Mc-Vs
	for git@vger.kernel.org; Tue, 30 Dec 2008 00:49:00 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 00:48:59 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 00:48:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Response
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.2 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.2 PRIORITY_NO_NAME Message has priority, but no X-Mailer/User-Agent
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104142>

Hi David & thanks for helping me out,

So I tried again to do

$ git add .

this time no warnings about CRLF / LF, in fact no output, so not sure if it 
did anything (though took some time to process)

$ git status

Shows all the files in the index ok, but I don't know if it was the first 
git add or the second (post CRLF=false config change) that put them there 
....

I'd like to be certain, as 500 out of 5000 files could just get changed here 
!

I know I could just delete everything in .git dir, and git init again

But I'm after the intelligent way to do this :-(



<david@lang.hm> wrote in message 
news:alpine.DEB.1.10.0812290928370.15026@asgard.lang.hm...
> On Mon, 29 Dec 2008, Zorba wrote:
>
>> Thanks Dmitry,
>>
>> So I have two options to do this - edit the files direct or issue a 
>> command,
>> thank you !
>>
>> Now, my next problem is taking all my changes ($ git add .  -> puts 5k 
>> files
>> into index, with LF in place of CRLF) out of the index.
>>
>> Because I haven't committed anything in this repo yet...
>
> I think if you just do a git add . again it will put the files into the 
> index without doing the conversion.
>
> David Lang
>
>> $ git reset --hard
>>
>> ....falls over, as it has no HEAD to reset to
>>
>> I think I read how to do this in a tutorial somewhere, maybe with
>> git-checkout, but I'm searching and can't find it.
>> Any kind soul can point me in the right direction ?
>>
>> thanks !
>> "Dmitry Potapov" <dpotapov@gmail.com> wrote in message
>> news:37fcd2780812290758q3ef989c0w5156da3098d06068@mail.gmail.com...
>>>> I'd rather not let git change any files, many of which are PHP that run
>>>> on
>>>> Apache
>>>> I think I remember reading that this is a config option that gets
>>>> swithced
>>>> on by default on windows (which we are running git on)
>>>>
>>>> how do I switch it off ?
>>>
>>> git config core.autocrlf false
>>>
>>> or if you want to ensure that all your text files have only LF then
>>>
>>> git config core.autocrlf input
>>>
>>> or if you want to disable conversion for some specific files then you 
>>> can
>>> use 'crlf' attribute. See 'gitattributes' for more information.
>>> http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html
>>>
>>> Dmitry
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
