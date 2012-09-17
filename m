From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] Integrate wildmatch to git
Date: Sun, 16 Sep 2012 22:54:57 -0700
Message-ID: <7vd31lw5vy.fsf@alter.siamese.dyndns.org>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
 <1347809265-2457-1-git-send-email-pclouds@gmail.com>
 <1347809265-2457-5-git-send-email-pclouds@gmail.com>
 <7vpq5lw6z8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 07:55:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDUIZ-0007B3-HS
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 07:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153Ab2IQFzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 01:55:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48066 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473Ab2IQFzA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 01:55:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E56006509;
	Mon, 17 Sep 2012 01:54:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pK0KmU8Wsb7fNZvhG0I9vlDsClo=; b=iu+Ol7
	KoEIV+tAHOciQ4bQ0dEgVTKjgE/xN690aDx84TvL0GwzAnFzqGdbSKRaxkhewKVI
	x4Ad+8U2HV3UANsyNN4vdQqMMK4gPmNIC0hIZGxy+1U85UJsp3fq7qy8EcS/+P0U
	pp9V6+xsEkZBXVC5IO6J2pByMUf75hrKu1ccA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ChRRTTIJYePOnJje9uftQCUzG0rZdDXT
	7vcroCevZCQxNyLrtVFTAmYz/etn9w3R7MgAiBK/w/jTUe+TmSr9pknuwbrM5sxE
	FOr/BqO3bAOpe/tvlEiq3mGdkfbvxO0dc2hBu+dI6El3RotHvAZvGsdxsqXM3g6P
	71V8yKEjzak=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3CFA6508;
	Mon, 17 Sep 2012 01:54:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C9086507; Mon, 17 Sep 2012
 01:54:59 -0400 (EDT)
In-Reply-To: <7vpq5lw6z8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 16 Sep 2012 22:31:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36FDCEA0-008C-11E2-B8BC-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205652>

Junio C Hamano <gitster@pobox.com> writes:

> Am I missing some includes?
>
> test-wildmatch.c:50: error: array type has incomplete element type
> test-wildmatch.c:52: error: 'POPT_ARG_NONE' undeclared here (not in a function)
> test-wildmatch.c:53: error: 'POPT_ARG_STRING' undeclared here (not in a function)
> test-wildmatch.c:54: error: 'POPT_ARG_INT' undeclared here (not in a function)
> test-wildmatch.c: In function 'main':
> test-wildmatch.c:122: error: 'poptContext' undeclared (first use in this function)
> test-wildmatch.c:122: error: (Each undeclared identifier is reported only once
> test-wildmatch.c:122: error: for each function it appears in.)
> test-wildmatch.c:122: error: expected ';' before 'pc'
> cc1: warnings being treated as errors
> test-wildmatch.c:125: error: implicit declaration of function 'poptGetNextOpt'
> test-wildmatch.c:125: error: 'pc' undeclared (first use in this function)
> test-wildmatch.c:128: error: implicit declaration of function 'poptGetOptArg'
> test-wildmatch.c:139: error: implicit declaration of function 'poptBadOption'
> test-wildmatch.c:139: error: 'POPT_BADOPTION_NOALIAS' undeclared (first use in this function)
> test-wildmatch.c:140: error: implicit declaration of function 'poptStrerror'
> test-wildmatch.c:148: error: implicit declaration of function 'poptGetArgs'

Yeah, popt.h it is.  It is a bit distasteful that we have a build
dependency only to build test-* helper on something that we do not
even have runtime dependency on.
