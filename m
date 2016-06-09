From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 37/38] refs: make lock generic
Date: Thu, 9 Jun 2016 17:53:31 +0200
Message-ID: <575990FB.5000908@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
 <d2a3cb56d7276c00174a08fe609d63e00755b205.1464983301.git.mhagger@alum.mit.edu>
 <xmqqlh2griq3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:53:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB2HI-00022G-NS
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 17:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbcFIPxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 11:53:49 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:63862 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751799AbcFIPxs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2016 11:53:48 -0400
X-AuditID: 12074414-62bff700000008e6-29-575990fe8d0a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 07.E4.02278.EF099575; Thu,  9 Jun 2016 11:53:34 -0400 (EDT)
Received: from [192.168.69.130] (p508EAACA.dip0.t-ipconnect.de [80.142.170.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u59FrVtg011166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 9 Jun 2016 11:53:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <xmqqlh2griq3.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsUixO6iqPtvQmS4wckf6hbzN51gtOi60s1k
	0dB7hdmie8pbRosfLT3MFjOvWlucedPI6MDusXPWXXaPZ717GD0uXlL22L90G5vH4gdeHgue
	32f3+LxJLoA9itsmKbGkLDgzPU/fLoE7Y+uXBuaC+0wVnfteMzUwTmPqYuTkkBAwkejsfsUM
	YgsJbGWU2PPcGMI+zyRxuSMFxBYWMJI4/qoVrEZEQE1iYtshli5GLqCanYwS+5bNAHOYBWYx
	SXRsvcgIUsUmoCuxqKcZbAOvgLbExPO3wOIsAioSk3e0g00SFQiROL9uKytEjaDEyZlPWEBs
	TgFriROdZ8DqmQX0JHZc/8UKYctLbH87h3kCI/8sJC2zkJTNQlK2gJF5FaNcYk5prm5uYmZO
	cWqybnFyYl5eapGuhV5uZoleakrpJkZIwIvsYDxyUu4QowAHoxIPr0ZKRLgQa2JZcWXuIUZJ
	DiYlUV7BnshwIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8pt1AOd6UxMqq1KJ8mJQ0B4uSOO+3
	xep+QgLpiSWp2ampBalFMFkZDg4lCd69/UCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJ
	pSUZ8aCYjC8GRiVIigdor/YEkL3FBYm5QFGI1lOMxhwLftxey8RxZP+9tUxCLHn5ealS4ryc
	IKUCIKUZpXlwi2Cp7hWjONDfwrxPQe7hAaZJuHmvgFYxAa1afiQcZFVJIkJKqoExolL0vfnn
	fQwmRWo9DFNdVjbY29feu2iWs/a8wNoChrlXVnfnPJsesIs1Z+W+3TNnPE1XCVq7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296896>

On 06/07/2016 07:50 PM, Junio C Hamano wrote:
> [...]

Thanks for all your comments, Junio. I've pushed a revised version of
the patch series to my GitHub fork [1] as branch "ref-store", but I'll
wait for a little longer to see if there are more comments on the list
before sending a re-roll.

Michael

[1] https://github.com/mhagger/git
