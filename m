From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add an optional argument for --color options
Date: Sun, 14 Feb 2010 19:18:04 -0600
Message-ID: <20100215011803.GA15966@progeny.tock>
References: <1266098475-21929-1-git-send-email-lodatom@gmail.com>
 <20100214064408.GB20630@coredump.intra.peff.net>
 <ca433831002140658r30aa539fy5480cae8298d6d6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 02:18:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgpbU-0001od-7D
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 02:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382Ab0BOBSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 20:18:07 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:48703 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866Ab0BOBSG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 20:18:06 -0500
Received: by iwn39 with SMTP id 39so1729518iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 17:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gq2RUIPksHfMio04P7CvHyKNEBxq3JuO+ngKGb4EXe8=;
        b=SV2k75PEuwcW4dUg2ePD4ghX02A1OVoAGjQLBjJrI6x2p9/WgpyZO9RAdl2AQY3kvg
         2TijD1gRrlBroTAK62wSBCYlUUbQ4akXyGckYM7mjcMHPZ3FuxvZQbFxa+rwPxwA5w8v
         awwC7+ePxG0MbGfCwjFFSS7D2ft8umiJIAgn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FK7mGc2/MEStOarAFUNeqhA3MS4tkL+xcV2hI+ezU/75bODtNbBZ2C8P4bP4yQMIZq
         kqEbEI9sKXiSMe2DzmK8peO2cUMNO79Yp3UkNbw30Yl5bnh6SuNGgCPi8qzEsop+H7r4
         DmVKayIkA2SsEy6UgJwj/uPq5gFL3BTAjXt6k=
Received: by 10.231.167.65 with SMTP id p1mr3296865iby.20.1266196683174;
        Sun, 14 Feb 2010 17:18:03 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm5771905iwn.4.2010.02.14.17.18.02
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 17:18:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ca433831002140658r30aa539fy5480cae8298d6d6c@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139953>

Mark Lodato wrote:

> Just wondering, why does diff use a separate option parsing mechanism
> than the rest of the code?  Would it be worthwhile to switch to
> parse_opt?

Historical reasons, I think.  And yes. ;-)

> Perhaps I can throw the tests in Jonathan's "tests for automatic use
> of pager", t7006-pager?  Or, create a new test that mimics his?

I would suggest copying whatever functions you need to a new
lib-terminal.sh and sourcing that with . from a new test.  Then I
could adapt t7006-pager to use your library and avoid duplication of
code.

I am also interested in feedback on the techniques used in that test.
Should it just rely on redirects to /dev/tty instead, and work to
avoid sending any actual output there?  Is there an easier way to
detect use of color?

Jonathan
