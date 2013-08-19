From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: CPPCheck found 24 high risk bugs in Git v.1.8.3.4
Date: Mon, 19 Aug 2013 23:55:53 +0100
Organization: OPDS
Message-ID: <166132E40AA54EE387BA9B4558823C55@PhilipOakley>
References: <85C8141E5DAD94428A121F706995A31F010F116FDAD3@MX1.net.tbe.com> <33FCCE7A2CD5494B88F3C5CDBC341DFD@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: "Erik Faye-Lund" <kusmabite@gmail.com>
To: "Koch, Rick \(Subcontractor\)" <Rick.Koch@tbe.com>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 20 00:55:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBYMe-0007IM-Up
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 00:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121Ab3HSWzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 18:55:53 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:64901 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750816Ab3HSWzw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Aug 2013 18:55:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AugLABuiElJOl3GZ/2dsb2JhbABagwU1iSm2UwQEAYEjF3SCHwUBAQQBCAEBLh4BASEFBgEBAwUCAQMVAQslFAEEGgYHFwYBEggCAQIDAQOHdgoIqm2PI4E5gyJ3A4h1hg6KDpAogx07gTU
X-IPAS-Result: AugLABuiElJOl3GZ/2dsb2JhbABagwU1iSm2UwQEAYEjF3SCHwUBAQQBCAEBLh4BASEFBgEBAwUCAQMVAQslFAEEGgYHFwYBEggCAQIDAQOHdgoIqm2PI4E5gyJ3A4h1hg6KDpAogx07gTU
X-IronPort-AV: E=Sophos;i="4.89,915,1367967600"; 
   d="scan'208";a="429383862"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip05ir2.opaltelecom.net with SMTP; 19 Aug 2013 23:55:50 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
x-mimeole: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232576>

----- Original Message ----- 
From: "Philip Oakley" <philipoakley@iee.org>
> From: "Koch, Rick (Subcontractor)" <Rick.Koch@tbe.com>
> Sent: Monday, August 19, 2013 6:09 PM
>>I'm directing to this e-mail, as it seems to be the approved forum
>>for posting Git bugs. We ran CPPCheck against Git v.1.8.3.4
>>and found 24 high risk bugs. Please see the attachment xlsx.
>
>>Is there a method to post to the Git community to allow the
>>community to review and debunk as faults positive or develop
>>patches to fix lists code files?
>
>>v/r
>
>>Roderick (Rick) Koch
>>Information Assurance
>>Rick.Koch@tbe.com
>
> What OS version / CPPCheck version was this checked on?
>
> In case other readers don't have a .xlsx reader here is Rick's list in 
> plain text (may be white space damaged).
>
> I expect some will be false positives, and some will just be being too 
> cautious.
>
> Philip
>
> description resourceFilePath fileName lineNumber
>      nullPointer(CppCheck) \git-master\builtin\add.c add.c 286
>      wrongPrintfScanfArgNum(CppCheck) \git-master\builtin\fetch.c
> fetch.c 588
>      nullPointer(CppCheck) \git-master\builtin\ls-files.c ls-files.c
> 144
>      nullPointer(CppCheck) \git-master\builtin\merge.c merge.c 1208
>      doubleFree(CppCheck) \git-master\builtin\notes.c notes.c 275
>      nullPointer(CppCheck) \git-master\builtin\reflog.c reflog.c 437
>      uninitvar(CppCheck) \git-master\builtin\rev-list.c rev-list.c 342
>      uninitvar(CppCheck) \git-master\builtin\rev-list.c rev-list.c 342
>      uninitvar(CppCheck) \git-master\compat\regex\regcomp.c regcomp.c
> 2803
>      uninitvar(CppCheck) \git-master\compat\regex\regcomp.c regcomp.c
> 2802
>      uninitvar(CppCheck) \git-master\compat\regex\regcomp.c regcomp.c
> 2805
>      memleakOnRealloc(CppCheck) \git-master\compat\win32\syslog.c
> syslog.c 46

This looks like a possible, based on 
http://bytes.com/topic/c/answers/215084-can-realloc-potentially-cause-memory-leak 
(Mac's reply, with tweaks)

"Misuse of realloc CAN cause a memory leak, but only when allocation 
fails"
"if realloc fails, the memory previously pointed to by 'str = 
realloc(str, ++str_len + 1)' will still be claimed, but you will have 
lost your only pointer to it, because realloc returns NULL on failure. 
This is a memory leak."

We (those using the compat function) then only provide a warning, so it 
could repeat endlessly.

Eric (cc'd) may be able to clarify if this is a possibility.

>      uninitvar(CppCheck)
> \git-master\contrib\examples\builtin-fetch--tool.c 
> builtin-fetch--tool.c
> 419
>      uninitvar(CppCheck) \git-master\fast-import.c fast-import.c 2917
>      nullPointer(CppCheck) \git-master\line-log.c line-log.c 638
>      nullPointer(CppCheck) \git-master\mailmap.c mailmap.c 156
>      uninitvar(CppCheck) \git-master\merge-recursive.c
> merge-recursive.c 1887
>      uninitvar(CppCheck) \git-master\notes.c notes.c 805
>      uninitvar(CppCheck) \git-master\notes.c notes.c 805
>      deallocret(CppCheck) \git-master\pretty.c pretty.c 677
>      resourceLeak(CppCheck) \git-master\refs.c refs.c 3041
>      doubleFree(CppCheck) \git-master\sequencer.c sequencer.c 924
>      nullPointer(CppCheck) \git-master\sha1_file.c sha1_file.c 125
>      doubleFree(CppCheck) \git-master\shell.c shell.c 130
>
> --
Philip 
