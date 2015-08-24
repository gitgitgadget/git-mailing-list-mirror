From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v13 11/12] tag.c: implement '--format' option
Date: Mon, 24 Aug 2015 20:37:45 +0530
Message-ID: <CAOLa=ZR4LJSou5QqmZJm1M49tD74t4Besb64F+XOHefjnxo7xw@mail.gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
 <1440214788-1309-12-git-send-email-Karthik.188@gmail.com> <vpq37z9lqwp.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 24 17:08:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTtMN-0007Bo-QL
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 17:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567AbbHXPIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 11:08:16 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36314 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbbHXPIP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 11:08:15 -0400
Received: by oiev193 with SMTP id v193so81995072oie.3
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 08:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TLaj2DpsyczMMw09yb9Hy0TCcfchCZX79G6Bmin5Xp4=;
        b=fe6JVuMOCbvWzqNYqziid7PYiXdFTwhkPdC9mCHwaVDP4DcY6SUkwo4+7GODGqm2DH
         NSpiBzzrnSbrMMWnCB/PsfboErNBBzOnA9BjaweZ7uleoLkpELTyk7fSfN4/5lDsawfF
         oJ4xHEvkzVDOZDMxt3UzlX50nNJl6rH7OoU32iTiVGo6WK3VUaETSzFrmbdBiMTYICyO
         98RPwmjk6vk1p2ZSBPMYJa1ecefrCSpZP1eImwzHSwDgtm0/UlsHgszIJ9ApImiFfsvR
         WWR7nLRvkr9TqviflvZh3bCKJk/Emoug37+SEflUdDBZ5+WHbDqDphxoPVUU1Fo2iLPb
         KXPQ==
X-Received: by 10.202.221.4 with SMTP id u4mr2515551oig.104.1440428894725;
 Mon, 24 Aug 2015 08:08:14 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 24 Aug 2015 08:07:45 -0700 (PDT)
In-Reply-To: <vpq37z9lqwp.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276450>

On Mon, Aug 24, 2015 at 1:26 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> --- a/Documentation/git-tag.txt
>> +++ b/Documentation/git-tag.txt
>> @@ -13,7 +13,8 @@ SYNOPSIS
>>       <tagname> [<commit> | <object>]
>>  'git tag' -d <tagname>...
>>  'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
>> -     [--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>] [<pattern>...]
>> +     [--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>]
>> +     [--format=<format>] [<pattern>...]
>>  'git tag' -v <tagname>...
>>
>>  DESCRIPTION
>> @@ -158,6 +159,11 @@ This option is only applicable when listing tags without annotation lines.
>>       The object that the new tag will refer to, usually a commit.
>>       Defaults to HEAD.
>>
>> +<format>::
>
> Shouldn't this be --format <format>, not just <format>? We usually use
> the named argument in the SYNOPSIS for positional arguments, but not for
> arguments following an option.
>

This is how it was in for-each-ref Documentation, hence to keep it similar I
just put <format>.

-- 
Regards,
Karthik Nayak
