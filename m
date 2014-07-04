From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v4 1/2] add `config_set` API for caching config files
Date: Fri, 04 Jul 2014 14:55:54 +0530
Message-ID: <53B67322.1080408@gmail.com>
References: <1404280905-26763-1-git-send-email-tanayabh@gmail.com>	<1404280905-26763-2-git-send-email-tanayabh@gmail.com>	<vpqoax8m8bh.fsf@anie.imag.fr> <53B63461.2040300@gmail.com> <vpq1tu1xz2g.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 04 11:26:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2zku-0005mt-Ul
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jul 2014 11:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbaGDJ0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2014 05:26:04 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:39901 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbaGDJ0C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2014 05:26:02 -0400
Received: by mail-pa0-f50.google.com with SMTP id bj1so1718758pad.23
        for <git@vger.kernel.org>; Fri, 04 Jul 2014 02:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=LSsWO40rXZL0LbLtOpWgH5LGLRQpFR2N6esrLckCF4E=;
        b=mqSGKaXc8D7ZmlcXoqrjJ6X4Gqf7PD14xGzrCn8hwUq9kZdKy+IUOE8UANpb5gTTZB
         xxSALBfIcPtJnQH/QgMIeUC8nsB6tUrkcHKMNyNAPlC7GuSmSLqdX0Y7hLZiNFmM/wgu
         //PHALwKrG6A/b3nloDbUXIWHzgWeJS333S13ND3f3Y132g3r/QhQJDpAd9OQPARaTzz
         W/7SOGu7xIh7JjQj2LtXsyT9aQ7HA1EkCuhAIQHO4WbTxjLcBJ7/n5QKH0KXcmop6muB
         jebQXUHNYEeVv6wK18oK/m61xc11R9jaj2h5Kd9fP/6JZrgp37vZTM61pJ4ylbnFjLjs
         bC2g==
X-Received: by 10.68.136.5 with SMTP id pw5mr9899970pbb.106.1404465961672;
        Fri, 04 Jul 2014 02:26:01 -0700 (PDT)
Received: from [127.0.0.1] ([117.254.221.228])
        by mx.google.com with ESMTPSA id hs5sm43527342pbb.92.2014.07.04.02.25.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 04 Jul 2014 02:26:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpq1tu1xz2g.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252892>



On 7/4/2014 2:47 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> Hi,
>>
>> I have cooked up a single hashmap implementation. What are your
>> thoughts about it?
> 
> I had a quick look, and it looks good to me. I'll make a more detailed
> review when you send the next series.
>

One more doubt, does <filename,linenr> for every value has any use other than
raising semantic error in typespecific API functions.

For example, if we call git_config_get_int(foo.bar), we can show to the user
"value not a int at <filename, linenr>". Other than that I cannot think of
any other use of it. Currently `git_config_int` dies if value put for
parsing is not an int.

Junio and Karsten, both raised the point for saving <filename,linenr>, but I can't
find any use cases for it other than what I mentioned above.

Thanks.
Tanay.
