From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 0/6] gitweb: feed metadata enhancements
Date: Fri, 6 Feb 2009 23:42:56 +0100
Message-ID: <200902062342.57994.jnareb@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 23:44:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVZRC-0000Hm-Gv
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 23:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbZBFWnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 17:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753254AbZBFWnN
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 17:43:13 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:10168 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbZBFWnM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 17:43:12 -0500
Received: by fg-out-1718.google.com with SMTP id 16so639183fgg.17
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 14:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vWg5ZaRLIEoXo4QJG3qlPqcKkPjp9zXiEsmDn7/fmME=;
        b=DM1QiChjiK5HHqMsnNVz+iGdBYONMmsmaY0397DeXgZZDzvmIrneXKVIGEWqe5s3PT
         tzs5/91Auj9gfNpzWpkEJMFaZ3ZsEufzmEbpsAJ1oS3NfHMqiFSPPjrJjMkDtifkS7Ta
         Napc41Ef9Jeery+2NP1UHLplIWtkmxGFn8A/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=JrhMHn/K4jbPoc7LYT3SWc5gmjLT1kF9u2kY2o8SXStGdpicClOt2aGEASwL9Ckxub
         sqIA1kilN4rWcz6b46+Bi825WyZJl8/QCQ22gypidVTNp+xi4fdDPBqS5zAaD/+2hDlz
         Fl77ck37tcFhUt/IQbEdXMv0aNU7uzQQ1q59U=
Received: by 10.86.60.14 with SMTP id i14mr1247737fga.70.1233960190958;
        Fri, 06 Feb 2009 14:43:10 -0800 (PST)
Received: from ?192.168.1.13? (abwn77.neoplus.adsl.tpnet.pl [83.8.237.77])
        by mx.google.com with ESMTPS id l12sm2504458fgb.31.2009.02.06.14.43.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Feb 2009 14:43:09 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108796>

On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:

> This second revision adds two patches to improve client-side rss
> caching: the last-modified header we output is based on commit rather
> than creation time, and we now act on if-modified-since request headers.
> 
> The last patch requires either HTTP::Date (from libwww-perl) or
> Time::ParseDate


Below there is summary of my comments.
 
> Giuseppe Bilotta (6):
>   gitweb: channel image in rss feed

O.K. esc_url is perhaps unnecessary, but safe

>   gitweb: feed generator metadata

Better to use the same convention for version info as in meta.generator
in HTML header.  Use '"' for attribute values.

>   gitweb: rss feed managingEditor

Need to esc_html (well, esc_xml ;-) $owner, because it might be set to
"O Wner <owner@example.com>".

>   gitweb: rss channel date

O.K. (with question if it would be better to quote relevant fragment
of RSS 2.0 standard with respect to meaning of those date elements).

>   gitweb: last-modified time should be commiter, not author

O.K. perhaps with clarification that it affects not only Last-Modified,
but also just introduced (and used earlier) "publish" dates for feed.

>   gitweb: check if-modified-since for feeds

O.K., with proposed addition to commit message.

> 
>  gitweb/gitweb.perl |   40 ++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 38 insertions(+), 2 deletions(-)
> 
> 

-- 
Jakub Narebski
Poland
