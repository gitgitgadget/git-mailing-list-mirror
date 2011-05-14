From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Add log.abbrevCommit config variable
Date: Sat, 14 May 2011 16:55:43 -0500
Message-ID: <20110514215543.GA23648@elie>
References: <20110514190122.GA16851@elie>
 <1305406038-36435-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junio@kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 14 23:56:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLMp8-0007Ly-V6
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 23:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907Ab1ENVzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 17:55:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60253 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722Ab1ENVzu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 17:55:50 -0400
Received: by iwn34 with SMTP id 34so3066595iwn.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 14:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=PVhPZvh2Vycb38xSxm5Abog5+jPQMo9MSfiW8Qaw7YM=;
        b=noEbGsBLyLKC/ihvned8GG2OPhp2QQyoiWCg5yDT3kGBfk/rzPJQ2mME9QzvMQ56Xl
         R1RprwEebIGXM/ZL3vSReHrN65DAwgG/f8EJ0XAjk2PpKJ4kKZhahNymFBaBpMOllWQu
         Sa+8y91wZJkCf66QHpqaA7+P18W6B6tRSVYxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ir+QyZEgQOd1VJQwp0lhX/IXeIvnKg0RA/3xNcPFRft/twL8Ub/xddk5vIiQ8Y6WQa
         QL42pkYpy9VbaIgFLykXBTXtVCBE48VYatLX5UhBBtR1uemvtV51G/fhyXZw9qd5Kgmt
         z/0XDfNvCc0NbC2s/spd/pFI41A/f2Nait/1I=
Received: by 10.42.230.138 with SMTP id jm10mr3291701icb.451.1305410149331;
        Sat, 14 May 2011 14:55:49 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.sbcglobal.net [69.209.56.134])
        by mx.google.com with ESMTPS id 4sm1514063ibc.66.2011.05.14.14.55.47
        (version=SSLv3 cipher=OTHER);
        Sat, 14 May 2011 14:55:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305406038-36435-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173607>

Jay Soffian wrote:

> Add log.abbrevCommit config variable as a convenience for users who
> often use --abbrev-commit with git log and friends. Allow the option
> to be overridden with --no-abbrev-commit.

Based on a quick google code search, this will break scripts. :/
For example, tig uses "git log --pretty=raw" to get revision lists,
including expecting 40-digit commit ids.

But aside from that, this looks good to me.  I'm not sure what to
suggest: go out and spread the word about diff-tree? suppress this
configuration when --pretty or --format is passed?  There's no obvious
good answer.
