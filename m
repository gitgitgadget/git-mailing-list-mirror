From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-merge ignore specific files
Date: Tue, 6 Nov 2007 14:46:35 +0100
Message-ID: <200711061446.36336.jnareb@gmail.com>
References: <323303.75335.qm@web55010.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bill Priest <priestwilliaml@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 14:47:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpOlc-0003yP-Ok
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 14:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbXKFNql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 08:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbXKFNql
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 08:46:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:7246 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbXKFNqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 08:46:40 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1688283nfb
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 05:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=0K18oDskPZENm8vJqEAWN1imtxSRlGb1i6z8blYuPmM=;
        b=aHX1ruQgFb+NVZA2x79lVX8JQXzk/0muvFo7iNAh7T4T/kgehBX1lWjlcChz6JpwZAVypOjT/8n1n8r73ZJgYO/lMmk6y3omXHt+zkVmFFHZ7vc6nrZT1Ehzj4jMGK1fuFw9nbi0lW1PoSAlAwrXhgiQ9g0EfXcUWhfFp1WT4cs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rzRqtW2gNqok8pv2FTV0IzeCJfwdo+CCRQhJpi8cwt9Hpp/awd2IvQWYQbc6eoBIbdQe0kBbXwIK4Fh6+BOdtZq4xNr4ltRB20/NJx8CFNsg6jha9XIinbC5aB6C3E8dFAgl3esHiwXADlsmDeB9kRuHYmZAYkW9ABF2gUMO56g=
Received: by 10.86.86.12 with SMTP id j12mr4342281fgb.1194356799502;
        Tue, 06 Nov 2007 05:46:39 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.198.250])
        by mx.google.com with ESMTPS id c24sm9202294ika.2007.11.06.05.46.37
        (version=SSLv3 cipher=OTHER);
        Tue, 06 Nov 2007 05:46:38 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <323303.75335.qm@web55010.mail.re4.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63675>

Bill Priest wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> Bill Priest wrote:
>> 
>>> All,
>>>   I have two branches that are slightly different and
>>> most changes "belong" in both.  There are a handful of
>>> files/directories that are disparate.  Is there any
>>> way in git to tell it not to merge these files? Kind
>>> of like .gitignore but for merges.
>> 
>> Most probably you can use gitattributes for that.
>> Or you can use 'our' merge strategy.
> 
> Can you point me to some docs on "our" merge strategy?

git-merge(1), section "Merge strategies":

  ours::
        This resolves any number of heads, but the result of the
        merge is always the current branch head.  It is meant to
        be used to supersede old development history of side
        branches.

>>>   In addition I'd like a way to specify to git-merge
>>> to leave all merged files unrecorded in the index.
>>> Then as I go through each file making sure that the
>>> merge "makes sense" (not that git did the right thing;
>>> but that I want the changes in both branches) that
>>> I add the change to the index.
>> 
>> You can use gitattributes for that.
> 
> I did man gitattributes and nothing jumped out at me
> as far as an attribute that I could set/unset that
> would stop a file from being merged.  What am I
> missing?

See `diff' and `merge' attributes, for example

*.nbi		-diff -merge

-- 
Jakub Narebski
Poland
