From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] do_one_ref(): save and restore value of current_ref
Date: Wed, 24 Jul 2013 07:35:24 -0700
Message-ID: <51EFE62C.4070003@alum.mit.edu>
References: <CAPWNY8Ua=3t4jeDvkj3Aw2Ouvv+0r1kWrET5GNq9uS8PasGudQ@mail.gmail.com> <1373901857-28431-1-git-send-email-mhagger@alum.mit.edu> <7voba04ir8.fsf@alter.siamese.dyndns.org> <51E97ACA.40300@alum.mit.edu> <7vppueuyw4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?TWFudGFzIE1pa3VsxJduYXM=?= <grawity@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 16:35:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V20AQ-0001b5-P7
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 16:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410Ab3GXOfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 10:35:33 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:62963 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754122Ab3GXOf2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jul 2013 10:35:28 -0400
X-AuditID: 12074414-b7f626d0000001f1-4c-51efe62f83fa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id FF.86.00497.F26EFE15; Wed, 24 Jul 2013 10:35:27 -0400 (EDT)
Received: from [192.168.0.17] (24-182-26-32.dhcp.slto.ca.charter.com [24.182.26.32])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r6OEZO0K026588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 24 Jul 2013 10:35:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7vppueuyw4.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqKv/7H2gwdH9BhZdV7qZLBp6rzBb
	vGw/wOzA7LFz1l12j4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M6Y1PqLqWAZe8XDe7tYGhgf
	s3YxcnBICJhILF6Q38XICWSKSVy4t56ti5GLQ0jgMqPE5U9XoJwrTBLr1l5hAqniFdCWmNw2
	lw3EZhFQldj3u4UZxGYT0JVY1NPMBDJUVCBM4spvVYhyQYmTM5+wgNgiAmoSE9sOgdnMAjES
	R86fARspLOAh8fHrThaIXb8ZJba1/wGbySlgJrH+dTs7yExmAXWJ9fOEIHrlJba/ncM8gVFg
	FpIVsxCqZiGpWsDIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10IvN7NELzWldBMjJGxFdjAe
	OSl3iFGAg1GJh7dg1rtAIdbEsuLK3EOMkhxMSqK88Y/eBwrxJeWnVGYkFmfEF5XmpBYfYpTg
	YFYS4X37ACjHm5JYWZValA+TkuZgURLn/bZY3U9IID2xJDU7NbUgtQgmK8PBoSTBe/oJUKNg
	UWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KErji4FxCpLiAdp7G6Sdt7ggMRcoCtF6
	ilGX48CPLe8ZhVjy8vNSpcR5X4EUCYAUZZTmwa2AJalXjOJAHwvz/gap4gEmOLhJr4CWMAEt
	cW0AW1KSiJCSamCcf3yBoAir77PHJSkHEtfYhCjt5r7t5tJYJWS9KHui3IsbjLtv+l+uXd/4
	QeWQ+RQxiQnXb/0rvXf62YJnS8pm7lxz2/2caqd2nAHzE/VgliOpd4/FcLmezmtd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231100>

On 07/19/2013 12:34 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I sent the patch shortly before leaving for a trip so I didn't have time
>> to make it as complete as I would have liked.  But given that the
>> problem was already in master, and the fix is pretty simple, I wanted to
>> send the fix right away.  When I have some time I can fix it up better,
> 
> That is very much appreciated.  How would you describe this fix in a
> two-to-three line paragraph in Release Notes?

How about:

    Fix a NULL-pointer dereference during nested iterations over
    references (for example, when replace references are being used).

Unfortunately I don't have time now to audit the code more carefully to
figure out what other circumstances might have triggered the bug.

Hope that helps,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
