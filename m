From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] submodule-config: use hashmap_iter_init()
Date: Tue, 15 Mar 2016 14:58:05 -0400
Message-ID: <CAPig+cR6Cy2MHvoTxNa89gZx9qJZW1Rv93N+wcwK2JRGkUBzRw@mail.gmail.com>
References: <1458066330-5107-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 19:58:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afuAc-00025o-DS
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 19:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965626AbcCOS6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 14:58:08 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:36273 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934145AbcCOS6G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 14:58:06 -0400
Received: by mail-vk0-f43.google.com with SMTP id c3so33075567vkb.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=qfdHRTJO1LheCdh5fG2JCTa9oIJySr9BNpJ2y9jPT34=;
        b=sQfD2QML91HlEJO6syvtpbPiySDY9kPWIwNRXjmMFzN/BORPST2ki0jOc0fVMYDiJS
         m8iTwv8TwbA7mCgyPP+9U3cQ1jGPih5NzQInGn84qB4asR40rOliRxa6h+KJr/AzYwl4
         SVL1Mq0HlMTfGfpQhkteRjUpbhQOGe+KFLw30TIp0FJWK3i2P1UtvErGYFM9N+RD63g+
         fT4K5EBcOMIsipU8rlR1xXfSscV3TOcdJA69Qn8Ubixf4Qu9drzj/+U11obMMT5se7RG
         63smQiCcZXMZK7oNtVkRhcJm2eaWD2ANOMK8/Q8c5AShxWbKMuiws/wok/px24UntE4e
         qJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=qfdHRTJO1LheCdh5fG2JCTa9oIJySr9BNpJ2y9jPT34=;
        b=W2cnJjjEljvprr3MtnFiVq5Fv9ZSk1uS1u8zAbWcz5+jkgFxynnpKEhqVbkCobXM6l
         bqQtbyc9zrypkF7NQ71rXkm1TRJ+LDaRMU6Yse4jTBvB++TiEccaz6xWzaZG9ovJUnH9
         No0SSCCKFDsIQi5ZQ+/eCyNxiJS8LdgWGfjFcP34bARt6iES49SFJJWgFRl71JBttSjw
         memx08ksJtOKVzWo+fUBpBj9oQKa3z4x4Ccxpln5ttpq/ucUcNUyrnHGZxQIq0XENyyc
         Qz3uBFf8toscW3TSrdPfAlRoUmqfkaYPQGJ8h5R/rUcB+c8LCY6TmZmEsNS7dw8wuKg9
         LYfw==
X-Gm-Message-State: AD7BkJJymcV2XAux4yy7Ji3Nbh+Ba7XAnVHVmx5HppdKqC4q2amJbH0vuMB3ON2ADIj7aMRCA4Ugf6R6YKsCRw==
X-Received: by 10.31.47.135 with SMTP id v129mr33523034vkv.115.1458068285689;
 Tue, 15 Mar 2016 11:58:05 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 15 Mar 2016 11:58:05 -0700 (PDT)
In-Reply-To: <1458066330-5107-1-git-send-email-kuleshovmail@gmail.com>
X-Google-Sender-Auth: U6eTYPX7llluaLfnDPx0c-1GVUs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288890>

On Tue, Mar 15, 2016 at 2:25 PM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> submodule-config: use hashmap_iter_init()

Did you mean s/init/first/ ?

> from the <hashmap.h> for simplification.

Sentence fragment...

Missing sign-off.

> ---
> diff --git a/submodule-config.c b/submodule-config.c
> index b82d1fb..8ac5031 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -405,8 +405,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>                 struct hashmap_iter iter;
>                 struct submodule_entry *entry;
>
> -               hashmap_iter_init(&cache->for_name, &iter);
> -               entry = hashmap_iter_next(&iter);
> +               entry = hashmap_iter_first(&cache->for_name, &iter);
>                 if (!entry)
>                         return NULL;
>                 return entry->config;
> --
