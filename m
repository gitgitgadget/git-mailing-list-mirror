From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv6 15/16] Add missing &&'s throughout the testsuite
Date: Sun, 3 Oct 2010 16:17:52 -0500
Message-ID: <20101003211752.GA24530@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-16-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 23:21:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Vzo-0002gi-Pt
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 23:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295Ab0JCVVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 17:21:09 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45732 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197Ab0JCVVI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 17:21:08 -0400
Received: by qyk36 with SMTP id 36so2195509qyk.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 14:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xv9qimP2WJ/zzpMxJPQNsZdAkVOEu95rOJBRWXCcT3Y=;
        b=fkdaj0E1Am9sNS66yB3xX717YTRbY9BYHq+25KK93Az2OBPBrx65NwwKBqgpLEqr8z
         md0btnKqzcd6ONE8hh+YWnl5+bERowaUFEDx8oI6HZOCUJxBl9CluqJhtUfGqjEWmBkz
         iELvu8EoIH7q/6xfDol1T5T1f1jiOJ1ff7JJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bNyDbGFXNSRpgEajUmv6EaDW3EmfmwD1g4RjDUc3lUrSz4CDkRi11gWRpeBXkIQmT7
         AOrWKLk+Q54oam9z9dA5cejTbb6fsJRbYaQofP2gzS6+CCEwzcOURrW6lL+LjySm79+U
         z5jvHCGFuW21Lp8k6woyC/qdMJxm/Be0UbPms=
Received: by 10.224.45.135 with SMTP id e7mr6083688qaf.390.1286140867433;
        Sun, 03 Oct 2010 14:21:07 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id r38sm4483277qcs.38.2010.10.03.14.21.06
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 14:21:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286136014-7728-16-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157926>

Elijah Newren wrote:

> +++ b/t/t5550-http-fetch.sh
> @@ -93,9 +93,7 @@ test_expect_success 'fetch notices corrupt idx' '
>  '
>  
>  test_expect_success 'did not use upload-pack service' '
> -	grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act
> -	: >exp
> -	test_cmp exp act
> +	! grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act

Wait a moment: this writes its output to act instead of stdout,
so one still does _not_ get to see the output when debugging
with -v.

Probably the nontrivial changes (this one and adding a SYMLINKS
prereq) should be split off as separate patches or mentioned in
the log message?

Pro tip: if all that remains is tiny tweaks like these, you can
probably ask Junio to amend instead of resending everything. :)
