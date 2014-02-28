From: Lee Hopkins <leerhop@gmail.com>
Subject: Re: Branch Name Case Sensitivity
Date: Fri, 28 Feb 2014 09:10:56 -0500
Message-ID: <CAJHY66EPKnmSGGSxRi=p8m4dsys=wiLNWoQF6+3Xe4j9J+DivQ@mail.gmail.com>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>
	<xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>
	<530FA0C1.3000109@web.de>
	<530FBB1D.3050505@gmail.com>
	<CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>
	<53102FB0.6040603@viscovery.net>
	<5310959D.709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 15:11:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJO9V-0003UE-T7
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 15:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbaB1OK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 09:10:57 -0500
Received: from mail-qa0-f49.google.com ([209.85.216.49]:52287 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaB1OK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 09:10:57 -0500
Received: by mail-qa0-f49.google.com with SMTP id j7so667365qaq.36
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 06:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=x+Qhi0/BchsepSPaxTaxMYU0JY5Z4SsQukBaf/OtORI=;
        b=JoDmt3KB0FxKLlSBhzIehKzkmOLyFbcb0fF4XJ2XKFxLrajCpqjEOn1lb/gT/V/L1k
         x84o3yJGT1EzccAF33ogspDAjcqjTrO04NCVcv0hYrDte92h/iGXjyeLlCklpplbF8m2
         F91RArk2fUv72Yq4CV+ECUre9soJfQVUZKbrIWecSxlt4zTcexBz732VzRNNoVBkQ7PS
         xONXzB21AG0I+W97s4eq2IZvcnFbSr73vN7pKGkTcgzQF3J6zfm3CNVwFjrcQ4ILyXo9
         EppTj2rO+/0bOuIejmdYhLNofU5Jcs+0K4WAG7q7uWaSH1gvGWEqLnstNtuHyMeMp2va
         r/ug==
X-Received: by 10.140.108.116 with SMTP id i107mr3673393qgf.80.1393596656403;
 Fri, 28 Feb 2014 06:10:56 -0800 (PST)
Received: by 10.140.106.69 with HTTP; Fri, 28 Feb 2014 06:10:56 -0800 (PST)
In-Reply-To: <5310959D.709@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242960>

> If you are on a case-insensitive filesystem, or work on a cross-platform
> project, ensure that you avoid ambiguous refs. Problem solved.

I agree this is the best solution, and I personally avoid the use of
ambiguous refs. However, since there is nothing in git stopping the
use of ambiguous refs, there is no way to stop every person who works
on a shared repo from using them.

> So, everybody on a case-insensitive file system should pay the price even
> if they do not need the "feature"? No way.

I would say preventing potential loss of commits is a price worth paying.

> IMO the proper solution is to teach packed-refs about core.ignorecase. Until that happens, disabling gc.packrefs seems to be a valid
> workaround for people who have that problem.

Once again, based on Michael Haggerty's very informative input, maybe
an even better solution would be to add a core.allowambiguousrefs
(default to true) option and when it is false do a case insensitive
comparison during ref creation (branching, tagging).

Thanks,
-Lee
