From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 03/24] t1430: test the output and error of some commands
 more carefully
Date: Fri, 08 Apr 2016 17:57:37 -0400
Organization: Twitter
Message-ID: <1460152657.5540.16.camel@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
	 <1460055791-23313-4-git-send-email-dturner@twopensource.com>
	 <5707CACB.4030906@alum.mit.edu> <1460143577.5540.11.camel@twopensource.com>
	 <xmqq4mbbvnjk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 23:58:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoePl-0008FF-CF
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 23:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759190AbcDHV5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 17:57:42 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:34756 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759183AbcDHV5k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 17:57:40 -0400
Received: by mail-qg0-f52.google.com with SMTP id c6so101995182qga.1
        for <git@vger.kernel.org>; Fri, 08 Apr 2016 14:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=duORqp9CLalhfx7XMLwy39zaTxgB0QLA7HrQb267CBI=;
        b=fwDZ+Gs1Zoe34xRY2LxJbzTFjEXRt4ZaU8RbOZDoGz2+dDT/Ehcx3/JzB+1k/mbDgQ
         oJY78NvENk/G130PPZQlmUDqKF4SKiFZnbWxe4VEB2mJRokxXzqMXKbrGatFZquCjDZu
         k8469TD+qDWxBCY2p3LSDxi3CSpLMeEpYxHHGFAQA9+/OHwgrT8qAXyIa5C3POA0eIcJ
         jgbAL7imEfLRH5jwwW/tDtvZfTqNLHt35HR5zX23mY0+WeyEn7HazrHGPyzFwX8uKTDD
         kqx1YL+VNNnq926+WjXUQkusx3CuM0hvE2E/m3t3II0P5FA3oTBolmY4wlqvdtipk67I
         2Z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=duORqp9CLalhfx7XMLwy39zaTxgB0QLA7HrQb267CBI=;
        b=CpJOVsdnoWghqfUEEDRLFfZh33AX6EAmjLmEu8jjFci15q9VDx9s9ceRtu0m4QCEWL
         2x2PzCpYU/s1q6jz4AaPp9JR5zoFH4SrtZy8P6tDi8f2a2KnDMf0FbOJpxX9cqqqWY6H
         4PbWJqse7Vt6gcBvyUqkyv3uttNJ87ox1zu4qs8PlSX5QbM56QaNMsI8qI+Priw5puwH
         EquqghxJ+rj3jlbjrs8kLc8Fz/ErpNMGaW9O7wlDhqmpH9XsuzBk9uQTqgQnpFq/Rq5i
         D9+mJ8AjOdzyNqjbK4lLYif68rE2Sztd2W7+t8ujZgUssCjxFPD6X98ngNwS9l0tklHJ
         m/GQ==
X-Gm-Message-State: AD7BkJI1RdA0/vuzMvoBGYStRRo6tCynVJsujhygyNeGAuvp4aek3tTuHQ73OHIUUmhAdw==
X-Received: by 10.140.251.70 with SMTP id w67mr14458153qhc.99.1460152658978;
        Fri, 08 Apr 2016 14:57:38 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id h64sm6325946qgh.39.2016.04.08.14.57.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Apr 2016 14:57:37 -0700 (PDT)
In-Reply-To: <xmqq4mbbvnjk.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291073>

On Fri, 2016-04-08 at 13:43 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > Would you like
> > me to re-roll with my sign-off, or would you prefer to add it
> > yourself?
> 
> I take it that you see no other reason to reroll the series at this
> point (otherwise you wouldn't be asking ;-), so I'll check which
> ones need amending and add them.

That is correct.
