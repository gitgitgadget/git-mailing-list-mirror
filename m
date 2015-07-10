From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 05/10] ref-filter: add option to match literal pattern
Date: Fri, 10 Jul 2015 16:41:52 +0530
Message-ID: <CAOLa=ZTr=C49K4d_zdD56mGoiiKKO_M35cagvTfCz06paxh=ew@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <1436437671-25600-5-git-send-email-karthik.188@gmail.com>
 <vpq8uap78xu.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 10 13:12:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDWEF-0005qG-GO
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 13:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbbGJLMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 07:12:24 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33707 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbbGJLMW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 07:12:22 -0400
Received: by obbgp5 with SMTP id gp5so76968412obb.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 04:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=68W+gbiHpN+oLKs9h2N4gVeuJuGWis5VxmiPs0dxcXQ=;
        b=tX9K25N0858p59MXCqYVvGG63sG+jO+1Swps2xIhWtSChHOKiBf6jUK2yQVWC62t0C
         Lqygy2BpPLKz9J2f1SUW5oqCecG/nSnd181w41m7kKn3KixtFc3XL/yNcJy27foZzw/i
         CtvyT71GVdryyLb2qbwdsvNBfnDU/4Ti5oOJon7H3Ho+niVFpC8KXk/BbuFoQYNfWso4
         uKkr7m8SWPQrrFelC31xXGLH+uQpkkToBnJYy5ToQn8QBi7vOU3uUAg7p0uH/VfXPADb
         J2bKrIgO165y8F1oTqEAy937eQLNL/z6iSG47qJOjhacPOrChlpMHGJhdpBMuBgIJz7z
         TawA==
X-Received: by 10.202.73.198 with SMTP id w189mr18076097oia.102.1436526742049;
 Fri, 10 Jul 2015 04:12:22 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Fri, 10 Jul 2015 04:11:52 -0700 (PDT)
In-Reply-To: <vpq8uap78xu.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273816>

On Thu, Jul 9, 2015 at 7:02 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Since 'ref-filter' only has an option to match path names
>> add an option for regular pattern matching.
>
> Here also, a hint on why this is needed would be welcome.
>

Will add.

>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -956,6 +956,20 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
>>
>>  /*
>>   * Return 1 if the refname matches one of the patterns, otherwise 0.
>> + * A pattern can be a literal prefix (e.g. a refname "refs/heads/master"
>> + * matches a pattern "refs/heads/m") or a wildcard (e.g. the same ref
>> + * matches "refs/heads/m*",too).
>
> Missing space after , (same in the hunk context below)
>

Noted. Thanks :)

-- 
Regards,
Karthik Nayak
