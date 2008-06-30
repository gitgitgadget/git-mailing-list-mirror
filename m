From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v8] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Tue, 1 Jul 2008 00:01:42 +0200
Message-ID: <200807010001.42373.jnareb@gmail.com>
References: <1214273933-3925-1-git-send-email-LeWiemann@gmail.com> <200806300047.12224.jnareb@gmail.com> <48681EC8.8000606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 00:02:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDRSO-0002hZ-1g
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760270AbYF3WBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 18:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754682AbYF3WBr
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:01:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:34101 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203AbYF3WBp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 18:01:45 -0400
Received: by nf-out-0910.google.com with SMTP id d3so502831nfc.21
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=fxoQb+FCCf110bhkMwF1ZXLBSSkM2zHegEaXtsUDPR8=;
        b=st/PhuHtHbECxFy+pgnrpyVZE98d6vW9sY5TTlvfdRIFuwm9kS4uX4PhZYvCnTV3cy
         KqXmsiT0Cd1lvRcGWHwgF6kecG6DO4MjKW2CiGSbfFX63GHqaL7NHlPrtBYilLNe+Bxh
         3dCm8tUE/N82OdUi+Hw+UglTytHOqMsqkeoBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=NhT30ilq0WOnt5i6pHjJ9W4lgnd/Tms91grHzYbx6fBUkjrIa0t8Y4ooY3dooQg7ln
         igIYtK23AjoBn8rumfE2uymnOv9C+6Vu/wzP4MPYoS3AOzSY4nQ7vYxJiinkxvv/Nuhy
         9ixaxLGQJCBq3v+5Mbwkd5r6zN8J3HN+6gFFc=
Received: by 10.210.56.10 with SMTP id e10mr4676649eba.20.1214863303795;
        Mon, 30 Jun 2008 15:01:43 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.210.122])
        by mx.google.com with ESMTPS id b33sm7336864ika.2.2008.06.30.15.01.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Jun 2008 15:01:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48681EC8.8000606@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86941>

[back-to-list]

On Mon, 30 Jun 2008, Lea Wiemann wrote:
> [off-list]
[...]
 
> By the way, I found the supercat (spc) colorizer very helpful for the
> mechanize tests, since the output tends to be long and the lines wrap a
> lot.  Here are my regexes:
> 
> $ cat ~/.spcrc/spcrc-test_more
> #  HTML COLOR NAME   COL A N T STRING or REGULAR EXPRESSION
> #################### ### # # # #########################################
> Black                blk     r (.*)
> Green                grn b   r (^ok .*)
> Red                  red b   r (^not ok)
> Yellow               yel b   r (^not ok .* # TODO.*)
> Green                grn     r (^ok .*\[auto\].*)
> Red                  red     r (^not ok .*\[auto\].*)
> Yellow               yel     r (^not ok .*\[auto\].* # TODO.*)
> Black                blk     r ( - .*)
> Green                grn r   r (\* passed all .*)
> Red                  red r   r (\* failed .*)
> 
> Then you can just run
> 
> ./t9503-gitweb-Mechanize.sh -v -l 2>&1 | spc -t test_more
> 
> Hope it's useful!

Hmmm... it would be nice if 'test_external*' functions supported syntax
highlighting of command output if it follows TAP: Test Anything Protocol
http://www.perlfoundation.org/perl5/index.cgi?testing#tap_test_anything_protocol
in a manner similar to coloring native tests (using git_expect_success,
git_expect_failure etc.).

Test::More as far as I know produces TAP-compatibile output.

-- 
Jakub Narebski
Poland
