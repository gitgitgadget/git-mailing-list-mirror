From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/13] revert: Factor out add_message_to_msg function
Date: Tue, 21 Jun 2011 10:58:36 -0500
Message-ID: <20110621155836.GG15461@elie>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 17:58:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ3Li-00085M-QG
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 17:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756861Ab1FUP6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 11:58:41 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36121 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756743Ab1FUP6l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 11:58:41 -0400
Received: by iyb12 with SMTP id 12so2959579iyb.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=WtwUIZ2EuhXUPNOAn2OvdyU7qz90f+bregkqLmfJ8HA=;
        b=L4dnMDDdh13BcO8yQfv+o3yc/yogHliYPeAUAmnbS74QNp3vtUPwxvGM0maja6Sy1f
         KGFc7kFpvOxZMK/2sdvJAp0Pe0qzFSd43yT3DA8oB1lnsVEQjC0XKzc++k2NzlD0PVxH
         Dxz9WLkaQVFqS6wkCRFIpUGTx+FHD/+iruOM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FtdMFnjYR72IcNLPPLsbS6YsCDRTiUvQRijfKFmsgfsEcHjO1SGLR6RN368erQEEi9
         7dOvJBtKjxNbb7yulUGB2ur+VIyzzxkS+6XXcEEwPZ4zn8KaXILC9om20RQBqDry4Myb
         3wB8Li7MLuQH7VMOenus7UROMTMYmClYk/PYg=
Received: by 10.42.148.1 with SMTP id p1mr7514773icv.319.1308671920680;
        Tue, 21 Jun 2011 08:58:40 -0700 (PDT)
Received: from elie (adsl-69-209-79-158.dsl.chcgil.ameritech.net [69.209.79.158])
        by mx.google.com with ESMTPS id d10sm3869244ibb.15.2011.06.21.08.58.38
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 08:58:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308661489-20080-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176164>

Ramkumar Ramachandra wrote:

> [Subject: [PATCH 02/13] revert: Factor out add_message_to_msg function]

"Factor out" means to introduce a new function.  I think you mean
"inline". :)

> The add_message_to_msg function is poorly implemented, has an unclear
> API, and only one callsite.  Replace the callsite with a cleaner
> implementation.

The above does not answer the question I would have, namely what
exactly is wrong with add_message_to_msg.  Is it too slow?  Not
robust?  Is the generated assembly too long?  Is it hard for a reader
to figure out the intent?  Does it blend in poorly with its
surroundings?
