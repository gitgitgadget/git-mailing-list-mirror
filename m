From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v4 2/2] gitweb: introduce localtime feature
Date: Sat, 19 Mar 2011 22:09:27 +0100
Message-ID: <201103192209.29759.jnareb@gmail.com>
References: <ab54ba2199cc7487e383a31e3aa65885@localhost> <7v39mjro38.fsf@alter.siamese.dyndns.org> <AANLkTimssscn+STEPyM7NbXF5ddFApPBsgXfqz-9SSNs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 22:09:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q13PH-0003de-CU
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 22:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757539Ab1CSVJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 17:09:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48025 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757508Ab1CSVJj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 17:09:39 -0400
Received: by fxm17 with SMTP id 17so4591908fxm.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 14:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Eg2/ikKKMXFXRmIULVPEmRdAmuTXKETc3BrLQTVUXMI=;
        b=WXpa2eOs6BFclKFOnxwzQoeLNr82dZytE/6B9s57WZtMIpi+L0L9nsdME4xcJFh0qZ
         c0RVHJ0mgpPxh7MhHnh8ffwkiP/i/OKum2bK4OzvnxBb3EsaOHwFoqIy3m8Fc4EDS//R
         UA2jdqDxwaeUtRpVecjpq2vwWTC6t33ByxfGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mtKAuCfUVJk3USa0b14Tw2KLvoGWJI9VzN58qkiQVNGXx2iAM0EdSaB6+m2K7DUGI+
         mwSth1VhmTm+t08Im6KQZ/TiN5AHmjlCv3RvLggPDvFYhJwFTJ1dZ0MNhlPk6tTY20Fg
         elbLdzEIggVVY2Oxntb/FO7eu0BcLUcntUqz4=
Received: by 10.223.127.210 with SMTP id h18mr2944516fas.71.1300568978073;
        Sat, 19 Mar 2011 14:09:38 -0700 (PDT)
Received: from [192.168.1.13] (abrz59.neoplus.adsl.tpnet.pl [83.8.119.59])
        by mx.google.com with ESMTPS id b18sm1662162fak.8.2011.03.19.14.09.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 14:09:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimssscn+STEPyM7NbXF5ddFApPBsgXfqz-9SSNs@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169464>

On Sat, 19 Mar 2011, Kevin Cernekee wrote:
> On Sat, Mar 19, 2011 at 10:56 AM, Junio C Hamano <gitster@pobox.com> wrote:

> > Looks like we used to only paint HH:MM part but...
> > ... we now paint the whole line, which I personally think is a friendly
> > move for color challenged people (me included---a larger span of text
> > painted in different colors tends to help you still notice it better using
> > value/brightness difference, even if your hue perception is weaker than
> > other people). But it is a change from the old behaviour and might be
> > worth stating in the log message.
> 
> For the $feature{'localtime'} disabled case, the coloring is the same as before.

No, it is not the same.  It used to be

  Wed, 16 Mar 2011 07:02:42 +0000 (02:02 -0500)
                                   ^^^^^

and now it is

  Wed, 16 Mar 2011 07:02:42 +0000 (02:02 -0500)
                                  ^^^^^^^^^^^^^

which is I also think improvement,... but should be mentioned in the
commit message.
 
> I will paint the whole line in the next spin, and mention it in the
> commit message.

I think current solution of using

  Wed, 16 Mar 2011 02:02:42 -0500 (07:02:42 +0000)
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

when 'localtime' feature is enabled is better than painting the whole:
you are now painting the _local_ part, i.e the part responsible for
"atnight" warning.


[...]
> $use_localtime indicates whether or not to add the " (hh:mm -zzzz)" at
> the end.  This also enables the atnight coloring.
> 
> This argument name was suggested in an earlier post and I guess I took
> it a little too literally...
> 
> Do you think it would be a good idea to take two separate options:
> -atnight for the variable coloring, and -alt_time (or some other name)
> to show " (hh:mm -zzzz)" after the RFC 2822 string?

Perhaps name this parameter -long.  Or simply always use the long form.

> Or maybe take one option, named something like "-commitpage", to
> indicate that it is a format specific to that view?  If it is not
> specified, the caller gets back an uncolored RFC 2822 date.
> 
> Also, is there a cleaner way of writing this?
> 
> sub timestamp_html {
>     my %date = %{$_[0]};
>     shift;
>     my %opts = @_;

  sub timestamp_html {
      my %date = %{ shift };
      my %opts = @_;


> 
> Or should I pass in the options as a hash reference, more like $cgi->a():
> 
> sub timestamp_html {
>     my %date = %{$_[0]};
>     my %opts = %{$_[1]};

Or just use hash reference for $date:

  sub timestamp_html {
      my ($date, %opts) = @_;

and use $date->{'sth'}.

-- 
Jakub Narebski
Poland
