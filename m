From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCHv6] clone --single: limit the fetch refspec to fetched branch
Date: Wed, 19 Sep 2012 14:36:14 +0700
Message-ID: <CACsJy8AjCC2C2dGt+G0V1FZWVJg1f=QGetTJdB4-JVEs8f4DBw@mail.gmail.com>
References: <1347909706-22888-1-git-send-email-ralf.thielow@gmail.com> <1347995660-9956-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 09:36:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEEq6-0008WD-Hr
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 09:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880Ab2ISHgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 03:36:45 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38401 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694Ab2ISHgp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 03:36:45 -0400
Received: by iahk25 with SMTP id k25so553670iah.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 00:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FIKcRwP3TbzC9p7SCTrbKD/CnzlSAIh9EP4gjoUvjvg=;
        b=pXWWNZ+b8TSCCIBIEq3KPMX+iDq04qp+30dvFFtvac8caFcddaFpZRT98SxrmoZ1b2
         3AKyGAbwKNv1VE4FoZ7qdrHxQTcAC3oVok914OJvLSG86qIhg28AKr0kZ5qwrToNtxCe
         fVfba/yanJtKAGqzTS2/zMzVEhhFKPkrqmWfk1UpLcsgW2g4kh+SIVh7OZYKoZCrhzrN
         +VHxNfHRFNbP8G+4gAQDnqBE62cs6vat+44TkGoSsZyt2mJOmuKekO/aGFUEro0dLTma
         K0a9+RGetKwrjl2H7xlc5rZRCBKYYJJsCcoTXmuLczjiQEYUyHXAE9R8yMIrW60xvcjb
         0aqg==
Received: by 10.50.91.162 with SMTP id cf2mr1993666igb.40.1348040204398; Wed,
 19 Sep 2012 00:36:44 -0700 (PDT)
Received: by 10.64.167.139 with HTTP; Wed, 19 Sep 2012 00:36:14 -0700 (PDT)
In-Reply-To: <1347995660-9956-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205915>

On Wed, Sep 19, 2012 at 2:14 AM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
> +test_expect_success '--single-branch with explicit --branch tag' '
> +       (
> +               cd dir_tag && git fetch &&
> +               git for-each-ref refs/tags >../actual
> +       ) &&
> +       git for-each-ref refs/tags >expect &&
> +       test_cmp expect actual
> +'

We should have added the tag right after cloning, not until the first
git-fetch. Not that I object how you do it in this patch. Just a note
to myself that if I'm going to do that, I'll need to update this test
to update the change tag before fetching and verify the tag is updated
after git-fetch.
-- 
Duy
