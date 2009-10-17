From: "jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com>
Subject: Re: Introduction and Wikipedia and Git Blame
Date: Sat, 17 Oct 2009 18:42:18 +0200
Message-ID: <ee9cc730910170942p7869d62ra08571948675d696@mail.gmail.com>
References: <ee9cc730910160207x49feb40ej692188abb0a57473@mail.gmail.com>
	 <ee9cc730910160443k7e5f718bs964923a796cf38d1@mail.gmail.com>
	 <alpine.DEB.1.00.0910161548550.4985@pacific.mpi-cbg.de>
	 <7vbpk7w9qx.fsf@alter.siamese.dyndns.org>
	 <ee9cc730910161100r71818303v343f555151db4dcc@mail.gmail.com>
	 <7v7huvuptn.fsf@alter.siamese.dyndns.org>
	 <7vpr8nt894.fsf@alter.siamese.dyndns.org>
	 <ee9cc730910161419x608f5972x705ce8088d72c94a@mail.gmail.com>
	 <7v3a5irkel.fsf@alter.siamese.dyndns.org>
	 <ee9cc730910162350p250b8afak767b0626bede34e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 18:42:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzCMN-0001GH-MG
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 18:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbZJQQmQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Oct 2009 12:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbZJQQmQ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 12:42:16 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:59729 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbZJQQmP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Oct 2009 12:42:15 -0400
Received: by fxm18 with SMTP id 18so3516802fxm.37
        for <git@vger.kernel.org>; Sat, 17 Oct 2009 09:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UlkHOJs7xWF6HO6/Fly2whE00D49co41yQ8oOlu1Nt8=;
        b=eMtn0etupDCR5SGLtJxBjlAaLcZ7k1o681AeOYEP02oWhX7NCkCswnVTzD6/cqYu74
         BCHKL35aHgT1abyggKFR7qKFhIUtHSy4FQIe1VXdgVZ3JvzNQEtMeOKmXgOi8JncJPqv
         SowN5wFhnW4bz6RPPFVq7giySBmgdst/GhGto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QVKC3DBw4XCvKT3hj7HoMhkVUx2rra6dOyvGjQimA4/pRU2kMndP/LJs8AErkY0lxd
         i9B240YUIZT5pzQwzYK0VklWYoHzJqxDxPWgeosoW2aLISzDmxZY9NXlxymmUTIS14hm
         zyPTTK5FXJru4tncmDT/PikADLF5jZGI10AyY=
Received: by 10.204.8.138 with SMTP id h10mr2758794bkh.187.1255797738587; Sat, 
	17 Oct 2009 09:42:18 -0700 (PDT)
In-Reply-To: <ee9cc730910162350p250b8afak767b0626bede34e4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130564>

I have done a workaround hack,
today I attempted to hack the blame code but I need to do more
research, it did not work.

But I did get a new version of the import script running and word
level blame going.

http://fmtyewtk.blogspot.com/2009/10/mediawiki-git-word-level-blaming-o=
ne.html

Next step is ready :

1. I have a single script that will pull a given article and check in
the revisions into git,
it is not perfect, but works.

http://bazaar.launchpad.net/~jamesmikedupont/+junk/wikiatransfer/revisi=
on/8
you run it like this,from inside a git repo :

perl GetRevisions.pl "Article_Name"

git blame Article_Name/Article.xml
git push origin master

The code that splits up the line is in Process File, this splits all
spaces into newlines.
that way we get a word level blame.

     if ($insidetext)
     {
  ## split all lines on the space
  s/(\ )/\\\n/g;


  print OUT  $_;
     }


The Article is here:
http://github.com/h4ck3rm1k3/KosovoWikipedia/blob/master/Wiki/2008_Koso=
vo_declaration_of_independence/article.xml


here are the blame results.
http://github.com/h4ck3rm1k3/KosovoWikipedia/blob/master/Wiki/2008_Koso=
vo_declaration_of_independence/wordblame.txt


Problem is that github does not like this amount of processor power
begin used and kills the process, you can do a local git blame.

Now we have the tool to easily create a repository from wikipedia, or
any other export enabled mediawiki.

mike


On Sat, Oct 17, 2009 at 8:50 AM, jamesmikedupont@googlemail.com
<jamesmikedupont@googlemail.com> wrote:
> Thank you very much for your input and advice,
> I have a lot of learn about this great tool.
> I am working on learning how the existing blame tool runs now.
> Will report back when I have some code.
> mike
>
> On Sat, Oct 17, 2009 at 1:25 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> "jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com> wr=
ites:
>>
>>> What do you think of my idea to create blames along a specific user
>>> defined byte positions ?
>>
>> Overly complicated and not enough time for _review_. =A0If you are b=
laming
>> one-byte (or one-char) per line, wouldn't it be enough to consider t=
he
>> line number in the output as byte (or char) position when reconstitu=
ting
>> the original text?
>>
>
