From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH 4/4] diffcore-delta.c: Ignore CR in CRLF for text files
Date: Fri, 29 Jun 2007 17:14:19 +0900
Message-ID: <200706290813.l5T8DJ6w024507@mi1.bluebottle.com>
References: <1183098962312-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 10:13:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4BbZ-0002Kh-Dj
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 10:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857AbXF2INW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 04:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753380AbXF2INV
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 04:13:21 -0400
Received: from mi1.bluebottle.com ([206.188.25.14]:39553 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbXF2INU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 04:13:20 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5T8DJ6w024507
	for <git@vger.kernel.org>; Fri, 29 Jun 2007 01:13:19 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=Re0Z55pUsCivwuXy5Gr4GQfuw154x6hIBLg7bavJGEe8cwPhg2xlV2fi6oPWjM+TX
	PiOVQCuEqvq6cJzl8JnKrmNmc9GpWW1JkdZRmjNVupR+kDwPudVsECSggYxJhOp
Received: from nanako3.mail.bluebottle.com ([218.7.48.22])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l5T8D8iB010980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Jun 2007 01:13:16 -0700
In-Reply-To: <1183098962312-git-send-email-gitster@pobox.com>
X-Trusted-Delivery: <f579bd6f44b9ec3fdf4b482d501be8d1>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51162>

Quoting Junio C Hamano <gitster@pobox.com>:

> This ignores CR byte in CRLF sequence in text file when
> computing similarity of two blobs.
> ...
> +test_expect_success 'diff -M' '
> +
> +	git diff-tree -M -r --name-status HEAD^ HEAD |
> +	sed -e "s/R[0-9]*/RNUM/" >actual &&
> +	echo "RNUM	sample	elpmas" >expect &&
> +	diff -u expect actual
> +
> +'

I tried this test but it does not give R100.  The new file is unchanged except for
LF -> CRLF.  Could you explain why?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email address with REAL anti-spam protection.
http://www.bluebottle.com
