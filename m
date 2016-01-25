From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2016, #02; Mon, 11)
Date: Mon, 25 Jan 2016 16:56:20 +0700
Message-ID: <CACsJy8D2x1DtzNGB+zjoLxNwZoG2cVkkU9=ziHtRiV6rfBVc7Q@mail.gmail.com>
References: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 10:57:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNdtM-0007ib-3Y
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 10:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756349AbcAYJ44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 04:56:56 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34346 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243AbcAYJ4v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 04:56:51 -0500
Received: by mail-lf0-f53.google.com with SMTP id 17so81054241lfz.1
        for <git@vger.kernel.org>; Mon, 25 Jan 2016 01:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WAIx6GJcSdsnmCI4zLYbsoyu5I/YRwv/7mzhmEwSDAM=;
        b=M3y9/N3vIXN0VY1ScdCP1ejbXFKwpEWjYDhpK5NMtQabRmfuxSCaf5GvWFeyHPQIWm
         269Y6sGHzxjS1pB2vw0YLfUX+at/CsBhi5Ta1RADP8WTxZFYRSmHidl/sBIw0wti8Gi9
         kqKhSnUtJpgAhfz991M/237n6KRBkaK5Hevkj0aewVCP3bEaid0buE9olFYI/qNwZCuF
         ZiRVPpRjsQuDoaVaUwqByh2PzEV4QTOBZqoqIX3rBGeEYnY9/9sp79eDbWk2uVfgWAd/
         zCeTrd1wQEhpmcip4WNL0xCPNqeY7YPG8GIVs+csfToETAaZPKDdl16Sk8V6cOPhZtp8
         JoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=WAIx6GJcSdsnmCI4zLYbsoyu5I/YRwv/7mzhmEwSDAM=;
        b=DqW+r838m76chtEHzlU0Yip11EjB30jyKP09U735Bpv4V6KvKadlU11AsblNzHU2V/
         jKW+Kc7JwIu+AeXbI/Mte6N4zLpPb9pT0fr57MJbNTr5XPv6HKS61lBu03lLZKNKOXFf
         6PdD93tU6o21heFHa7OPF3auku0/IyQYTibjAmZcqRKWdA2GBL1nCciRnNi9i318RpX9
         l28Qq3Z+yAymYtpi8/LlF/5Qzk3Zws1Z3SgJE3oJVbynp78le7+Nw1PydYLk+NcYVlRz
         Pigf3AFV/qCS0Rf+GgKyeeAWzZs9PPi9XQDacHfskhOKRSwbmBp7tSvDNJyWK6yBIzkj
         Rvww==
X-Gm-Message-State: AG10YOSPmLiEIkqJzBppjCOf+4kY5qfwr3/pjlr5zAbluE8y3w4DGxtkihLeJkqAe3vaT01DEz0oKb7I9X6h7g==
X-Received: by 10.25.157.135 with SMTP id g129mr5886524lfe.45.1453715809834;
 Mon, 25 Jan 2016 01:56:49 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Mon, 25 Jan 2016 01:56:20 -0800 (PST)
In-Reply-To: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284730>

On Tue, Jan 12, 2016 at 6:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * jk/graph-format-padding (2015-09-14) 1 commit
>  - pretty: pass graph width to pretty formatting for use in '%>|(N)'
>
>  Redefine the way '%>|(N)' padding and the "--graph" option
>  interacts.  It has been that the available columns to display the
>  log message was measured from the edge of the area the graph ended,
>  but with this it becomes the beginning of the entire output.
>
>  I have a suspicion that 50% of the users would appreciate this
>  change, and the remainder see this break their expectation.  If
>  that is the case, we might need to introduce a similar but
>  different alignment operator so that this new behaviour is
>  available to those who want to use it, without negatively affecting
>  existing uses.
>
>  No comments after waiting for a long time.
>  Will discard.
>  ($gmane/278326)

I carried this in my tree and didn't realize it's dropped from 'pu'.
There's actually a comment last month [1]. By your last comment, does
it mean I should check if "it" breaks anything to resurrect this one?

[1] http://thread.gmane.org/gmane.comp.version-control.git/277710/focus=282886
-- 
Duy
