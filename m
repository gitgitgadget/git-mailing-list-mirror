From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GitWeb and atom feed links
Date: Mon, 13 Feb 2012 23:17:34 +0100
Message-ID: <201202132317.35255.jnareb@gmail.com>
References: <F3741779-8DDA-4275-BB68-24D02297C702@pilhuhn.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Heiko W. Rupp" <hwr@pilhuhn.de>
X-From: git-owner@vger.kernel.org Mon Feb 13 23:17:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx4DO-0004YT-Ik
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 23:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757280Ab2BMWRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 17:17:38 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:35228 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740Ab2BMWRh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 17:17:37 -0500
Received: by eekc14 with SMTP id c14so2018591eek.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 14:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=1qAInIlsGwh3bq6f/lIf0eKRnr4spfU1jmBneEv0Xrc=;
        b=cR87Hel32Bq9m8TklCet6e71PNyHcStfJkwzdht/fcLppbTGIp/Z9QqUTwP4z0kbF8
         qAc7r+Fpd/idpnuXUjxWT8bQZij+0qA33fKAmVsn1l3WKY4vp7JZxuvHgMyc/gbLnJNR
         LxqDgmpDzLMs7VbgNtIfGpQljxLNM9b4SqxU0=
Received: by 10.14.38.208 with SMTP id a56mr5734183eeb.53.1329171456289;
        Mon, 13 Feb 2012 14:17:36 -0800 (PST)
Received: from [192.168.1.13] (aeho143.neoplus.adsl.tpnet.pl. [79.186.196.143])
        by mx.google.com with ESMTPS id n17sm65665193eei.3.2012.02.13.14.17.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 14:17:35 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <F3741779-8DDA-4275-BB68-24D02297C702@pilhuhn.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190679>

Heiko W. Rupp wrote:
> 
> when you e.g. look at http://git.kernel.org/?p=git/git.git;a=summary
> and then the lower right, there are two buttons for feeds.

Yes, [Atom] and [RSS], for different formats of the same feed.

> If you click on e.g. atom, you end up with an url of
> http://git.kernel.org/?p=git/git.git;a=atom  
> where the output is not a feed in atom format, but plain html with
> tables etc. 
> 
> If you change the url to http://git.kernel.org/?p=git/git.git&a=atom
> the output is a correct atom feed (same for rss).

I don't know what is the source of bug you are seeing; I suspect some
trouble with output caching that git.kernel.org fork of gitweb has added,
but this isn't it.  Those two forms of 'atom' URL are equivalent.

Wikipedia says in  http://en.wikipedia.org/wiki/Query_string:

 "* The query string is composed of a series of field-value pairs.
  * The field-value pairs are each separated by an equals sign. The
    equals sign may be omitted if the value is an empty string.
  * The series of pairs is separated by the ampersand, '&' or
    semicolon, ';'.

  [...]

  W3C recommends that all web servers support semicolon separators
  in the place of ampersand separators.[4]"

[4]: http://www.w3.org/TR/1999/REC-html401-19991224/appendix/notes.html#h-B.2.2

 "B.2.2 Ampersands in URI attribute values
  ----------------------------------------

  The URI that is constructed when a form is submitted may be used as an
  anchor-style link (e.g., the href attribute for the A element).
  Unfortunately, the use of the "&" character to separate form fields
  interacts with its use in SGML attribute values to delimit character
  entity references. For example, to use the URI "http://host/?x=1&y=2"
  as a linking URI, it must be written <A href="http://host/?x=1&#38;y=2">
  or <A href="http://host/?x=1&amp;y=2">.

  We recommend that HTTP server implementors, and in particular, CGI
  implementors support the use of ";" in place of "&" to save authors
  the trouble of escaping "&" characters in this manner."

CGI(3pm) says:

 "-newstyle_urls

      Separate the name=value pairs in CGI parameter query strings with semi-
      colons rather than ampersands.  For example:

          ?name=fred;age=24;favorite_color=3

      Semicolon-delimited query strings are always accepted, and will be
      emitted by self_url() and query_string(). newstyle_urls became the
      default in version 2.64."

-- 
Jakub Narebski
Poland
