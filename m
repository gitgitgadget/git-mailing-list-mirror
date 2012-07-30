From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Mon, 30 Jul 2012 11:55:02 -0500
Message-ID: <20120730165502.GB8515@burratino>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <3225988.4e4jhmQGr7@flomedio>
 <20120730082951.GA7702@burratino>
 <19477122.a5lMBqWgns@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 18:55:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvtFW-0001ut-5w
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 18:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749Ab2G3QzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 12:55:09 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50800 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab2G3QzI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 12:55:08 -0400
Received: by yhmm54 with SMTP id m54so5038536yhm.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 09:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=btIFaKHbXuYcAIk8lTooIdFlaQwJlate5RNywwhTnKk=;
        b=i4W8HLLhdOAdUQkjoMrfEIk6WIEUXMW5YrOwdak+jNB2+UzH3vEN87synzPpfeneC6
         VRpAkBNLxIT5nFCAzDzK+xsHVkw+hXNOH8zS3OwJ1Jtt/QWNkXyLsWyuWQ98afcUEkSp
         BrexWCBkP0DK+8Fl3n/Z2m2RTJdhQgSE9fc4cQ8d+YwFKczhwAT2VCEU01aMjxUxpcnj
         vtAvp5+MSKcQP6/+uDxO3rpdxecrQrlwxPXJDUsv12/ugUYPGTxISs8wa/OXtkLOtWjc
         Kyyi4xsYlcj2PsTWHSLYl5Qaaiy70YO69YlG5TT/F13OFv4eNm/ujccuDZHxabQW50mj
         fr4A==
Received: by 10.50.104.168 with SMTP id gf8mr8656196igb.62.1343667307297;
        Mon, 30 Jul 2012 09:55:07 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id pp4sm14911140igb.5.2012.07.30.09.55.06
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 09:55:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <19477122.a5lMBqWgns@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202580>

Florian Achleitner wrote:

> Hm .. that would mean, that both fast-import and git (transport-helper) would 
> write to the remote-helper's stdin, right?

Yes, first git writes the list of refs to import, and then fast-import
writes feedback during the import.  Is that a problem?
