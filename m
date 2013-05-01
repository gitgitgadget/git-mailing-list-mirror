From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] help: add help_unknown_ref
Date: Wed, 01 May 2013 22:23:57 +0200
Message-ID: <518179DD.8050009@kdbg.org>
References: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com> <1367407327-5216-2-git-send-email-vikrant.varma94@gmail.com> <CALkWK0nMMi-nmAMUGXCaJDCV29G3dOzYTosKqSw+bFzc0osiaA@mail.gmail.com> <51817319.6060201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Vikrant Varma <vikrant.varma94@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 22:24:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXdZY-00060H-Hm
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 22:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186Ab3EAUYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 16:24:04 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:14361 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755701Ab3EAUYC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 16:24:02 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id CC08C13005A;
	Wed,  1 May 2013 22:23:58 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E064E19F5CB;
	Wed,  1 May 2013 22:23:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <51817319.6060201@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223136>

Am 01.05.2013 21:55, schrieb Vikrant Varma:
> On 01-05-2013 17:53, Ramkumar Ramachandra wrote:
>> Vikrant Varma wrote:
>>> +void help_unknown_ref(const char* ref) {
>>> +        int i;
>>> +        struct similar_ref_cb ref_cb;
>>> +        ref_cb.similar_refs = (struct string_list)STRING_LIST_INIT_NODUP;
>>
>> Why are you casting STRING_LIST_INIT_NODUP?
>>
>>> +        ref_cb.base_ref = ref;
> 
> 
> ref_cb.similar_refs has already been defined. The compiler won't let me
> assign to it unless I cast first. However, I think compound literals are
> a C99/gcc feature. Is this better?
> 
>     struct similar_ref_cb ref_cb = {ref, STRING_LIST_INIT_NODUP};

No. There are compilers that can initialize a struct only with constant
data, but ref is not a constant.

-- Hannes
