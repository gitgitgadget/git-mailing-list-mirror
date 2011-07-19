From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/17] revert: Inline add_message_to_msg function
Date: Tue, 19 Jul 2011 14:36:08 -0500
Message-ID: <20110719193608.GA26557@elie.gateway.2wire.net>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-3-git-send-email-artagnon@gmail.com>
 <20110712165302.GA13578@elie>
 <CALkWK0kHutr41aH7OrmW3REV+YBUeHSryA9n62yxyF0qRd1FEw@mail.gmail.com>
 <20110713064240.GC31003@elie>
 <CALkWK0mmPeYawqF-Dd3Sv_0qYjfYA-36POengYupfjwNBRDj-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 21:36:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjG5g-0004jU-Gz
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 21:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261Ab1GSTgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 15:36:17 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51992 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab1GSTgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 15:36:16 -0400
Received: by ywe9 with SMTP id 9so1934667ywe.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RR9LUVlmE4oOWNlh6Xt1DziYBJkff63Duh4W2aTNsys=;
        b=cvlV0jqqPnOcoi5GdMQKi7q/g3tp26ZNcOgyytFMq35g55Cyf/VVqlzLqsI9zDPA35
         YbhZrd931OzOPweD1ccNMm8YG4WyMGEFUUZ+gGTRSQp/zE3ieTFmbaTSjm32+h5iwmsR
         NUpdJYMo/oeSHjF0VqtGMJ+RUKDOD+0qW3l+M=
Received: by 10.90.3.38 with SMTP id 38mr7143508agc.194.1311104176067;
        Tue, 19 Jul 2011 12:36:16 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-74-225.dsl.chcgil.ameritech.net [69.209.74.225])
        by mx.google.com with ESMTPS id j3sm197753anm.21.2011.07.19.12.36.14
        (version=SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 12:36:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mmPeYawqF-Dd3Sv_0qYjfYA-36POengYupfjwNBRDj-g@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177494>

Ramkumar Ramachandra wrote:

> Since it's
> totally impossible to reproduce this bug, it's not really a bug --

Huh?

	git cat-file commit HEAD | sed -e '/^$/ q' >newcommit &&
	cmit=$(git hash-object -t commit -w newcommit) &&
	git cherry-pick $cmit

Fun bonus:

	git log $cmit
