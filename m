From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Add svnrdump
Date: Fri, 9 Jul 2010 15:43:18 +0200
Message-ID: <20100709134318.GC12315@debian>
References: <20100708083516.GD29267@debian>
 <002d01cb1e7f$e0ff03c0$a2fd0b40$@nl>
 <alpine.561.2.00.1007081113210.3936@daniel2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Huijben <bert@qqmail.nl>, dev@subversion.apache.org,
	'Jonathan Nieder' <jrnieder@gmail.com>,
	'Sverre Rabbelier' <srabbelier@gmail.com>,
	'Git Mailing List' <git@vger.kernel.org>
To: Daniel Shahaf <d.s@daniel.shahaf.name>
X-From: git-owner@vger.kernel.org Fri Jul 09 15:41:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXDpn-00046l-Jt
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 15:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756133Ab0GINli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 09:41:38 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34919 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756106Ab0GINlh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 09:41:37 -0400
Received: by eya25 with SMTP id 25so302985eya.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 06:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7XqLL2yg2g0gFukRwA07iTOs6u++HhrGcFPC10BMfiY=;
        b=Xjln7too2yrNjOjNMrfrIRXaH8Su+RlfWEtE1/vWmVCjbx0Oe+hVgwn845O6/hIFce
         k7tJ/Mp2RbcNvA/ccEoTMo/XihQUaBJ9JH8rvo4fWTzmw4ShHIH5wy5oZ/1iYQqdyLQa
         jl0l022iNqV6zYve7pGLiCqB00q8rFI1QPZJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jJwGg+9voVgnGs9dM8LyPV1DDpSIC8gDMuzQ8ytERwmAojshMP6+OwTKlWeasiRq9c
         NCOUAQ8WMhYZ/+SEGGkZZKhwzNiESwov8EsQ1Zm4zOpSE7+VGfCr2BPrx6vttEgNFuj6
         ubjF10fdf20ZPjcCtqyHvitHOxl0pSncZazj4=
Received: by 10.213.10.195 with SMTP id q3mr539778ebq.29.1278682896146;
        Fri, 09 Jul 2010 06:41:36 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id x54sm7637914eeh.23.2010.07.09.06.41.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 06:41:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.561.2.00.1007081113210.3936@daniel2.local>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150667>

Hi Daniel,

Daniel Shahaf writes:
> > > +  /* Use a temporary file to measure the text-content-length */
> > > +  apr_err = apr_temp_dir_get(&tempdir, hb->pool);
> 
> svn_io_temp_dir()

Fixed.

> > > +  if (apr_err != APR_SUCCESS)
> > > +    SVN_ERR(svn_error_wrap_apr(apr_err, NULL));
> > > +
> > > +  hb->temp_filepath = apr_psprintf(eb->pool, "%s/svn-fe-XXXXXX",
> > > tempdir);
> > 
> 
> os.path.join()
> 
> Err, I mean, svn_dirent_join().

Fixed. Thanks :)

-- Ram
