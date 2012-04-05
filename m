From: Corey F <coyotebush22@gmail.com>
Subject: Re: GSoC git-add--interactive improvements
Date: Wed, 04 Apr 2012 22:46:01 -0700
Message-ID: <4F7D3199.5040401@gmail.com>
References: <4F7BC8FE.4060808@gmail.com> <CAP8UFD0V17Gag3esFd=ZDocZZoiN_4a1bjQ8rFwbBZoJEiasBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 07:46:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFfWU-000265-DP
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 07:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284Ab2DEFqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 01:46:07 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42638 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab2DEFqF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 01:46:05 -0400
Received: by obbtb18 with SMTP id tb18so1335024obb.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 22:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=zuHJQPTbJTMNlyIu3PmUELxslnMplY1z8wNT/NoWiSc=;
        b=A2B1VF1jjAaGx65lvCb273C/fhvEGn3bHTqeWCHjQqZgINqZSompXSYaksy/4HNAjB
         RP15ukdhskBR+eycd03aHnbA7KiU4ik9ujc4gSOpnpc8/RR+6IdkF9nNrYbKC8FlFpFI
         sL9+ln2WNc2M+8iMEiOoyza8977cENScsPjIDBh22uE7rwbSJ6/QE3+6C0lbYrYuKjDN
         HwiuBxIMhBIbs/CcTR6WPGdyTpzO9/7oP8Q3Lc94b1ai9uUkcylvW82YDLGe3SDSXYss
         d+d493MIs3G+ACqFqR0vio+KQJbLxBJbFcwsHZesiYtDMQDFIF2bL3lZvJA/RB/d2JxG
         9G4g==
Received: by 10.60.28.33 with SMTP id y1mr1562729oeg.62.1333604764842;
        Wed, 04 Apr 2012 22:46:04 -0700 (PDT)
Received: from [198.188.150.160] (pcp037279pcs.cabrillo.reshall.calpoly.edu. [198.188.150.160])
        by mx.google.com with ESMTPS id b2sm3174490obo.22.2012.04.04.22.46.03
        (version=SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 22:46:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <CAP8UFD0V17Gag3esFd=ZDocZZoiN_4a1bjQ8rFwbBZoJEiasBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194759>

On 04/04/2012 01:26 AM, Christian Couder wrote:
> Hi,
>
> On Wed, Apr 4, 2012 at 6:07 AM, Corey F<coyotebush22@gmail.com>  wrote:
>> Last year's SoC ideas page included rewriting some commands in C, including
>> this one. I'm at least as comfortable with C as with Perl, but I'm guessing
>> that incorporating a rewrite into the project would be an ambitious and/or
>> dangerous idea.
> It depends how you plan to do it. In builtin/apply.c and perhaps
> elsewhere there is already some C code that is duplicated in
> git-add--interactive.perl.
> Maybe you can first make add--interactive use the C code by creating a
> helper command and then move more and more stuff from add--interactive
> to the helper command.
> Hopefully in the end the code in the helper could be used to add an
> interactive mode to git apply.

Okay, that sounds like an interesting way to approach it. The helper 
command would then constitute a slightly more generic patch-chooser 
interface, and most of the suggested architectural changes would be 
broadly applicable.

Then again, perhaps it would be better to instead, as a sub-project, 
make git-add--interactive.perl work for apply in addition to 
add,commit,stash,reset. That would let me still primarily focus on 
restructuring the Perl code.

I think the first few suggested design improvements, in particular, will 
be valuable changes. (I often find myself wanting even more granular 
control over what exact characters get staged; that may be another 
improvement I'll aim for.)

I'll think about these some more and hope to put together a GSoC 
application. Thanks for your insights.

Corey
