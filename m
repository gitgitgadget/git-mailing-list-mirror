From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 17/22] refs.c: add a backend method structure with
 transaction functions
Date: Fri, 08 Aug 2014 14:17:52 -0400
Organization: Twitter
Message-ID: <1407521872.26542.21.camel@leckie>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
	 <1407516309-27989-18-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 20:18:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFojx-0002de-Ut
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 20:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbaHHSSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 14:18:03 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:43523 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbaHHSR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 14:17:59 -0400
Received: by mail-qg0-f47.google.com with SMTP id i50so6405662qgf.6
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 11:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=0mgtzExp4/v1O9/E1EpbJMO+AkYq/2qIqoZOvojqhNo=;
        b=FnvksHZXZGB0mcSXuM7YcchUtZL0wW/sp9gr8h+weHCxnFx/BRF3AIX6Z6OC+R8QhR
         vDtirpLMl/ITtTi/aFxFsB6PV3M3b/8ocw+UU9kn13F0Zcz+tD5HCax9KLylWy2xsVA9
         VcKMATizbCXo4ModR3gnTI6NXhIjkmpq1/JmEtpxIDpAMzQqejvOB6s8pEk4rCYEK3ay
         YB6UOBHP66b2rwZo/h5fp6PrrcWeaOPICApCCKSXK6irEwEqqp7X3c569evLG78/tZ5f
         r9WBHXlfyZW9y+okfUrh/GulnSy6jFdXopgpquMbvhXZUcKcIplQ7UyMbr6QeUQcymhU
         RdHg==
X-Gm-Message-State: ALoCoQmg1g5XdyqwjAieVOuBj3Pm66sFyvXUN/zom6EhFL8an/QyW57yXAirGgqE6aZEWYfuUqAO
X-Received: by 10.229.225.131 with SMTP id is3mr40014543qcb.2.1407521878726;
        Fri, 08 Aug 2014 11:17:58 -0700 (PDT)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id b2sm6720050qaq.4.2014.08.08.11.17.57
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 08 Aug 2014 11:17:57 -0700 (PDT)
In-Reply-To: <1407516309-27989-18-git-send-email-sahlberg@google.com>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255061>

On Fri, 2014-08-08 at 09:45 -0700, Ronnie Sahlberg wrote:

> +struct ref_be refs_files = {
> +	.transaction_begin		= files_transaction_begin,
> +	.transaction_update_sha1	= files_transaction_update_sha1,
> +	.transaction_create_sha1	= files_transaction_create_sha1,
> +	.transaction_delete_sha1	= files_transaction_delete_sha1,
> +	.transaction_update_reflog	= files_transaction_update_reflog,
> +	.transaction_commit		= files_transaction_commit,
> +	.transaction_free		= files_transaction_free,
> +};

C99 designated initializers are unfortunately forbidden by
CodingGuidelines.
