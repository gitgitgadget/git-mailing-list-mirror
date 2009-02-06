From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH] submodule: add --no-fetch parameter to update command
Date: Fri, 6 Feb 2009 19:01:25 +0100
Message-ID: <8c5c35580902061001m6259d4ebt1c0dea7691b0a5dc@mail.gmail.com>
References: <1233872312-17781-1-git-send-email-git@fabian-franz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Fabian Franz <git@fabian-franz.de>
X-From: git-owner@vger.kernel.org Fri Feb 06 19:02:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVV2W-0001sh-QR
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 19:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760156AbZBFSB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 13:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbZBFSB3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 13:01:29 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:19638 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759679AbZBFSB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 13:01:27 -0500
Received: by fg-out-1718.google.com with SMTP id 16so577904fgg.17
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 10:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M2UZivXGCZwiEEqnPEbdXIvcGuOvEttdVyHuJYO0Rkg=;
        b=ZB/h7KO874Efjl0JobbMJMQLhbVtjn9xh+IXD7WCVdu01rgMgTi6oC+6f0qHwa2OXD
         8j4QKxlQdzG2RpC72BXs2zleXRWg2Dot1sA3W6EQMB0+2232a8et9w+e8uMhgv/B/QvV
         tIXmbFT6sNvDn+Tl9Rrz9fAJrY4/SO36dOKDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m93HU/PxsZs7S6tJbTTmAXSm9x9AC0H0v/Q2VPyBTFuX7FD7Zgsm61V9gkXV8jPkzl
         hkInFw8h66PRszycHtzuVov/6DO2QT+mW2AaO/BsX0Mna6cgJHrCi2QlZSKAf+hBZ/ML
         LTPOIMM5XQdsxlkArNiwtAeJ9XRl4i2e0J244=
Received: by 10.86.51.2 with SMTP id y2mr1125190fgy.23.1233943285877; Fri, 06 
	Feb 2009 10:01:25 -0800 (PST)
In-Reply-To: <1233872312-17781-1-git-send-email-git@fabian-franz.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108765>

On Thu, Feb 5, 2009 at 23:18, Fabian Franz <git@fabian-franz.de> wrote:
> git submodule update --no-fetch makes it possible to use git submodule
> update in complete offline mode by not fetching new revisions.

This is nice, but it would be even nicer IMHO if "submodule update"
first tried to checkout the submodule commit and only if that failed
would it try to fetch objects (before re-trying the checkout).


>  Documentation/git-submodule.txt |    7 ++++++-
>  git-submodule.sh                |   19 ++++++++++++++++---
>  2 files changed, 22 insertions(+), 4 deletions(-)

Extending t/t7400-submodule-basic.sh would also be nice (either for
--no-fetch or for a less fetchy "submodule update").

--
larsh
