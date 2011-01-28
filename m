From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Project- vs. Package-Level Branching in Git
Date: Fri, 28 Jan 2011 16:43:26 -0500
Message-ID: <AANLkTik4v-DdZ9A3i3GF5qQvPDv49kyyo9w2zNNHmrsK@mail.gmail.com>
References: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com>
	<AANLkTinTRgzv0s9MTyM4TaOwVOmhwRckDqMfxrbsKVfm@mail.gmail.com>
	<15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Thomas Hauk <tom@shaggyfrog.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 22:43:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Piw6P-0001QS-1Z
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 22:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087Ab1A1Vn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 16:43:28 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51844 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab1A1Vn1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jan 2011 16:43:27 -0500
Received: by gwj20 with SMTP id 20so1257724gwj.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 13:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5Hfej97O+WXTsdef5zaZ/YPf2QDemf5vrzphGNukquA=;
        b=S2mrIMlcHyGqO0lE6qFrf3aUnJS8VzohV27abL2GqM4W1C4cyxVbOu6/4pPHXI3B7N
         qqKnRmWf358bl3Lj1CRD4F4dsMOVV26tJKtrpxZ2N/DF4W9e3mUllma8X5UgkyaEz1un
         ZTxa7CnOqjofzfu6wJeJOFf0IT06IUWTe2A/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Esxhy/Q1ABX81ohpkzQWA0ivGgojStb+PhKZwohtE3kGEZ4Q9gy7I8faegHbYBtwCu
         t6ElEmmlhMzHDg+E2kDwBt7XYUYslwQIYI1fU5+aBV1z65nCFfS/6cMbC4Rg+3LIU96b
         3ZvReqY2EBuCvLk+YLXqk700yPYswXFbbnUG0=
Received: by 10.90.72.8 with SMTP id u8mr5520752aga.72.1296251006699; Fri, 28
 Jan 2011 13:43:26 -0800 (PST)
Received: by 10.146.168.5 with HTTP; Fri, 28 Jan 2011 13:43:26 -0800 (PST)
In-Reply-To: <15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165643>

> But how often do you have a project that has no external or internal dependencies on any other packages or libraries? Any project I've ever done, big or small, has relied on some existing codebase. Imagine a project that uses liba and libb, which both reference libc. To use Git, I'd have to have copies of libc existing in three repositories, and copies of liba and lib in two repositories each. What a nightmare... and that's only a trivial hypothetical example.
>
...> I'm really trying to get on the Git bandwagon, here.
>
> --
> Thomas Hauk
> Shaggy Frog Software
> www.shaggyfrog.com
>

For example at my shop we have very "component oriented" approach
(JAVA). Each project is a separate git repository, that is producing
one artifact (.jar, .war etc) and has a ivy dependency descriptor. We
are using Hudson CI to perform intergration builds of projects
themselves upon push and their downstream projects as well. In this
particular example there is no need to keep any copies that you're
talking about. For this Git works perfectly!!

OTOH there is a part of development that is using C++. And the whole
infrastructure is about static linking and is so heavily depending on
the CVS ability to expand keywords, that there is no way  (at least so
far i could not find an acceptable solution) to migrate the C++
development to Git.

My question is why do think you should have the copies??? Can it be
that the inability to use Git for your projects is related to the way
how you do things? May be you just have to be ready for the paradigm
shift first hand?

Thanks,
Eugene
