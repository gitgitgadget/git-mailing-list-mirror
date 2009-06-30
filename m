From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv8 1/7] gitweb: refactor author name insertion
Date: Tue, 30 Jun 2009 22:04:40 +0200
Message-ID: <200906302204.40876.jnareb@gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com> <1246312854-3365-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 22:27:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward2.uio.no ([129.240.10.71])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLjvo-0005qX-3w
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:27:56 +0200
Received: from exim by mail-out2.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLjf0-0002Im-0k
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:10:34 +0200
Received: from mail-mx3.uio.no ([129.240.10.44])
	by mail-out2.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLjez-0002Ij-W0
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:10:33 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx3.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLjey-0000aN-GK
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547AbZF3UKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 16:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753138AbZF3UKN
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 16:10:13 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:48868 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756318AbZF3UKL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 16:10:11 -0400
Received: by bwz25 with SMTP id 25so108570bwz.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 13:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=vulJbBJUi1tK0gwPbc19bYjlvA5oXUJSM3gVZ/Zz7vE=;
        b=swXrxR3AYt2e9pelzfzShmZOSHBNi/sR6gyLhZOUaGHTaMsbQ39YIGW5uj1YYff2Yq
         RyJzQUMQ2nsBbhdk+BWo7qupQbo3qMuhr4ZZ93UEoWX1fxwFsALm+p3S+cbezbWGmgKl
         Mr5MVZXezF9sut9BBmDvZlsGEEOYU4ARfUGNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=pG3s1pwBNd9chgMVXUAuLulstqZ5JJd4P5h50jcUJZjBn5qG4N1nzja9VhiG+x7Itd
         P2uCka4HYFLv+eIyuwAsea7DmsqFq8MGpu9mrzmYN/PbDhbYmBVTVTV2XWuDD1iZP9RP
         OwYRx3xwQh9d0b8o08bDhDFPOIVtrGytrUIhk=
Received: by 10.102.247.4 with SMTP id u4mr5136628muh.26.1246392612588;
        Tue, 30 Jun 2009 13:10:12 -0700 (PDT)
Received: from ?192.168.1.13? (abvk72.neoplus.adsl.tpnet.pl [83.8.208.72])
        by mx.google.com with ESMTPS id u9sm2040704muf.37.2009.06.30.13.10.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Jun 2009 13:10:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1246312854-3365-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3, uiobl=NO, uiouri=_URIID_)
X-UiO-Scanned: 18608CA5318315CB818F91E1DA392FA43F62B79E
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 47 total 2548624 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122532>

On Tue, 30 Jun 2009, Giuseppe Bilotta wrote:

> Collect all author display code in appropriate functions, making it
> easier to extend these functions on the CGI side.
> 
> We also move some of the presentation code from hard-coded HTML to CSS,
> for easier customization.
> 
> A side effect of the refactoring is that now localtime is always
> displayed with the 'at night' warning.

It is a very nice side effect, I think.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.css  |    5 ++-
>  gitweb/gitweb.perl |   93 ++++++++++++++++++++++++++++++---------------------
>  2 files changed, 59 insertions(+), 39 deletions(-)

[...]  
> +sub print_local_time {
> +	my %date = @_;
> +	if ($date{'hour_local'} < 6) {
> +		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
> +			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
> +	} else {
> +		printf(" (%02d:%02d %s)",
> +			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
> +	}
> +}

Very nice refactoring.  

It could do with a comment describing its output, but it is not
necessary, and IMHO not worth resend.  We can always add it "in tree".

-- 
Jakub Narebski
Poland
