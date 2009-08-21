From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH v2] Fix symlink __stdcall problem at MSVC
Date: Fri, 21 Aug 2009 10:42:14 +0800
Message-ID: <1976ea660908201942r7ba14d1cnbb516f9f2c31f8bb@mail.gmail.com>
References: <1250778072-4324-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 21 04:42:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeK59-0002fT-K3
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 04:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbZHUCmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 22:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752145AbZHUCmO
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 22:42:14 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:59597 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbZHUCmN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 22:42:13 -0400
Received: by qw-out-2122.google.com with SMTP id 8so250605qwh.37
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 19:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lWqxSJSKFY/+b9EwY+Fg+4ojNBjoEvrskg77x8zVbrQ=;
        b=jzG1JAK0TUiekVwyG3OCnXnPV/u+m//aBmgWI8MevSKg5Bcbf2Dtz4QURZl+ICoykJ
         C1zXzlGrRUJyQHoiBsGPFLQSLuze8sfscYz5SB93OetaIJ3xY6HzQoOGCMMBaP76Lxe8
         osDQZI4snbzG6F7+W6bYVYAwdcMTeUShC3Cvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ug68xmopbiXCpRO7UPLrCU0NzWXI1CNYZDqAYfYmnRGiyJLMnhtyqCDbAsQ04b/5si
         stM+mDIUqN8mk3vc049KYdC331Hljc0v59UrCk//B+351qdRr9OIGlQ4QzPQ51HUd9fL
         NYoqaocTRwLm0O0t58Cy1E2rHCV1xnnbds7sU=
Received: by 10.224.53.101 with SMTP id l37mr365820qag.367.1250822534587; Thu, 
	20 Aug 2009 19:42:14 -0700 (PDT)
In-Reply-To: <1250778072-4324-1-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126666>

>
>  int symlink(const char *oldpath, const char *newpath)
>  {
> -       typedef BOOL WINAPI (*symlink_fn)(const char*, const char*, DWORD);
> +       typedef BOOL (WINAPI *symlink_fn)(const char*, const char*, DWORD);
>        static symlink_fn create_symbolic_link = NULL;
>        if (!create_symbolic_link) {
>                create_symbolic_link = (symlink_fn) GetProcAddress(
> --
> 1.6.4.msysgit.0
>

This is new patch for latest devel branch mingw.c.
