From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Merging submodules
Date: Thu, 31 Jul 2008 15:17:13 +0200
Message-ID: <8aa486160807310617o1a1cf8ddtdee3a43c2835d552@mail.gmail.com>
References: <20080730230336.GA6481@Hermes>
	 <20080731092104.1a6ce8bd@pc09.procura.nl>
	 <20080731143955.034f0577@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brian Gernhardt" <benji@silverinsanity.com>,
	"Git List" <git@vger.kernel.org>,
	"Lars Noschinski" <lars-2008-1@usenet.noschinski.de>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Jul 31 15:18:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOY2r-0006Mr-8M
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 15:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbYGaNRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 09:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbYGaNRQ
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 09:17:16 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:18323 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbYGaNRP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 09:17:15 -0400
Received: by yw-out-2324.google.com with SMTP id 9so330628ywe.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SVm1OQ2E0E5c4CRIKhVSO9Owm1PR+/JxYm2Dhjda1gc=;
        b=X7TF5rPbPxDoDZkMZ8gcL8u0JAXALMomuNZxE6zq+7Uck1GvZN5HsgzemNgwP8KcH9
         a4wH59qMMgeu5d45+C9vxLQpYyilevaGIjLSmBzSfvuddHLK8k32udG79t8a83iyfWzO
         f0Tcbi+bJ/o/UFBeBqxlbkPHtkdQNVNLPwIEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aBkrZdvUA/Od4PZw8BwyL07kdhiKZhvJkUF6uJN07KpRJCwWZZvNZ7gbAbsI9idutO
         kIZb49kAgwgSMplAGkmewgDu2Y8LfRkR47rrc7wZb/ly2m/a4LIrPg0VHIGMnCVwTclr
         K3YbC2Wcadfbd8IMP98JGkXtNr7aP95oCPF3A=
Received: by 10.151.143.14 with SMTP id v14mr1224114ybn.69.1217510233774;
        Thu, 31 Jul 2008 06:17:13 -0700 (PDT)
Received: by 10.150.95.21 with HTTP; Thu, 31 Jul 2008 06:17:13 -0700 (PDT)
In-Reply-To: <20080731143955.034f0577@pc09.procura.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90946>

On Thu, Jul 31, 2008 at 14:39, H.Merijn Brand <h.m.brand@xs4all.nl> wrote:
>
> There is a slight problem with this merging approach. The path names
> are as they are/were in the submodules. In module_a, foo.pl was without
> a leading module_a/ path, and now after integration, it still is. Is it
> possible to rethink this whole process that integrates/merges the
> several git repo's in subfolders into the current folder, as-if they
> would have been in this folder in the first place?

If you want to have module_a/foo.pl in the old commits you will need
to rewrite the history, either with "git filter-branch" or
fast-export/import, or importing again.

For the new commits it depends on how you would do them. If you modify
and commit without these module subfolders (without the module_a/.git
as your git-merge-mods does) then the new commits will have
module_a/foo.pl. So at the end you will have a merge of all the mods
(using the subtree strategy), and after that you will have a single
project.

All depends in a few factors, if you have published the history (for
the rewriting), if you want to have the module_# as independent
projects (this way you can merge them in other projects),...

Santi
