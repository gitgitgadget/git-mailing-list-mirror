From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH/RFC 4/6] transport: add refspec list parameters to
 functions
Date: Tue, 19 Apr 2016 15:31:03 -0400
Organization: Twitter
Message-ID: <1461094263.5540.113.camel@twopensource.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	 <1460747949-3514-5-git-send-email-dturner@twopensource.com>
	 <xmqqa8kq69i5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 21:31:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asbMf-0007NB-AH
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 21:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbcDSTbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 15:31:08 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34455 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbcDSTbH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 15:31:07 -0400
Received: by mail-qg0-f47.google.com with SMTP id c6so15629038qga.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 12:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=8j+xWLF4fTCG5fP01LVtw5Vd02t/AugFCmI4xXaAeik=;
        b=zFxsweZ0BYzm3aVxkjqjUEXBb1URi1qqNx/HqGRHS0HTYDNjEZnHBCV3SWkpqUeWVe
         PR7D+WCzfg5uDGGeCujp/vxCeePo1ee0SIHITXgz2mRgHNKooR+yqAAQvPLokyo/Hv1K
         DOiE5CaiOnZb6nOV/Z0cR1kMU2Q5aNR6m+wyDueAXFBQO0VYJCHAnCubsNwT0W6R8DW1
         p5vYSWJcxdzPran1Z0d7Pnk/KPMO67F6eQIs61M8aTV/VRy+tsECtXu6P5xlmgdTzoHw
         Qlx1hFHPv/t6mq5bb5KWCaBP7HA53vjjI3bbnhD7JwLzwoRC8vMfSaNgMKl3B7n8RMoP
         ab1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=8j+xWLF4fTCG5fP01LVtw5Vd02t/AugFCmI4xXaAeik=;
        b=H3bYc+7c/DIFTIozQyXkrkKvcJNJm1n2E/R1hUjNKBUR1Ho6I9A9KArnCFe/zuxeNC
         AxsVhHdlyaGBL6502QbLcYPAuCUv4Sn/NpP1sSoEhmGSwMvl2p9g6pDq2N0CVlZToPVD
         iAMK2F1cK25YrvlkbiK2bjC9+qZXwlqqhJq9W5IaKaU+cVoXS5cyw9eAK0kg7vnNgHDJ
         iocQ8TyDj1PznxvKUnhqj80YXUF1S3vOtT2hySDO7U6wxHleUTTiameCLDcQhKLv+gxz
         sg0A1iEX+daq6sPrlbzPAOKgb3LfQkiWrIZvOgjaQxtO9LrA1H4oW7hrftYsxYeUCqa1
         FFXw==
X-Gm-Message-State: AOPr4FW5eYpVw74wd40vdmUAkSd0QeOo3SwBuZSnMXl6cVMVEBeMKblmoZJlJFf5jxtrQA==
X-Received: by 10.141.41.130 with SMTP id s124mr6231661qhe.69.1461094265474;
        Tue, 19 Apr 2016 12:31:05 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id u16sm29697669qka.22.2016.04.19.12.31.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 12:31:04 -0700 (PDT)
In-Reply-To: <xmqqa8kq69i5.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291912>

On Mon, 2016-04-18 at 11:45 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > Add parameters for a list of refspecs to transport_get_remote_refs
> > and
> > get_refs_list.  These parameters are presently unused -- soon, we
> > will
> > use them to implement fetches which only learn about a subset of
> > refs.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> 
> What the code tries to do I am more than halfway happy.  It is
> unfortunate that we cannot do this natively without upgrading the
> protocol in a fundamental way, but this is a nice way to work it
> around only for Git-over-HTTP transport without having to break the
> protocol.
>  
> As a POC it is OK, but I am moderately unhappy with the use of
> "refspec" here.
> 
> At the transport layer, we shouldn't care what the receiving end
> intends to do with the objects that sits at the tip of the refs at
> the other end, so sending "refspecs" down feels somewhat wrong for
> this feature.  At one layer up in the next patch, you do use
> "interesting refs" which makes it clear that only the left-hand-side
> of a refspec, i.e. what they call it, matters, and I think that is a
> much better phrasing of the concept (and the passed data should only
> be the left-hand-side of refspecs).

I will rename the parameter to "interesting_refs".
