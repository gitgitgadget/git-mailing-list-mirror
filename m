From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/4 v4] minor gitweb modifications
Date: Sun, 2 Jan 2011 11:53:14 -0600
Message-ID: <20110102175314.GB13358@burratino>
References: <1293744031-17790-1-git-send-email-sylvain@abstraction.fr>
 <20110101104121.GA12734@burratino>
 <1293985641.15404.11.camel@kheops>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Sun Jan 02 18:53:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZS7Y-0003q7-Rs
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 18:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162Ab1ABRxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 12:53:24 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63612 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913Ab1ABRxX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 12:53:23 -0500
Received: by gxk9 with SMTP id 9so2405513gxk.19
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 09:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aSkp1WSxIiZKvzt+L7OQ564Uj+zAU9fFhNAQJAgD+OQ=;
        b=hm5SChwFbOey1V7zq3FZ1S+STn8nQX+ltJdRrJjtI+RbMalhJN8+XufeysR0A5CLxg
         JSfDbUy2B+BTAxkxsZnOf3+v7tmjESeTV6HNsbq62hCr3jQGWyeG/4Z3x8iJYvJa3uCX
         yFjxPM3dMzukwqknNUd59O0i3vYmYzPRB+6CA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ukl4gG9GWm7gzXc8JTDNdrTErYftOdBKNrE2nw4xvz/CKzlPztyyY2bpLMcRv/yGwE
         qZZ+aAkEPHGheVatozwSyIOGaTJKroRn1Pw0LBHYgXsC1Z4fq1/k7r5yRcMFeis6odZi
         pNT0kLp8EPPn36AQ2mA1xpMd0NhxYzre6yWm4=
Received: by 10.236.95.141 with SMTP id p13mr3693215yhf.98.1293990801819;
        Sun, 02 Jan 2011 09:53:21 -0800 (PST)
Received: from burratino ([69.209.72.219])
        by mx.google.com with ESMTPS id 8sm2250047yhl.44.2011.01.02.09.53.19
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 09:53:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1293985641.15404.11.camel@kheops>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164422>

Sylvain Rabot wrote:
> On Sat, 2011-01-01 at 04:41 -0600, Jonathan Nieder wrote:

>> 	<tr id="metadata_owner">
>> 		<td class="metadata_tag">owner</td>
>> 		<td>UNKNOWN</td>
>> 	</tr>
>> 	...
>>
>> The idea was that the rows are already labelled for use by css, so to
>> make this stylable all we need to do is use a class for the first
>> column.  This way if some site operator wants the first column
>> *always* be bold then that is easy to do.
>
> So your idea is to use the same class for all this kind of tables' first
> column ?

Yes, or more generally to find a way to make the first column always
stylable.  Actually

 tr#metadata_desc > td:first-child {
	...
 }

already does the trick (or

 table.projects_list > tr > td:first-child {
	...
 }

for style that should apply to all first columns) but I haven't
checked how widely supported first-child is.
