From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 0/2] do_compare_entry: use already-computed path
Date: Mon, 21 Dec 2015 18:33:04 -0500
Organization: Twitter
Message-ID: <1450740784.3892.3.camel@twopensource.com>
References: <1450737260-15965-1-git-send-email-dturner@twopensource.com>
	 <xmqqzix3e61h.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 00:33:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB9x3-0008Uv-7v
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 00:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbbLUXdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 18:33:08 -0500
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33910 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbbLUXdH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 18:33:07 -0500
Received: by mail-qg0-f44.google.com with SMTP id 74so51886171qgh.1
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 15:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=hlRYzSIq6RQielLQbxQe2eUqZAwNSBbDBgHVATI4Tsg=;
        b=vZdJ/ycIaE75tZA1U8gSTh/yxUidbyXmreXcxe0K6A1eqc4gdzFUs0aOnXaxXWRndy
         ogSX7SN8qyiFo6I5o6xgjH1ZcqY4JwU/9x6+NtPPkYkNl+2482WJhG7rcjq5Bd/4x7wQ
         zxanzXGHBUyKd7vgnVhNx0ZIryumqdotEed65AbEfUv3ViaX6B9lZjBr8aBog+EOwxqH
         Rn35PYd9cx5af4qQHps4b2ojz/lL7PFEnKE3TRnoEzQt616bUD8nVJvmk3naOXdyj8+D
         C9kpng7glzWlw1C62NxSAwjKi/c0pE1hAcU/I+ruwLb33qxeTbAzf5ZXyeEoDXDkBjeb
         sC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=hlRYzSIq6RQielLQbxQe2eUqZAwNSBbDBgHVATI4Tsg=;
        b=OCVmXxOUA+5ms1QoQhFhvh+Uj4PUhTYoNPI6++WblxYvQ9DaHm19SXUeeu1mvU601q
         EvN7UQqLJuskr2cDiE12oXJ9q3snKJ0B76zZZ5OM7J5pPo+I2nAbhlA2sgiRFXHp9Qt8
         V4+lWAN7oe5atqMTEtPqYmV43Vnwz4N+DKFzm7EgaoYRTGVoCj/iB7p+lUFNyBbPYsGj
         JSSpkMFB6bKhsZsHmG51QVw6r9YcXoqelqOJWag5dmwJF2AydeZA6+dmtGQZpwDBhA5X
         DjjRZU/KTFjtf7pvI21TfnlX4PkHHgN/VvPdFWmrtSWFGmHISh9z5W6n2NtO3GtX+BtO
         MQZQ==
X-Gm-Message-State: ALoCoQk0k1PEvtfPK/wrIOO/NnC4so44kK8QCwcyBsolJ1piZsIWybIwnxC9LSVwpKH+5ZnvHe2uGTH1+0xWleJbm+kPzkDRjA==
X-Received: by 10.140.132.72 with SMTP id 69mr30240039qhe.17.1450740786143;
        Mon, 21 Dec 2015 15:33:06 -0800 (PST)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id t47sm14957407qgt.28.2015.12.21.15.33.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Dec 2015 15:33:05 -0800 (PST)
In-Reply-To: <xmqqzix3e61h.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282825>

On Mon, 2015-12-21 at 15:27 -0800, Junio C Hamano wrote:
> Thanks.  Does the number still stay at 25% improvement?

Yes.
