From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb, FastCGI and PSGI/Plack
Date: Mon, 10 May 2010 20:40:33 +0200
Message-ID: <201005102040.36490.jnareb@gmail.com>
References: <g2s693254b91005091428ib188cbd1le5ffa90eace741a8@mail.gmail.com> <201005101232.32908.jnareb@gmail.com> <AANLkTikH39rbm64sc0nn7eTBJSfxcqWpz6VXZBCQQIl3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Peter Vereshagin <peter@vereshagin.org>,
	Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Tatsuhiko Miyagawa <miyagawa@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 20:40:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBXuJ-0000li-RK
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 20:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878Ab0EJSkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 14:40:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65504 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802Ab0EJSkl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 14:40:41 -0400
Received: by fxm7 with SMTP id 7so419794fxm.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 11:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1uJq1yA0SkLX6afB3VqjWKMlua/HM3QOJ5FCSiFS/ow=;
        b=dQhlu43+6sD5DVl+l2f0CqVHmnnnh9xdu6YxT4osR5MGy5m3PpDaYrB/IscZwvjUDj
         Ofka4SGP7bTVorG+oC1u+lWGVuZuJIP3wWYI8yYG5F1FEXEvhHKzLj+thKIH6eAQIiTv
         7Zhk09tys4r/aCGU9zB8DZnk700YCfMAOfxYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IXyKbH5xqCF+S2iO4RYkfuQOqnOoQGIC0nWVDJNCE3u8xmKKHfCvgDyYsPPJs31+aQ
         nd9ZRS4J6nFg7l3R0jeTP27I+4pYVi6HoBGLwBH7t83k6spdysvwdY6AOp8FQ5ModKvo
         JNy8qkyKc4e5y63yl/BDCLYKI2FAD6qJ/HWQY=
Received: by 10.223.19.87 with SMTP id z23mr4882754faa.7.1273516839570;
        Mon, 10 May 2010 11:40:39 -0700 (PDT)
Received: from [192.168.1.13] (abwb94.neoplus.adsl.tpnet.pl [83.8.225.94])
        by mx.google.com with ESMTPS id 7sm22676995far.18.2010.05.10.11.40.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 11:40:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikH39rbm64sc0nn7eTBJSfxcqWpz6VXZBCQQIl3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146843>

On Mon, 10 May 2010, Tatsuhiko Miyagawa wrote:

> Yes, that makes sense - if implementing FastCGI is just switching CGI
> to CGI::Fast and a while loop, implementing PSGI interface just for
> that is far more complicated. I just argued about it because I saw on
> a separate thread that PSGI implementation is also on its way.

What!?  No, currently there are no plans to add PSGI support to gitweb,
nor moving gitweb from CGI (and mod_perl's ModPerl::Registry, and
FastCGI now) to PSGI.

This separate thread is about adding support for 'plackup' to
git-instaweb (and perhaps also adding gitweb.psgi wrapper).

>From git-instaweb manpage:

  NAME
       git-instaweb - Instantly browse your working repository in gitweb

  SYNOPSIS
       git instaweb [--local] [--httpd=<httpd>] [--port=<port>]
                    [--browser=<browser>]
       git instaweb [--start] [--stop] [--restart]

  DESCRIPTION
       A simple script to set up gitweb and a web server for browsing the local
       repository.

  OPTIONS
       -d, --httpd
              The HTTP daemon command-line that  will  be  executed.  Command-line
              options  may  be  specified here, and the configuration file will be
              added at the end of the command-line. Currently  apache2,  lighttpd,
              mongoose and webrick are supported. (Default: lighttpd)

I wanted to add support for '--httpd=plackup', see the following thread
on git mailing list:

  "Adding support for "plackup" and similar web server tools to git-instaweb"
  Message-ID: <201005020317.42112.jnareb@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/146124

*Not* moving gitweb to PSGI/Plack.

-- 
Jakub Narebski
Poland
