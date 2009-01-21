From: Jay Soffian <jaysoffian@gmail.com>
Subject: cherry-pick/rebase question
Date: Wed, 21 Jan 2009 12:27:34 -0500
Message-ID: <76718490901210927m7fd3fbdey6ebd4cbfe44b1b71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 18:29:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPgtP-00017w-3u
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 18:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857AbZAUR1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 12:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbZAUR1g
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 12:27:36 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:49410 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbZAUR1f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 12:27:35 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3702185rvb.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 09:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=KdEpYbkh2tsQnMiEqSWXyWLgDpRxAw7xS5B45TwEtQE=;
        b=gH6BTGfygy9jT67Wfl7VTHsthAocr2v5FdKSwfgt7solo1//Nudj2AYw0z4OPIUqqH
         2dclUQQgQQV1mc8NUracOsQ60agMtdhS0dFAHByiIWNJD65Jj+IAB3cZsV3WYzn0heyV
         d9biOmOzfFyJnOFolqBNTHR+yh3Szd0H4tZro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=YV2teW6fVbU/hL9FSvWJUTQhJ8vq9sPWwVB8JlswzVspGeVvfSPGCoDl2TJ+6pFAZR
         ILcDGZYKOK2LngwxJkgAxjQCBTuZWwIldH9fWLkTlYcEldxnwyq7iQBBnw/Ft5SLmy3M
         UN8OC2Ti86vDvWgiFZluwUEjSXkwH53Iqh8kg=
Received: by 10.141.178.8 with SMTP id f8mr2741552rvp.238.1232558854958; Wed, 
	21 Jan 2009 09:27:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106632>

Say I have the following linear set of commits on master:

A---B---C---D---E---F---G master

And I realize that I've intermixed two topics such that I want to move
commits B and E-G to their own branch. So my result should be:

A---C'---D' master
 \
  B'---E'---F'---G' topic

What's the best way to do it?

I read the rebase and cherry-pick man pages, found myself confused,
tried rebase a few different ways, failed, and ended up doing what I
needed with format-patch and am. (Extract B-G with format-patch, reset
master to A, create topic branch, apply B,E,F,G to topic with am,
similarly apply C,D to master with am.)

Thanks,

j.
