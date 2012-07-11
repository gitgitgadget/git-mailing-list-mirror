From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Tue, 10 Jul 2012 20:37:56 -0500
Message-ID: <20120711013756.GA2964@burratino>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
 <1341939181-8962-2-git-send-email-cmn@elego.de>
 <20120710191354.GE8439@burratino>
 <7v1ukjiehe.fsf@alter.siamese.dyndns.org>
 <20120710201105.GH8439@burratino>
 <7vsjczgx3h.fsf@alter.siamese.dyndns.org>
 <20120710210901.GI8439@burratino>
 <7vehojgqgk.fsf@alter.siamese.dyndns.org>
 <20120710234717.GA21467@burratino>
 <7vzk77f602.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 03:38:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Solsg-0006gk-TA
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 03:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225Ab2GKBiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 21:38:13 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45074 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab2GKBiN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 21:38:13 -0400
Received: by yenl2 with SMTP id l2so721007yen.19
        for <git@vger.kernel.org>; Tue, 10 Jul 2012 18:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PmII44r+Bw+KXbOtycqhlKCSiPCG2WH7/Hq9o33fEU0=;
        b=WX8O9Mt1agaNivtkNdgYNjBEio65tmlvxv1LfuqjWX57o3AIZ5tr4ZbnykvT5JM7yd
         J/xLRtKVUquv4u5ZKzUn5ZZxs0k1vP4pZx7HAZt5tho9j7Hv9U6USblqCYat5g58HOqp
         04WeU/dRIzJxBphO6KF3nwY7nhxvrg2F2EsvkbzGsnBFtRWQTJJDIyGstADaTD+nMj4O
         VBBv0yErg2mlgIDL/muBxrCk1+oOXeOmrj1lj4K99TA4fFKVtqiXFKWbr0Cp0IaXU5Mk
         LdZBBAteKPfpCa/e7DGJEAxJRNg+D7qtfj3fKkK1hUub+k4qP3xkWKDeEpEfcuO5oLtR
         78OQ==
Received: by 10.50.163.70 with SMTP id yg6mr12803683igb.70.1341970691926;
        Tue, 10 Jul 2012 18:38:11 -0700 (PDT)
Received: from burratino (ip-64-134-175-40.public.wayport.net. [64.134.175.40])
        by mx.google.com with ESMTPS id y5sm731080igb.11.2012.07.10.18.38.07
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jul 2012 18:38:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzk77f602.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201289>

Junio C Hamano wrote:

> In short, you are saying that, assuming that missing <start> and
> <branch> are given a sane default values (namely "HEAD"), the
> syntax:
>
>	git branch <branch> [<start>]
>	git branch --set-upstream-jrn [<branch>] <upstream>
>
> is easier to understand

I didn't propose allowing the branch argument to be omitted, actually.
It would be clearest, _especially_ because one argument currently
means something different, to make that error out.  Sorry for the lack
of clarity.

One more detail I didn't mention before: I think a convenience feature

	git branch --set-upstream-to <upstream>

that takes exactly one argument and means

	git branch --set-upstream HEAD <upstream>

would be fine.  Having a second command to do the same thing as
--set-upstream does (or adding new --set-other-things commands that
use this proposed convention where the value comes before the key) and
migrating awkwardly to it is what I object to.

Clearer?
Jonathan
