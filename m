From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] refs.c: write updates to packed refs when a
 transaction has more than one ref
Date: Sun, 8 Jun 2014 05:03:12 -0400
Message-ID: <CAPig+cTQocaZBHciFkP591A11w9qcKAvG5a2H+R=7QHVvxU4EQ@mail.gmail.com>
References: <1402010788-8236-1-git-send-email-sahlberg@google.com>
	<1402010788-8236-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 11:03:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtZ0X-0007nA-Fx
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jun 2014 11:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475AbaFHJDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2014 05:03:13 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:38058 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbaFHJDM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2014 05:03:12 -0400
Received: by mail-yh0-f48.google.com with SMTP id b6so332376yha.21
        for <git@vger.kernel.org>; Sun, 08 Jun 2014 02:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qnQ+YrUW+jxyL24Hw8KZuxeHGMVmw7IVoC958gZZNfk=;
        b=l0s8CLDhbxtpMcHG8rOu4ikR+vw8qgsLNCgH0+j+/dcW4REmWRqYqy/tSVAE3NtyY7
         yAzfx51qAu382kBjuTODPd6VkKuHWW/azAQDjgyz3Wvj191Me1kGs7FpjxAO65vvt1lW
         a4nBsobTf4QuvlTC7qm1f1co8iaKCpL6gcmSCrpjL2snuNytnO4LeNr+C8+225Lh3dSt
         PXvttGJrNbgn/cXICEo7FZnCklKUNDfX8t4EeuHNuzF9fhhAoz4UrbOKgLP1g4UdFuKA
         +y3wwrqJAds2lOsEOdZxDDeaiQjDKqVu85FWKW35sazObEBNhC/ISjZbgouaGl/ozMs3
         N8nw==
X-Received: by 10.236.220.197 with SMTP id o65mr3043yhp.125.1402218192164;
 Sun, 08 Jun 2014 02:03:12 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Sun, 8 Jun 2014 02:03:12 -0700 (PDT)
In-Reply-To: <1402010788-8236-2-git-send-email-sahlberg@google.com>
X-Google-Sender-Auth: ErQPU9IclcqeuP8N6ZJ_I1drSx0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251050>

On Thu, Jun 5, 2014 at 7:26 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> When we are updating more than one single ref, i.e. not a commit, then
> write the updated refs directly to the packed refs file instead of writing
> them as loose refs.
>
> Change clone to use a transaction instead of using the pacekd refs api.

s/pacekd/packed/

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
