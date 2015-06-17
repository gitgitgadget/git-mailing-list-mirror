From: Paul Tan <pyokagan@gmail.com>
Subject: Re: New Defects reported by Coverity Scan for git
Date: Wed, 17 Jun 2015 22:39:43 +0800
Message-ID: <CACRoPnRz8T3yV3=g4128oa+GtuCzdxXCa1JN7stcbP_zVKFLqw@mail.gmail.com>
References: <558151df465a5_4fafe3b3182568a@scan.mail>
	<CACsJy8D5_n3+yQ=7fRFMv6XU=s3vf0hoi4-7yDyYZSByK0zKsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 16:39:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5EVK-00080z-FM
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 16:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756645AbbFQOjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 10:39:46 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33544 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756504AbbFQOjp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 10:39:45 -0400
Received: by lblr1 with SMTP id r1so33246237lbl.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YjAO/9M8GWbNswQghkNf1bepXh1elOWbvi6/XIlOAMA=;
        b=gdR7gXmyBxpADDyutT2Yz1TngtjBWUYPEpt+tgJikiAPo8r5mwFsFNX863jW8AHOjB
         poI0tCi9TdouqlsjZ7ZFqKf2F/1for202xDQrfPGSAK8AbR4UXGrGzCEQdJwoCrS4tYN
         U1HMvJTWR3khGIEX03LGJoTovlrX2KBr+8nzRZu9iY0DueaEutmFiaYyq6n9rZheQ5y+
         t+DORtjfi9/JicPlL7J2IUnQonKCKs5hgwdLGZXpDbAa1nlB7VPtMDmg3Qp30C93q8Fe
         6pok64fe/Cy375MZCQXTd/eYXVi40/er66SCNfaNKZD7bSRf5XFhIADBADVWMeCsZqGD
         6H7A==
X-Received: by 10.152.30.4 with SMTP id o4mr8033917lah.74.1434551983471; Wed,
 17 Jun 2015 07:39:43 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 17 Jun 2015 07:39:43 -0700 (PDT)
In-Reply-To: <CACsJy8D5_n3+yQ=7fRFMv6XU=s3vf0hoi4-7yDyYZSByK0zKsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271851>

On Wed, Jun 17, 2015 at 9:54 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> I think Coverity caught this correctly.
>
> ** CID 1306846:  Memory - illegal accesses  (USE_AFTER_FREE)
> /builtin/pull.c: 287 in config_get_rebase()
>
>
> ________________________________________________________________________________________________________
> *** CID 1306846:  Memory - illegal accesses  (USE_AFTER_FREE)
> /builtin/pull.c: 287 in config_get_rebase()
> 281
> 282             if (curr_branch) {
> 283                     char *key = xstrfmt("branch.%s.rebase",
> curr_branch->name);
> 284
> 285                     if (!git_config_get_value(key, &value)) {
> 286                             free(key);
>>>>     CID 1306846:  Memory - illegal accesses  (USE_AFTER_FREE)
>>>>     Passing freed pointer "key" as an argument to "parse_config_rebase".
> 287                             return parse_config_rebase(key, value, 1);
> 288                     }
> 289
> 290                     free(key);
> 291             }
> 292

Ugh, thanks. ><

Regards,
Paul
