From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [RFC 5/5] Date Mode: Tests
Date: Sat, 23 Apr 2011 05:06:02 +0000
Message-ID: <fdb4707e-125d-4e60-964e-b972386f0e85-mfwitten@gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
            <bbf61df6-b7fa-429e-866e-899354953cbd-mfwitten@gmail.com>
            <7vd3kfusva.fsf@alter.siamese.dyndns.org>
            <f1ad6d6f-44c8-442c-a335-d0b4113c48d7-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 07:08:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDV5E-0007fB-Gm
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 07:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288Ab1DWFIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 01:08:35 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49141 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab1DWFIe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 01:08:34 -0400
Received: by vws1 with SMTP id 1so801167vws.19
        for <git@vger.kernel.org>; Fri, 22 Apr 2011 22:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:cc:message-id:in-reply-to
         :references;
        bh=p8ex/fR4hD0fE7xCTLg5l7U7MJwqLcNkomtbLoPq7xQ=;
        b=eK2p9SMGv7ivJofXth82cJGlW65bvWcdZz59H8Ejrg8GBGUGn64urq5ZSJU3nM2iuI
         QtDCr8581+jNvlB7uDTrA+GDZ9xWI/mdOM6v9nDQ6oYobzv+xFXeTpcSW0gGQH7E6dt1
         q8t/7Vf0Ax/AuSQff869t/7D4V6USt1fA5EFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        b=L8HJ3tvOh/nkUHkIzHfHGJyf64KfY1Qshm27XxjQdVEbNbuD/iKgpTm001FrNq6roR
         +nCkwn4bvNT8gUFbD1VwT1mJJaMPOkmLOBsC6VCZn+v3GsEZPPYCQwHSbO5bDu9SSNll
         /epDrDJDJNXFQtxLNvhqdSTuOM7sD1A7zr3lw=
Received: by 10.52.64.169 with SMTP id p9mr2803413vds.181.1303535312962;
        Fri, 22 Apr 2011 22:08:32 -0700 (PDT)
Received: from gmail.com (saeed.torservers.net [68.68.27.157])
        by mx.google.com with ESMTPS id bc2sm657868vdb.11.2011.04.22.22.08.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Apr 2011 22:08:32 -0700 (PDT)
In-Reply-To: <f1ad6d6f-44c8-442c-a335-d0b4113c48d7-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171952>

On Sat, 23 Apr 2011 03:42:24 +0000

> On Thu, 21 Apr 2011 15:44:41 -0700, Junio C Hamano wrote:
>
>> I'd like to have part of the tests in this patch at the beginning of the
>> series to document and protect the behaviour of the current --date related
>> options, then your enhancement that adds --zone that lets the users
>> specify the timezone and the format independently, and finally the
>> remainder of this patch as an addition to the test script to document and
>> protect the interaction between the two options (e.g. what happens when
>> none or only one is specified? what happens when conflicting options such
>> as "--date=local --zone=gmt" is given?).
>
> I would split it up as requested, but I'm not sure that it's worthwhile;
> while there is a certain appeal to such a natural progression, my feeling
> is that the separate patches won't turn out to be usefully smaller (and
> thus more easily verified, as I'm sure you desire), because every data
> structure and code path deals with both simultaneously.

Maybe I spoke to soon; let me play around with it.

Still, though:

> Moreover, the beauty of your proposed progression is lost on the fact that
> these patches will be applied so close in time to each other; why bother
> dealing with solely date mode formats when such a version will almost
> certainly never be used?
>
> Thus, it seems cleaner just to introduce the whole set of tests in one go.
