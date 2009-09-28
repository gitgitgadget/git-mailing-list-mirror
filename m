From: Christian Himpel <chressie@googlemail.com>
Subject: Re: Getting a list of last commit's files and piping them..
Date: Mon, 28 Sep 2009 16:13:12 +0200
Message-ID: <20090928141312.GA4564@mrslave>
References: <4f302eef91c72cd4583e0aa4707ab4c0@ahmednuaman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ahmed Nuaman, Freelance Designer and Developer" 
	<ahmed@ahmednuaman.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 16:13:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsGyf-0006kJ-BZ
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 16:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbZI1ONO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 10:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbZI1ONO
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 10:13:14 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:37709 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbZI1ONN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 10:13:13 -0400
Received: by bwz6 with SMTP id 6so1283749bwz.37
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2RiNBG3Lg6bhFTaULyvFfrU5OUKiX2qQwZ5cUICmUQU=;
        b=FiqC8aKKFyVprK8hH+U0VjqsGEoXSzQo0ugK3qIZTArfLDj0Oi6n5IGYdhUK4ITHg1
         lWVrajbiZX10Jhyhv78XbEvHWvodEpzxY7KGXhzYkH4ErVNB9vtD8t/Aj2YpI7U1ijtF
         tH3oHs4QJRM1kKtCR/idqWXp9T+zn5JeyxU9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vBjWToGKr2El9fMahD+kb5LbAS+S2rJcbGWVq8Mqv9725FCDc+Xh1TWFJioqyu6Y6l
         9Jkzh7uxvYWJvTkF/6uzef9E7CQFpi88fNjTryHP5g9Cu2RQITlflUzIwFljhNPRwDTm
         suU4Xxg7dkq/wz8QIvYC0ma7hvsq0luhSnZKk=
Received: by 10.204.154.213 with SMTP id p21mr2842640bkw.163.1254147196676;
        Mon, 28 Sep 2009 07:13:16 -0700 (PDT)
Received: from mrslave (HSI-KBW-078-043-091-043.hsi4.kabel-badenwuerttemberg.de [78.43.91.43])
        by mx.google.com with ESMTPS id z10sm4829932fka.49.2009.09.28.07.13.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Sep 2009 07:13:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4f302eef91c72cd4583e0aa4707ab4c0@ahmednuaman.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129265>

On Mon, Sep 28, 2009 at 02:02:52PM +0100, Ahmed Nuaman, Freelance Designer and Developer wrote:
> I use git for a local versioning system and was wondering if there was a
> way that I could write a bash script that would get the paths of the files
> from the latest commit and then pipe them to ftp or ssh for deployment.

For example, to scp a complete file list from branch `topic' to
`user@server', you could use `rsync' and do something like:

git checkout topic &&
git ls-tree -r --name-only |
rsync -a -e ssh --files-from=- user@server:/path/to/dest

Note, that this is completely untested.  Use at your own risk.


Regards,
chressie
