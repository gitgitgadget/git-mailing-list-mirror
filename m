From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 34/38] refs: add method for delete_refs
Date: Thu, 9 Jun 2016 17:14:41 +0200
Message-ID: <575987E1.9060200@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
 <17da5760ac671c98811cc5a3ec46a61f8261d8d9.1464983301.git.mhagger@alum.mit.edu>
 <xmqqporsrj21.fsf@gitster.mtv.corp.google.com>
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
X-From: git-owner@vger.kernel.org Thu Jun 09 17:18:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB1fX-0002r5-Gh
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 17:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbcFIPOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 11:14:47 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:52126 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752014AbcFIPOq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2016 11:14:46 -0400
X-AuditID: 12074411-e3fff70000000955-1e-575987e4e6fa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id C2.94.02389.4E789575; Thu,  9 Jun 2016 11:14:44 -0400 (EDT)
Received: from [192.168.69.130] (p508EAACA.dip0.t-ipconnect.de [80.142.170.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u59FEfdu008874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 9 Jun 2016 11:14:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <xmqqporsrj21.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsUixO6iqPukPTLc4P9ac4v5m04wWnRd6Way
	aOi9wmzRPeUto8WPlh5mi5lXrS3OvGlkdGD32DnrLrvHs949jB4XLyl77F+6jc1j8QMvjwXP
	77N7fN4kF8AexW2TlFhSFpyZnqdvl8CdsaZtGlvBat6KGbMlGhifcHUxcnJICJhItL1/zdjF
	yMUhJLCVUaLv3Tk2COc8k8TSaRsZQaqEBawlHixewgJiiwioSUxsO8QCUbSTUeLNpyVgDrPA
	LCaJjq0XwTrYBHQlFvU0M4HYvALaEqtXNLKD2CwCKhK/p09nBrFFBUIkzq/bygpRIyhxcuYT
	sA2cQNuWHWgCq2EW0JPYcf0XK4QtL7H97RzmCYz8s5C0zEJSNgtJ2QJG5lWMcok5pbm6uYmZ
	OcWpybrFyYl5ealFuqZ6uZkleqkppZsYISEvuINxxkm5Q4wCHIxKPLwaKRHhQqyJZcWVuYcY
	JTmYlER5ZYARI8SXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEt64NKMebklhZlVqUD5OS5mBREufl
	W6LuJySQnliSmp2aWpBaBJOV4eBQkuCdBNIoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRY
	WpIRD4rK+GJgXIKkeID2/gfbW1yQmAsUhWg9xajLcWT/vbVMQix5+XmpUuK8XiBFAiBFGaV5
	cCtgCe4VozjQx8K8ciDv8QCTI9ykV0BLmICWLD8SDrKkJBEhJdXAGM7mV+Yf1MzTbFGtkMYp
	c+7lx6Qo43L/cu+m3wxt6We5chcKPlZondN97oaT89HOrS6GUS3mEfmiRd+nvl7F 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296893>

On 06/07/2016 07:43 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> From: David Turner <dturner@twopensource.com>
>>
>> In the file-based backend, delete_refs has some special optimization
>> to deal with packed refs.  In other backends, we might be able to make
>> ref deletion faster by putting all deletions into a single
>> transaction.  So we need a special backend function for this.
>>
>> Signed-off-by: David Turner <dturner@twopensource.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>> I think that we could get away without this method if we make
>> ref_transactions a bit smarter (for example, by supporting best-effort
>> updates that can fail without causing the entire transaction to be
>> aborted). But that would be a significant detour, so let's leave it
>> here for now.
> 
> Hmm, I actually was wondering why 'pack without' was there while
> reading 24/38; IIUC, that is one of the "special optimization" that
> is very much tied to the files backend, and it may make sense to
> hide it behind delete_refs() as its implementation detail.
> 
> Which is exactly what this step is about, so I am happy ;-)

In the future I think this optimization will be even better hidden,
namely within the transaction_commit method of a packed_refs_store class :-)

> Unlike other changes like the ones that did read_raw_ref(),
> verify_refname_available(), etc., the title does not follow the
> pattern "refs: make X() virtual", even though as far as I can see
> the intent is the same as others.  Perhaps a minor retitle is in
> order?

OK.

Michael
