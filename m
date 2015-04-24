From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/5] ref_transaction_commit(): remove the local flags variables
Date: Fri, 24 Apr 2015 17:51:41 -0400
Message-ID: <CAPig+cS7+NW1L5D1gAwz3xp9jv13u4L9i-u1oFDLvRbr-u_X7w@mail.gmail.com>
References: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
	<1429875349-29736-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 24 23:51:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YllVj-00037r-Oa
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 23:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966964AbbDXVvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 17:51:43 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:36711 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966933AbbDXVvm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 17:51:42 -0400
Received: by igblo3 with SMTP id lo3so25512538igb.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 14:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2TAHNJBFLklWFfhjDIBPKS9KTriT/uLXWfLfs5fgoZU=;
        b=lYKsrGcARmQ/nOuiFbxc++hfpPgywxgAI2jhTY/h3GF+fuPj8eIigItWkZ8uZkAtxu
         L/GQTFPP7lBseN5IeL1NU4nEE3m0DOJle88X6gx+cV3HB95J85ThTHnRVKK0sX1kW465
         SWJTS61EiMh8n+qD4XeBgMG+WcNhGb1mqKboA5RLGFmVdQb49GNZ4EJsgWfAgoCBTt9V
         zkw3Dw92ffkz8ckSpAvob+V/fCGaZpQngMr/FEIQrDwNweBSzs17N2aoP5+LCEgy2qL4
         y3Xy0HTSfIJqBAbc2kRV3OvEJlQmnUjcNQYYjwZAXNbq5pVcE45iye3eRU2A6YvIGDqd
         8H/w==
X-Received: by 10.42.207.206 with SMTP id fz14mr1246208icb.34.1429912302041;
 Fri, 24 Apr 2015 14:51:42 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 24 Apr 2015 14:51:41 -0700 (PDT)
In-Reply-To: <1429875349-29736-5-git-send-email-mhagger@alum.mit.edu>
X-Google-Sender-Auth: 5WEjmZLZgwHn9jkTdEfR1bLpvnM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267758>

On Fri, Apr 24, 2015 at 7:35 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Instead, work directly with update->flags. This has the advantage that
> the REF_DELETING bit, set in the first loop, can be read in the third
> loop instead of having to compute the same expression again. Plus, it
> was kindof confusing having both update->flags and flags, which

s/kindof/kind of/

> sometimes had different values.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
