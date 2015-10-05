From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/1] Makefile: make curl-config path configurable
Date: Mon, 5 Oct 2015 13:49:09 -0700
Message-ID: <20151005204909.GE11993@google.com>
References: <1444077159-3268-1-git-send-email-repk@triplefau.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>
To: Remi Pommarel <repk@triplefau.lt>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:49:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjChS-0007aD-Ut
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbbJEUtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 16:49:14 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32896 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbbJEUtM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 16:49:12 -0400
Received: by pacex6 with SMTP id ex6so186958139pac.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 13:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=f92IH1ufNH+rr73f+PdGDRyCvz43FPKxB6/+3FL4JaY=;
        b=N5est8JtKd6MAmTU7pQQR8ZiQkbSbmrWwWMp3oaqeu/qQIn7ht3A9D8kcQvw809o/Q
         CfUPwJSdalZbpw9lQfF74ZDamn+oa1jTbqGqE7kLhBtWXDIV1z34YsuzMPtOCSmpt3Te
         nDi4X8g8O0xtSRRrcKTmPY3D/Gl6FiMs3/C0RbFjlOfZ5NEZUejc76FJ+LAHXZChhKJo
         EFX43SghAsLZD3+kMpbFsmpAsqgrUC2i01F+iEfKRW/UJAixTE3eumN4qlVOIoejTWFY
         lPHQBCHPlnB9sTx36r67zawAv8iIDZKHfxwakrcB8aw1w5jLkzoYgETOfz4OXVZEShA8
         wMFQ==
X-Received: by 10.66.164.132 with SMTP id yq4mr42779652pab.8.1444078152042;
        Mon, 05 Oct 2015 13:49:12 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:201e:549b:492b:2feb])
        by smtp.gmail.com with ESMTPSA id uc1sm29437708pab.20.2015.10.05.13.49.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Oct 2015 13:49:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1444077159-3268-1-git-send-email-repk@triplefau.lt>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279092>

Remi Pommarel wrote:

> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

For what it's worth, with or without the tweaks below,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> --- a/Makefile
> +++ b/Makefile
> @@ -39,6 +39,10 @@ all::
>  # Define CURLDIR=/foo/bar if your curl header and library files are in
>  # /foo/bar/include and /foo/bar/lib directories.
>  #
> +# Define CURL_CONFIG to curl's configuration program that gives informations
> +# about the library (ie curl's version, cflags, ...) . If not set it defaults
> +# to 'curl-config'.

Extra spaces, some wording tweaks:

s/gives informations about the library/prints information about the library/
s/(ie curl's version, cflags, .../) /(e.g., its version number)/
s/If not set it defaults to/The default is/

Thanks.

diff --git i/Makefile w/Makefile
index 5a94434..4a870a4 100644
--- i/Makefile
+++ w/Makefile
@@ -39,9 +39,8 @@ all::
 # Define CURLDIR=/foo/bar if your curl header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
 #
-# Define CURL_CONFIG to curl's configuration program that gives informations
-# about the library (ie curl's version, cflags, ...) . If not set it defaults
-# to 'curl-config'.
+# Define CURL_CONFIG to curl's configuration program that prints information
+# about the library (e.g., its version number).  The default is 'curl-config'.
 #
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports (dumb).
