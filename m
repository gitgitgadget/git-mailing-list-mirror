From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git-p4 question
Date: Fri, 10 Aug 2007 18:25:46 +0200
Message-ID: <81b0412b0708100925g45b5d3e7j19141374f7f57458@mail.gmail.com>
References: <69b0c0350708091953wdc9c22vd2b17b1edd1c5cd2@mail.gmail.com>
	 <81b0412b0708100106m3123a504p16309b6e06cd9609@mail.gmail.com>
	 <81b0412b0708100110w6ff90215gd5c367fb65e2ae21@mail.gmail.com>
	 <69b0c0350708100817u58f74acbyed5c19830cb92ed7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Govind Salinas" <govindsalinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 18:26:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJXJZ-0003xl-To
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 18:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932772AbXHJQZu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 12:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765624AbXHJQZu
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 12:25:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:54939 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765475AbXHJQZs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 12:25:48 -0400
Received: by nf-out-0910.google.com with SMTP id g13so278566nfb
        for <git@vger.kernel.org>; Fri, 10 Aug 2007 09:25:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iPSFwg4bA9mOYDSj6U/4vki52ddYp/yIww2q5Y5SBWjEU+ocABfk8YmTxX61S9jSSS2oZTggZkEtGGaCwIxCymFde+m3GhujQ6LkUejE+6NNrNwra84CjI8bQRmRDi2som/HZcSE5sm+RUREXCxuJz1NzzfnO1/8LQI3Yi3wX1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ISqVHT0KKiCYc3Hfj2NeEF4qcYIbtsUSMc3RivAzAfrQ22MjVLLUE6kBsTFz5GNbIE+o31KgOQVAJTV10vX09MAz7sgBuG92rPG/MmN2tzFuQX2dNLHvJuSfzWZV6CVQ7HVel9Cc6T4Vkj3MmHrcrDGYEZrAAgWch3JRY2LaMFM=
Received: by 10.78.193.5 with SMTP id q5mr1424757huf.1186763146636;
        Fri, 10 Aug 2007 09:25:46 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Fri, 10 Aug 2007 09:25:46 -0700 (PDT)
In-Reply-To: <69b0c0350708100817u58f74acbyed5c19830cb92ed7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55552>

On 8/10/07, Govind Salinas <govindsalinas@gmail.com> wrote:
> I am having some problems running the script.  It seems that (line
> 1425) $f->{sha1} is uninitialized and causing the import to fail (the
> perforce path is missing the leading "//" I don't know if that is
> intentional).

the line in question deals with local pathnames, so it is expected.
What i don't understand is how did you manage to have the file
without sha1... Could you put a

 print "$tmpfile\n";

after line 1400?
 open($ft,'>',$tmpfile) or die "$tmpfile: $!\n";

and run git-p4-import -v -v -v?
Than it possible to compare lists of the files which is acquired
through p4 change with the list of files output by p4 print.

What perforce client version do you have, BTW?

>  Let me know if you want to continue this off list since
> it isn't really a part of git.

It isn't. We can continue privately
