From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/3] merge-recursive: Small code cleanup
Date: Mon, 6 Sep 2010 15:25:17 -0600
Message-ID: <AANLkTiky3JL6rpo2x79dqQKKndUMa58Se_4CLpSFdj4+@mail.gmail.com>
References: <AANLkTimz8qSwefp137-D+vEbsf6soG51u0im9EC911_O@mail.gmail.com>
	<1283806070-22027-3-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, oinksocket@letterboxes.org,
	ken.schalk@intel.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 23:25:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsjBt-0001oS-1A
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 23:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386Ab0IFVZU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 17:25:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65284 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab0IFVZT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 17:25:19 -0400
Received: by fxm13 with SMTP id 13so2662569fxm.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 14:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=m0CEyP743T1I/mL12Ri0ipzUcgIArdRMzTtV2C1747g=;
        b=xnQLk3lr2o1U0uMPzI0N9VR8bkObkGSKPVU/lnV6x9eQULvWwQghtuowNCkweJBf5z
         xM8kF/tbJ+8YcexHKucT7LzFh9RyCvzdODyeFjl5y5i/XJt50P6lev9wPufHPYrM3kWk
         nhj9krTuzfcUzgoqyUMY1XJ4a9FSzVXgWCTWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hdVaY1ecaAt/9jpc2RSaE3Pe7ByM8FG60/uR6G7HOZgWJmRjwAgJaLLsddScD9glAQ
         kOENYot9yHCEOFD+QJT57C7ifzXvhL7kMnm8jIgbAtk5r9M4z/U2mrlramt3bwgxV50E
         9a4QIO2W9uCTGHo8nsCa9CwVXLk+Bx6Gj44bk=
Received: by 10.223.112.212 with SMTP id x20mr28679fap.89.1283808317805; Mon,
 06 Sep 2010 14:25:17 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Mon, 6 Sep 2010 14:25:17 -0700 (PDT)
In-Reply-To: <1283806070-22027-3-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155625>

On Mon, Sep 6, 2010 at 2:47 PM, Elijah Newren <newren@gmail.com> wrote:
> process_renames() had a variable named "stage" and derived variables
> src_other and dst_other whose purpose was not entirely clear to me. =C2=
=A0Make
> the name of stage slightly more descriptive and add a brief comment
> explaining what is occurring.
>
> Also, in d5af510 (RE: [PATCH] Avoid rename/add conflict when contents=
 are
> identical 2010-09-01), a separate if-block was added to provide a spe=
cial
> case for the rename/add conflict case that can be resolved (namely wh=
en
> the contents on the destination side are identical). =C2=A0However, a=
s a
> separate if block, it's not immediately obvious that its code is rela=
ted to
> the subsequent code checking for a rename/add conflict. =C2=A0We can =
combine and
> simplify the check slightly.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

Hmmm...should I have split this off from the rest of the series (its
only relation is that it cleans up code that made it harder for me to
find the real fix)?  If I did that, I could rebase the rest of the
series on maint...
