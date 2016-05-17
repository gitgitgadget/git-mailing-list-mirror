From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 0/1] CRLF-Handling: bug fix around ce_compare_data()
Date: Tue, 17 May 2016 06:08:31 +0200
Message-ID: <573A993F.8020205@web.de>
References: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
 <1463413889-12490-1-git-send-email-tboegi@web.de>
 <xmqqshxi2d80.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, tboegi@web.de
X-From: git-owner@vger.kernel.org Tue May 17 06:08:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2WJV-0002WN-5J
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 06:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbcEQEIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 00:08:53 -0400
Received: from mout.web.de ([212.227.15.14]:56058 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810AbcEQEIw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 00:08:52 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MgO9u-1bGKL140EI-00Nios; Tue, 17 May 2016 06:08:34
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <xmqqshxi2d80.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:WFDdMjqmBZ9F/X8DASyoxW060GDiPfrooETTr1CMiD3M/qcoRXs
 66oXnQTX0leP2Qxv8Kzm6BRK3j9fn0MrssjSHoNqRWEfMQ8oVpln1gamf0Pz0HKcmpMtdbf
 hJg9cksgt7XNvXUbM3GjxrMbpr+bnDIVWHQYsLnAhkWDu/xKyhqRv8TvOhMqy56xQDS5NTe
 fT1cwAms08uDHmf86ibQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4DrJ69PynoM=:TtpdRL5gzh4UVwYpIbnJpk
 HxqftzbVtkTz/EBWau7ABt1yFrjdISVaOemZA6YeCVuTO6twPyKLF2sSktFBT6BB4SJFWshmc
 NfzSiWXRVUFQb5pGijRehu0v5UL8+KQvbG38dQreY/leSusv34tob5pBz752WIm6NO/HqkMdz
 Pf7Ze6+fBVa2s0ArUTnfKqsiet4ui0q+YTY66Sji5bZJHG12RUsbX8gE7WfsOWU/8bMHX8oOQ
 8stJh1Uj5AAcwVEKrsSBJv19OqXr0Q+wBXhVE8vEd0UW47igWAGH8uP3q36+SdCKXLqb8sTaV
 2N+RrxArAxx1daIbH7vsjC/pLbuzCpqzK8LIoPef3S12kRiGReqCIu9trMCQB6CZjLK2Lilkd
 y8/s83ovexJmVfoxnBKhR9DTk4L5EozvxiNZ4ki8JVEyIxsVkdWqOUJm9EPmA3rXD6fNsNpc3
 yTzQx8WUcESjsSQN4Es20t8y9a7Rmhcj6HATwVK53YWhQ1jTC4RowIlQpyxyVt5V8DEbymZoZ
 rplEh/umanRNlm7bzJ0HSHAagXmlWlGY0E67344WPgtEOjy92fDPQWIS8/ft7hdkJiWc3SOhr
 q1P81mHOlL8yTXvEE8hPbs9buroURPXrfk7dvIGRWiOqHeFAPMm+pA3+TY8j7mW8dVTiMwTaR
 jcl2mJddpb9gMqcJfZ8op1PG0k62c5y38DXTXSmBanh0qWl9tKhXed8PNYALMFFuxY3t0zSIx
 ftS1yqN62AbedtV77P4vmptmuO9eLc3qi7+aq6v8GsPsQl52IePUMyEm3eEeNlZ9DoQvT8Bb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294850>

On 05/16/2016 06:13 PM, Junio C Hamano wrote:
> Wait a minute, please.  I only asked the reason why you did it that
> way and mentioned that the end result seemed equivalent.  "The end
> result seems equivalent" does not automatically mean "therefore you
> must avoid changing the code."
>
> If you still prefer the original code, and your preference is backed
> by a solid reasoning, don't change the code to a less preferrable
> version.  You may have to explain what you wrote in () above clearly
> in an updated log message to save other readers from asking the same
> question as I asked, though.
>
> Thanks.
> --
>
No problem.
I will re-send v4 in some time and pull out the update of t6038 into an 
own path
