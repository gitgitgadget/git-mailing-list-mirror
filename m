From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH] update-ref: fail create operation over stdin if ref already
 exists
Date: Wed, 02 Apr 2014 08:57:15 -0400
Message-ID: <533C092B.1050801@kitware.com>
References: <1396426194-3292-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Aman Gupta <aman@tmm1.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:34:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeO6-0000xS-QD
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758709AbaDBM4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 08:56:38 -0400
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:59928 "HELO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758622AbaDBM4h (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Apr 2014 08:56:37 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]) (using TLSv1) by na3sys009aob132.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUzwI+7DpOEq6y5dYioylFzFHfGBYc0Xt@postini.com; Wed, 02 Apr 2014 05:56:37 PDT
Received: by mail-oa0-f47.google.com with SMTP id i11so164147oag.20
        for <git@vger.kernel.org>; Wed, 02 Apr 2014 05:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=l3NBBF4vYplEkfeNCqnIUTwvEw0dRfe5twDsh+eEEGo=;
        b=fVOnuMw4BPMU6meG0XzQo+J/ZVId5vxZCjMeuzjBYKNWlk19IFpLeEnCToJZxeLrh3
         ZFoxVBpTWGJZrDJL46QZe8D3uTBWPgwALeXysloK0WxgSKJyDu5Vo6QvYykFNYgzHRfr
         pZFy0mll6CLK7dhENzexy9jO0XfgDBhjyvaGTBWC45ID9CZXGriMQhV/e2VezV26MnKf
         QZZhCJWok3GhLngNNAQB2qo6B0oSedM9NF8v9NbXdY7tYuSo6hFFOwQtTn1aRwO+Gm9M
         jGzhge1SI6qP17Sb9dIQuHNtGhddTOHlhIrvzPan20XT9K8P3UxDlW50qAaE14XtjGNc
         i4zA==
X-Gm-Message-State: ALoCoQmwbgGvaQcfuaGFzVMMu96gdAxg8cgU1A5FSZ87KlcYpF5N0All28tT7LdUvVUB5KuYuOCXg/jdoEOrqIMvHC4SBP83dpSsAKAHhQ+fpuVl8Ynp3ZwiL0ee6uLgvMFBSTjnXT+UFNjDE25DazGXrfBrjSh3og==
X-Received: by 10.182.129.134 with SMTP id nw6mr386781obb.34.1396443386888;
        Wed, 02 Apr 2014 05:56:26 -0700 (PDT)
X-Received: by 10.182.129.134 with SMTP id nw6mr386768obb.34.1396443386703;
        Wed, 02 Apr 2014 05:56:26 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id cn1sm8155337oeb.11.2014.04.02.05.56.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 02 Apr 2014 05:56:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1396426194-3292-1-git-send-email-mhagger@alum.mit.edu>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245719>

On 04/02/2014 04:09 AM, Michael Haggerty wrote:
> From: Aman Gupta <aman@tmm1.net>
[snip]
> @@ -147,6 +147,7 @@ static void parse_cmd_create(const char *next)
>  	struct ref_update *update;
>  
>  	update = update_alloc();
> +	update->have_old = 1;

Looks good.

> +test_expect_success 'stdin -z create ref fails when ref exists' '

Strictly speaking we should have a non-z mode test too.

Thanks,
-Brad
