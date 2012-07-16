From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Mon, 16 Jul 2012 18:48:12 +0200
Message-ID: <500445CC.2020404@alum.mit.edu>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu> <vpqhat7wujb.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 16 18:55:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqoZv-0002q3-QZ
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 18:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064Ab2GPQzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 12:55:18 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:59212 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751808Ab2GPQzQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2012 12:55:16 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2012 12:55:16 EDT
X-AuditID: 12074414-b7f846d0000008b8-4a-500445ce54cb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id CA.5B.02232.EC544005; Mon, 16 Jul 2012 12:48:14 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q6GGmC9n030486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 16 Jul 2012 12:48:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <vpqhat7wujb.fsf@bauges.imag.fr>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsUixO6iqHvOlSXA4PMadovjT6+zWHRd6Way
	uPR5PavF6sd32B1YPHbOusvuMfHLcVaPz5vkApijuG2SEkvKgjPT8/TtErgzdjw4wlbwhbti
	55QpjA2MFzi7GDk5JARMJC517WCBsMUkLtxbz9bFyMUhJHCZUWLK2scsEM5xJomjZ/6yglTx
	CmhLbPrWxg5iswioSryb8hPMZhPQlVjU08zUxcjBISoQJjF9JztEuaDEyZlPWEDCIgL6Ej8n
	s4GEmQVyJVrvXGECsYUFnCVWztkB1ikkkCJx7VgESJgTaODpKROYQcLMAtYS33YXQXTKS2x/
	O4d5AqPALCTzZyFUzUJStYCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRroVebmaJXmpK6SZG
	SPiK7GA8clLuEKMAB6MSD+8NG5YAIdbEsuLK3EOMkhxMSqK8Sx2BQnxJ+SmVGYnFGfFFpTmp
	xYcYJTiYlUR4G+2BcrwpiZVVqUX5MClpDhYlcd5vi9X9hATSE0tSs1NTC1KLYLIyHBxKErz6
	wDgVEixKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFaHwxMEZBUjxAe91B2nmLCxJz
	gaIQracYLTmefLl1i5Fjwa57QLL7C5AUYsnLz0uVEue1B2kQAGnIKM2DWwdLYq8YxYG+F+Y1
	AqniASZAuKmvgBYyAS20LGECWViSiJCSamCcLe6ve1zPZ9LuDanS0YtNWGeE3WHdlOd/MKRw
	i7zCY5vHd+N2vPhREXOY1afW7MRW+3NeE3ec5vkgu5yp2z59dfin5uaeXN9L87bN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201530>

On 07/16/2012 06:16 PM, Matthieu Moy wrote:
> mhagger@alum.mit.edu writes:
>
>> From: Michael Haggerty <mhagger@alum.mit.edu>
>>
>> Add a new Python script, contrib/hooks/post-receive-multimail.py, that
>> can be used to send notification emails describing pushes into a git
>> repository.  This script is derived from
>> contrib/hooks/post-receive-mail, but has many differences, including:
>>
>> * One email per commit [1].
>
> It's cool to have it, but it would be nice to allow the "one email per
> push" mode too. I have co-workers who already complain about the number
> of emails sent by the post-receive-mail script. I can't imagine their
> reaction if I set up a one-email-per-commit hook ;-).

It's already supported:

     git config hooks.announcelist \
         "nosy@example.com, overwhelmed@example.com, phb@example.com"
     git config hooks.refchangelist \
         "nosy@example.com, overwhelmed@example.com"
     git config hooks.commitlist "nosy@example.com"

Granted, the ReferenceChange emails currently cannot be configured to 
include diffs, as can those of the old post-receive-email script, and 
the text alludes to upcoming one-email-per-commit emails.  But since it 
looks like the new script might be put forward as a replacement for the 
old one, I will obviously put more work into supporting as much of the 
old functionality as possible.

Thanks for the feedback!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
