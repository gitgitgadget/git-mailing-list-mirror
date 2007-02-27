From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Replacement for cvs2cl, for generating ChangeLog
Date: Tue, 27 Feb 2007 12:57:36 +0000
Message-ID: <200702271257.37437.andyparkins@gmail.com>
References: <877iu3q13r.fsf@latte.josefsson.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Simon Josefsson <simon@josefsson.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 13:57:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM1tr-0002dM-6O
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 13:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030621AbXB0M5o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 07:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030622AbXB0M5o
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 07:57:44 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:33080 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030621AbXB0M5n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 07:57:43 -0500
Received: by nf-out-0910.google.com with SMTP id o25so169827nfa
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 04:57:42 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=p8QOMwWNoVNdX8oYJ9wACevE7JV2taxMTUu1tT2n6tWUkusLP3yxwhPYZzH8cEtgq3osSwlLZtj8M1YadqiEVISasP2nv4YBnjAh1x4TevTOEvmg384oszHpNC0reNjEwn6rS8j3VWqacbZhgpzAh3rpzgFG/yWROh41TTCcimY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KAHl+hCqCWLbaRoGKF5L57MUWkuAYKB2OglDgRLjMxCr7NnBTWRLt8HNBNRU/CpMVEYkUrJULlri12lKCrEgPQaepf3dtquNZKdxpG2rVStCC3cc9khOzPF+uy+UgNix9VIvEu6OL8jLE5C26e/x3X2T4LyZB6Oe2SsoPFfpDHI=
Received: by 10.48.216.7 with SMTP id o7mr1042139nfg.1172581062400;
        Tue, 27 Feb 2007 04:57:42 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id y23sm1779838nfb.2007.02.27.04.57.39;
        Tue, 27 Feb 2007 04:57:39 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <877iu3q13r.fsf@latte.josefsson.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40728>

On Tuesday 2007 February 27 11:41, Simon Josefsson wrote:

> * How do I discard all locally modified or added files?  'cvs upd -C'
>   does some of that, but I've been using a tool 'cvsco' which quickly
>   restore a CVS checkout into a pristine state.

If I understand you correctly ("locally" has slightly ambiguous meaning when 
the repository is local as well), the following would restore a working 
directory to be identical to the current HEAD.

 git checkout -f HEAD

The "-f" means force - i.e. don't worry about discarding local changes :-)

> * Is there a tool that produce ChangeLog files in the GNU format,
>   based on the git logs?  Similar to the 'cvs2cl' tool.  The output
>   should look like:

Not that I know of, but git has some lovely log generation tools, so I'm sure 
it could be easily done with a snippet of perl - or perhaps a change to git's 
own log generator to support

 git-rev-list --pretty=gnucl

would be more appropriate.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
