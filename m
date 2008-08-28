From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Thu, 28 Aug 2008 03:43:17 +0200
Message-ID: <48B602B5.1070304@gmail.com>
References: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com> <200808261015.37023.jnareb@gmail.com> <cb7bb73a0808260358o41a04a9ara701e6c726cf2298@mail.gmail.com> <200808261349.28771.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 03:44:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYWYf-0004Sv-RX
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 03:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbYH1BnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 21:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753020AbYH1BnR
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 21:43:17 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:56020 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbYH1BnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 21:43:16 -0400
Received: by fg-out-1718.google.com with SMTP id 19so122072fgg.17
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 18:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=c+FNUuUbyDzFKZ9wKH0osVA+9eaOKtcDaUcqcZlaVzw=;
        b=cIrgzqiUclydn5Pq/VjHEoTbqKbX1cDUagnsJAHYKCxF4sNypwTVl6l75gL4iEPZwF
         mlTDgCA29zbekJPbl2H5QZw+hTiGVYhW8TU8PQkuVrbUpq6Ela9zn7+G2956FKcWGvX6
         RAUSeiWovYAT4YhhTCISnx79A9QzBgf+rzc2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=BYCXa4qIQ5DmAfkyKz0Lupm42xVieGFCI8pwAqBLftz5hQGYMGQgk6RT730ilCIwBB
         Y0AC/YzVjOfk0GuwFTfUVCKFi5aUfHO7xc0wP6zZ/0239Gkgz8QES0aFrQqG1LbuljPU
         4dM8DueHlQcDoNqAiUmw8iHStxVqlmQ/0THlE=
Received: by 10.86.80.17 with SMTP id d17mr585257fgb.47.1219887794916;
        Wed, 27 Aug 2008 18:43:14 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.241.196])
        by mx.google.com with ESMTPS id 4sm511744fgg.4.2008.08.27.18.43.12
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 18:43:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080707 Thunderbird/2.0.0.16 Mnenhy/0.7.5.666
In-Reply-To: <200808261349.28771.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94014>

Jakub Narebski wrote:
> By the way, this is argument *for* selecting action when generating
> link, if it is possible without incurring unnecessary (if you don't
> follow the link) performance penalty.

I agree that it's much cleaner to select the action when generating the
page, rather than having an 'objectview' action or so.

Worrying about performance seems like premature optimization though --
my guesstimate is that the performance penalty for looking up the object
type is not practically noticeable (read: relevant), and with my patch
applied (even without caching activated) it should move below the
measurable range.  So don't complicate the code to gain another 0.01%
performance. ;-)

-- Lea
