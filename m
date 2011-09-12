From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 0/7] Improved infrastructure for refname normalization
Date: Mon, 12 Sep 2011 17:11:30 +0200
Message-ID: <4E6E2122.8000201@alum.mit.edu>
References: <1315637443-14012-1-git-send-email-mhagger@alum.mit.edu> <7vehzmbd0o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 12 17:12:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R38B8-0007Ts-L8
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 17:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757857Ab1ILPME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 11:12:04 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:44757 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757475Ab1ILPMD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 11:12:03 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8CFBVGY003818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 12 Sep 2011 17:11:31 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <7vehzmbd0o.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181217>

On 09/12/2011 06:28 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> There were a few minor things that looked worth mentioning while
> reviewing, though.
> 
>  - (style) You seem to be fond of pre-increment a lot, but in general our
>    codebase prefers post-increment especially when the end result does not
>    make any difference, e.g.
> 
> 	for (i = 1; ...; ++i) {
>         	...

OK, changed.

>  - (series structure) It might make the series progress easier to follow
>    if you introduced check_ref_format_unsafe() in the same commit where
>    you change check_ref_format() to take flags parameter.

OK.  I'll take the opportunity to rename the functions to
check_refname_format*(), to make it more obvious that they only concern
themselves with the refnames and not the references themselves.

I discovered a bug in my code for handling refnames without
normalization; I will also fix that in v3.

OTOH I am again having serious doubts that trying to support
unnormalized refnames is a good idea.  I will write more when I have
time to argue my case.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
