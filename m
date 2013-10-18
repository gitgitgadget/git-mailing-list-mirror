From: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
Subject: Re: [PATCH v6] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible.
Date: Fri, 18 Oct 2013 12:35:08 +0300
Message-ID: <21F30E1F-3497-41F2-81C4-F4193C58FE11@gmail.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com> <A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com> <660A536D-9993-4B81-B6FF-A113F9111570@gmail.com> <AFC93704-D6C5-49AF-9A66-C5EA81348FFA@gmail.com> <79A13931-694C-4DDC-BEDF-71A0DBA0ECA1@gmail.com> <89A4E8C6-C233-49E2-8141-837ABDBBC976@gmail.com> <xmqqmwm71ysp.fsf@gitster.dls.corp.google.com> <B690713F-6FF1-46A7-85A7-C92303BBAF0E@gmail.com> <xmqqzjq7wmj7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 8BIT
To: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 18 11:35:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VX6Sn-0004IN-Ct
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 11:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab3JRJfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 05:35:14 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62816 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab3JRJfM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Oct 2013 05:35:12 -0400
Received: by mail-lb0-f174.google.com with SMTP id w6so2890088lbh.33
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 02:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=+/nQxXE9b/h3AMll8F3dpI+VX8XQ4Ze5/NFPChYQjEc=;
        b=S1tmv63RAIoyBJbG32bFxbHaLxY4k+qmw7gWZv2FvMRfnPKCV69zWe3YXz3oK6b9+Y
         MJnuOOMMIfZnFISaALTIdZCG3BLyLHkiNNOaCCEcRjwa6Ca9N0v7ytyGkOZlxk0Q17uL
         g7/g4+98X1xZjUMrP+FwkwPTWWUfbMUq9DgD6i0ZSW5M3OzaNFyuCssA25Eyp6GgHZfo
         0JLwCUXuuUPdqqvBSV75SPeooIayrvjPwUNgHAJyl1DsuE1PJeJMuL+9FpSQvrU26i7Y
         3UsCuRQTgdsMNJC8irxCTKCHOT+V32ALJLaQNkZWjz3pbve1y8B/BubhYLfZI70HkBZ8
         WaTw==
X-Received: by 10.152.29.201 with SMTP id m9mr1762077lah.6.1382088910659;
        Fri, 18 Oct 2013 02:35:10 -0700 (PDT)
Received: from [10.128.134.109] (fsgw.f-secure.com. [193.110.108.33])
        by mx.google.com with ESMTPSA id vk8sm1292131lbb.0.2013.10.18.02.35.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 18 Oct 2013 02:35:09 -0700 (PDT)
In-Reply-To: <xmqqzjq7wmj7.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236340>

Hello Junio

>> In the "[PATCH v7]", I changed to keep filename part of suffix to handle
>> above case, but not always keep directory part because I feel totally
>> keeping all part of long suffix including directory name may cause output like:
>>    …{… => …}…ongPath1/LongPath2/nameOfTheFileThatWasMoved 
>> And, above may be worse than:
>>   ...{...ceDirectory => …ionDirectory}.../nameOfTheFileThatWasMoved
>> I think.
> 
> I am not sure if I agree.
> 
> Losing LongPath2 part may be more significant data loss than losing
> a single bit that says the change is a rename, as the latter may not
> quite tell us what these two directories were anyway.
I'm not sure which is the better in general.
But anyway, I don't have strong opinion about this.
So, I just changed to keep the all of the <sfx> part(lator than '}').
I just sent the updated patch as "[PATCH v8]".

Thanks !

---
Tsuneo Yoshioka (吉岡 恒夫)
yoshiokatsuneo@gmail.com




On Oct 18, 2013, at 1:38 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Yoshioka Tsuneo <yoshiokatsuneo@gmail.com> writes:
> 
>> In the "[PATCH v7]", I changed to keep filename part of suffix to handle
>> above case, but not always keep directory part because I feel totally
>> keeping all part of long suffix including directory name may cause output like:
>>    …{… => …}…ongPath1/LongPath2/nameOfTheFileThatWasMoved 
>> And, above may be worse than:
>>   ...{...ceDirectory => …ionDirectory}.../nameOfTheFileThatWasMoved
>> I think.
> 
> I am not sure if I agree.
> 
> Losing LongPath2 part may be more significant data loss than losing
> a single bit that says the change is a rename, as the latter may not
> quite tell us what these two directories were anyway.
