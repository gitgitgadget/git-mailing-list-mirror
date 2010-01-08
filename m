From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: Trouble with 'make prefix=/usr info'
Date: Fri, 8 Jan 2010 15:14:31 -0600
Message-ID: <F6C72DBA-4C11-4F6D-A562-7C45D85B9746@pobox.com>
References: <loom.20091222T164442-704@post.gmane.org>
 <4B30ECA1.2040508@drmicha.warpmail.net>
 <d4133e470912220814h465175bfr8fd10942898096a1@mail.gmail.com>
 <4B310054.4060900@drmicha.warpmail.net>
 <d4133e471001060432v38a3f910qb27b9e77f4c1aa8b@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Craig Moore <craigtmoore@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 22:15:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTMBJ-0003Kk-Hl
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 22:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064Ab0AHVP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 16:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754050Ab0AHVP2
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 16:15:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46384 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab0AHVP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 16:15:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C5D888FD20;
	Fri,  8 Jan 2010 16:15:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=in-reply-to
	:references:mime-version:content-type:message-id:cc
	:content-transfer-encoding:from:subject:date:to; s=sasl; bh=x2H1
	RE5HxM0avljkv+v8HXkERrk=; b=cBQ+9L0dGOAfmQvtq8mxP9W5+2esd17k+XbP
	leBB1varF5Rrx4g42/Ec2QQSdRHon0FzPHWjOw9cn/Svzi5rS/xr48AdJGv7Ps9J
	r6BejOloRSl+Jb36YefAPAcFUr9QT4uZH/r7bkqm3CKvdVl2pEXJZ888mOVqH7NK
	GPcGHx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=in-reply-to
	:references:mime-version:content-type:message-id:cc
	:content-transfer-encoding:from:subject:date:to; q=dns; s=sasl; b=
	awe/8GhvVSsz0wxCsH2yDTuO5+ye65IBsOL6+2tmK77ncxOOx7P/iZ3sNmkj0xHt
	RAOZPo9dO/4s+RLT0KwlvIuAFznGYFJa9FnTsXAO6EAcW688gBJrEMpxyJdVI0Yj
	znuhbHj3tONiveSJfB4PqH4SeEimTCxUNxtifAwSr/Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A15468FD1F;
	Fri,  8 Jan 2010 16:15:23 -0500 (EST)
Received: from [192.168.1.241] (unknown [75.53.33.9]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F5248FD1E; Fri,  8 Jan
 2010 16:15:20 -0500 (EST)
In-Reply-To: <d4133e471001060432v38a3f910qb27b9e77f4c1aa8b@mail.gmail.com>
X-Mailer: Apple Mail (2.753.1)
X-Pobox-Relay-ID: EF389DB8-FC9A-11DE-87E8-9D59EE7EF46B-07245699!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136478>

On 2010 Jan 6, at 06:32, Craig Moore wrote:
> I've isolated the problem, and its coming from this command:
>
> ================================
> $ docbook2x-texi user-manual.xml --encoding=UTF-8 --to-stdout
>> user-manual.texi++
> Usage: jw [<options>] <sgml_file>
> where <options> are:
>   -f|--frontend <frontend>:      Specify the frontend (source format)
>                                  (default is docbook)
>   -b|--backend <backend>:        Specify the backend (destination  
> format)
>                                  (default is html)
>   -c|--cat <file>:               Specify an extra SGML open catalog
>   -n|--nostd:                    Do not use the standard SGML open  
> catalogs
>   -d|--dsl <file>|default|none:  Specify an alternate style sheet
>                                  (default is to use the default  
> stylesheet)
>   -l|--dcl <file>:               Specify an alternate SGML declaration
>                                  (usual ones like xml.dcl get detected
> automatically)
>   -s|--sgmlbase <path>:          Change base directory for SGML  
> distribution
>                                  (usually /usr/share/sgml)
>   -p|--parser <program>:         Specify the parser if several are  
> installed
>                                   (jade or openjade)
>   -o|--output <directory>:       Set output directory
>   -u|--nochunks:                 Output only one big file
>                                  (overrides the stylesheet settings)
>   -i|--include <section>:        Specify a SGML marked section to  
> include
>                                  (should be marked as "ignore" in  
> the SGML text)
>   -w|--warning <warning_type>|list: Control warnings or display the
> allowed warning types
>   -e|--errors <error_type>|list: Control errors or display the allowed
> error types
>   -h|--help:                     Print this help message and exit
>   -V <variable[=value]>:         Set a variable
>   -v|--version:                  Print the version and exit
>
> $ docbook2x-texi --version
> DocBook-utils version 0.6.14 (jw version 1.1)
> ================================
>
> As you can see, I'm using DocBook-utils version 0.6.14 (jw version
> 1.1), and it doesn't list '--encoding=UTF-8 --to-stdout' in its
> options list. I'm guessing I've got the wrong version or type
> installed? Is there another which I should be using?
>
> Thanks for your help,
> Craig
>

I have previously used docbook2texi from docbook2X 0.8.8 by setting  
DOCBOOK2X_TEXI for 'make info'.

     <http://docbook2x.sourceforge.net/>

It needed a non-released patch to understand the combination of "--to- 
stdout" and "--encoding=", though:

     <http://docbook2x.cvs.sourceforge.net/viewvc/docbook2x/docbook2X/ 
perl/db2x_texixml.pl?r1=1.49&r2=1.50>

Alternatively, it is possible to work-around the failure of --stdout  
with a wrapper script, but the patch is easy enough to apply.

-- 
Chris
