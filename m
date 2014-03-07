From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Microproject idea: new OPT_* macros for PARSE_OPT_NONEG
Date: Fri, 7 Mar 2014 14:54:12 +0700
Message-ID: <CACsJy8AUhHE8=Yaj6_G46V6w5ZbA3z403GkBfsbZL7MxgeA3RQ@mail.gmail.com>
References: <CACsJy8CBVVJN3V8N_djLF4XKfTbxvdcJCnWmZJxVZOwy8AMQWA@mail.gmail.com>
 <531977AF.4060907@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 07 08:54:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLpcG-0007Ns-Ap
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 08:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbaCGHyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 02:54:44 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:53721 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaCGHyn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 02:54:43 -0500
Received: by mail-qa0-f53.google.com with SMTP id w8so3713400qac.12
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 23:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=50E00mfhVmp2moND67pCFEqGnzX2vLWoSPsER+PzO8s=;
        b=J3SJpfc9/MDMSwhbOEqLeotKSSKic73XHCyg4gMkSEkpAVVlSSja2BjcL7+AS/jStc
         XPMtArGc/JdrPp6bZ/WEAKZeW2I73/lisGd0rWnUZU66NwjRqgbjXkwGu6DaQWCSxyxE
         JPzQFze+cLk/v25t6h9XTTz/vyEuqunJktaATKz+dBgdZJlElpmr5TsxGRIG0r2jrNqH
         nkqoIUNRbprnPn0rYT8NhE0JhhRwuAfPrbv/6mQEfXsmzAxn6u8gTK5OThdv+QtzLZVQ
         qnhc+HVdWhMerlCMb8szJhH6fXrUL3O206UbqInJhZUPDBdN8qhZtefNFlznwtBJiX6a
         ruXA==
X-Received: by 10.140.80.53 with SMTP id b50mr18656406qgd.43.1394178883060;
 Thu, 06 Mar 2014 23:54:43 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 6 Mar 2014 23:54:12 -0800 (PST)
In-Reply-To: <531977AF.4060907@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243606>

On Fri, Mar 7, 2014 at 2:39 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 03/07/2014 02:38 AM, Duy Nguyen wrote:
>> Currently in order to avoid --[no]-xxx form we have to resort to
>> declare full struct option. It'd be nice to have a set of OPT_* macros
>> with PARSE_OPT_NONEG set. Find and update all "struct option []"
>> declarations with the new macros (including ones that should never
>> accept --no- form, but do anyway).
>
> I added this to the list, with the following warning:
>
>     This is more a milliproject than a microproject
>
> because to me it feels considerably more involved than the other
> microprojects.  To  complete it, the student will have to understand at
> least part of the parse_options() API, which is more than a 15 minute
> job by itself.

I don't know the scope of these microprojects, but yes I think it'll
take a few hours for this. By the way, a bit more thought on the idea:
instead of making OPT_BOOL_NONEG() that sets NONEG, we could make
OPT_BOOL_FLAGS(..., NONEG), which is more flexible.
-- 
Duy
