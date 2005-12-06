From: Andreas Ericsson <ae@op5.se>
Subject: Re: type_size_sort
Date: Tue, 06 Dec 2005 22:38:39 +0100
Message-ID: <439604DF.5010603@op5.se>
References: <118833cc0512061319l3726fdfbs8286e7b3f5ab0713@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Dec 06 22:41:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjkWK-0003w4-63
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 22:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbVLFVil (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 16:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbVLFVil
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 16:38:41 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:20189 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932641AbVLFVik
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 16:38:40 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 982CC6BD07
	for <git@vger.kernel.org>; Tue,  6 Dec 2005 22:38:39 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: GIT Mailing List <git@vger.kernel.org>
In-Reply-To: <118833cc0512061319l3726fdfbs8286e7b3f5ab0713@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13293>

Morten Welinder wrote:
> static int type_size_sort(const struct object_entry *a, const struct
> object_entry *b)
> {
> ...
>   return a < b ? -1 : (a > b);
> }
> 
> This does not look valid.  the standard says you must not depend on the
> location:
> 
> 
>        [#4] When  the  same  objects  (consisting  of  size  bytes,
>        irrespective  of  their  current positions in the array) are
>        passed more  than  once  to  the  comparison  function,  the
>        results  shall be consistent with one another.  That is, for
>        qsort they shall define a total ordering on the  array,  and
>        for  bsearch  the  same object shall always compare the same
>        way with the key.
> 

It's perfectly correct. If the same list was to be passed to 
create_sorted_list() twice it will come out exactly the same the second 
time as it did the first. The only thing to remark on is that the return 
above could be written as below instead:

	return a - b;

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
