From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] t: branch: improve test rollback
Date: Thu, 31 Oct 2013 12:39:29 -0600
Message-ID: <CAMP44s01ABhU1tsqR+VKH6q6L+MNTDxHEgwfsCboxhP-euSmdA@mail.gmail.com>
References: <1383211631-9244-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq1u3170l1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:39:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbx9c-00006M-AQ
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421Ab3JaSjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:39:32 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:61238 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728Ab3JaSja (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 14:39:30 -0400
Received: by mail-lb0-f179.google.com with SMTP id w6so2695900lbh.38
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 11:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Pxsqbqv8XOKMfMo9EkdVCMAF+4zGECrkWf/XHHWiEqg=;
        b=rfMg82YmbbTbaA/5i2xNQelplHldLbme46Y8KuFytk6643Z2343LijNuDjFyZOE3n1
         0+MdC99feomwyG6mVMbiEp/2IpHemIUp1SZ1yMu8Q63xDr6D1QWy9w5aqzaR1rMIh3jy
         qP+xxn5GXwNlARSZw3LQtiudoQjs2ieK+Ktb1noq5b0Ty7if1W1s9P2sMx37Mzf2Z87G
         +tUy0IHXs5wnITVXFwMMkJEWRl51MvFYNz4UCAgYIsXCQO4gLHoRVVHUQsalZ5Pcx0Kz
         Q9E/rQpGr6NRyW5BYu4MnfW2/ggcZJPUDkBq27s9SyNSpkdMuvJ+o+lwoY1UPW50RpxA
         7/uQ==
X-Received: by 10.112.52.225 with SMTP id w1mr3137141lbo.31.1383244769261;
 Thu, 31 Oct 2013 11:39:29 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Thu, 31 Oct 2013 11:39:29 -0700 (PDT)
In-Reply-To: <xmqq1u3170l1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237151>

On Thu, Oct 31, 2013 at 12:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>> index 0fe7647..33673e0 100755
>> --- a/t/t3200-branch.sh
>> +++ b/t/t3200-branch.sh
>> @@ -329,7 +329,7 @@ test_expect_success 'tracking setup fails on non-matching refspec' '
>>  '
>>
>>  test_expect_success 'test tracking setup via config' '
>> -     git config branch.autosetupmerge true &&
>> +     test_config branch.autosetupmerge true &&
>>       git config remote.local.url . &&
>>       git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
>
> And "remote.local.*" setting does not follow that "pristine"
> principle, making the result of applying this patch inconsistent.
> Is that desirable?

This patch is *improving* test rollback, it's not making it perfect.

Let not the perfect be the enemy of the good.

-- 
Felipe Contreras
