From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH/RFC 7/7] update-ref: support multiple simultaneous updates
Date: Thu, 29 Aug 2013 14:42:39 -0400
Message-ID: <521F961F.3090801@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <8d323b9c2a71a9bafa8b48caf1d85c1035549b16.1377784597.git.brad.king@kitware.com> <xmqqioyo4a7w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:44:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF7Co-0005BB-1b
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756717Ab3H2SoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:44:25 -0400
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:45434 "HELO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754315Ab3H2SoY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 14:44:24 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]) (using TLSv1) by na3sys009aob115.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUh+Wh3pe+iCIjJoA2IBQ2g7SsEGLL5Kc@postini.com; Thu, 29 Aug 2013 11:44:24 PDT
Received: by mail-oa0-f49.google.com with SMTP id i7so1095672oag.36
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=y3pYQz+0whyNv9cao8fyWm1BawXc2lQbN4yp9zF8EfM=;
        b=ZscWcROLs0861c/vW+eBHy5dQov2TGX+knPEJPmmCdj0WcAE7jal1QSQorT9E+u8sY
         Dav8mptbzZ4zPRBixViL0F9Co7UnhXf1LNb+bR0z79agZyFk25tq0/G7rvlhDt+lNTTR
         FlREV6YiYWGvrauC0xs+eRjaTkHqlgIqevVcE8cwjHJHgAVKBN3ztVzeG3VjY/sUj3fK
         u6Z722vZQPYHUJAPjDKHPdZbbi+drY5JSBAGIaS6dNax4V9r11A+mchE8ojJOBHZFlQd
         zsFen/RuhO0SKS4IKQYFpDjzr3N1i8IqT1RDi/NO/tyoAGDqnauBcT4hbHVA83xgNYHA
         HshA==
X-Gm-Message-State: ALoCoQmxXXqgaOaIqBbh373xcJNmmaQ0+tfPuhMXsIwKTr+XVQ8S+byGAvkMxpKC6EN1nSGmaVQ7TWuqPjqHn2kYIf9KZXQ8FU9ZDUP/0hIXXZyd73rbeDSACIaQUlPyzjWndfDNBP72h2as2UW8dU8nPNQRVVGe8A==
X-Received: by 10.182.113.131 with SMTP id iy3mr3532640obb.64.1377801863385;
        Thu, 29 Aug 2013 11:44:23 -0700 (PDT)
X-Received: by 10.182.113.131 with SMTP id iy3mr3532635obb.64.1377801863277;
        Thu, 29 Aug 2013 11:44:23 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id qi5sm32798357obb.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:44:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <xmqqioyo4a7w.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233332>

On 08/29/2013 02:34 PM, Junio C Hamano wrote:
> Brad King <brad.king@kitware.com> writes:
> 
>> +	const char *c, *s, *oldvalue, *value[2] = {0,0};
> 
> This patch has many style issues of the same kind, lack of a SP at
> places where there should be between operators and after comma.

Okay, I can fix those.  However, for this patch I'm particularly
interested in suggestions for the proposed stdin format.  Right
now it just looks like the command line, but it feels strange to
parse "-options" from a formatted input stream that is not an
options response file.

Thanks,
-Brad
