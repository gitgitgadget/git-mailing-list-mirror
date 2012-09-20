From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] test-string-list.c: Fix some sparse warnings
Date: Thu, 20 Sep 2012 09:13:37 +0200
Message-ID: <505AC221.8070103@alum.mit.edu>
References: <5054AA62.2040603@ramsay1.demon.co.uk> <5056DC28.60809@alum.mit.edu> <505A17D5.2000406@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Christopher Li <sparse@chrisli.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Sep 20 09:13:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEaxM-0004QG-JO
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 09:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165Ab2ITHNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 03:13:43 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:47603 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751891Ab2ITHNm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Sep 2012 03:13:42 -0400
X-AuditID: 12074411-b7fa36d0000008cc-78-505ac225597c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 35.49.02252.522CA505; Thu, 20 Sep 2012 03:13:41 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8K7DcQn023305
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Sep 2012 03:13:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <505A17D5.2000406@ramsay1.demon.co.uk>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqKt6KCrAYMtyNYuuK91MFg29V5gt
	dk9bwGbRteYQqwOLx4pVV1g8Ll5S9ng88QSrx+dNcgEsUdw2SYklZcGZ6Xn6dgncGQ+XPWEt
	uCZQcbj7F1sD43veLkZODgkBE4mmzVOZIWwxiQv31rN1MXJxCAlcZpSYcfEdK4RznEni4P5X
	LF2MHBy8AtoSrRscQBpYBFQl1m6eyAZiswnoSizqaWYCsUUFQiRmXJ4MNpRXQFDi5MwnLCC2
	CFDN4nknweLMAjUSHZO2gPUKCzhKPD+/DqxXSKBc4sOzK2BxTgFjibvXPrJB1OtIvOt7ANUr
	L7H97RzmCYwCs5CsmIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE31cjNL9FJT
	SjcxQsJZcAfjjJNyhxgFOBiVeHhNxKIChFgTy4orcw8xSnIwKYnyah8ECvEl5adUZiQWZ8QX
	leakFh9ilOBgVhLh3TgRKMebklhZlVqUD5OS5mBREuflW6LuJySQnliSmp2aWpBaBJOV4eBQ
	kuBdCTJUsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSp8cXAWAVJ8QDtLQFp5y0u
	SMwFikK0nmLU5Vh7d8EDRiGWvPy8VClxXkWQIgGQoozSPLgVsOT1ilEc6GNh3nKQKh5g4oOb
	9ApoCRPQkoonYSBLShIRUlINjKKblm7Q6D696rz//Fsvry7T596k//im3RXDnVMW8d7W3uie
	ZbK6cpefr8a/PfVHP0/ILZS93JG2X+bPU33pG3XzXvJuEk2SME0rvpU8I6CTdfPi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206040>

On 09/19/2012 09:07 PM, Ramsay Jones wrote:
> Michael Haggerty wrote:
>> Is there some documentation about how to run sparse on the git codebase?
>>  I naively tried "make sparse" and ended up with zillions of errors like
>>
>> /usr/include/unistd.h:288:54: error: attribute '__leaf__': unknown attribute
>> /usr/include/unistd.h:294:6: error: attribute '__leaf__': unknown attribute
>> /usr/include/unistd.h:298:6: error: attribute '__leaf__': unknown attribute
>> /usr/include/unistd.h:306:6: error: attribute '__leaf__': unknown attribute
>> /usr/include/unistd.h:338:18: error: attribute '__leaf__': unknown attribute
>> /usr/include/unistd.h:347:6: error: attribute '__leaf__': unknown attribute
>> /usr/include/unistd.h:418:36: error: attribute '__leaf__': unknown attribute
>> /usr/include/unistd.h:423:50: error: attribute '__leaf__': unknown attribute
> 
> Yep, "make sparse" is the correct way to run sparse over git.
> 
> This looks like you are running sparse on a 64-bit system. I have heard that
> it has (or *had*) problems running on 64-bit systems. Unfortunately, I am
> currently confined to 32-bit. (I'm looking at getting a new laptop soon, before
> Windows 8 causes boot-time problems, so I will then have the same problem!)
> 
> How did you obtain/build/install sparse? The current release (v0.4.4) was
> released about Nov 2011 and I think you need a more up to date version.
> i.e. you need to build the latest, directly from the sparse repo.

Yes, I'm running 64-bit Ubuntu 12.04 "precise".  I installed sparse from
the Ubuntu "multiverse" repository.  It is package version
0.4.3+20110419-1 in Ubuntu's notation.

Thanks very much for all the info.  I hadn't heard of sparse before and
thought that using it might help me avoid submitting patches with
problems like the ones you detected.  It does seem promising!  But since
it seems a bit fiddly to get it running, and even then has some
problems, it doesn't sound like the simple pre-submit checklist item
that I had imagined.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
