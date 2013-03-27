From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: propagating repo corruption across clone
Date: Tue, 26 Mar 2013 18:25:15 -0700
Message-ID: <20130327012515.GC28148@google.com>
References: <20130324192350.GA20688@sigill.intra.peff.net>
 <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
 <20130325145644.GA16576@sigill.intra.peff.net>
 <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com>
 <20130325155600.GA18216@sigill.intra.peff.net>
 <CAOx6V3a6vGJvJ4HEmAXdTRKKCzRJS23OYd_em1b3aQLzPNEtQA@mail.gmail.com>
 <20130325200752.GB3902@sigill.intra.peff.net>
 <CAOx6V3ZWB1ZpmXcaBeSaPOvHqmAMF3U1rTXuwinFGmEZQwFGYQ@mail.gmail.com>
 <20130326165553.GA7282@sigill.intra.peff.net>
 <1364340037755-7580771.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Rich Fromm <richard_fromm@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 02:28:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKf7d-0000f3-3e
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 02:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710Ab3C0BZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 21:25:20 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:37627 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab3C0BZU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 21:25:20 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj3so1441253pad.20
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 18:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=CcccFLLAHPLU0/6K+hmHDeXxzjNLpdJxsN6ch6P9EdE=;
        b=L5SeLykcaMc82aVl9bDMyEWwslRAYc32gZhUcoBSof+uovX21yZTln3UT5bnxqE+wk
         HtPf22IQ3QBfC2CoMCeX9XYtjIBuu3ZPyvf42aMv8HQi1Y44ft3a6AmJt8d0g4dNV03d
         q5aWlnXttwlPMAaUklf/OE9mzTCEZwWN9LAkNSx4UmRq11hLo+YU1niZGZDsikOdkn8c
         jNzMUCmGCevOn1V1zPZEx+SMso/HkCXUrkMdu7lwCWDs8iwWFCW6G78/KXLixnv0vaCD
         c/J+WIiC1rzKj+fT5jqH8kUf+cfxbkRbxCoH/WPE2ygZxYsr/mgtwgN15MSsX1NoAUh8
         2Okg==
X-Received: by 10.66.43.198 with SMTP id y6mr26425999pal.213.1364347519597;
        Tue, 26 Mar 2013 18:25:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id cn1sm4451332pbb.7.2013.03.26.18.25.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Mar 2013 18:25:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1364340037755-7580771.post@n2.nabble.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219232>

Hi,

Rich Fromm wrote:

>                                                The host executing the clone
> command is different than the the host on which the remote repository lives,
> and I am using ssh as a transport protocol.  If there is corruption, can I
> or can I not expect the clone operation to fail and return a non-zero exit
> value?  If I can not expect this, is the workaround to run `git fsck` on the
> resulting clone?

Is the "[transfer] fsckObjects" configuration on the host executing the
clone set to true?
