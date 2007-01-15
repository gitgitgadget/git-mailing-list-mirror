From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Mon, 15 Jan 2007 11:32:00 +0100
Message-ID: <200701151132.00971.jnareb@gmail.com>
References: <200701150144.56793.jnareb@gmail.com> <200701151003.44498.jnareb@gmail.com> <20070115095613.GA4037@localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:33:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VVr-0000SN-Ig
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:20:51 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9c-0003eK-4q
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbXAOKbk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 05:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbXAOKbk
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 05:31:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:42034 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185AbXAOKbk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 05:31:40 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1311178uga
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 02:31:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=s5fOn4KhBSop4q+mEy/IJuBqGVbA7e6EYL9Xwy/183uEvBmrE3EEwpSU6xCbSc/d9kalFpBdzQIv5n2l9lg65aoepQHlAyw2r+SP6E3j43VKtRlfCRlfP4iUn1zuTD8CjaDXQeX0btPYLMKyvlRTDlvvXfalvl6JS0YqfXOKUAY=
Received: by 10.67.97.18 with SMTP id z18mr5169237ugl.1168857098310;
        Mon, 15 Jan 2007 02:31:38 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id 20sm5407397uga.2007.01.15.02.31.37;
        Mon, 15 Jan 2007 02:31:37 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
User-Agent: KMail/1.9.3
In-Reply-To: <20070115095613.GA4037@localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36838>

Eric Wong wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> Eric Wong wrote:
>>> Jakub Narebski <jnareb@gmail.com> wrote:
>>>> To make gitweb faster I thought about adding to it, or to Git.pm,
>>>> simple nonvalidation config file reader. Nonvalidating means that
>>>> it would accept some input which git-repo-config considers invalid.
>>> 
>>> How about something like git-for-each-ref that dumps the entire output
>>> of a config file into an eval()-able string?  That way we don't have to
>>> deal with corner-cases and subtle differences between C and Perl
>>> implementations.
>> 
>> The idea is (at least for gitweb) to avoid cost of fork. And I think
>> if the format gets documented properly, there should be no differences
>> in config file parsing.
> 
> If the Perl output is redirected to a file (say .git/config.perl) and
> only regenerated when .git/config changes, `do(".git/config.perl")' will
> likely be faster since all the parsing will be done by Perl itself.

Would you write "git repo-config --perl", then? ;-)

Besides, I'd rather avoid the need for /tmp/gitweb, and I think usually
gitweb do not have (and should not have) write access to repository.

-- 
Jakub Narebski
Poland
