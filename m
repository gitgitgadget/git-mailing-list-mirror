From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v6 7/7] git: submodule honor -c credential.* from command line
Date: Tue, 1 Mar 2016 10:05:34 -0800
Message-ID: <CA+P7+xp41mkHjA0CF=69extO4R2Oam2V3sJA7PoqNbHD=9kw+g@mail.gmail.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
 <1456786715-24256-8-git-send-email-jacob.e.keller@intel.com>
 <CAGZ79kbDaV=i0augzh5RgGYpTWXOuTLx=7Occhc-6iE+0pBVNg@mail.gmail.com> <xmqqh9gq85yc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 19:06:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaogK-0005jK-NS
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 19:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbcCASFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 13:05:55 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:36758 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbcCASFy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 13:05:54 -0500
Received: by mail-io0-f173.google.com with SMTP id l127so231591921iof.3
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 10:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YRTtDK2pG9Ut6VzkYZ5U1QDtssUKaMpIpgDFALJPHk4=;
        b=bhLfIAs6qzMuaKAydHW3iXcJqchLvKl8Hyl0msYOxi04rGe7rFyQTSDFez7fDKQTHv
         cmAIBoVJdWgUIC1lsc48/IPKcL5Cd9reosUlyH5WE/YaEPXKIeK6WCr0TNWWvhvEH6Z4
         S72yCuRD5m4Hh6766wKh6n/j+ThdsVPsATn/83G7fyIFNTzQbHn86VK6W0NRCbVp8sAk
         C2KdYFyIXU8IvqDszG6QB2t/sIGx48GAjcRDxP5Q14LWlXJ5BST3NB1qDqm5LNF+hLPp
         J+zBk7qf92kXa9aD1JB8ZuSTNO76EhOiOP4FfIrVjy+aH53BUX8p/TMj+zMLj76erh6p
         h2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YRTtDK2pG9Ut6VzkYZ5U1QDtssUKaMpIpgDFALJPHk4=;
        b=AoRgvdT5INE7ybTctkkkbwH3Y/x+DumRQhmT7/4gRAJZ9cGkeRlgpJwDVrqxH90WMT
         S3wzb2E+SiWRhGYIWXimMVp+a9jLjXuZlJ2U3hKHrikgq/ja8YoPCBoipih3mNROKsBW
         gnRbZ6elJ9ZYx4K0/Q6cCJVrHlIZ4TrCPSNRVygtOt82qTVkivb6dN4SZuSelLi6gmTV
         YfQlZOvYBuHh9WvwjXbxlI5uEZs0YEyer1+Ui9fHNBwKJcnyCoWupRCXGjF4JT/xtRBl
         ExK6wL9u0+SlOvn7dzRlRz20JQgsxfBYOWSpx9NzQD7kLcBwK2eetK+OM2PVNapYilh3
         lHnQ==
X-Gm-Message-State: AG10YORf+QnVp1LOLH07ZVvfvL9GuJMbv/Ng/WY417UFh82YC+rNPijMquH1nCIenwUWboBxoT9EHueLfk7B2w==
X-Received: by 10.107.166.195 with SMTP id p186mr26190461ioe.146.1456855553824;
 Tue, 01 Mar 2016 10:05:53 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Tue, 1 Mar 2016 10:05:34 -0800 (PST)
In-Reply-To: <xmqqh9gq85yc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288049>

On Tue, Mar 1, 2016 at 9:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I find this in t/lib-httpd.sh:
>
>         set_askpass() {
>                 >"$TRASH_DIRECTORY/askpass-query" &&
>                 echo "$1" >"$TRASH_DIRECTORY/askpass-user" &&
>                 echo "$2" >"$TRASH_DIRECTORY/askpass-pass"
>         }
>
> and expect_askpass peeks at askpass-query to see if Git asked the
> right questions.
>
> I think askpass-query is cleared here because the author of the test
> suite expected that the helpers are used in such a way that you
> always (1) set-askpass once, (2) run a Git command that asks
> credentials, (3) use expect_askpass to validate and do these three
> steps as a logical unit?
>
> That "clone" the test expects to fail does ask the credential, so
> even though the test does not check if the "clone" asked the right
> question, it finishes the three-step logical unit, and then you need
> to clear askpass-query.
>
> It may have been cleaner if you had clear_askpass_query helper that
> is called (1) at the beginning of set_askpass instead of this manual
> clearing, (2) at the end of expect_askpass, as the exchange has been
> tested already at that point, and (3) in place of expect_askpass if
> you choose not to call it (e.g. this place, instead of the second
> set_askpass, you would say clear_askpass_query), perhaps, but I do
> know if that is worth it.
>

Probably something worth looking at doing in the future.

I could call expect_askpass here at each time but I don't think it
would be meaningful after a test_must_fail.

Thanks,
Jake
