From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Factorize editor handling.
Date: Tue, 27 Feb 2007 14:17:34 +0000
Message-ID: <b0943d9e0702270617h6ba8669bke55182f84296064b@mail.gmail.com>
References: <20070226194812.28907.80551.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 15:18:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM39O-00032v-Tc
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 15:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbXB0ORi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 09:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbXB0ORi
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 09:17:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:9603 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbXB0ORg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 09:17:36 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1116226uga
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 06:17:35 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cVJreAGVoo3krxh1IS6t4TklQxKeXUg7Pb9TvfNzKZi9FD71RxlHT72BwhPKRGdROg4NehqLIomovx8PvbxTZF3zxZdfMq0i2Z4KH5yTPQNz5et5tQD5DO8VtaT27+ASlbvfLb2mjLapQSUZGrsLlTXzHd9JnazkOykKdUrlqi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gMsL6CMgrLeP7i4klodEFVaKnixEMhihYW4FDUtNUA1HNLTgUzwSB4NIVs9SSF3CovN7wXhFWGgH6Tc0YoJiGoxvmhhz6Hz6uefBS9BAfqZmH4k3bsFHGp6at/OnUKY1yXqvUqfPyaBpj7wFHgWOFmnfjWBBXS4VUM/9h9QJDz8=
Received: by 10.114.148.1 with SMTP id v1mr258927wad.1172585854353;
        Tue, 27 Feb 2007 06:17:34 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Tue, 27 Feb 2007 06:17:34 -0800 (PST)
In-Reply-To: <20070226194812.28907.80551.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40737>

On 26/02/07, Yann Dirson <ydirson@altern.org> wrote:
> At the same time we trap the editor error for all editor calls, not
> just when called from "stg mail".

I merged this patch. In the initial StGIT versions, someone complained
that an editor (ed) returning a non-zero code is not actually an error
and shouldn't raise an exception. If anyone complains about this in
the future (that person is no longer using StGIT :-)), we could add a
config option to not raise the exception (though with some problems
for them).

> We may want to define a new exception for this though.

I added an EditorException since it needs to cought in main.py to
avoid a stack dump.

-- 
Catalin
