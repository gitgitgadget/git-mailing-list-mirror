From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4: Handle p4 submit failure
Date: Fri, 30 Oct 2015 19:53:30 +0000
Message-ID: <5633CABA.1000003@diamand.org>
References: <CAJA=mv4Tr_DoBMwR8hK_fEJ1PFCYTu17HHvEnFWMANGFcf0Wpg@mail.gmail.com>	<xmqqeggcmhle.fsf@gitster.mtv.corp.google.com>	<CAJA=mv7ydNCm-yy9Ukk2XB-xvAJ1VkyqHEGcCTA2PEg=5y9cFQ@mail.gmail.com> <xmqqy4ekkzmg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Etienne Girard <etienne.g.girard@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:53:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsFk3-0005Sy-4B
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 20:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760469AbbJ3Txe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 15:53:34 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35661 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504AbbJ3Txe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 15:53:34 -0400
Received: by wmll128 with SMTP id l128so20290463wml.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=fYDVxHlFNIDJa0dM1qjSCLiX1Zqc2r3n/ZvfZOGvGr4=;
        b=N/YuL7Jyt5TkQ3XUE91Kqv0qrSEEkmbNWRowUsSIXjwCcSHYbDo13sc3Hlw/ZH9loF
         ZXZLjgcBZPuuM02PztBQdHp+JW9CLI0Dm2BCiCFC1leV9bQfZ73FCt1vQarPVlkXOpEj
         MyIDei4zZVa0LtfrdGyNVv1eXIgKFq4IRCMm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=fYDVxHlFNIDJa0dM1qjSCLiX1Zqc2r3n/ZvfZOGvGr4=;
        b=cKTC+pwigqnlIDQn5C4eJFF4FcYn15XDOFiG4zsfS9k0wJ2ULqOm+0DD+CRqxCTOL5
         skebx+4I7UW1+c3JW7zwqn1vfyOQI3CCo1DGqUrm/ef5VgyRAGJtWR1BvC/b+h5l0sA7
         jzyvFP3QZrf3JQRTlB5CF39Zpzgt2nmfIT6fAFxROu+NFn16msOfWsXKzNYQYTQAUJHo
         +4rM0JoSq7yHrzFYy9W6HhmbTahbC5isE4rtdAdfYTWC488Pg1K7cYkcMsMAWEICeBYn
         7ND3Nuxt8AWpqFfUR2ExFL8LVN0IuQ1hklqL3uRKAWMv5upsL2K6c9P1Jm2s1F5e0unw
         fJVA==
X-Gm-Message-State: ALoCoQngr0b2sVjwe55oE7rA68cU+KjoGhjPYGPD8r6z1TV31gz7W27yBChHjuWstfKD9krvdKhU
X-Received: by 10.28.137.194 with SMTP id l185mr5754wmd.21.1446234812771;
        Fri, 30 Oct 2015 12:53:32 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id e189sm4447665wma.4.2015.10.30.12.53.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Oct 2015 12:53:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqy4ekkzmg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280535>

On 30/10/15 17:57, Junio C Hamano wrote:
> Etienne Girard <etienne.g.girard@gmail.com> writes:
>
>> Yes, however if `p4 submit` fails the corresponding "Command failed"
>> error message is displayed, and the p4 error message itself is
>> displayed if any.
>> Tthe script will also terminate successfully if self.edit_template
>> returns false but it will exit with error code 1 if p4 submit fails.
>>
>> So the user will get "Command failed: [...]" followed by "Submission
>> cancelled, undoing p4 changes", to let him know that the script failed
>> because of p4 and that nothing was submitted.
>
> OK, then it sounds like all I have to do is to update the log
> message with the "How about this" version and correct the authorship
> to use your murex address, and then wait for reviews from real "git
> p4" reviewers.
>

Looks good to me. Nice use of try...finally.

One very small thing - test t9807-git-p4-submit.sh is now failing with 
this change.

That's because it tries to delete one of the files it created, but you 
are now deleting it already! Could you just update that please?

Thanks!
Luke
