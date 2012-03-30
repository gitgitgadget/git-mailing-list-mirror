From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH] run-command: treat inaccessible directories as ENOENT
Date: Fri, 30 Mar 2012 22:22:39 +0200
Message-ID: <op.wbz2v2k60aolir@keputer>
References: <20120330075217.GA8384@sigill.intra.peff.net>
 <CAH6sp9N=JsWp7iQ=AAdXHe0J+aB5L9cBq2_0BJgUO=Y-vgAbNg@mail.gmail.com>
 <7vmx6ym54m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org,
	"James Pickens" <jepicken@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 22:22:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDiLS-00076F-H5
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 22:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760102Ab2C3UWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 16:22:46 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39206 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759210Ab2C3UWo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 16:22:44 -0400
Received: by eekc41 with SMTP id c41so328465eek.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 13:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=+XYoTDajxGG7TXGVPcw/ROizxwkP74XDWwkC+XcjtIc=;
        b=jXeNW1A4sWc16fmnArwoCNHvOwG2GkRVPnouWEKrOr8dd/5dIfDNqeYcAw2pbharMN
         CDkH4HO/5T/qBktuLQSbbg4CP85PRgaCL3niqWG/yk8nGeAAoSBZVl2L7jSt2XOc/Eq9
         Rfvol9G7vU9t8GLUuL25auOnWOBj0tA+q+HKW2iunaevt/CfZ+MrmOtCnull7TDPlimU
         MmCOZgcNUSgoVQey3hdF6m+DWnaUqXsAg5I/t9noTalII310WhOWBtUwCRXYr87/AMhm
         oJov2NxJIHJFURRzo6ipo0mAbaZfvsgfpvvmcjuWUUXBRAye35sw4z0cz3ZsMd/8XGFP
         m2Fg==
Received: by 10.14.94.133 with SMTP id n5mr887896eef.21.1333138963487;
        Fri, 30 Mar 2012 13:22:43 -0700 (PDT)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id r44sm36352598eef.2.2012.03.30.13.22.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 13:22:42 -0700 (PDT)
In-Reply-To: <7vmx6ym54m.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194399>

On Fri, 30 Mar 2012 18:21:29 +0200, Junio C Hamano <gitster@pobox.com>  
wrote:

> Frans Klaver <fransklaver@gmail.com> writes:
>
>> isn't it rather more sensible from a unit-test perspective to see
>> if start_command returns 127 instead of 128 in this specific case?
>
>
> You are welcome to add another test that checks lower level  
> implementation
> detail, but this specific test is to make sure the gripe "Why does git
> deny my aliases when I have inaccessible directory on my PATH?" will  
> never
> come back.

I think I didn't word carefully enough there. I didn't mean to dispute the  
use of the test. The test I proposed would make sense in t0061, but I  
would rather have expected the test in Jeff's patch in a tests that  
specifically targets aliases. It would be less surprising, wouldn't it?  
The fact that git goes through start_command before doing aliases is  
merely an implementation detail, from my point of view.
