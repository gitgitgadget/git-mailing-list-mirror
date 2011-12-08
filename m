From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] parse-options: introduce OPT_SUBCOMMAND
Date: Thu, 8 Dec 2011 10:30:50 -0600
Message-ID: <20111208163049.GA2116@elie.hsd1.il.comcast.net>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 17:31:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYgsA-0005vw-Pc
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 17:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648Ab1LHQa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 11:30:58 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50504 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab1LHQa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 11:30:57 -0500
Received: by ghbz2 with SMTP id z2so1677791ghb.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 08:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8hKPhxvr7cfJf+rCBgQYrrRvQTshN5jG1irEqh9/Rzo=;
        b=Z3RmxYvamMAFpwLGJ+p42mn9hjPwMpcPLqoozLC0pXYnsw1y9Ss8yk9z1wnFo+3DUM
         V3WGTFitfcWmgdRIi3u2rDx7SN43qbDzc4aM3tJdrcr1XhF0jDGz402mtleO+EcGsmWF
         yD7P59QAskdde7NRcc41q7K9vSNX4Ai/CodxM=
Received: by 10.236.175.72 with SMTP id y48mr5972436yhl.17.1323361856841;
        Thu, 08 Dec 2011 08:30:56 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a15sm7544996ana.1.2011.12.08.08.30.55
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 08:30:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323349817-15737-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186567>

Hi,

Quick thoughts:

Ramkumar Ramachandra wrote:

> Currently, the parse-options framework forbids the use of
> opts->long_name and OPT_PARSE_NODASH, and the parsing has to be done
> by hand as a result.  Lift this restriction

This part seems like a sane idea to me.

> , and create a new
> OPT_SUBCOMMAND; this is built on top of OPTION_BIT to allow for the
> detection of more than one subcommand.

This part I am not convinced about.  Usually each subcommand takes its
own options, so I cannot see this OPT_SUBCOMMAND being actually useful
for commands like "git stash" or "git remote".

Hope that helps,
Jonathan
