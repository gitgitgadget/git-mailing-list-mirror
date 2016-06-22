Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC02C20189
	for <e@80x24.org>; Wed, 22 Jun 2016 18:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbcFVShJ (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 14:37:09 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36243 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbcFVShI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 14:37:08 -0400
Received: by mail-yw0-f195.google.com with SMTP id f75so7465340ywb.3
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 11:37:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Pwkuq8o3vpcbfhJIdalFhUK3nbyt2ibxAdDs1DbTY2o=;
        b=t0cCDiNjElTof4HvkNHwFY6xubukqCne17RMvCzl462YPKp7CgirL+FRMoNkFZ4kiL
         5O1gCWfJ4Cx06sI+X8xNrpC5VnLg7DV19kLJnOwz4nMd0fbWo+sJ11SwDsn4fbCragzH
         U3FaSWCLkXFcxcIur4lZxJ25vyMQmYsuVPxaHtgJdReHv0PwObtd64399oFYO/XA7Gyd
         C1NSFVxr8FQPS8d7Vgn0Nqe9Wb/+/eLaXDVK82TH8sE3HMlhmqJ69sGkbejqbxO48BQ3
         7OUK1FRopi4XmSvfn3YiqXB97wOX+I6lEY/bidN3COe4Lr6hX+GVC7knVMv04dwj5Bbb
         StLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Pwkuq8o3vpcbfhJIdalFhUK3nbyt2ibxAdDs1DbTY2o=;
        b=Od85xvDOyOwIOoKENdbJaxfakmh7zvkWbajSkadjlDp3NdeXDezy5gON9bqWe2OirJ
         srHQDNmRMv9f9lmZt0efV0b9K/1LQFj1ZdVeIqqDWXt3xERPrJfmVmJ/keE2WdGCxM+t
         mVNaSTcYVKouY32OQVpAPSatdC8BlmLX8zH7a4obZPC1pPRnjfqj7WV2u3Rm7l3Y88k6
         qPknG2Ax0SKynX66X79S6CWfa2rD3IN+rMdzQnuksjH7pfTI52DhV1Q45fInfseyWcBp
         Evmyy8DenhjJUyBkoz1YG2TYmNnN/7BM4EN/LOUVtiG1bQiaXpvUVG2hyTVwD0lDh9Hi
         BRYw==
X-Gm-Message-State: ALyK8tIxpH9DCWToTMWMIj1Sb+uLU9/+Ltoc8CDE1oW5A9XkCtbFqhrP1fMAE0ETcN1c1GbU5C0LXK/lOiiqdA==
X-Received: by 10.37.114.9 with SMTP id n9mr16307572ybc.80.1466620626252; Wed,
 22 Jun 2016 11:37:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.251.71 with HTTP; Wed, 22 Jun 2016 11:36:46 -0700 (PDT)
In-Reply-To: <CACsJy8BQxAkpoT7GVNgtM-0n1pMZeV5TRCiSn6TsYeATWeU=EA@mail.gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
 <1454724190-14063-1-git-send-email-pclouds@gmail.com> <xmqq4m8rz9qr.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CSVvZfwjG+zAEpG6tAWYAWVkrkz4RP32Hrr9O1A_8ZMg@mail.gmail.com> <CACsJy8BQxAkpoT7GVNgtM-0n1pMZeV5TRCiSn6TsYeATWeU=EA@mail.gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 22 Jun 2016 11:36:46 -0700
X-Google-Sender-Auth: utxn5mDGu9SJ6GIum8_naOxm_vs
Message-ID: <CAPc5daWEoK4Gp138VPstqwCAX+2K=_gSW98brHjmJYNWK4dkZw@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Fix icase grep on non-ascii
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 22, 2016 at 11:29 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>
> Can any shell wizards explain this to me? With this code
>
> BS=\\
> echo ${BS}${BS}
>
> Debian's dash returns a single backslash while bash returns two
> backslashes. Section 2.2.1 [1] does not say anything about one
> backslash (hidden behind a variable!) after escaping the following one
> and still eats the one after that..
>
> [1] http://pubs.opengroup.org/onlinepubs/009604499/utilities/xcu_chap02.html

I am not a wizard, but is the difference between the shell syntax, or just their
implementation of builtin-echo?  IOW, how do these three compare?

printf "%s\n" "${BS}${BS}"
echo "${BS}${BS}"
echo ${BS}$BS}
