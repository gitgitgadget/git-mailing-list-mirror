From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Add svnrdump
Date: Fri, 9 Jul 2010 15:46:00 +0200
Message-ID: <20100709134600.GD12315@debian>
References: <20100708083516.GD29267@debian>
 <002d01cb1e7f$e0ff03c0$a2fd0b40$@nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dev@subversion.apache.org, 'Jonathan Nieder' <jrnieder@gmail.com>,
	'Sverre Rabbelier' <srabbelier@gmail.com>,
	'Git Mailing List' <git@vger.kernel.org>
To: Bert Huijben <bert@qqmail.nl>
X-From: git-owner@vger.kernel.org Fri Jul 09 15:44:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXDsQ-0006CK-19
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 15:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756471Ab0GINoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 09:44:21 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62224 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834Ab0GINoU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 09:44:20 -0400
Received: by eya25 with SMTP id 25so303586eya.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 06:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TOjzpnwy/q7ADirRnNcBrLJg2QEULM4Hbzr1aDNgPMQ=;
        b=sKPff8UgK6lVYGFa50QvQBi1P/Lv4e5+dAZ2b87ZePRyO5S5gDMmIyH8HRvhPOwwTP
         AoeknI/snZkXtJrjQuKawFULljQy5Tivwhr8H+goQI40cnIpx4KvoxVHR7MTTcSAbM9d
         AQ1odJ6Ab4bnqQhSg5c0TmdIcRgyB/nyPNtU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kgrQydb05dYVx+Uj17JPbKbCYc5fHZTDVL9EQQWkybnrIL24Zdb1SqpkTupApnLgRa
         8SJLd6cNrGUyrkWQIYWqVk6YwHaZH4iDmRTpCVyGuUOQvFEf+cZf/bw7nNkMJIZeD73L
         N3zVRyqv4zinAT5D3h8YoP5aZmh7MuJ2L85So=
Received: by 10.213.14.20 with SMTP id e20mr8328049eba.21.1278683058865;
        Fri, 09 Jul 2010 06:44:18 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id v8sm7681662eeh.14.2010.07.09.06.44.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 06:44:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <002d01cb1e7f$e0ff03c0$a2fd0b40$@nl>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150668>

Hi,

Bert Huijben writes:
> > +  /* Cleanup */
> > +  SVN_ERR(svn_io_file_close(hb->temp_file, hb->pool));
> > +  SVN_ERR(svn_stream_close(hb->temp_filestream));
> 
> The standard handler already closes the stream for you and if you don't
> disown the file on mapping, this also closes the file.
> 
> > +  svn_pool_destroy(hb->pool);
> 
> And as you clear the pool that contains the file and stream here, closing
> yourself is not necessary.

I realize this, but I closed the stream anyway to make debugging
easier. The pool is only destroyed much later. Do you think this is
bad policy?

-- Ram
