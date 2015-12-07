From: Alex Jones <ajones@netsertive.com>
Subject: Re: git branch in Bash subshell "$(git branch -a)" including ls
 output as part of return?
Date: Mon, 7 Dec 2015 12:57:30 -0500
Message-ID: <CAJGk2Wx9cng8+9f0PxX1WFiGPLnoufMKgN8x0HWP-L0Xj8Nr-Q@mail.gmail.com>
References: <CAJGk2Wx4B=AHFxkJep=yYVKU9UyJieazoNaC44W5yBXoMi+gdg@mail.gmail.com>
	<20151207165810.GA25856@hashpling.org>
	<20151207170259.GA25915@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Dec 07 18:57:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a602a-0005Pg-Hg
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 18:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008AbbLGR5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 12:57:32 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36415 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbbLGR5b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 12:57:31 -0500
Received: by igcph11 with SMTP id ph11so79191347igc.1
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 09:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netsertive.com; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IGAKbS0QH6tGVxPOA96yOM4t9wMhiL3dWhFz3U4cRDc=;
        b=W872xtv1AaR+XJ7IluNyoEDvSYtZSi6XuXSbQMDId9YxJvo/eXoNlKhD7SbKiAhmKD
         EmY4RO6snwtMQ+03bEzFhnGrCnFuxfCfpTM6Twr4DnsO1QbI44PPFwxKltFJrzomkjvI
         IbWQ50H5spys5zUnL7FPyEmoes1e5jYkZ66Vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=IGAKbS0QH6tGVxPOA96yOM4t9wMhiL3dWhFz3U4cRDc=;
        b=TrRQrKgYlNS9EdKZtlaEVJlVF5wS4tGtWwHcotE0tL3PA6Y824+w28vX33DVi21T8W
         0+QUOIIQmCYTm7a0lpmpbtkroGPqgXQazXzWNQ6HRqwyABVyEpG12GjCxpBNHYlHcx7R
         tmIjaprxQRmzTxXZ9YY1yFY7d1+Nl/WQOifoNtVM1rZk7QPqc9qDynAW0IjLtzfcHIDm
         EYk0YfbkyPowgEiOmymS6W+MIH1DlLV9FmKFJhab3ax1Qkl8Juc7txE+tL71yyE8Y+3W
         m3pzjkWQViOAtwkU9rXqMyCR0proYSe1jN5IHxh7W6azlrnHaJTTVSOitYgWNjV13S9m
         C/kg==
X-Gm-Message-State: ALoCoQlmfLp8yhYfaf161KlA3iMURW+JagX7J2KnjC5PEEvVeXz1YMzGjnNu25ufv8swBkeflTNp
X-Received: by 10.50.134.230 with SMTP id pn6mr18179523igb.90.1449511050789;
 Mon, 07 Dec 2015 09:57:30 -0800 (PST)
Received: by 10.107.168.161 with HTTP; Mon, 7 Dec 2015 09:57:30 -0800 (PST)
In-Reply-To: <20151207170259.GA25915@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282101>

That did the trick, thanks for the help and the suggestion.

On Mon, Dec 7, 2015 at 12:02 PM, Charles Bailey <charles@hashpling.org> wrote:
> On Mon, Dec 07, 2015 at 04:58:10PM +0000, Charles Bailey wrote:
>>
>> Looking at the two outputs, you are seeing the shell's glob expansion of
>> the '*' current branch marker. You probably want to quote the command
>> expansion to prevent this:
>>
>> echo "$(git branch -a)"
>
> Pressing send has, of course, caused me to think further. You probably
> don't want to parse the output of a "porcelain" command such as "git
> branch" at all, but instead look at using something like "git
> for-each-ref", perhaps with the --format=%(refname) option, grepping out
> master and iterating through the rest.



-- 

Alex Jones | Software Engineer
919-238-4404 direct
336-263-2099 mobile
netsertive.com
