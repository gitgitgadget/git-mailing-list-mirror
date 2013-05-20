From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository dwimmery
Date: Mon, 20 May 2013 22:09:53 +0100
Organization: OPDS
Message-ID: <BDA138F1A58247F4A4940B3436A94485@PhilipOakley>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org><1368964449-2724-3-git-send-email-philipoakley@iee.org><20130519173924.GB3362@elie.Belkin> <7v38thwn6l.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 20 23:09:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeXLB-0001x2-4t
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 23:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758182Ab3ETVJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 17:09:53 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:53211 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757164Ab3ETVJw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 May 2013 17:09:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArkNAJqPmlFOl3mN/2dsb2JhbABagwiJKrhEBAEDAYEDF3SCGgUBAQQBCAEBLh4BASELAgMFAgEDFQELJRQBBAgSBgcXBgESCAIBAgMBh2oDCQqzcQ2IWYxKgW1qgnphA4hnhgGGao4DhSODEDs
X-IronPort-AV: E=Sophos;i="4.87,709,1363132800"; 
   d="scan'208";a="419257142"
Received: from host-78-151-121-141.as13285.net (HELO PhilipOakley) ([78.151.121.141])
  by out1.ip05ir2.opaltelecom.net with SMTP; 20 May 2013 22:09:50 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224982>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Monday, May 20, 2013 6:55 PM
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> --- a/Documentation/gitcli.txt
>>> +++ b/Documentation/gitcli.txt
>>> @@ -59,6 +59,10 @@ working tree.  After running `git add hello.c; rm 
>>> hello.c`, you will _not_
>>>  see `hello.c` in your working tree with the former, but with the 
>>> latter
>>>  you will.
>>>
>>> +Just as, by convention, the filesystem '.' refers to the current 
>>> directory,
>>> +using a '.' (period) as a repository name in Git (a dot-repository) 
>>> refers
>>> +to your local repository.
>>
>> Good idea, but I fear that no one would find it there.
>
> Also I think it would be better without ", by convention,".  If you
> say '.' == current directory is "a convention", you have to start
> saying that "by convention", "hello.c" refers to the file in the
> current directory of that name, which may be technically correct but
> make the phrase "by convention" meaningless.  A dot "."  is *the*
> name for the current directory, just like "hello.c" is the name for
> that file.

The part I had previously needed clearing up was if the '.' was in some 
way expanded by the shell, or whether the file system commands 
interpreted it by themselves for that specific purpose. So in this case 
Git sees the single character and has to decide what to do with it.

>
>    Just like '.' refers to the current directory in the filesystem, 
> '.'
>    refers to the current repository.
>
> would be sufficient.
>
>> Would it make sense to put this in Documentation/urls.txt (aka the
>> "GIT URLS" section of git-fetch(1) and git-clone(1)), where other URL
>> schemes are documented?
>
> Yes, the '.' described above is a special case of giving a
> repository URL as a relative-path on the filesystem.

So we can have a branch whose remote is '.'
_and_ a remote whose URL is '.'

Hence we/one/I could declare a remote called 'home' whose URL is '.'
(with my 'away' remote on Github - just thinking aloud of the upstream / 
downstream / across-stream discussions!)

Can there be a clash with a named remote that is actually '.', where the 
push/fetch is actually a no-op?

Philip 
