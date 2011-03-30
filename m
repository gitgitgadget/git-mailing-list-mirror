From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: remote-helpers and refs without a value
Date: Wed, 30 Mar 2011 09:59:42 +0800
Message-ID: <AANLkTikVPevgKGf2B881ox0zZ5xqBLd9hH1pQF2pW2Jx@mail.gmail.com>
References: <20110327082428.GA4428@glandium.org>
	<AANLkTi=cNin=XYqbAJMggWj7OcZ8=9PGCVGGg=JRO-bj@mail.gmail.com>
	<20110328075009.GA5115@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Mar 30 03:59:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4khJ-0008Qw-7z
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 03:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443Ab1C3B7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 21:59:44 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49698 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348Ab1C3B7n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 21:59:43 -0400
Received: by iyb14 with SMTP id 14so736225iyb.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 18:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7VCcDNFT33BjKug/qlTUdnkd5Q6tpOq52iLewHoIYU8=;
        b=ohVuq/O5Dg5Hj3j/T4VhbCQ3F8BOBkzSyztgkrrdgW2EuH66grCqYWJ7hy6HoOpfZ+
         5+JGbtX97MeUNRjDwesaa+hCkfkyM2hH+8Qe2XgwwZJHh9YYu6o5be2xBmqRfbQVCR+c
         7CNIMrvHfxEdjnG4TxlrKtWv+d68z+Sm0CV7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=osYtM7ZRO08z5WaszMvZuuBlWGJvCemfMo5vOBnZgSMVirPkSi4oFZAmRKWvz7SWvm
         J8nL0qPRM3wyZZYdRzDCAI7BYZbKXY4x8Je4vxIIGVoxHbIf3Ur2UZzPA7x5+86FLNwK
         veFl5il/5HihF8DgQPyaOINJ61QGmcN0YvQ6c=
Received: by 10.43.51.65 with SMTP id vh1mr376447icb.435.1301450382832; Tue,
 29 Mar 2011 18:59:42 -0700 (PDT)
Received: by 10.42.230.1 with HTTP; Tue, 29 Mar 2011 18:59:42 -0700 (PDT)
In-Reply-To: <20110328075009.GA5115@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170347>

On Mon, Mar 28, 2011 at 3:50 PM, Mike Hommey <mh@glandium.org> wrote:
> Failing wouldn't make sense. That'd mean '?' may not be used by
> remote-helpers, and that they'd need to grab everything from the remote
> before git even decides what to grab.

I guess from "grab" you mean fetching the actual objects etc. However,
I believe the '?' is used only in the ref fetching/matching step,
which is before the step where the actual objects are fetched.

So, if a '?' was reported by the helper, then the transport machinery
would most likely be unable to properly match refs; then, it would not
direct the remote-helpers to fetch anything (ie. objects).

-- 
Cheers,
Ray Chuan
