From: Andreas Ericsson <ae@op5.se>
Subject: Re: git fast-import crashes importing commits with more than one
 author
Date: Mon, 03 May 2010 10:59:17 +0200
Message-ID: <4BDE9065.5030500@op5.se>
References: <1272728636.27562.12.camel@localhost.localdomain> 	<m2ocgztw7z.fsf@igel.home> <g2x86ecb3c71005010947x662aad8bn1fc2950d741b07e7@mail.gmail.com> 	<7vbpcz5ylz.fsf@alter.siamese.dyndns.org> <y2m86ecb3c71005011028t7f581ce7t98256aa8f8bbb0bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Giedrius Slavinskas <giedrius.slavinskas@gmail.com>,
	git@vger.kernel.org
To: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
X-From: git-owner@vger.kernel.org Mon May 03 10:59:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8rUw-0002AQ-OE
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 10:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923Ab0ECI7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 04:59:24 -0400
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:52432 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751758Ab0ECI7X (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 04:59:23 -0400
Received: from source ([72.14.220.158]) by na3sys009aob101.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS96QaSC53nZ9t55CAMH1hIDG81Gk3uQA@postini.com; Mon, 03 May 2010 01:59:22 PDT
Received: by fg-out-1718.google.com with SMTP id 16so554896fgg.10
        for <git@vger.kernel.org>; Mon, 03 May 2010 01:59:20 -0700 (PDT)
Received: by 10.87.69.8 with SMTP id w8mr9665751fgk.58.1272877160349;
        Mon, 03 May 2010 01:59:20 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 12sm7002351fgg.19.2010.05.03.01.59.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 01:59:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <y2m86ecb3c71005011028t7f581ce7t98256aa8f8bbb0bf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146223>

On 05/01/2010 07:28 PM, Dmitrijs Ledkovs wrote:
> On 1 May 2010 18:19, Junio C Hamano<gitster@pobox.com>  wrote:
>> Dmitrijs Ledkovs<dmitrij.ledkov@ubuntu.com>  writes:
>>
>>> On 1 May 2010 17:36, Andreas Schwab<schwab@linux-m68k.org>  wrote:
>>>> Giedrius Slavinskas<giedrius.slavinskas@gmail.com>  writes:
>>>>
>>>>> git fast-import does not support commits with more than one author. I
>>>>> try to import bzr repository and it crashes.
>>>>
>>>> You can find a patch here:
>>>> <http://bazaar.launchpad.net/~schwab-linux-m68k/bzr-fastimport/fastimport.dev/revision/262>
>>>>
>>>> Andreas.
>>>
>>> Although this is fine shouldn't we put the additional authors to the
>>> signed-off: lines in the git commit message?
>>
>> If an author didn't sign-off in the log message, a tool shouldn't add it
>> automatically.  Doing so makes S-o-b meaningless.
>>
> 
> Fair enough. I'm justing thinking on how to support round-tripping to
> bzr with import/export cause there are a few other properties bzr
> needs to recreate identical repository. Is it more appropriate for the
> marks format revision (bzr side of it)?

Add

Co-authored-by: Some One <some.one@example.foo>

and parse that when sending back to bzr. That way you get attribution
properly in both tools, in a way.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
