From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v3] for-each-ref: `:short` format for `refname`
Date: Wed, 3 Sep 2008 18:56:58 +0200
Message-ID: <36ca99e90809030956r5ab94a14he088265e28ea9b14@mail.gmail.com>
References: <36ca99e90809030133r43fc5a3agad1aa38339a758a3@mail.gmail.com>
	 <1220431352-30605-1-git-send-email-bert.wesarg@googlemail.com>
	 <20080903151829.GB27682@spearce.org>
	 <36ca99e90809030933m15ef9cf5p1a56bfe90071fc10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	szeder@ira.uka.de
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 18:58:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KavgI-0008G4-7D
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 18:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbYICQ5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 12:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbYICQ5D
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 12:57:03 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:45031 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbYICQ5B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 12:57:01 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1669677yxm.1
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 09:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0f0zVBM4N7KGT7XglS2O0bomID5xfvU3fsoIVPiB378=;
        b=ALLMdz2bx6jigNouSNg2JUflZ8ChviiNGFhuiq1V6Ok0mN+YP5y+4sSTAtvX0aRDlh
         f2UBt0YcneOOn2ZHmwj+K7yyIknbZfD8Uz0C10Nq8M1Flb2SzDZ01aJ/WPIdJ0qFk+E9
         9he2+OacqJxyDsydy2Y2IxCuvh+W7qaFbbxGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MWROTXpoRZKR5MfeEcq2nszgb8mwrG5IDmczZzLHCeJJIHw1uESZ5cuMFdw5+0qC4B
         n6UzDZJlN6sOTL7DtO1QbnhjY5J3Lxo7os0ptCPVa9Cm60eHrhLWhoJ4bUL8YH+jGFIK
         tqYu51gzTEgqy4ek9GW+2v8ZhcJ0XNncXxMw4=
Received: by 10.114.177.1 with SMTP id z1mr7743647wae.226.1220461018992;
        Wed, 03 Sep 2008 09:56:58 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Wed, 3 Sep 2008 09:56:58 -0700 (PDT)
In-Reply-To: <36ca99e90809030933m15ef9cf5p1a56bfe90071fc10@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94815>

On Wed, Sep 3, 2008 at 18:33, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> On Wed, Sep 3, 2008 at 17:18, Shawn O. Pearce <spearce@spearce.org> wrote:
>> Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>>> Try to shorten the refname to a non-ambiguous name.
>>>
>>> Changes in v3:
>>>  * don't compare sha1's, its ambiguous if the short name
>>>    resovles to more than one ref
>>>  * use xstrdup()
>>>  * use indexes for the loops to clarify backward/forward
>>>    direction
>>>
>>>
>>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>> Cc: git@vger.kernel.org
>>> Cc: szeder@ira.uka.de
>>> Cc: Shawn O. Pearce <spearce@spearce.org>
>>> ---
>>
>> Looks good.  But the commit messages shouldn't have the "Changes
>> in v3" section or probably the "Cc:" lines.  The changes in v3
>> part usually goes below the ---.
> Ok, but shouldn't git format-patch detect that there is already a ---
> in the commit message, or is it illegal to have more than one ---?
>
> And while we are at it, shouldn't git format-patch detect, that there
> is already a [*PATCH*]-prefix in the first line of the commit?
Ok, I was too fast, -k is obviously the right option for this.

>
> I always need to edit these two things after format-patch.
>
> Bert
>>
>> --
>> Shawn.
>>
>
