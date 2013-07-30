From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Flatten history
Date: Mon, 29 Jul 2013 21:05:15 -0700
Message-ID: <CAE1pOi0LKy8hsjAEsFPPN+9mJRDoEE0a3sMv7gpnW8V95_W9sA@mail.gmail.com>
References: <CAE1pOi0CQ1k3h3ie=s3qvkQog9foYBOnJ++uuum-Br7vzQHRSQ@mail.gmail.com>
 <CAMP44s2pXSN2HbpGLW9jrgJAypbLM3JtgD+nyK7LkNdvH4nsfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 06:05:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V41Bs-0004qI-Qz
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 06:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783Ab3G3EFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 00:05:37 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:62130 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418Ab3G3EFg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 00:05:36 -0400
Received: by mail-vc0-f182.google.com with SMTP id hf12so2719946vcb.13
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 21:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VzpmkDBGotYdChc8ecniEPMZ1IWCJdvBz1GHknEdTSE=;
        b=IDXVdRHiDWGWTnDsNUyOW5jFhhT3WpNtGdz2fkIckmtDKdPzluFk+7lDZKVKYqIbXo
         fhKwEZ2lS8H2b66A4d6UaDOR+7GIbODPOGf+nF9WlKkAXvNvbUmWBQ5uoEsdMBNU4+DD
         GX+LPTA75GcwVluEmAAoxeIV1bBnlR5mt8nH1wtCVRat1fEcUPITyHqrbzNKPaU0gHTV
         FpiId+1gIFvM2upfaWMG6h6hBqxPkW//BRjVSMilun9YpxTc2G6o+DuJH4fDkCWkOwKY
         s2JDbzfGh+M+6hOcPRZFW354dWOLV54BrzNmFck5FmBQgJejs3XaDfLroCFqrHjnQ0IC
         U1Yw==
X-Received: by 10.58.49.130 with SMTP id u2mr27035256ven.7.1375157135863; Mon,
 29 Jul 2013 21:05:35 -0700 (PDT)
Received: by 10.58.229.106 with HTTP; Mon, 29 Jul 2013 21:05:15 -0700 (PDT)
In-Reply-To: <CAMP44s2pXSN2HbpGLW9jrgJAypbLM3JtgD+nyK7LkNdvH4nsfQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231348>

On 29 July 2013 20:50, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> On Mon, Jul 29, 2013 at 8:42 PM, Hilco Wijbenga
> <hilco.wijbenga@gmail.com> wrote:
>> Hi all,
>>
>> I have a (public) "feature" branch that has been kept up-to-date with
>> "master" by regularly merging master back into it. I would now like to
>> get all the changes from feature but not any of the commits.
>> Basically, I want to replay all of feature's commits without creating
>> those commits.
>>
>> I thought something like
>>
>> git cherry-pick -n abcd^..feature
>>
>> should do the trick (while on master, where abcd is the SHA-1 of the
>> commit where feature was created) but I get conflicts.
>>
>> First, why the conflicts? I have done all the merges so cherry-pick
>> should simply be able to replay them? Second, what is the correct way
>> of doing this?
>
> Perhaps
>
> % git cherry-pick -n --no-merges --right-only --topo-order
> --cherry-pick abcd^..feature

Thank you for the suggestion but this still gives me conflicts.
