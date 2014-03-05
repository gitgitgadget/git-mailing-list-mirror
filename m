From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 27/27] count-objects: report unused files in $GIT_DIR/repos/...
Date: Wed, 5 Mar 2014 19:08:14 +0700
Message-ID: <CACsJy8AP7n8psnfWfASVgmQQTgW1qiLYr7SjV-cnPBgNsK+j+A@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com> <1393675983-3232-28-git-send-email-pclouds@gmail.com>
 <CAPig+cToTqJ4PPX3mvt0ftC-+Ncfiakz5dd_=xymM76T01z4fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 13:08:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLAd0-0004wO-5Z
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 13:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbaCEMIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 07:08:46 -0500
Received: from mail-qa0-f50.google.com ([209.85.216.50]:58871 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282AbaCEMIp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 07:08:45 -0500
Received: by mail-qa0-f50.google.com with SMTP id o15so876608qap.9
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 04:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sUVH4qzBpwX+6ONpiyA4QknqqgJRZAjj5hJzm+0+HaQ=;
        b=XnK91ffLXButEhDd1txHH+oAD2H927/C+pgKMlugv0s7prjoRCtA6SuqLnbo99n5jr
         7TyxWrvCqT+hGSIMKsPMuLZg4Ka9O3kMBLGTViZbyXwgiXNUo51UffIBuM+g/YKDjUBr
         DPd1MopsNHRg83ASj76Qqw9tPmIOG4GPN0omB8rJQWD7Fm1dtIS7v+uzKk6ifkZ05T2m
         /PXGwPCeprHSSqj2le/75qT83nj4Jp461bM3abeTIys9VUHLT0V8K9CiMB21uwVPDYyd
         NP+ZWw16PL1LFuzkhcktv3YwzjUaeqcSKhbMquRzfUCnWhqFXvxYXDEV7UBR0JU5dLqG
         MzAg==
X-Received: by 10.140.84.40 with SMTP id k37mr5792089qgd.98.1394021325021;
 Wed, 05 Mar 2014 04:08:45 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 5 Mar 2014 04:08:14 -0800 (PST)
In-Reply-To: <CAPig+cToTqJ4PPX3mvt0ftC-+Ncfiakz5dd_=xymM76T01z4fQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243434>

On Wed, Mar 5, 2014 at 11:25 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>  static void update_common_dir(struct strbuf *buf, int git_dir_len)
>>  {
>> +       /*
>> +        * Remember to report_linked_checkout_garbage()
>> +        * builtin/count-objects.c
>> +        */
>
> I couldn't figure out why this comment was telling me to remember to
> report "linked checkout garbage" until I realized that you omitted the
> word "update" (as in "remember to update"). It might be clearer to say
> something along these lines:
>
>     Keep synchronized with related list in
>     builtin/count-objects.c:report_linked_checkout_garbage().
>

I have a tendency to accidentally important words :)

> Is it not possible or just too much of a hassle to maintain this list
> in just one place, as in a header which is included by these two
> files? The exceptions, such as 'log' and 'gc.pid', could be marked by
> a special character in the entry ("!gc.pid", for example) or any such
> scheme.

It might work. Let me try.
-- 
Duy
