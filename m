From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Wed, 22 May 2013 17:43:34 -0500
Message-ID: <CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 00:43:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfHl2-0000xA-Vr
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 00:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757899Ab3EVWni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 18:43:38 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:36022 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757892Ab3EVWng (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 18:43:36 -0400
Received: by mail-la0-f41.google.com with SMTP id ee20so2564536lab.28
        for <git@vger.kernel.org>; Wed, 22 May 2013 15:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fD9tXqQt3JDLkOs0e8iWeHCOslziZQllKx0VgZghwwg=;
        b=fLWnzugOUzCtiswGzFiwlluGkgTcn14Z9ONEMuGiWfPNoC4sFjzksYMQk7M4CVlG3+
         QZwcjvHHsKX+B4qUdDNXa9HIoxsepx6hejC/Uwewf79ealJoMeer26GuLePtubwdDkQE
         7OcZUJkKYLVbuJTd+WCjhbr/vewQSEjxw0OakYVnUZnNZrwNrk+NXqpu5VhqY+/B+JWB
         QjNTku7fGI/9N46R0oRi+j1fkOUsPCM2knSfGi4UfpST0rqTEceDvKodYCTPWGdaRtHG
         JLHr+lMKz1+F0eFkqNsGVCth/idwFxKCx2fo77KQUxjhaETbwz/oCfWkwXeBKa0SWZQb
         qUwA==
X-Received: by 10.112.142.8 with SMTP id rs8mr4366013lbb.8.1369262614408; Wed,
 22 May 2013 15:43:34 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Wed, 22 May 2013 15:43:34 -0700 (PDT)
In-Reply-To: <7vd2siiqsr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225201>

On Wed, May 22, 2013 at 5:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> Depending on the nature of the change in question, it may match well
>>> or worse to what you are trying to find out.  When you are trying to
>>> say "What were you smoking when you implemented this broken logic?",
>>> using -C may be good, but when your question is "Even though all the
>>> callers of this function live in that other file, somebody moved
>>> this function that used to be file static in that file to here and
>>> made it public. Why?", you do not want to use -C.
>>>
>>> I am reasonably sure that in the finished code later in the series
>>> it will become configurable, but a fallback default is better to be
>>> not so expensive one.
>>
>> The script's purpose is to find related commits, -CCC does that, does it not?
>
> As I already said in the above, the answer is no, when you are
> trying to find who moved the code from the original place.

But I'm not trying to find who moved the code, I'm trying to find
related commits; hence the name 'git related'.

The person who moved the code will be on the list regardless, so 'git
related' does find the person who moved the code indirectly; by
finding the persons that touched the code.

>>> Makes sense to start from the preimage so that you can find out who
>>> wrote the original block of lines your patch is removing.
>>>
>>> But then if source is /dev/null, wouldn't you be able to stop
>>> without running blame at all?  You know the patch is creating a new
>>> file at that point and there is nobody to point a finger at.
>>
>> A patch can touch multiple files.
>
> So?
>
> What line range would you be feeding "blame" with, for such a file
> creation event?

I thought it was skipping git blame in such cases, perhaps it got
dropped in one of the other countless versions of this script.

Good catch.

-- 
Felipe Contreras
