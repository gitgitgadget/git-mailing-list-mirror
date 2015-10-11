From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 04/10] ref-filter: modify "%(objectname:short)" to take length
Date: Sun, 11 Oct 2015 23:14:56 +0530
Message-ID: <CAOLa=ZSQMtW8Kd-B7u=9nJ0d3AtN7f1mtz0k0dS9WKmWSv5CNQ@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
 <1444295885-1657-5-git-send-email-Karthik.188@gmail.com> <vpqh9m1mbln.fsf@grenoble-inp.fr>
 <CAOLa=ZT8YydU-4HH2migNewtiAvB=wOCWx2TGV+Y+8YVHCdaNQ@mail.gmail.com> <vpqlhb92xx9.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 11 19:45:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlKgd-0004y9-5R
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 19:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbbJKRp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 13:45:27 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34198 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbbJKRp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 13:45:26 -0400
Received: by vkat63 with SMTP id t63so75875140vka.1
        for <git@vger.kernel.org>; Sun, 11 Oct 2015 10:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HsQmGfhrgY0YUDBlH2pg3qxJxjSe8TG3By0g59ot8LQ=;
        b=LEID9R31G6ui/FfLe+BxgHTgNEhbKNWwWd9cXLAHKabz7vSfC1BWg+XqgrYRtEQRT7
         JJ/HPMPRlrG5GUMoL4NIFHNsFaYU4bBiEb5rh+YhDVLVf9/wWZOKqE9Cg6NwqGdCTs7d
         LWcwXege9pWk7lDypoXTWECQqMcRLXUS+kyPwgHk6yoVFDf8dHE09aWVhQnAnFUX2hDF
         xvJNFoNU3z007tC293tOvZckpPo441oKOypzrbvLnHhxpf9PmPDWzfleySHeS/7Wbpv0
         9t+dRRciLT5w8kvRwIeeg3H28DhXL+JN/DE1AygW68DNGVRbXt0coPGHfEDD5r2hEFoA
         SsDg==
X-Received: by 10.31.50.214 with SMTP id y205mr15894410vky.77.1444585525714;
 Sun, 11 Oct 2015 10:45:25 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sun, 11 Oct 2015 10:44:56 -0700 (PDT)
In-Reply-To: <vpqlhb92xx9.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279345>

On Sun, Oct 11, 2015 at 9:35 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>>> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
>>>> index 7c9bec7..6fc569e 100755
>>>> --- a/t/t6300-for-each-ref.sh
>>>> +++ b/t/t6300-for-each-ref.sh
>>>> @@ -385,6 +385,28 @@ test_expect_success 'Check short objectname format' '
>>>>       test_cmp expected actual
>>>>  '
>>>>
>>>> +cat >expected <<EOF
>>>> +$(git rev-parse --short=1 HEAD)
>>>> +EOF
>>>
>>> Please write all code within test_expect_success including this
>>> (t/README:
>>>
>>>  - Put all code inside test_expect_success and other assertions.
>>>
>>>    Even code that isn't a test per se, but merely some setup code
>>>    should be inside a test assertion.
>>> ).
>>>
>>
>> Was just following the previous syntax, should have read that. fixed it
>
> The common practice (not necessarily a rule, though) when you write code
> next to other code that does not follow the style is:
>
> * If it's not too disturbing, adopt the new style and keep the old code
>   as-is. I think we are in this case.
>
> * If the new and the old style do not mix well, prepend a "modernize
>   style" patch to the series, and adopt the new style in the patch
>   itself.
>
> * If you're too lazy to do a "modernize style", adopt the old style for
>   consistency.
>

Ah thanks, Makes sense :)

-- 
Regards,
Karthik Nayak
